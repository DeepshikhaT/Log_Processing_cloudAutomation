import boto3

def lambda_handler(event, context):
    s3 = boto3.client('s3')
    bucket = event['Records'][0]['s3']['bucket']['name']
    key = event['Records'][0]['s3']['object']['key']
    
    response = s3.get_object(Bucket=bucket, Key=key)
    log_content = response['Body'].read().decode('utf-8')
    
    if "ERROR" in log_content:
        print(f"Error found in log: {log_content}")
    else:
        print(f"Log is valid: {log_content}")
