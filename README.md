# 🔵 Rose Leaf Disease Detection Mobile Application
---

Real-Time Phytopathology Detection via Deep Learning
**Rose Leaf Disease Detection App** is a sophisticated mobile-first solution designed to bridge the gap between advanced computer vision and practical agriculture. By leveraging a high-performance YOLOv10 architecture, the system provides instant, localized analysis of rose leaf health, enabling early intervention and reducing crop loss.

---

  ![image alt](https://github.com/MdSohidUllahChowdhury/Rose-leaf-Disease-Detection-App/blob/main/lib/assets/app_screens.png)

---

## 🔵 System Architecture & Tech Stack

- **Frontend (Mobile):** Built with Flutter. It utilizes the camera and image_picker plugins for real-time streaming and high-resolution captures, ensuring a 60 FPS UI experience across both iOS and Android.

- **Backend (Inference Engine):** A **Flask(Python)** REST API. Flask acts as the orchestration layer, receiving image buffers, preprocessing them, and passing them to the model.

- **Deep Learning Model:** YOLOv10 (You Only Look Once). Chosen for its NMS-free (Non-Maximum Suppression) training, which significantly reduces latency and improves accuracy in detecting small-scale disease spots (like early-stage rust or black spot).

- **Data Communication:** Secure POST requests with multipart/form-data for image transmission, returning JSON payloads containing bounding box coordinates and confidence scores.

---

## 🔵 Features

- **AI-powered disease detection** using YOLOv10 model
- **95% accuracy** in classifying rose leaf diseases
- **Optimized for mobile inference** using TensorFlow Lite (35% faster predictions)
- **User-friendly UI/UX** with Flutter framework
- **Offline prediction support** (no internet needed after initial setup)

---

## 🔵 Deep Learning Model

- **Architecture**:
  - **CNN (Convolutional Neural Network)** for classification
  - **YOLOv10** for object detection & localization
- **Accuracy Achieved**: ~95%
- **Frameworks**: TensorFlow, PyTorch, Ultralytics, Jupyter Notebook

---
