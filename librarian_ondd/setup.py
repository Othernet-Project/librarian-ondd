import logging

from bottle import request
from bottle_utils.i18n import lazy_gettext as _

from .forms import ONDDForm

try:
    from . import ipc
except AttributeError:
    raise RuntimeError('ONDD plugin requires UNIX sockets')


def read_ondd_setup():
    initial_data = request.app.supervisor.exts.setup.get('ondd')
    return {} if isinstance(initial_data, bool) else initial_data


def has_invalid_config():
    ondd_alive = ipc.ping()
    if not ondd_alive:
        # If ondd is not running, skip the step
        return False
    settings = read_ondd_setup()
    if settings is None:
        # Settings is None if ONDD configuration has never been performed
        return True
    if settings == {}:
        # Settings is a dict if settings has been performed by no preset is
        # present. This is allowed, as user is allowed to skip through the
        # setup step without setting the tuner settings.
        return False
    form = ONDDForm(read_ondd_setup())
    return not form.is_valid()


def setup_ondd_form():
    return dict(status=ipc.get_status(), form=ONDDForm())


def setup_ondd():
    is_test_mode = request.forms.get('mode', 'submit') == 'test'

    form = ONDDForm(request.forms)
    form_valid = form.is_valid()

    if form_valid:
        # Store full settings
        logging.info('ONDD: tuner settings updated')
        request.app.supervisor.exts.setup.append({'ondd': form.processed_data})

        if is_test_mode:
            return dict(successful=False, form=form, status=ipc.get_status(),
                        # Translators, shown when tuner settings are updated
                        # during setup wizard step.
                        message=_('Tuner settings have been updated'))
        return dict(successful=True)

    # Form is not valid

    if is_test_mode:
        # We only do something about this in test mode
        return dict(successful=False, form=form, status=ipc.get_status())

    request.app.supervisor.exts.setup.append({'ondd': {}})
    return dict(successful=True)
