import os


class Config(object):
    UNPLANNED_MAINTENANCE = os.getenv('UNPLANNED_MAINTENANCE', False)
    PORT = os.getenv('PORT', 8077)
