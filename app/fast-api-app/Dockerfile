# Use the official Python image as the base image for building
# FROM python:3.12.7
# FROM python:3.13.0-slim
FROM python:3.13.1-slim-bookworm
# FROM public.ecr.aws/docker/library/python:3.8.12-slim-buster
# FROM public.ecr.aws/docker/library/python:3.13.1-slim-bookworm

# Set the working directory inside the container
WORKDIR /app

# setup environment with install gradio
COPY requirements.txt ./requirements.txt
RUN pip install --upgrade pip
RUN pip install -r requirements.txt
RUN mkdir app
COPY app app

# Expose the port the app runs on
EXPOSE 8000

# Command to run the app
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
