import os
import boto3

s3 = boto3.client(
    "s3",
    endpoint_url=os.getenv("S3_ENDPOINT", "http://ministack:4566"),
    region_name=os.getenv("AWS_REGION", "us-east-1"),
    aws_access_key_id=os.getenv("AWS_ACCESS_KEY_ID", "test"),
    aws_secret_access_key=os.getenv("AWS_SECRET_ACCESS_KEY", "test"),
)

BUCKET = os.getenv("BUCKET_NAME", "secure-files-bucket")


def handler(event, context):
    operation = event.get("operation")
    key = event.get("key")

    if not operation:
        raise ValueError("operation is required")

    if not key:
        raise ValueError("key is required")

    if operation == "put":
        body = event.get("body", "")
        s3.put_object(
            Bucket=BUCKET,
            Key=key,
            Body=body.encode("utf-8")
        )
        return {
            "status": "success",
            "operation": "put",
            "key": key
        }

    if operation in ("get", "download"):
        response = s3.get_object(
            Bucket=BUCKET,
            Key=key
        )
        body = response["Body"].read().decode("utf-8")

        return {
            "status": "success",
            "operation": operation,
            "key": key,
            "body": body
        }

    if operation == "copy":
        destination = event.get("destination")

        if not destination:
            raise ValueError("destination is required")

        s3.copy_object(
            Bucket=BUCKET,
            CopySource={
                "Bucket": BUCKET,
                "Key": key
            },
            Key=destination
        )

        return {
            "status": "success",
            "operation": "copy",
            "source": key,
            "destination": destination
        }

    if operation == "delete":
        s3.delete_object(
            Bucket=BUCKET,
            Key=key
        )

        return {
            "status": "success",
            "operation": "delete",
            "key": key
        }

    raise ValueError(f"Unsupported operation: {operation}")
