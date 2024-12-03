from kafka import KafkaProducer
import time
import random

producer = KafkaProducer(bootstrap_servers='localhost:9092')

logs = [
    "INFO: User logged in",
    "ERROR: Database connection failed",
    "INFO: File uploaded",
    "WARN: Disk space low",
    "INFO: Transaction completed"
]

while True:
    log = random.choice(logs)
    producer.send('distributed-logs', log.encode('utf-8'))
    print(f"Produced: {log}")
    time.sleep(2)
