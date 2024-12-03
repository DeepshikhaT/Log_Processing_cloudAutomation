FROM python:3.9-slim
WORKDIR /app
COPY . .
RUN pip install kafka-python boto3
CMD ["python", "consumer.py"]
