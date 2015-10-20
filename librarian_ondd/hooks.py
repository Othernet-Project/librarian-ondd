from .dashboard_plugin import ONDDDashboardPlugin
from .setup import has_invalid_config, setup_ondd_form, setup_ondd


def initialize(supervisor):
    supervisor.exts.dashboard.register(ONDDDashboardPlugin)
    # register setup wizard step
    setup_wizard = supervisor.exts.setup_wizard
    setup_wizard.register('ondd',
                          setup_ondd_form,
                          template='ondd_wizard.tpl',
                          method='GET',
                          test=has_invalid_config)
    setup_wizard.register('ondd',
                          setup_ondd,
                          template='ondd_wizard.tpl',
                          method='POST',
                          test=has_invalid_config)
