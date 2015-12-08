import logging

from bottle import request
from bottle_utils.ajax import roca_view
from bottle_utils.i18n import lazy_gettext as _, i18n_url

from librarian_core.contrib.templates.renderer import template, view

from .forms import ONDDForm
from .consts import get_form_data_for_preset

try:
    from ondd_ipc import ipc
except AttributeError:
    raise RuntimeError('ONDD plugin requires UNIX sockets')


@view('ondd/_status')
def get_signal_status():
    return dict(status=ipc.get_status())


@roca_view('ondd/settings', 'ondd/_settings_form', template_func=template)
def show_settings_form():
    return dict(form=ONDDForm())


@roca_view('ondd/settings', 'ondd/_settings_form', template_func=template)
def set_settings():
    preset = request.params.get('preset')
    if not preset:
        return dict(
            form = ONDDForm(request.forms),
            # Translators, message shown when user does not select a satellite
            # preset nor 'Custom' option to enter custom data.
            message = _("Please select a satellite or select 'Custom'"))
    try:
        preset = int(preset)
    except (TypeError, ValueError):
        preset = 0
    form_data = get_form_data_for_preset(preset, request.forms)
    form_data.update({'lnb': request.params.get('lnb')})
    form = ONDDForm(form_data)
    if not form.is_valid():
        return dict(form=form)

    logging.info('ONDD: tuner settings updated')
    request.app.supervisor.exts.setup.append({'ondd': form.processed_data})

    return dict(form=form,
                message=_('Transponder configuration saved.'),
                redirect_url=i18n_url('dashboard:main'))


@view('ondd/_file_list')
def show_file_list():
    return dict(files=ipc.get_transfers())


def routes(config):
    skip_plugins = config['app.skip_plugins']
    return (
        ('ondd:status', get_signal_status,
         'GET', '/ondd/status/', dict(unlocked=True, skip=skip_plugins)),
        ('ondd:files', show_file_list,
         'GET', '/ondd/files/', dict(unlocked=True, skip=skip_plugins)),
        ('ondd:settings', show_settings_form,
         'GET', '/ondd/settings/', dict(unlocked=True)),
        ('ondd:settings', set_settings,
         'POST', '/ondd/settings/', dict(unlocked=True)),
    )
