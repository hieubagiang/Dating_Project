from flask import Blueprint, request

from api.recommendation.recommend_controller import createGetRecommendAPI

recommendation_bp = Blueprint('recommendation', __name__)

# not use
# get Recommend with filter
# @recommendation_bp.route('/get_recommendation/<string:user_id>', methods=['GET'])
# # @require_authenticate
# def get_recommendations(user_id):
#     # Get page and limit from query parameters
#     page = request.args.get('page', default=1, type=int)
#     limit = request.args.get('limit', default=10, type=int)
#
#     # Get recommendations for user_id based on page and limit
#     recommendations = createGetRecommendAPI(user_id, page, limit)
#     return recommendations
#
