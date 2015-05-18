# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations
import mezzanine.pages.fields
import mezzanine.core.fields


class Migration(migrations.Migration):

    dependencies = [
        ('sites', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='Page',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('title', models.CharField(max_length=500, verbose_name='Title')),
                ('slug', models.CharField(help_text='Leave blank to have the URL auto-generated from the title.', max_length=2000, null=True, verbose_name='URL', blank=True)),
                ('_meta_title', models.CharField(help_text='Optional title to be used in the HTML title tag. If left blank, the main title field will be used.', max_length=500, null=True, verbose_name='Title', blank=True)),
                ('description', models.TextField(verbose_name='Description', blank=True)),
                ('created', models.DateTimeField(null=True, editable=False)),
                ('short_url', models.URLField(null=True, blank=True)),
                ('in_sitemap', models.BooleanField(default=True, verbose_name='Show in sitemap')),
                ('_order', mezzanine.core.fields.OrderField(null=True, verbose_name='Order')),
                ('titles', models.CharField(max_length=1000, null=True, editable=False)),
                ('content_model', models.CharField(max_length=50, null=True, editable=False)),
                ('login_required', models.BooleanField(default=False, help_text='If checked, only logged in users can view this page', verbose_name='Login required')),
            ],
            options={
                'ordering': ('titles',),
                'verbose_name': 'Page',
                'verbose_name_plural': 'Pages',
            },
            bases=(models.Model,),
        ),
        migrations.AddField(
            model_name='page',
            name='site',
            field=models.ForeignKey(editable=False, to='sites.Site'),
            preserve_default=True,
        ),
    ]
