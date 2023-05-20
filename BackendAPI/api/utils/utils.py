# Verify token
import datetime

from dateutil.parser import parser
from firebase_admin import auth


def verify_token(token):
    try:
        decoded_token = auth.verify_id_token(token)
        uid = decoded_token['uid']
        return True, uid
    except auth.InvalidIdTokenError:
        return False, None


def date_to_datetime(date: datetime.date):
    return datetime.datetime.combine(date, datetime.time(0, 0, 0))


def createPagination(total, page, limit):
    pagination = {'total': total, 'page': page, 'limit': limit}
    return pagination


def limitDocs(docs, page, limit):
    start = (page - 1) * limit
    end = start + limit
    # return error if page is out of range
    return docs[start:end], createPagination(len(docs), page, limit)


def get_pagination_params(request):
    page = request.args.get('page', 1, type=int)
    limit = request.args.get('limit', 10, type=int)
    return page, limit
