# -*- coding: utf-8 -*-
__author__ = 'XuWeitao'
from rawSql import Raw_sql
import json

def whetherAlreadyRegistered(Id):
    """
    判断该ID是否在数据库中已经存在
    :param Id: 管理员提交的ID号
    :return: 是否数据库中已经存在的布尔值
    """
    raw = Raw_sql()
    raw.sql = "SELECT * FROM RMI_ACCOUNT_USER WHERE Id = '%s'" %Id
    return True if len(raw.query_all()) != 0 else False

def authentication(Id, password):
    """
    验证用户登录
    :param Id:用户ID
    :param password:用户密码
    :return: 返回是否验证通过的布尔值
    """
    pass

def getEmployeeCreateTime(Id):
    """
    获取数据库数据表RMI_ACCOUNT_USER中对应id的Createtime字段的值
    :param Id: 员工ID
    :return: 返回对应创建时间的字段的值
    """
    raw = Raw_sql()
    raw.sql = "SELECT CreateTime FROM RMI_ACCOUNT_USER WHERE Id = '%s'"%Id
    result = raw.query_one()
    if not result:
        return None
    else:
        return result[0]

def editEmployeeInfo(employeeInfo):
    Id         = employeeInfo['Id']
    password   = employeeInfo['Password']
    name       = employeeInfo['Name']
    department = employeeInfo['Department']['name']
    job        = employeeInfo['Job']['name']
    avatar     = 'default' if 'Avatar' not in employeeInfo else unicode(employeeInfo['Avatar'])
    permission = 'default' if 'Permission' not in employeeInfo else json.dumps(employeeInfo['Permission'],encoding='utf-8')
    permission = permission.replace("'",'"')
    isNew      = True if employeeInfo['isNew'] == "True" else False
    raw        = Raw_sql()
    if isNew:
        raw.sql = "INSERT INTO RMI_ACCOUNT_USER(id, Password, Department, Job, Avatar, Permission, CreateTime, LastModifiedTime, Name)" \
                   " VALUES ('%s','%s','%s','%s','%s','%s', getdate(), getdate(), '%s');"%(
            Id, password, department, job, avatar, permission, name )
    else:
        createtime = getEmployeeCreateTime(Id)
        raw.sql    = "DELETE FROM RMI_ACCOUNT_USER WHERE Id = '%s';"%Id
        raw.sql   += "INSERT INTO RMI_ACCOUNT_USER(id, Password, Department, Job, Avatar, Permission, CreateTime, LastModifiedTime, Name)" \
                   " VALUES ('%s','%s','%s','%s','%s','%s','%s', getdate(), '%s');"%(
            Id, password, department, job, avatar, permission, createtime, name )
    print raw.update()




