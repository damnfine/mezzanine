# SETUP TODO
from __future__ import unicode_literals
import multiprocessing

project_name = "example"
stage = "alpha"

bind = "unix:/tmp/%s_%s_gunicorn.sock" % (stage, project_name, )
workers = 4
errorlog = "/srv/log/%s_%s_error.log" % (stage, project_name, )
loglevel = "error"
proc_name = "%s_%s" % (stage, project_name, )