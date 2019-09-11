from flask import jsonify, Blueprint

info_blueprint = Blueprint(name='Info', import_name=__name__, url_prefix='/')


@info_blueprint.route('/info')
def get():
    info = {'name': 'ras-maintenance-page'}
    return jsonify(info)
