#!/bin/sh
ADMIN_TOKEN=${ADMIN_TOKEN-`openssl rand -hex 10`}
openstack-config --set /etc/keystone/keystone.conf DEFAULT admin_token $ADMIN_TOKEN
openstack-config --set /etc/keystone/keystone.conf DEFAULT use_stderr True
openstack-config --set /etc/keystone/keystone.conf database connection ${CONNECTION-mysql://keystone:password@dbhost/keystone}
su keystone -s /bin/sh -c "keystone-manage db_sync"

/usr/bin/keystone-all
