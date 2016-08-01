## db_connection.py -- mysql database connection management object
##
## This file is part of CRIM -- Competitive Robotics Inspection Management
## Hosted at github.com/robot-inspection/crim
## See the LICENSE file for terms and conditions
## Copyright (c) 2016 robotinspection.org
## See the github page for contributor information
##
### ******************************************************************* ###

import mysql.connector
import singleton_type

class ConnectionPool(object):
    __metaclass__ = singleton_type

    def __init__(self):
        self.ConnectionPool = None
        self.ConnectionMap = []

    def InitConnectionPool(self):
        self.ConnectionPool = mysql.connector.pooling.MySQLConnectionPool()

    def get_cursor(self):
        try:
            connection = self.ConnectionPool.get_connection()
        except mysql.connector.pooling.errors.PoolError:
            return None

        cursor = connection.cursor(dictionary=True)
        map_entry = (cursor, connection)
        return cursor

    def free_cursor(self, cursor):
        for i in range(0,len(self.ConnectionMap)):
            if self.ConnectionMap[0] == cursor:
                cursor.close()
                self.ConnectionMap[1].close()

