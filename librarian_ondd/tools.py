import os

from librarian_core.contrib.templates.decorators import template_helper


@template_helper
def has_tuner():
    TUNER_DEV_PATH = '/dev/dvb/adapter0/frontend0'
    return os.path.exists(TUNER_DEV_PATH)
