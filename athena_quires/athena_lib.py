# File: AthenaLibrary.py
import boto3

def run_athena_query(database, query):
    client = boto3.client('athena')
    response = client.start_query_execution(
        QueryString=query,
        QueryExecutionContext={'Database': database},
        ResultConfiguration={
            'OutputLocation': 's3://your-query-results-bucket/'
        }
    )
    return response['QueryExecutionId']
