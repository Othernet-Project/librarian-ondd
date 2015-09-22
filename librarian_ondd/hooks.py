from .dashboard_plugin import ONDDDashboardPlugin


def initialize(supervisor):
    supervisor.exts.dashboard.register(ONDDDashboardPlugin)
