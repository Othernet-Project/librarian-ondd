

def query_cache_storage_status(supervisor):
    cache_min = supervisor.config['ondd.cache_min']
    cache_max = supervisor.config['ondd.cache_max']
    cache_status = supervisor.exts.ondd.get_cache_storage()
    cache_free = cache_status['free']
    try:
        cache_percentage = cache_free * 100.0 / abs(cache_max - cache_min)
    except ZeroDivisionError:
        cache_percentage = 0

    cache_status = dict(cache_min=cache_min,
                        cache_max=cache_max,
                        cache_free=cache_free,
                        cache_percentage=cache_percentage)
    supervisor.exts.cache.set('ondd.cache', cache_status)

