from modeltranslation.translator import translator
from mezzanine.core.translation import (TranslatedDisplayable,
                                        TranslatedRichText)
from mezzanine.pages.models import Page, RichTextPage


class TranslatedPage(TranslatedDisplayable):
    fields = ('titles',)


class TranslatedRichTextPage(TranslatedRichText):
    fields = ()


translator.register(Page, TranslatedPage)
translator.register(RichTextPage, TranslatedRichTextPage)
