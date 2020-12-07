# gcp_ha_wordpress

High Availability WordPress - Config
```
wget https://github.com/limitlessv/gcp_ha_wordpress/archive/master.zip
```
unzip master.zip


## Install Radis
```
sudo apt-get update -y && sudo apt-get upgrade -y
sudo apt-get install gcc make autoconf libc-dev pkg-config -y
sudo apt-get install redis-server -y
sudo apt autoremove

```

Edit redis config
```
sudo nano /etc/redis/redis.conf
```
redis config search and replace 1:
```
>> Search for:
supervised

>> Change to:
supervised systemd
```
redis config search and replace 2:
```
>> Search for:
# maxmemory-policy

>> Replace or Add after:
maxmemory-policy allkeys-lru
```

redis config search and replace 3:

Notes:
* Securing your redis command from external attack
* you can skip this for stand setup
```
>> Search for:
rename-command CONFIG ""

>> Add after:

#rename-command FLUSHDB ""
#rename-command FLUSHALL ""
rename-command DEBUG ""
rename-command SHUTDOWN WP248_SHUTDOWN
rename-command CONFIG WP248_CONFIG
```
redis config search and replace 4:

Notes:
* this parm based on your server configuration and free memory
* Skip this config if you are not sure
```
>> Search for:
# maxmemory <bytes>
```
for server with 2Gb I used 256mb
```
>> Add after / replace if not comments:
maxmemory 256mb
```

Comment out this line to used only memory:
Search for: 
```
save 900 1
save 300 10
save 60 10000
```
and comment out to avoid disk saving
```
#save 900 1
#save 300 10
#save 60 10000
```


Restart services
```
sudo systemctl restart redis
```
Test redis
```
redis-cli ping

# should return:
# PONG
```

Update php.ini and restart service
```
sudo pecl install redis
sudo nano /etc/php/7.4/fpm/php.ini
sudo nano /etc/php/7.4/cli/php.ini

sudo systemctl restart php7.4-fpm.service
sudo systemctl restart redis

```
Add wordpress config for redis

Notes:
* we adding [_] (underscore to the end at the domain name)
* the underscore at the end of the domain will help to see the right parm 
BUT it's less secure
```
cd 
wp config set WP_CACHE_KEY_SALT YOURDOMAIN.COM_
wp plugin install redis-cache --activate
```

### Redis check memory
Memory is a critical resource for Redis performance. Used memory defines total number of bytes allocated by Redis using its allocator (either standard libc, jemalloc, or an alternative allocator such as tcmalloc).

You can collect all memory utilization metrics data for a Redis instance by running “info memory”.

Example from one of our servers
 ```
redis-cli
127.0.0.1:6379> info memory
Memory
used_memory:11345728
used_memory_human:10.82M
used_memory_rss:25341952
used_memory_rss_human:24.17M
used_memory_peak:13190520
used_memory_peak_human:12.58M
used_memory_peak_perc:86.01%
used_memory_overhead:1110486
used_memory_startup:795704
used_memory_dataset:10235242
used_memory_dataset_perc:97.02%
```
