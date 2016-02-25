_ = lambda x: x


def query_cache_storage_status(supervisor):
    cache_min = supervisor.config['ondd.cache_min']
    cache_max = supervisor.config['ondd.cache_quota']
    cache_status = supervisor.exts.ondd.get_cache_storage()
    cache_free = cache_status['free']
    cache_used = cache_status['used']

    # We want cache to be a certain amount (cache_max). Since this is a virtual
    # capacity, we also have a virtual free space which is the amount of space
    # we want the cache to have (ideally) and the amount of data used in
    # reality.
    cache_virt_free = cache_max - cache_used

    # ONDD download cache is shared with other data that is stored on the
    # internal disk. This includes databases, logs, and downloaded files that
    # are not part of the cache (permanent files). The foreign data may
    # actually bite into the cache space. In this case, we need to add to the
    # used space, and subtract from the virtual free space.
    cache_foreign = min(0, cache_free - cache_virt_free)
    cache_used += cache_foreign
    cahche_virt_free -= cache_foreign

    # Sanity check
    assert cache_virt_free + cache_used == cache_max

    cache_status = dict(total=cache_max,
                        free=cache_virt_free,
                        used=cache_used)
    supervisor.exts.cache.set('ondd.cache', cache_status)

    if cache_free > cache_min:
        # We have enough free space, so bail
        return

    # Now we also need to warn the user about low cache capacity
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
