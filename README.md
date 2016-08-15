
hax-tld
=======
A bind9 config example for making a private DynDNS TLD.

"Private" means that *.hax is only resolved on computers that have your
DNS server in their network config.


chroot reminder
---------------
Does your bind ignore your config file changes? It may be running in a chroot.
  * [doc/chroot.md](doc/chroot.md) has hints for Plesk.



Project status
--------------
  * [x] Invent a [timestamp scheme](doc/ttl-serials.md) that
    * is easy to calculate in your head and
    * can accomodate lots of short-lived updates.
  * [x] Make a comment-explained, readable
        [zone file example](etc_bind/hax.zone.txt)
    * `# named-checkconf -z`: `zone hax/IN: loaded serial 164131520` […]
  * [x] Make bind9 serve that zone file.
    * To reload a single zone: `rndc reload hax`
      Last argument is the zone name = (sub)domain, not a file name.
  * [ ] Provide guidance on how to feed changing client IPs to the zone file.



Bind9 resources
---------------
  * Debian wiki: [Bind 9](https://wiki.debian.org/Bind9):
    useful hints and commands
  * Ubuntu Community Help:
    [Bind 9 Server Howto](https://help.ubuntu.com/community/BIND9ServerHowto)



Related projects and tutorials
------------------------------
  * Using other name servers and/or some SQL-y database:
    *  PowerDNS + MySQL: (german)
      [Uwe Debacher's DynDNS]( http://www.debacher.de/wiki/Mein_eigenes_DynDNS)
    * PowerDNS + sqlite3: (german, paywall)
      "Eigendynamik. Eigener DynDNS-Dienst für den Hausgebrauch und Freunde."
      [c't 24/2013, S. 196](http://heise.de/-2311284)

  * Not really DynDNS
    * PHP script to update a redirect-to-IP website (german):
      "DynDNS im Eigenbau - PC aus dem Web aufrufen"
      [PC•Welt](http://www.pcwelt.de/tipps/a-7810291.html)











