import unittest


from app.setup import create_app
from config import Config


class TestMaintenance(unittest.TestCase):

    def setUp(self):
        self.app = create_app()
        self.app.testing = True
        self.client = self.app.test_client()

    def test_get_maintenance_page(self):
        response = self.client.get('/')
        self.assertEqual(response.status_code, 200)
        self.assertTrue('Service temporarily unavailable'.encode() in response.data)

    def test_get_unplanned_maintenance_page(self):
        Config.MAINTENANCE_TEMPLATE = 'UNPLANNED_MAINTENANCE'
        response = self.client.get('/')
        self.assertEqual(response.status_code, 200)
        self.assertTrue('Unplanned downtime'.encode() in response.data)



