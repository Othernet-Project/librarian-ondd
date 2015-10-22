<%namespace name="ui" file="/ui/widgets.tpl"/>

<%
    SNR_MAX = 1.6
    BRATE_MAX = 100
    bitrate = th.get_bitrate(status)
    snr_pct = h.perc_range(status['snr'], 0, SNR_MAX)
    bitrate_pct = h.perc_range(bitrate, 0, BRATE_MAX)

    has_tuner = th.has_tuner()
    has_lock = status['has_lock'] 
    has_service = has_lock and status['streams'] and bitrate

    all_ok = False
    if not has_tuner:
        # Translators, used as main status text when there is no tuner
        status_text = _('no tuner')
    elif not has_lock:
        # Translators, used as main status text when there is no signal lock
        status_text = _('no lock')
    elif not has_service:
        # Translators, used as main status text when there is no service
        status_text = _('no service')
    else:
        # Translators, used as main status text when everything is ok
        status_text = _('receiving')
        all_ok = True
%>

<%def name="status_indicator(name, icon_name, active)">
    <span class="ondd-status-indicator ondd-status-${name} ondd-status-${'ok' if active else 'ng'}">
        <span class="icon icon-${icon_name}">
        </span>
    </span>
</%def>

<div class="ondd-status-panel">
    <div class="ondd-main-status">
        <p>
            <span class="ondd-quick-status${' ondd-all-ok' if all_ok else ''}">
                ${status_text}
            </span>
            <span class="ondd-status-icons">
                ${self.status_indicator('tuner', 'tuner', has_tuner)}
                ${self.status_indicator('lock', 'signal', has_lock)}
                ${self.status_indicator('service', 'download', has_service)}
            </span>
        </p>
    </div>
    <div class="ondd-status-indicators">
        ## Translators, label is located next to the satellite signal strength
        ## indicator
        ${ui.progress(_('Signal'), status['signal'], value=status['signal'], threshold=50)}
        ## Translators, label is located next to the satellite signal quality
        ## indicator
        ${ui.progress(_('Quality'), snr_pct, value=status['snr'], threshold=25)}
        ## Translators, labe is located next to the bitrate indicator
        ${ui.progress(_('Bitrate'), bitrate_pct, h.hsize(bitrate, 'b', 1000, rounding=0, sep=''), threshold=10)}
    </div>
</div>
