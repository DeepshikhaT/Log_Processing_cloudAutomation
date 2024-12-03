import json
import boto3

def lambda_handler(event, context):
    s3 = boto3.client('s3')
    for record in event['Records']:
        bucket_name = record['s3']['bucket']['name']
        key = record['s3']['object']['key']
        
        # Download log file
        response = s3.get_object(Bucket=bucket_name, Key=key)
        log_data = response['Body'].read().decode('utf-8')
        
        # Process log data (example: filter out error logs)
        processed_log_data = process_log_data(log_data)
        
        # Upload processed log back to S3
        processed_key = f"processed/{key}"
        s3.put_object(Bucket=bucket_name, Key=processed_key, Body=processed_log_data)
        
    return {
        'statusCode': 200,
        'body': json.dumps('Log processed successfully')
    }

def process_log_data(log_data):
    # Example: Filter out logs containing 'error'
    filtered_logs = [line for line in log_data.splitlines() if 'error' not in line]
    return "\n".join(filtered_logs)
