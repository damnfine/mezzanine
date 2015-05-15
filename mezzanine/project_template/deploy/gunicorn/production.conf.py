# SETUP TODO
from __future__ import unicode_literals
import multiprocessing

project_name = "example"

bind = "unix:/tmp/%s_gunicorn.sock" % project_name
workers = 4
errorlog = "/srv/log/%s_error.log" % project_name
loglevel = "error"
proc_name = "%s" % project_name