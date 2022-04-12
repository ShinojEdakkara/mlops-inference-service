# 
# FROM python:3.9

FROM mcr.microsoft.com/azureml/sklearn-0.24.1-ubuntu18.04-py37-cpu-inference:latest

RUN ls && pwd
USER root:root
# 
WORKDIR /code

# 
COPY ./requirements.txt /code/requirements.txt

RUN ls && pwd

# 
RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

# 
COPY . /code
# ADD porto_seguro_safe_driver_model.pkl /code/app/

# Code
# COPY ./app /var/azureml-app
# ENV AZUREML_ENTRY_SCRIPT=main.py

# # Model
# COPY model /var/azureml-app/azureml-models
# ENV AZUREML_MODEL_DIR=/var/azureml-app/azureml-models


CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "80"]