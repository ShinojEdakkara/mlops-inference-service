# 
# FROM python:3.9

FROM mcr.microsoft.com/azureml/sklearn-0.24.1-ubuntu18.04-py37-cpu-inference:latest

RUN ls && pwd
USER root
# 
WORKDIR /code

# 
COPY ./requirements.txt /code/requirements.txt

RUN ls && pwd

# 
RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

# 
COPY ./app /code/app
ADD porto_seguro_safe_driver_model.pkl /code/app/

RUN ls app && pwd


CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "80"]