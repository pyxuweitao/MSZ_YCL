#-*- coding: utf-8 -*-

from django.conf.urls import patterns, include, url
from sklcc import views

# Uncomment the next two lines to enable the admin:
# from django.contrib import admin
# admin.autodiscover()

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
    url(r'^api/inspect/getFlowList/$', views.getFlow),
    #TODO:F01改成数据库获取
	url(r'^api/inspect/(.+)/get(\w+)Data/(\w+)/$', views.getFormData),
	url(r'^api/inspect/(.+)/insert(\w+)Data/$', views.insertFormData),
    url(r'^api/inspect/(.+)/getTaskProcess/$', views.getTaskProcess),
    url(r'^api/inspect/(.+)/deleteTask/$', views.deleteTask),
    url(r'^api/inspect/(.+)/passProcess/(.+)/$', views.passProcess),

    # ========================================================
    url(r'^api/forms/$', views.get_form),
    url(r'^api/forms/(\w{6})/$', views.get_form_id),
    url(r'^api/forms/(\w{6})/data/$',views.get_data),
    url(r'^api/forms/(\w{6})/config/$',views.get_form_config),

    url(r'^api/processes/$',views.get_all_processes),
    url(r'^api/processes/(\w+)/$',views.get_process),
    url(r'^api/processes/(\w+)/references/$',views.reference),
    url(r'^api/processes/(\w+)/checkstatus/$',views.process_check_status),
    url(r'^api/processes/(\w+)/iscomplete/$',views.process_iscomplete),

    url(r'^api/processes/(\w+)/processnodes/(\w+)/availableflag/$',views.node_availableflag),
    url(r'^api/processes/(\w+)/processnodes/(\w+)/checkstatus/$',views.node_check_status),
    url(r'^api/processes/(\w+)/processnodes/(\w+)/conclusion/$',views.node_conclusion),

    url(r'^api/arrivals/$',views.add_all_arrival_process),
    url(r'^api/arrivals/(\w+)/$',views.add_arrival_process),

    url(r'^api/kvstore/(\S+)/$',views.kvstore),

    url(r'^api/processtypes/subclasses/$',views.subclasses),
    url(r'^api/processtypes/subclasses/(\w+)/$',views.delete_subclass),
    url(r'^api/processtypes/$',views.process_type_all_operation),
    url(r'^api/processtypes/(\w+)/$',views.process_type_operation),

    url(r'^api/processtypes/(\w+)/processnodetypes/$',views.process_node_type_all_operation),
    url(r'^api/processtypes/(\w+)/processnodetypes/(\w+)/$',views.process_node_type_operation),

    url(r'^api/sqlquery/$',views.sqlquery),

    url(r'^api/forms/resources/options/$',views.forms_resources_all_options),
    url(r'^api/forms/resources/options/(\w+)/$',views.forms_resources_options),
    url(r'^api/forms/(\w+)/tags/$',views.tags_operation),

    url(r'^api/feedback/$',views.feedback),

    # ==================================================
    url(r'^api/users/$',views.users_info_operations),
    url(r'^api/users/departmentAndJob/$',views.getDepartmentsAndJobs),
    url(r'^api/users/(\w+)/$',views.user_info),
    url(r'^api/users/(\w+)/login/$',views.login),
    url(r'^api/users/(\w+)/logout/$',views.logout),
    url(r'^api/users/(\w+)/operations/$',views.users_operation),
    url(r'^api/users/(\w+)/edit/$', views.editUser),
	url(r'^api/users/(\w+)/delete/$', views.deleteUser),


	url(r'api/test/$', views.test)
)

# from django.conf import settings
# if settings.DEBUG:
#     import debug_toolbar
#     urlpatterns += patterns('',
#         url(r'^__debug__/', include(debug_toolbar.urls)),
#     )

