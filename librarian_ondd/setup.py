import logging

from bottle import request

from .forms import ONDDForm

try:
    from . import ipc
except AttributeError:
    raise RuntimeError('ONDD plugin requires UNIX sockets')


def read_ondd_setup():
    initial_data = request.app.supervisor.exts.setup.get('ondd', {})
    return {} if isinstance(initial_data, bool) else initial_data


def has_invalid_config():
    form = ONDDForm(read_ondd_setup())
    return not form.is_valid()


def setup_ondd_form():
    return dict(status=ipc.get_status(), form=ONDDForm())


def setup_ondd():
    form = ONDDForm(request.forms)
    if not form.is_valid():
        return dict(successful=False, form=form, status=ipc.get_status())

    logging.info('ONDD: tuner settings updated')
    request.app.supervisor.exts.setup.append({'ondd': form.processed_data})
    return dict(successful=True)
