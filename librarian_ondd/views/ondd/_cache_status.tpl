## Translators, shows the disk space status of the storage where ondd cache is stored 
<label>${_("Cache storage status")}</label>
<span class="bar">
    <span class="bar-indicator" style="width: ${cache_percentage}%"></span>
</span>
<p class="percentage-lcd">${_("{percentage}% used ({amount} available)".format(percentage=cache_percentage, amount=h.hsize(cache_free)))}</p>
