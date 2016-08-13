
chroot
======

Reminder: If the zones list in `named-checkconf -z` differs from
what you see in your log files or syslog, chances are your bind
is running in a sandbox (probably a chroot).
Its config directory in `ps aux` may have the same name as yours,
but that name would be relative to the sandbox root.

__Pro Tip:__ If your distro ships with a perfectly real-looking
`/etc/bind` decoy, make a reminder so you won't be fooled again.
Don't just remove it, as it might be "repaired" by your package manager.
Instead, make a symlink like "/etc/bind/daemon-chroot" pointing to where
the real configs are.


Plesk
=====
  * Your chroot might be `/var/named/run-root`
  * Your config template probably is `$CHROOT_DIR/etc/named.conf.default` and
    has a line `// -- PLEASE ADD YOUR CUSTOM DIRECTIVES BELOW THIS LINE. --`
    * You may consider it tedious and slow to
      [re-generate named.conf](https://kb.plesk.com/en/879) from that,
      so best just add an `include` directive like
      `include "/etc/bind/named.conf.local";` so you'll have to do
      the generator just once.
      * Or just skip the generator and add that `include` directive to the
        live `named.conf` manually, as you just did in the template.
      * Make sure you have a file `$CHROOT_DIR/etc/bind/named.conf.local`.
        An empty file should be ok, but putting a comment line will save
        you from wondering whether future versions of bind might be scared.






