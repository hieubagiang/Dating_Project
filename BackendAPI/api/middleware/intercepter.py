from functools import wraps

from firebase_admin import auth
from flask import request


def require_authenticate(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        id_token = request.headers.get('Authorization')
        # Check Bear token format
        if id_token and id_token.startswith('Bearer '):
            id_token = id_token.split('Bearer ')[1]
        if not id_token:
            return {"status": False, "error_code": "MISSING_TOKEN",
                    "error_message": "Authorization token is missing."}, 401
        try:
            decoded_token = auth.verify_id_token(id_token)
            user_id = decoded_token.get('uid')
            request.user_id = user_id
            request.user = decoded_token

        except auth.InvalidIdTokenError:
            return {"status": False, "error_code": "INVALID_TOKEN",
                    "error_message": "Authorization token is invalid."}, 401
        return f(*args, **kwargs)

    return decorated_function
