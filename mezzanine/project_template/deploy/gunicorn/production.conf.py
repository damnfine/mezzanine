from __future__ import unicode_literals

bind = "unix:/tmp/example_gunicorn.sock"
workers = 4
errorlog = "/srv/log/example_error.log"
loglevel = "error"
proc_name = "example"
