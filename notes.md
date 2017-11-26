
YOLO
----
```bash
rsync -arv --rsync-path="sudo rsync" ./linux/data/* raspberrypi:/
```

pi config
---------
```bash
setsebool -P allow_execmem=1 -P allow_execmod=1 -P allow_execstack=1
```

custom_pi.te
```
module custom_pi 1.0;

require {
	type systemd_logind_t;
	type tmpfs_t;
	type init_t;
	class capability2 wake_alarm;
	class filesystem mount;
}

#============= init_t ==============
allow init_t self:capability2 wake_alarm;

#============= systemd_logind_t ==============
allow systemd_logind_t tmpfs_t:filesystem mount;
```

