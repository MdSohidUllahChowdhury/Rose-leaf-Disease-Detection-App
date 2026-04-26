# import os
# import io
# import traceback
# from flask import Flask, request, jsonify
# from flask_cors import CORS
# from PIL import Image
# import numpy as np

# from model_loader import get_model, MODEL_TYPE
# from preprocessor import preprocess_for_cnn, preprocess_for_yolo

# app = Flask(__name__)
# CORS(app)   # allows Flutter (on any origin) to call this API

# # ── Class names ──────────────────────────────────────────────────────────────
# # Edit this list to match your training labels.
# # Order must match the order used during training.
# CLASS_NAMES = ["Black Spot", "Powdery Mildew", "Rust", "Downy Mildew"] # single class example — add more if needed

# # ── Config ───────────────────────────────────────────────────────────────────
# MAX_FILE_SIZE_MB = 10
# CONFIDENCE_THRESHOLD = 0.25   # ignore predictions below this


# # ── Health check ─────────────────────────────────────────────────────────────
# @app.route("/health", methods=["GET"])
# def health():
#     """Simple liveness check — call this from Flutter on app launch."""
#     return jsonify({"status": "ok", "model_type": MODEL_TYPE})


# # ── Main prediction endpoint ──────────────────────────────────────────────────
# @app.route("/predict", methods=["POST"])
# def predict():
#     # 1. Validate that an image was sent
#     if "image" not in request.files:
#         return jsonify({"error": "No image field in request. Use multipart/form-data with key 'image'."}), 400

#     file = request.files["image"]

#     if file.filename == "":
#         return jsonify({"error": "Empty filename received."}), 400

#     # 2. Read and size-check the file
#     file_bytes = file.read()
#     size_mb = len(file_bytes) / (1024 * 1024)
#     if size_mb > MAX_FILE_SIZE_MB:
#         return jsonify({"error": f"File too large ({size_mb:.1f} MB). Max is {MAX_FILE_SIZE_MB} MB."}), 413

#     # 3. Validate it's actually an image
#     try:
#         Image.open(io.BytesIO(file_bytes)).verify()
#     except Exception:
#         return jsonify({"error": "Uploaded file is not a valid image."}), 422

#     # 4. Run inference
#     try:
#         if MODEL_TYPE == "YOLO":
#             result = predict_yolo(file_bytes)
#         else:
#             result = {"error": f"Unsupported model type: {MODEL_TYPE}"}
#             return jsonify(result), 500
#     except Exception as e:
#         traceback.print_exc()
#         return jsonify({"error": "Model inference failed.", "detail": str(e)}), 500

#     return jsonify(result), 200



# # ── YOLO inference ────────────────────────────────────────────────────────────
# def predict_yolo(file_bytes: bytes) -> dict:
#     model = get_model()
#     pil_img = preprocess_for_yolo(file_bytes)

#     results = model(pil_img, conf=CONFIDENCE_THRESHOLD, verbose=False)
#     boxes = results[0].boxes

#     if boxes is None or len(boxes) == 0:
#         return {
#             "label": "nothing detected",
#             "confidence": 0.0,
#             "model_type": "YOLO",
#             "detections": []
#         }

#     # Build a list of all detections
#     detections = []
#     for box in boxes:
#         label = results[0].names[int(box.cls)]
#         conf  = round(float(box.conf) * 100, 2)
#         x1, y1, x2, y2 = [round(float(v), 1) for v in box.xyxy[0].tolist()]
#         detections.append({
#             "label": label,
#             "confidence": conf,
#             "box": {"x1": x1, "y1": y1, "x2": x2, "y2": y2}
#         })

#     # Sort by confidence, return the best one as the top-level result
#     detections.sort(key=lambda d: d["confidence"], reverse=True)
#     best = detections[0]

#     return {
#         "label": best["label"],
#         "confidence": best["confidence"],
#         "model_type": "YOLO",
#         "detections": detections   # all detections, not just the best
#     }


# # ── Run ───────────────────────────────────────────────────────────────────────
# if __name__ == "__main__":
#     get_model()   # load model eagerly at startup, not on first request
#     app.run(host="0.0.0.0", port=5000, debug=False)





from flask import Flask, request, jsonify
from flask_cors import CORS
from ultralytics import YOLO
from PIL import Image
import io

app = Flask(__name__)
CORS(app)  # this allows Flutter to talk to Flask

# Load the model ONCE when the server starts
print("Loading YOLO model...")
model = YOLO("model/best.pt")
print("Model loaded. Server is ready.")

@app.route('/')
def home():
    return "The server is up and the YOLO model is ready!"

@app.route("/health", methods=["GET"])
def health():
    return jsonify({"status": "ok"})


@app.route("/predict", methods=["POST"])
def predict():
    # 1. Check that an image was sent
    if "image" not in request.files:
        return jsonify({"error": "No image sent. Use key 'image'."}), 400

    # 2. Read the image
    file_bytes = request.files["image"].read()
    image = Image.open(io.BytesIO(file_bytes)).convert("RGB")

    # 3. Run YOLO on it
    results = model(image, conf=0.25, verbose=False)
    boxes = results[0].boxes

    # 4. If nothing was detected
    if boxes is None or len(boxes) == 0:
        return jsonify({
            "label": "Nothing detected",
            "confidence": 0.0,
            "detections": []
        })

    # 5. Build result list
    detections = []
    for box in boxes:
        label = results[0].names[int(box.cls)]
        confidence = round(float(box.conf) * 100, 2)
        detections.append({"label": label, "confidence": confidence})

    # Sort by confidence — best result first
    detections.sort(key=lambda x: x["confidence"], reverse=True)
    best = detections[0]

    return jsonify({
        "label": best["label"],
        "confidence": best["confidence"],
        "detections": detections
    })


if __name__ == "__main__":
    app.run(host="192.168.0.213", port=5001, debug=True)
