

from project_template import settings

globals().update(i for i in settings.__dict__.items() if i[0].isupper())

# Require the mezzanine.accounts app. We use settings.INSTALLED_APPS here so
# the syntax test doesn't complain about an undefined name.
if "mezzanine.accounts" not in settings.INSTALLED_APPS:
    INSTALLED_APPS = list(settings.INSTALLED_APPS) + ["mezzanine.accounts"]

# Use the MD5 password hasher by default for quicker test runs.
PASSWORD_HASHERS = ('django.contrib.auth.hashers.MD5PasswordHasher',)


DEBUG = True

# Make these unique, and don't share it with anybody.
SECRET_KEY = "%(SECRET_KEY)s"
NEVERCACHE_KEY = "%(NEVERCACHE_KEY)s"

DATABASES = {
    "default": {
        # Ends with "postgresql_psycopg2", "mysql", "sqlite3" or "oracle".
        "ENGINE": "django.db.backends.sqlite3",
        # DB name or path to database file if using sqlite3.
        "NAME": "dev.db",
        # Not used with sqlite3.
        "USER": "",
        # Not used with sqlite3.
        "PASSWORD": "",
        # Set to empty string for localhost. Not used with sqlite3.
        "HOST": "",
        # Set to empty string for default. Not used with sqlite3.
        "PORT": "",
    }
}

###################
# DEPLOY SETTINGS #
###################

# Domains for public site
# ALLOWED_HOSTS = [""]

# These settings are used by the default fabfile.py provided.
# Check fabfile.py for defaults.

# FABRIC = {
#     "DEPLOY_TOOL": "rsync",  # Deploy with "git", "hg", or "rsync"
#     "SSH_USER": "",  # VPS SSH username
#     "HOSTS": [""],  # The IP address of your VPS
#     "DOMAINS": ALLOWED_HOSTS,  # Edit domains in ALLOWED_HOSTS
#     "REQUIREMENTS_PATH": "requirements.txt",  # Project's pip requirements
#     "LOCALE": "en_US.UTF-8",  # Should end with ".UTF-8"
#     "DB_PASS": "",  # Live database password
#     "ADMIN_PASS": "",  # Live admin user password
#     "SECRET_KEY": SECRET_KEY,
#     "NEVERCACHE_KEY": NEVERCACHE_KEY,
# }
