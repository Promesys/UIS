#!/bin/bash

# Install Redis
echo "Installing Redis..."
echo ''
apt-get install redis-server php-redis -y
# Just in case, ...
systemctl stop redis-server
# Change "supervised no" so "supervised systemd"? Question is unclear
# If "#bind 127.0.0.1 ::1", change to "bind 127.0.0.1 ::1"
cp /etc/redis/redis.conf /etc/redis/redis.conf.$(date +%y%b%d-%H%M%S)
sed -i "s/supervised no/supervised systemd/g" /etc/redis/redis.conf
# sed -i "s/# bind 127.0.0.1/bind 127.0.0.1/g" /etc/redis/redis.conf
systemctl start redis-server
# give redis-server a second to wake up
sleep 1
if [[ "$( echo 'ping' | /usr/bin/redis-cli )" == "PONG" ]] ; then
    echo "ping worked"
else
    echo "ping FAILED"
fi
systemctl status redis
systemctl status redis-server
exit 0