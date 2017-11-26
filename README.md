SERaspbian
==========

Scripts to compile raspberrypi's kernel with SELinux capability. The script is based on the official kernel building doc https://www.raspberrypi.org/documentation/linux/kernel/building.md. 

Requirements 
------------
For Pi 1, Pi 0, Pi 0 W, only ! (WIP)

* Install on your raspberry: selinux-basics selinux-policy-default
* Docker (to run the arm cross compile from debian)
* or a Debian system (./run.sh)

Run
---

```bash
./docker_build.sh
```

Or from debian OS
```
./run.sh
```

Finally, the compiled files are available from
```bash
[seraspbian]$ ls ./linux/data/
boot  lib
```


