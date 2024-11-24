# Mental Health Predictor App

## Problem Statement
The goal of this project is to predict sleep quality based on several factors related to mental health and physical activity. The app uses a machine learning model to predict the sleep quality of an individual by considering factors such as:

- Age
- Stress Level
- Depression Score
- Anxiety Score
- Physical Activity Level

This prediction helps users understand how their mental health and lifestyle factors might influence their sleep quality, allowing them to take steps to improve it.

## Dataset

The model is trained using a dataset based on a **Students Mental Health Survey**. The survey includes various questions related to mental health, stress levels, depression, anxiety, physical activity, and their possible effects on sleep quality.

- **Source**: [Kaggle](https://www.kaggle.com)

## API Endpoint

The app communicates with the following publicly available API endpoint to get predictions:

**API URL:** [https://linear-regression-model-using-flutter.onrender.com/predict](https://linear-regression-model-using-flutter.onrender.com)

### Request Example:

To predict sleep quality, send a `POST` request to the `/predict` endpoint with the following JSON body:

json
{
  "Age": 25,
  "Anxiety_Score": 4.2,
  "Depression_Score": 6,
  "Physical_Activity": 1,
  "Stress_Level": 7.5
}

curl -X 'POST' \
  'https://linear-regression-model-using-flutter.onrender.com/predict' \
  -H 'accept: application/json' \
  -H 'Content-Type: application/json' \
  -d '{
  "Age": 25,
  "Anxiety_Score": 4.2,
  "Depression_Score": 6,
  "Physical_Activity": 1,
  "Stress_Level": 7.5
}'

{
  "message": "Your predicted Sleep Quality is Good",
  "features": {
    "Age": 25,
    "Stress_Level": 7.5,
    "Depression_Score": 6,
    "Anxiety_Score": 4.2,
    "Physical_Activity": 1
  }
}

Response Codes:
200: Successful Response
422: Validation Error (e.g., invalid input data)
Swagger UI:
You can explore the API and try it out using Swagger UI.

# YouTube Video Demo

Watch the demo of the project on YouTube: Project Demo - 2 Minute Overview

# Running the Mobile App

Follow these steps to run the mobile app on your local machine:

# Prerequisites:

- Install Flutter on your machine.

- Ensure that you have an Android/iOS device or emulator available for testing.

- Clone the repository: 

git clone

- Install Dependencies:

Run the following command to install the required dependencies:

- flutter pub get

# Run the App:

- To run the app on your connected device or emulator, use the following command:

flutter run

- Ensure that your device/emulator is set up properly and connected before running the app.

Contributing:

- If you want to contribute to the project, feel free to open an issue or submit a pull request.
