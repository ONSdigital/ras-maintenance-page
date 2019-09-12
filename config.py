import os


class Config(object):
    MAINTENANCE_TEMPLATE = os.getenv('MAINTENANCE_TEMPLATE')
    PORT = os.getenv('PORT', 8077)
    VERSION = '1.0.2'
