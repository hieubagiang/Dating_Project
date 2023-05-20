import json
from datetime import datetime
from enum import Enum

from firebase_admin.messaging import Notification


class PaymentStatusType(Enum):
    pending = 'pending'
    success = 'success'
    failed = 'failed'

    def from_dict(self: str):
        return PaymentStatusType[self]


class PaymentHistoryEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj, Enum):
            return obj.value
        elif isinstance(obj, datetime):
            return obj.isoformat()
        elif isinstance(obj, PremiumPackage):
            return obj.__dict__
        elif isinstance(obj, PaymentModel):
            return obj.__dict__
        else:
            return json.JSONEncoder.default(self, obj)


class PremiumPackage:
    name: str
    price: int
    duration_in_days: int
    slug: str

    def __init__(self, name: str, price: int, duration_in_days: int, slug: str):
        self.name = name
        self.price = price
        self.duration_in_days = duration_in_days
        self.slug = slug

    @staticmethod
    def from_dict(data: dict):
        name = data["name"]
        price = data["price"]
        duration_in_days = data["duration_in_days"]
        slug = data["slug"]
        return PremiumPackage(name=name, price=price, duration_in_days=duration_in_days, slug=slug)

    def to_json(self):
        return json.dumps(self, cls=PaymentHistoryEncoder)

    def to_dict(self):
        return json.loads(self.to_json())


class PaymentModel:
    payment_id: str
    user_id: str
    status: PaymentStatusType
    payment_method: str
    transaction_id: str
    created_at: datetime
    updated_at: datetime
    subscription_package: PremiumPackage

    def __init__(self, payment_id: str, user_id: str,
                 status: PaymentStatusType, payment_method: str,
                 transaction_id: str, subscription_package: PremiumPackage, created_at: datetime = datetime.now(),
                 updated_at: datetime = datetime.now()):
        self.payment_id = payment_id
        self.user_id = user_id
        self.status = status
        self.payment_method = payment_method
        self.transaction_id = transaction_id
        self.subscription_package = subscription_package
        self.created_at = created_at
        self.updated_at = updated_at

    def to_json(self):
        return json.dumps(self, cls=PaymentHistoryEncoder)

    def to_dict(self):
        return json.loads(self.to_json())

    def set_success(self):
        self.status = PaymentStatusType.success
        self.updated_at = datetime.now()

    def set_failed(self):
        self.status = PaymentStatusType.failed
        self.updated_at = datetime.now()

    @staticmethod
    def from_dict(data):
        payment_id = data["payment_id"]
        user_id = data["user_id"]
        status = PaymentStatusType.from_dict(data["status"])
        payment_method = data["payment_method"]
        transaction_id = data["transaction_id"]
        subscription_package = PremiumPackage.from_dict(data["subscription_package"])
        created_at = datetime.fromisoformat(data["created_at"]) if 'created_at' in data else None
        updated_at = datetime.fromisoformat(data["updated_at"]) if 'updated_at' in data else None
        return PaymentModel(payment_id=payment_id, user_id=user_id, status=status,
                            payment_method=payment_method, transaction_id=transaction_id,
                            subscription_package=subscription_package, created_at=created_at, updated_at=updated_at)

    def get_notification_message(self):
        title = None
        body = None
        if self.status == PaymentStatusType.success:
            title = "Thanh toán thành công"
            body = f"Bạn đã thanh toán thành công gói premium {self.subscription_package.name}"
        return Notification(title=title, body=body) if title and body else None

