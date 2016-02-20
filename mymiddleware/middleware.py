# -*- coding: utf-8 -*-
import time
from django.db import connection, transaction
from sklcc.views import set_randhex

class MonitorMiddleware(object):
    def process_view(self,request,view_func,view_args,view_kwargs):
        ip = request.META.get('REMOTE_ADDR','unknown')
        content_length = request.META.get('CONTENT_LENGTH','unknown')
        date = time.time()
        start = time.time()*1000
        response = view_func(request,*view_args,**view_kwargs)
        total_time = int(time.time()*1000 - start)
        url = request.get_full_path()

        cursor = connection.cursor()
        print "insert into RMI_MONITOR(Id,Ip,ContentLength,[Date],TotalTime,Url) values ('%s','%s','%s','%s','%s','111')" % (set_randhex('Id','RMI_MONITOR'),ip,content_length,date,total_time,url)
        cursor.execute("insert into RMI_MONITOR(Id,Ip,ContentLength,[Date],TotalTime,Url) values ('%s','%s','%s','%s','%s','%s')" % (set_randhex('Id','RMI_MONITOR'),ip,content_length,date,total_time,url))
        transaction.commit_unless_managed()
        return response