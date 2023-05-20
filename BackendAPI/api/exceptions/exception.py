import json


class ApiException(Exception):
    error_message = None
    status = None

    def __init__(self, status: bool, error_message: str):
        self.status = status
        self.error_message = error_message

    def __str__(self):
        return json.dumps({'status': self.status, 'error_message': self.error_message})
