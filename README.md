<div align="center">

# 🎨 ChromeAI Colorize
### Bring Black & White History Back to Life with Neural Networks

[![Python](https://img.shields.io/badge/Python-3.11+-3776AB?style=for-the-badge&logo=python&logoColor=white)](https://python.org)
[![React](https://img.shields.io/badge/React-18+-61DAFB?style=for-the-badge&logo=react&logoColor=black)](https://react.dev)
[![Flask](https://img.shields.io/badge/Flask-3.x-000000?style=for-the-badge&logo=flask&logoColor=white)](https://flask.palletsprojects.com)
[![OpenCV](https://img.shields.io/badge/OpenCV-DNN-5C3EE8?style=for-the-badge&logo=opencv&logoColor=white)](https://opencv.org)
[![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)](LICENSE)

> **Upload a black & white photograph → Watch AI breathe color into it in seconds.**

</div>

---

## ✨ What Is This?

**ChromeAI Colorize** is a full-stack AI web application that uses a pre-trained deep neural network to automatically add realistic color to grayscale images.

- Drop a vintage photograph, an old newspaper clipping, or any B&W image.
- The AI model (trained on millions of images by researchers at UC Berkeley) detects objects and infers their most likely colors.
- An interactive **before/after comparison slider** lets you experience the transformation.

> 📖 **Want to understand every line of code?** Read the [Comprehensive Guide](COMPREHENSIVE_GUIDE.md) — a 1,400+ line beginner-friendly book that teaches you how to build this from absolute zero.

---

## 🚀 Live Demo (Local)

| Feature | Description |
|---|---|
| 🖱️ **Drag & Drop** | Drop any image onto the upload zone |
| 🤖 **AI Colorization** | Neural network predicts realistic colors |
| ↔️ **Comparison Slider** | Move the handle to reveal original vs colorized |
| 💾 **Download** | Save your colorized result as JPEG |

---

## 🏗️ Architecture Overview

```
┌─────────────────────────────────────────────────────────┐
│                     USER'S BROWSER                      │
│                                                         │
│   ┌──────────────────────────────────────────────────┐  │
│   │          React Frontend  (Port 5173)             │  │
│   │   Drag & Drop ──► Before/After Slider ──► Save  │  │
│   └────────────────────────┬─────────────────────────┘  │
│                            │ HTTP POST /api/colorize     │
└────────────────────────────┼────────────────────────────┘
                             │
┌────────────────────────────┼────────────────────────────┐
│                            ▼                            │
│   ┌──────────────────────────────────────────────────┐  │
│   │          Flask Backend  (Port 5000)              │  │
│   │   Receive image bytes ──► colorizer.py           │  │
│   └────────────────────────┬─────────────────────────┘  │
│                            │                            │
│   ┌────────────────────────▼─────────────────────────┐  │
│   │          OpenCV DNN + Caffe Model               │  │
│   │   BGR→Lab ──► Predict ab ──► Reconstruct ──► JPEG│  │
│   └──────────────────────────────────────────────────┘  │
│                     PYTHON SERVER                        │
└─────────────────────────────────────────────────────────┘
```

---

## 🧠 The Science Behind It

This app uses a technique from a landmark 2016 research paper:

> **"Colorful Image Colorization"** — Richard Zhang, Phillip Isola, Alexei Efros  
> European Conference on Computer Vision (ECCV), 2016  
> https://arxiv.org/abs/1603.08511

### How It Works in 3 Steps

**1. Color Space Conversion (BGR → Lab)**

The image is converted from standard BGR to the **Lab color space**, which separates lightness (L) from color information (a = green-red axis, b = blue-yellow axis). A grayscale image IS the L channel — so we already have it.

**2. Neural Network Inference**

The model (a Convolutional Neural Network trained on millions of color photos) takes the L channel and predicts a probability distribution across **313 quantized color bins** for every pixel in the image. This approach produces more vibrant, realistic results than predicting a single value.

**3. Reconstruction**

The predicted `ab` channels are combined with the original `L` channel, then converted back to BGR for display. The result: a full-color image.

```
Grayscale Photo  =  L channel  (we already have this)
                              +
AI predicts      →  a + b channels  (green-red and blue-yellow)
                              =
Full Color Image ✓
```

---

## 🛠️ Tech Stack

| Layer | Technology | Why |
|---|---|---|
| **AI Model** | Caffe DNN (pre-trained) | State-of-the-art colorization model |
| **Image Processing** | OpenCV 4.x | Industry-standard computer vision |
| **Math** | NumPy | Fast array operations on pixel data |
| **Backend** | Flask 3.x | Lightweight Python web framework |
| **CORS** | flask-cors | Allows frontend-backend communication |
| **Frontend** | React 18 + Vite | Fast, modern component-based UI |
| **Styling** | Vanilla CSS | Glassmorphism dark-mode design |
| **Version Control** | Git + Git LFS | Large model files tracked via LFS |

---

## 📁 Project Structure

```
📦 Black-and-white-image-colorization/
│
├── 📄 app.py                    # Flask REST API server
├── 📄 colorizer.py              # ImageColorizer class (AI core logic)
├── 📄 colorize.py               # Standalone script version
├── 📄 COMPREHENSIVE_GUIDE.md    # 📖 "The Big Book" — learn everything from scratch
├── 📄 README.md                 # This file
│
├── 📂 Model/                    # AI model files (auto-downloaded on first run)
│   ├── colorization_deploy_v2.prototxt      # Network architecture
│   ├── colorization_release_v2.caffemodel   # Trained weights (~123MB, Git LFS)
│   └── pts_in_hull.npy                      # 313 color cluster centers
│
├── 📂 frontend/                 # React web application
│   ├── src/
│   │   ├── App.jsx              # Main application + comparison slider
│   │   ├── index.css            # Premium dark-mode styling
│   │   └── main.jsx             # React entry point
│   ├── package.json
│   └── vite.config.js
│
├── 📂 colorization/             # Reference: original research repository
└── 📂 images/                   # Sample test images
```

---

## ⚡ Quick Start

### Prerequisites

Make sure these are installed:

- [Python 3.11+](https://python.org/downloads/)
- [Node.js LTS](https://nodejs.org/)
- [Git](https://git-scm.com/)

### 1. Clone the Repository

```bash
git clone https://github.com/Anannya-Vyas/Black-and-white-image-colorization.git
cd Black-and-white-image-colorization
```

> **Note**: The repo uses Git LFS for the 123MB model file. Make sure you have [Git LFS installed](https://git-lfs.github.com/). Run `git lfs install` once before cloning.

### 2. Set Up the Backend

```bash
# Install Python dependencies
pip install opencv-python numpy flask flask-cors

# Start the backend server
python app.py
```

On first run, the server will automatically download the required model files (~123MB). Then it starts on **http://localhost:5000**.

### 3. Set Up the Frontend

Open a **second terminal** (keep the first one running):

```bash
cd frontend
npm install
npm run dev
```

The app opens at **http://localhost:5173**.

### 4. Colorize!

1. Open http://localhost:5173 in your browser.
2. Drag and drop (or click to upload) any black & white image.
3. Click **"Colorize this Image"**.
4. Move the slider to compare before & after.
5. Click **"Download Result"** to save the colorized version.

---

## 🔌 API Reference

The Flask backend exposes a simple REST API:

### `GET /api/status`

Check if the server is running.

**Response:**
```json
{
  "status": "running",
  "ready": true
}
```

---

### `POST /api/colorize`

Colorize a grayscale image.

**Request:** `multipart/form-data`
| Field | Type | Description |
|---|---|---|
| `image` | File | The B&W image to colorize (JPG, PNG, WebP) |

**Success Response (200):**
```json
{
  "image": "data:image/jpeg;base64,/9j/4AAQ...",
  "message": "Successfully colorized!"
}
```

**Error Response (400 / 500):**
```json
{
  "error": "No image uploaded"
}
```

---

## 🧪 Using the Colorizer as a Python Library

You can use `colorizer.py` directly in your own Python scripts:

```python
from colorizer import ImageColorizer

# Create the colorizer (auto-downloads models on first use)
colorizer = ImageColorizer()

# Read any image as bytes
with open("old_photo.jpg", "rb") as f:
    img_bytes = f.read()

# Colorize it
colorized_bytes = colorizer.colorize(img_bytes)

# Save the result
with open("colorized_output.jpg", "wb") as f:
    f.write(colorized_bytes)

print("Done! Open colorized_output.jpg to see the result.")
```

---

## 📈 Model Details

| Property | Value |
|---|---|
| **Architecture** | Convolutional Neural Network (CNN) |
| **Framework** | Caffe |
| **Training Data** | ~1.3 million images from ImageNet |
| **Input** | L channel, resized to 224×224 |
| **Output** | ab channels, 313 quantized color bins |
| **Model Size** | ~123 MB |
| **Inference Time** | < 1 second (CPU, modern laptop) |
| **Original Paper** | ECCV 2016 by Zhang, Isola, Efros |

---

## 🤝 How to Contribute

Contributions are welcome! Here are some ideas:

- 🌟 Add a gallery of before/after examples
- 📊 Add confidence visualization showing where the AI is most uncertain
- 🔧 Add image preprocessing (auto-enhance contrast before colorizing)
- 🚀 Deploy to Heroku or Render with a one-click button
- 🎨 Add alternative colorization models (SIGGRAPH17 for interactive colorization)

**To contribute:**

```bash
# Fork the repo, then:
git checkout -b feature/your-feature-name
git commit -m "Add: your feature description"
git push origin feature/your-feature-name
# Open a Pull Request on GitHub
```

---

## 📖 Learn How It Was Built

This project comes with a **comprehensive, beginner-friendly guide** that explains absolutely everything from scratch — no prior programming experience required.

📚 **[Read the Complete Guide →](COMPREHENSIVE_GUIDE.md)**

**The guide covers (36 chapters):**
- Python programming from zero
- How images are stored as numbers
- The math behind Lab color space
- How neural networks learn and make predictions
- Every line of Flask backend code, explained
- Every line of React frontend code, explained
- Git, GitHub, and deploying your work

---

## 📜 License

This project is licensed under the MIT License — see the [LICENSE](LICENSE) file for details.

The colorization model is based on research by Richard Zhang, Phillip Isola, and Alexei Efros. The original model weights are distributed for research and educational use.

---

## 🙏 Acknowledgments

- **Richard Zhang, Phillip Isola, Alexei Efros** — for the groundbreaking colorization research.
- **OpenCV team** — for the DNN module that makes running Caffe models effortless.
- **The open-source community** — for Flask, React, Vite, and all the tools that make projects like this possible.

---

<div align="center">

**Made with ❤️ by [Anannya Vyas](https://github.com/Anannya-Vyas)**

⭐ If this project helped you, please give it a star!

</div>
