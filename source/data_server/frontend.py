## data_frontend.py -- internal data rest API for CRIM
##
## This file is part of CRIM -- Competitive Robotics Inspection Management
## Hosted at github.com/robot-inspection/crim
## See the LICENSE file for terms and conditions
## Copyright (c) 2016 robotinspection.org
## See the github page for contributor information
##
### ******************************************************************* ###

## This file initializes the data server

from flask import Flask
import flask_restful
from data_providers import *

api = flask_restful.Api(prefix='/api/v1')

## Need to automate this resource discovery
resource_list = [
    {'class' : Checklist.Checklist, 'url' : '/checklist/<checklist_name>'},
    {'class' : ListOfChecklists.ListOfChecklists, 'url' : '/checklists'}
]

for entry in resource_list:
    api.add_resource(entry['class'],entry['url'])

app = Flask(__name__.split('.')[0])
api.init_app(app)
if __name__ == '__main__':
    app.run(debug = True)
