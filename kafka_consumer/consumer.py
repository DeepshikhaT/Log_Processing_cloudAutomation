from kafka import KafkaConsumer
import boto3

consumer = KafkaConsumer(
    'distributed-logs',
    bootstrap_servers='localhost:9092',
    auto_offset_reset='earliest',
    group_id='log-consumer'
)

s3 = boto3.client('s3')
bucket_name = 'log-storage-bucket'

for message in consumer:
    log = message.value.decode('utf-8')
    print(f"Consumed: {log}")
    s3.put_object(Bucket=bucket_name, Key=f'logs/{message.offset}.log', Body=log)
