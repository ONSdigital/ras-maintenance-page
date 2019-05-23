from flask import render_template, Blueprint

from config import Config

maintenance_blueprint = Blueprint(name='Maintenance', import_name=__name__, url_prefix='/')


@maintenance_blueprint.route('/')
def maintenance():
    if Config.UNPLANNED_MAINTENANCE:
        return render_template('src/unplanned-maintenance.html')
    else:
        return render_template('src/index.html')
