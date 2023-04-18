import json

def lambda_handler(event, context):
    print("In lambda handler")
    my_json = {
        "this": "that",
        "other": "not"
    }
    
    
    resp = {
        "statusCode": 200,
        "headers": {
            "Access-Control-Allow-Origin": "*",
        },
        "body": json.dumps(my_json)
    }
    
    return resp