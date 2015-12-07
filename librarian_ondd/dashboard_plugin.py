"""
plugin.py: ONDD plugin

Allows Librarian to communicate with ONDD.

Copyright 2014-2015, Outernet Inc.
Some rights reserved.

This software is free software licensed under the terms of GPLv3. See COPYING
file that comes with the source code, or http://www.gnu.org/licenses/gpl.txt.
"""

from bottle_utils.i18n import lazy_gettext as _

from librarian_core.contrib.templates.decorators import template_helper
from librarian_dashboard.dashboard import DashboardPlugin

from .consts import PRESETS
from .forms import ONDDForm
from .setup import read_ondd_setup

try:
    from ondd_ipc import ipc
except AttributeError:
    raise RuntimeError('ONDD plugin requires UNIX sockets')


COMPARE_KEYS = ('frequency', 'symbolrate', 'polarization', 'delivery',
                'modulation')


@template_helper
def get_bitrate(status):
    for stream in status.get('streams', []):
        return stream['bitrate']

    return 0




def match_preset(data):
    if not data:
        return 0
    data = {k: str(v) for k, v in data.items() if k in COMPARE_KEYS}
    for preset in PRESETS:
        preset_data = {k: v for k, v in preset[2].items() if k in COMPARE_KEYS}
        if preset_data == data:
            return preset[1]
    return -1


class ONDDDashboardPlugin(DashboardPlugin):
    # Translators, used as dashboard section title
    heading = _('Tuner settings')
    name = 'ondd'
    priority = 10

    def get_template(self):
        return 'ondd/dashboard'

    def get_context(self):
        initial_data = read_ondd_setup()
        preset = match_preset(initial_data)
        return dict(status=ipc.get_status(),
                    form=ONDDForm(initial_data),
                    files=ipc.get_transfers(),
                    selected_preset=preset)
