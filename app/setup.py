from flask import Flask
import os

from app.views.info import info_blueprint
from app.views.maintenance import maintenance_blueprint


def create_app():
    app = Flask(__name__)
    app.register_blueprint(maintenance_blueprint)
    app.register_blueprint(info_blueprint)
    app_config = f'config.{os.environ.get("APP_SETTINGS", "Config")}'
    app.config.from_object(app_config)
    return app
