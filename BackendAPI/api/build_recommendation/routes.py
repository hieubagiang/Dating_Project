from flask import request, Blueprint

from api import api_app
from api.build_recommendation.build_recommendation_controller import build_scores, get_recommendation
from api.middleware.intercepter import require_authenticate

build_recomendation_bp = Blueprint('recommendation', __name__)

# get Recommend with filter
@build_recomendation_bp.route('/build_recommendation/', methods=['GET'])
# @require_authenticate
def when_build_recommendations():
    build_scores()
    return {'success': True}


# get Recommend with filter
@build_recomendation_bp.route('/get_recommendation', methods=['GET'])
@require_authenticate
def when_get_recommendation_from_user_id():

    return get_recommendation(request)
