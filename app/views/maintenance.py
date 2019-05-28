from flask import render_template, Blueprint

from config import Config

maintenance_blueprint = Blueprint(name='Maintenance', import_name=__name__, url_prefix='/')

MAINTENANCE_TEMPLATES = {"UNPLANNED_MAINTENANCE": "src/unplanned-maintenance.html",
                         "SERVICE_UNAVAILABLE": "src/service-unavailable.html"}


@maintenance_blueprint.route('/')
def maintenance():
    template = MAINTENANCE_TEMPLATES.get(Config.MAINTENANCE_TEMPLATE)

    if template is None:
        return render_template('src/service-unavailable.html')
    else:
        return render_template(template)
