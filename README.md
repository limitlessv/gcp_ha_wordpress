# gcp_ha_wordpress

High Availability WordPress - Config
```
wget https://github.com/limitlessv/gcp_ha_wordpress/archive/master.zip
```
unzip master.zip


# Install Radis
```
sudo apt update
sudo apt-get install gcc make autoconf libc-dev pkg-config -y
sudo apt-get install redis-server -y
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
