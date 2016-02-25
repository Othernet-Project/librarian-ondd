_ = lambda x: x


def query_cache_storage_status(supervisor):
    cache_min = supervisor.config['ondd.cache_min']
    cache_max = supervisor.config['ondd.cache_max']
    cache_status = supervisor.exts.ondd.get_cache_storage()
    cache_free = cache_status['free']
    try:
        free_percentage = cache_free * 100.0 / abs(cache_max - cache_min)
    except ZeroDivisionError:
        free_percentage = 0

    if free_percentage > 100:
        used_percentage = 0
    else:
        used_percentage = 100 - free_percentage

    cache_status = dict(cache_min=cache_min,
                        cache_max=cache_max,
                        cache_free=cache_free,
                        free_percentage="{0:.2f}".format(free_percentage),
                        used_percentage="{0:.2f}".format(used_percentage))
    supervisor.exts.cache.set('ondd.cache', cache_status)
    if cache_free <= cache_min:
        db = supervisor.exts.databases.notifications
        supervisor.exts.notifications.delete_by_category('ondd_cache', db)
        supervisor.exts.notifications.send(
            # Translators, notification displayed when internal cache storage
            # is running out of disk space
            _('Cache storage space is getting low. '
              'Please ask the administrator to take action.'),
            category='ondd_cache',
            dismissable=False,
            group='guest',
            db=db)
        supervisor.exts.notifications.send(
            # Translators, notification displayed when internal cache storage
            # is running out of disk space
            _('Cache storage space is getting low. You will stop receiving '
              'new content if you run out of storage space. Please move some '
              'content from the internal storage to an external one.'),
            category='ondd_cache',
            dismissable=False,
            group='superuser',
            db=db)
