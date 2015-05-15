from modeltranslation.translator import translator
from mezzanine.core.translation import TranslatedDisplayable
from mezzanine.pages.models import Page


class TranslatedPage(TranslatedDisplayable):
    fields = ('titles',)

translator.register(Page, TranslatedPage)