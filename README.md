Grid Job Watcher
================

This is a script to watch your grid jobs and post them as a
webpage. There's a lot of hardcoded stuff, don't say I didn't warn
you!


Running as cron job
===================

This is supported only on lxplus7, if you want to run automatically
three times an hour, you'll need something like

```
0,20,40 * * * * lxplus7 ~/grid-watcher/make-html.sh > ~/logs/grid-$(date +\%F_\%H).log
```
