from __future__ import unicode_literals

SECRET_KEY = "97ab9fc8-4e77-4034-bf49-67a205a78b2da07becf2-8f4c-4ab3-" \
             "b169-1b7d6f3aeae8b8162e23-eaca-4894-9399-30f3067a1f44"
NEVERCACHE_KEY = "0e2d6fc0-4057-4a7c-be34-2992c4523a2f2d4fb161-ceb5-433d-" \
                 "bbf2-7f84698ea810128d828b-c45b-47bc-8ac2-9b479fa64657"

ALLOWED_HOSTS = ["example.com", "www.example.com"]

DATABASES = {
    "default": {
        # Ends with "postgresql_psycopg2", "mysql", "sqlite3" or "oracle".
        "ENGINE": "django.db.backends.postgresql_psycopg2",
        # DB name or path to database file if using sqlite3.
        "NAME": "example",
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
