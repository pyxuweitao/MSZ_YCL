#-*- coding: utf-8 -*-
__author__ = "XuWeitao"

from django.test import TestCase
from rawSql import Raw_sql
from django.core.urlresolvers import reverse

class testViewsTest(TestCase):
	def test_test_whether_inserted(self):
		raw     = Raw_sql()
		raw.sql = "SELECT * FROM RMI_TASK"
		print dir(raw)
		preNo   = len(raw.query_all())
		print 'here'
		print preNo
		response = self.client.get(reverse("views:test"))
		self.assertEqual( response.status_code, 200 )
		afterNo = len(raw.query_all())
		print afterNo
		self.assertEqual( afterNo - preNo, 10 )