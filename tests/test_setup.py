import unittest

from app.setup import create_app


class TestSetup(unittest.TestCase):

    def setup(self):
        self.app = create_app()
        self.app.testing = True
        self.test_client = self.app.test_client()

    def test_setup_being_created(self):
        test_app = create_app()
        self.assertEqual(test_app.config['UNPLANNED_MAINTENANCE'], False)
