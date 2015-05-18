from __future__ import unicode_literals

bind = "unix:/tmp/beta_example_gunicorn.sock"
workers = 4
errorlog = "/srv/log/beta_example_error.log"
loglevel = "error"
proc_name = "beta_example"
