## ListOfChecklists.py -- data provider for CRIM list of checklists
##
## This file is part of CRIM -- Competitive Robotics Inspection Management
## Hosted at github.com/robot-inspection/crim
## See the LICENSE file for terms and conditions
## Copyright (c) 2016 robotinspection.org
## See the github page for contributor information
##
### ******************************************************************* ###

from flask_restful import  Resource
from connectionpool import ConnectionPool

class ListOfChecklists(Resource):
    def get(self):
        return self.get_checklists()

    def post(self):
        pass


    def get_checklists(self):
        sql_string = 'SELECT * FROM inspection_checklist;'
        cursor = ConnectionPool().get_cursor()
        result = cursor.execute(sql_string)
        ConnectionPool().free_cursor(cursor)
        return result