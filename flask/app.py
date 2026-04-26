from flask import Flask, request, jsonify
from flask_cors import CORS # type: ignore
from ultralytics import YOLO # type: ignore
from PIL import Image # type: ignore
import io
import traceback
import os

app = Flask(__name__)
# Allows Flutter to connect to Flask
CORS(app)

# Configuration
CONFIDENCE_THRESHOLD = 0.25
# take the model
MODEL_PATH = os.path.join(os.path.dirname(__file__), "model", "best.pt")
# Load the model ONCE when the server starts
model = None

def load_model():
    global model
    try:
        if not os.path.exists(MODEL_PATH):
            print(f"ERROR: Model file not found at {MODEL_PATH}")
            return False

        print(f"Loading YOLO model from {MODEL_PATH}...")
        model = YOLO(MODEL_PATH)
        print("Model loaded successfully. Server is ready.")
        return True

    except Exception as e:
        print(f"ERROR loading model: {e}")
        traceback.print_exc()
        return False


@app.route('/')
def home():
    if model is None:
        return "ERROR: Model not loaded. Check Flask logs.", 500
    return "Server is running and ready!"


@app.route("/health", methods=["GET"])
def health():
    return jsonify({
        "status": "ok" if model is not None else "error",
        "model_loaded": model is not None
    })


@app.route("/predict", methods=["POST"])
def predict():

    # Check model is loaded
    if model is None:
        return jsonify({"error": "Model not loaded. Restart the server."}), 500

    try:
        # 1. Validate image was sent
        if "image" not in request.files:
            return jsonify({"error": "No image field in request. Use multipart/form-data with key 'image'."}), 400

        file = request.files["image"]
        if file.filename == "":
            return jsonify({"error": "Empty filename received."}), 400

        # 2. Read and validate image
        file_bytes = file.read()
        if len(file_bytes) == 0:
            return jsonify({"error": "Uploaded file is empty."}), 400

        # 3. Convert to PIL Image
        try:
            image = Image.open(io.BytesIO(file_bytes)).convert("RGB")
        except Exception as e:
            return jsonify({"error": f"Invalid image format: {str(e)}"}), 422

        # 4. Run YOLO inference
        print(f"Running inference on image: {file.filename}")
        results = model(image, conf=CONFIDENCE_THRESHOLD, verbose=False)
        boxes = results[0].boxes

        # 5. Extract detections
        if boxes is None or len(boxes) == 0:
            print("No detections found in image")
            return jsonify({
                "label": "Nothing detected",
                "confidence": 0.0,
                "detections": [],
                "model_type": "YOLO"
            }), 200

        # 6. Build detection list
        detections = []
        for box in boxes:
            class_id = int(box.cls)
            label = results[0].names[class_id]
            confidence = round(float(box.conf) * 100, 2)

            # Get bounding box coordinates
            x1, y1, x2, y2 = box.xyxy[0].tolist()
            x1, y1, x2, y2 = round(float(x1), 1), round(float(y1), 1), round(float(x2), 1), round(float(y2), 1)

            detections.append({
                "label": label,
                "confidence": confidence,
                "class_id": class_id,
                "box": {"x1": x1, "y1": y1, "x2": x2, "y2": y2}
            })

        # 7. Sort by confidence (highest first)
        detections.sort(key=lambda x: x["confidence"], reverse=True)
        best = detections[0]

        response = {
            "label": best["label"],
            "confidence": best["confidence"],
            "detections": detections,
            "model_type": "YOLO",
            "total_detections": len(detections)
        }

        print(f"Detections found: {len(detections)} - Top: {best['label']} ({best['confidence']}%)")
        return jsonify(response), 200

    except Exception as e:
        print(f"ERROR in predict: {e}")
        traceback.print_exc()
        return jsonify({
            "error": "Inference failed",
            "detail": str(e)
        }), 500


if __name__ == "__main__":
    # Load model before starting server
    if load_model():
        print("\n" + "="*60)
        print("Starting Flask server...")
        print("="*60)
        app.run(host="0.0.0.0", port=5001, debug=True)
    else:
        print("Failed to load model. Exiting.")
        exit(1)
