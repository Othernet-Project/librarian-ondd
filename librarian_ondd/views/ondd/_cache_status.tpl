<% 
used_pct = round(float(cache_status['used']) / cache_status['total'] * 100, 2)
%>
## Translators, shows the disk space status of the storage where ondd download cache is stored 
<label>${_("Allocated download capacity")}</label>
<span class="bar">
    <span class="bar-indicator" style="width: ${used_pct}%"></span>
</span>
<p class="percentage-lcd">
    ${_("{percentage}% used ({amount} available)".format(percentage=used_pct, amount=h.hsize(cache_status['free'])))}
</p>
