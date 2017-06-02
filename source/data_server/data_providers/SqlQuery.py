## ListOfChecklists.py -- data provider for CRIM list of checklists
##
## This file is part of CRIM -- Competitive Robotics Inspection Management
## Hosted at github.com/robot-inspection/crim
## See the LICENSE file for terms and conditions
## Copyright (c) 2016 robotinspection.org
## See the github page for contributor information
##
### ******************************************************************* ###

from flask_restful import Resource
from connectionpool import ConnectionPool

class ListOfChecklists(Resource):

    def __init__(self, query_string):
        self.query = query_string

    def get(self):
        return self.get_result()

    def post(self):
        pass


    def get_result(self):
        cursor = ConnectionPool().get_cursor()
        result = cursor.execute(self.query)
        ConnectionPool().free_cursor(cursor)
        return result
