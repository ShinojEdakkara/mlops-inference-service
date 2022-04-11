
import json
import numpy as np
import os
import pickle
import joblib

from typing import Optional

from fastapi import FastAPI
from azureml.core.model import Model

app = FastAPI()



@app.get("/")
def read_root():
    return {"Hello": "World"}


@app.get("/items/{item_id}")
def read_item(item_id: int, q: Optional[str] = None):
    return {"item_id": item_id, "q": q}


@app.get("/models")
def predict_score(data):
    score = run(data)
    return score



def init():
    global model
    # AZUREML_MODEL_DIR is an environment variable created during deployment.
    # It's the path to the model folder (./azureml-models/$MODEL_NAME/$VERSION).
    # For multiple models, it points to the folder containing all deployed models (./azureml-models).
    model_path = Model.get_model_path(
        model_name="porto_seguro_safe_driver_model.pkl")

    model = joblib.load(model_path)

def run(raw_data):
    model_path = Model.get_model_path(
        model_name="app/porto_seguro_safe_driver_model.pkl")

    model = joblib.load(model_path)

    data = json.loads(raw_data)
    # data = np.array(raw_data)
    # Make prediction.
    y_hat = model.predict(data)
    # You can return any data type as long as it's JSON-serializable.
    return y_hat.tolist()