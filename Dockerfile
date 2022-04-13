# 
# FROM python:3.9

FROM mcr.microsoft.com/azureml/sklearn-0.24.1-ubuntu18.04-py37-cpu-inference:latest

# USER root:root
# 
WORKDIR /code

# 
COPY ./requirements.txt /code/requirements.txt

# 
RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

# 
COPY . /code


CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "80"]