## data_checklists.py -- data provider for CRIM checklists
##
## This file is part of CRIM -- Competitive Robotics Inspection Management
## Hosted at github.com/robot-inspection/crim
## See the LICENSE file for terms and conditions
## Copyright (c) 2016 robotinspection.org
## See the github page for contributor information
##
### ******************************************************************* ###

from flask_restful import reqparse, Resource
from connectionpool import ConnectionPool

checklist_parser = reqparse.RequestParser()
checklist_parser.add_argument('name', location=['json'])

class Checklist(Resource):
    def get(self, checklist_name):
        return self.get_checklist(checklist_name)

    def post(self, checklist_name):
        pass

    def get_checklist(self, name):
        sql_string = 'SELECT checklist_members.entry_num, checklist_item.checklist_text FROM ' \
                     'inspection_checklist INNER JOIN checklist_members INNER JOIN checklist_item ' \
                     'WHERE checklist_item.uid == checklist_members.cklist_item AND ' \
                     'checklist_members.parent_checklist == inspection_checklist.uid AND ' \
                     'inspection_checklist.name LIKE %s ORDER BY checklist_members.entry_num ASC ;'

        cursor = ConnectionPool().get_cursor()
        result = cursor.execute(sql_string, name)
        ConnectionPool().free_cursor(cursor)
        return result