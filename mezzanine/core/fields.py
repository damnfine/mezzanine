from __future__ import unicode_literals
from future.builtins import str
from future.utils import with_metaclass

from bleach import clean

from django.conf import settings
from django.contrib.admin.widgets import AdminTextareaWidget
from django.core.exceptions import ImproperlyConfigured, ValidationError
from django.db import models
from django.forms import MultipleChoiceField
from django.utils.text import capfirst
from django.utils.translation import ugettext_lazy as _

from mezzanine.core.forms import OrderWidget
from mezzanine.utils.importing import import_dotted_path


# Tags and attributes added to richtext filtering whitelist when the
# RICHTEXT_FILTER_LEVEL is set to low. General use-case for these is
# allowing embedded video, but we will add to this fixed list over
# time as more use-cases come up. We won't ever add script tags or
# events (onclick etc) to this list. To enable those, filtering can
# be turned off in the settings admin.
LOW_FILTER_TAGS = ("iframe", "embed", "video", "param", "source", "object")
LOW_FILTER_ATTRS = ("allowfullscreen", "autostart", "loop", "hidden",
                    "playcount", "volume", "controls", "data", "classid")


class OrderField(models.IntegerField):
    def formfield(self, **kwargs):
        kwargs.update({'widget': OrderWidget,
                       'required': False})
        return super(OrderField, self).formfield(**kwargs)


class MultiChoiceField(with_metaclass(models.SubfieldBase, models.CharField)):
    """
    Charfield that stores multiple choices selected as a comma
    separated string. Based on http://djangosnippets.org/snippets/2753/
    """

    def formfield(self, *args, **kwargs):
        from mezzanine.core.forms import CheckboxSelectMultiple
        defaults = {
            "required": not self.blank,
            "label": capfirst(self.verbose_name),
            "help_text": self.help_text,
            "choices": self.choices,
            "widget": CheckboxSelectMultiple,
            "initial": self.get_default() if self.has_default() else None,
        }
        defaults.update(kwargs)
        return MultipleChoiceField(**defaults)

    def get_db_prep_value(self, value, **kwargs):
        if isinstance(value, (tuple, list)):
            value = ",".join([str(i) for i in value])
        return value

    def to_python(self, value):
        if isinstance(value, str):
            value = value.split(",")
        return value

    def validate(self, value, instance):
        choices = [str(choice[0]) for choice in self.choices]
        if set(value) - set(choices):
            error = self.error_messages["invalid_choice"] % value
            raise ValidationError(error)

    def value_to_string(self, obj):
        value = self._get_val_from_obj(obj)
        return ",".join(value)


# Define a ``FileField`` that maps to filebrowser's ``FileBrowseField``
# if available, falling back to Django's ``FileField`` otherwise.
try:
    FileBrowseField = import_dotted_path("%s.fields.FileBrowseField" %
                                         settings.PACKAGE_NAME_FILEBROWSER)
except ImportError:
    class FileField(models.FileField):
        def __init__(self, *args, **kwargs):
            for fb_arg in ("format", "extensions"):
                kwargs.pop(fb_arg, None)
            super(FileField, self).__init__(*args, **kwargs)
else:
    class FileField(FileBrowseField):
        def __init__(self, *args, **kwargs):
            kwargs.setdefault("directory", kwargs.pop("upload_to", None))
            kwargs.setdefault("max_length", 255)
            super(FileField, self).__init__(*args, **kwargs)


# South requires custom fields to be given "rules".
# See http://south.aeracode.org/docs/customfields.html
if "south" in settings.INSTALLED_APPS:
    try:
        from south.modelsinspector import add_introspection_rules
        add_introspection_rules(patterns=["mezzanine\.core\.fields\."],
            rules=[((FileField, MultiChoiceField), [], {})])
    except ImportError:
        pass
