# Zabbix template for Windows Storage Spaces
## Monitoring params:
  - pools (size, allocated size, operational status, health status)
  - virtual disks (size, write cache size, is tiered, ssd tier size, hdd tier size, operational status, health status)
## Install

  1. Import template in zabbix web ui
  2. Copy PS scripts and .conf file to C:/Program Files/Zabbix
  3. Include .conf file to your config like this:
```
Include=C:\Program Files\Zabbix Agent\zabbix_ss.win.conf
```
  4. Restart Zabbix Agent
  5. Connect template to host

  