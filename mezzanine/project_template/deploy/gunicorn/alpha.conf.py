from __future__ import unicode_literals

bind = "unix:/tmp/alpha_example_gunicorn.sock"
workers = 4
errorlog = "/srv/log/alpha_example_error.log"
loglevel = "error"
proc_name = "alpha_example"
