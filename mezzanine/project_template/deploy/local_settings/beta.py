from __future__ import unicode_literals

DEBUG = True

SECRET_KEY = "%(SECRET_KEY)s"
NEVERCACHE_KEY = "%(NEVERCACHE_KEY)s"

ALLOWED_HOSTS = ["beta.example.com"]

DATABASES = {
    "default": {
        # Ends with "postgresql_psycopg2", "mysql", "sqlite3" or "oracle".
        "ENGINE": "django.db.backends.postgresql_psycopg2",
        # DB name or path to database file if using sqlite3.
        "NAME": "example_beta",
        # Not used with sqlite3.
        "USER": "git",
        # Not used with sqlite3.
        "PASSWORD": "",
        # Set to empty string for localhost. Not used with sqlite3.
        "HOST": "",
        # Set to empty string for default. Not used with sqlite3.
        "PORT": "",
    }
}
