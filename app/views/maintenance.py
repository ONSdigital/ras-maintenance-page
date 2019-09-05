from flask import render_template, Blueprint

from config import Config

maintenance_blueprint = Blueprint(name='Maintenance', import_name=__name__, url_prefix='/')

MAINTENANCE_TEMPLATES = {"UNPLANNED_MAINTENANCE": "src/unplanned-maintenance.html",
                         "SERVICE_UNAVAILABLE": "src/service-unavailable.html"}

# A catch all route in Flask/Werkzeug
@maintenance_blueprint.route('/', defaults={ 'path': '' })              # Set a default variable 'path' to pass to route handler
@maintenance_blueprint.route('/<path:path>')                            # Route then expects a variable, defaults to blank if not specified
def maintenance(path):                                                  # Pass the variable to the handler, even though we don't need it, to avoid error
    template = MAINTENANCE_TEMPLATES.get(Config.MAINTENANCE_TEMPLATE)

    if template is None:
        return render_template('src/service-unavailable.html')
    else:
        return render_template(template)
