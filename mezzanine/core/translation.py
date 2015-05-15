from modeltranslation.translator import TranslationOptions


class TranslatedSlugged(TranslationOptions):
    fields = ('title',)


class TranslatedDisplayable(TranslatedSlugged):
    fields = ('_meta_title', 'description')
