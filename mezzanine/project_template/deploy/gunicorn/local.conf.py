from __future__ import unicode_literals

bind = "unix:/tmp/local_example_gunicorn.sock"
workers = 4
errorlog = "/srv/log/local_example_error.log"
loglevel = "error"
proc_name = "local_example"
