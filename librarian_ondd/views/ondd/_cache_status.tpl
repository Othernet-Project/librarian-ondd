<%namespace name="widgets" file="/ui/widgets.tpl"/>

## Translators, shows the disk space status of the storage where ondd cache is stored 
${widgets.progress(_("Cache storage status:"), cache_percentage, cache_percentage)}
