#-*- coding: utf-8 -*-

from django.conf.urls import patterns, include, url
from sklcc import views

# Uncomment the next two lines to enable the admin:
# from django.contrib import admin
# admin.autodiscover()


# from django.conf import settings
urlpatterns = patterns('',
    # Examples:
    # url(r'^$', 'MSZ_YCL.views.home', name='home'),
    # url(r'^MSZ_YCL/', include('MSZ_YCL.foo.urls')),

    # Uncomment the admin/doc line below to enable admin documentation:
    # url(r'^admin/doc/', include('django.contrib.admindocs.urls')),

    # Uncomment the next line to enable the admin:
    # url(r'^admin/', include(admin.site.urls)),
    url(r'^$', views.index ),

	url(r'^api/inspect/(\w+)/getTasks/$', views.getTasks),
	url(r'^api/inspect/editTask/$', views.editTask),
	url(r'^api/inspect/(.+)/commitTask/$', views.commitTask),
    url(r'^api/inspect/getFlowList/$', views.getFlow),
    #TODO:F01改成数据库获取
	url(r'^api/inspect/(.+)/get(\w+)Data/(\w+)/$', views.getFormData),
	url(r'^api/inspect/(.+)/insert(\w+)Data/$', views.insertFormData),
	url(r'^api/inspect/getAllQuestions/(.+)$', views.getAllQuestions),
    url(r'^api/inspect/(.+)/getTaskProcess/$', views.getTaskProcess),
    url(r'^api/inspect/(.+)/deleteTask/$', views.deleteTask),
    url(r'^api/inspect/(.+)/passProcess/(.+)/$', views.passProcess),
	#administration
    url(r'^api/users/$',views.users_info_operations),
    url(r'^api/users/departmentAndJob/$',views.getDepartmentsAndJobs),
    url(r'^api/users/(\w+)/$',views.user_info),
    url(r'^api/users/(\w+)/login/$',views.login),
    url(r'^api/users/(\w+)/logout/$',views.logout),
    url(r'^api/users/(\w+)/edit/$', views.editUser),
	url(r'^api/users/(\w+)/delete/$', views.deleteUser),


	url(r'api/test/$', views.test)
)
# if settings.DEBUG:
#     import debug_toolbar
#     urlpatterns += patterns('',
#         url(r'^__debug__/', include(debug_toolbar.urls)),
#     )

