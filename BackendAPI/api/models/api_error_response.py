import dataclasses
import json
from datetime import datetime
from enum import Enum


class ApiErrorResponseEncoder(json.JSONEncoder):
    def default(self, obj):
        if obj is None:
            return None
        if isinstance(obj, Enum):
            return obj.value
        elif isinstance(obj, datetime):
            return obj.isoformat()
        elif isinstance(obj, ApiResponse):
            return obj.__dict__
        elif isinstance(obj, ApiErrorResponse):
            return obj.__dict__
        else:
            return json.JSONEncoder.default(self, obj)


class ApiResponse:
    status: bool
    data: dict = None
    message: str = None
    code: str = None

    def __init__(self,data: dict = None, message: str = None, code: str = None):
        self.status = True
        self.data = data
        self.message = message
        self.code = code
    def to_json(self):
        return json.dumps(self, cls=ApiErrorResponseEncoder)

    def __str__(self):
        return self.to_json()

    def to_dict(self):
        return json.loads(self.to_json())

class ApiErrorResponse:
    status: bool
    error_message: str
    code: str

    def __init__(self, error_message: str, code: str):
        self.status = False
        self.error_message = error_message
        self.code = code
    def to_json(self):
        return json.dumps(self, cls=ApiErrorResponseEncoder)

    def __str__(self):
        return self.to_json()

    def to_dict(self):
        return json.loads(self.to_json())
