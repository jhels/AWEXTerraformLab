import json

def lambda_handler(event, context):
    print("In lambda handler")
    my_json = {
        "this": "Hello from AWS Lambda!!"
    }
    
    
    resp = {
        "statusCode": 200,
        "body": json.dumps(my_json)
    }
    
    return resp