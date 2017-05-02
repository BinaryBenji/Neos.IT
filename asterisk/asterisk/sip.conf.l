[general]
context=public
allowoverlap=no
udpbindaddr=0.0.0.0
tcpenable=no
tcpbindaddr=0.0.0.0
transport=udp
srvlookup=yes
qualify=yes

[authentication]
[basic-option](!)
	dtmfmode=rfc2833
	context=from-office
	type=friend
[natted-phone]
	directmedia=no
	host=dynamic
[public-phone]
	directmedia=yes
[my-codecs](!)
	disallow=all
	allow=ilbc
	allow=g729
	allow=gsm
	allow=g723
	allow=ulaw
[ulaw-phone](!)
	dallow=all
	allow=ulaw

[benji]
	type=friend
	context=phones
	allow=ulaw,alaw
	secret=benji
	host=dynamic

[micka]
        type=friend
        context=phones
        allow=ulaw,alaw
        secret=micka
        host=dynamic

[lael]
        type=friend
        context=phones
        allow=ulaw,alaw
        secret=lael
        host=dynamic

[outside]
        type=friend
        context=incoming
        allow=ulaw,alaw
        secret=bemila
        host=dynamic

