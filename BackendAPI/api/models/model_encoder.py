from datetime import datetime
from enum import Enum
from typing import TYPE_CHECKING

if TYPE_CHECKING:
    from api.models import CallModel

import json


class AllModelEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj, Enum):
            return obj.value
        elif isinstance(obj, datetime):
            return obj.isoformat()
        elif isinstance(obj, CallModel):
            return obj.__dict__
        else:
            return json.JSONEncoder.default(self, obj)
