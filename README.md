OpenStack Keystone
==================


Usage
-----

### Setup database
```
$ docker run -d --name keystone-database -e MYSQL_ROOT_PASSWORD=secrete mariadb:10.1
$ docker exec keystone-database mysql -psecrete -e "create database keystone;"
$ docker exec keystone-database mysql -psecrete -e "GRANT ALL ON keystone.* TO 'keystone'@'%' IDENTIFIED BY 'password';"
$ docker exec keystone-database mysql -psecrete -e "GRANT ALL ON keystone.* TO 'keystone'@'localhost' IDENTIFIED BY 'password';"
$ docker exec keystone-database mysql -psecrete -e "flush privileges;"
```

### Generate token for API usage
```
$ export TOKEN=$(openssl rand -hex 10)
```

### Start container
```
$ docker run -d --link keystone-database:dbhost -e ADMIN_TOKEN=$TOKEN -p 5000:5000 --name keystone-server gbraad/openstack-keystone:mitaka
```

### Create service entry
```
$ docker exec keystone-server keystone --os-token $TOKEN --os-endpoint http://localhost:35357/v2.0/ service-create --name=keystone --type=identity --description="Keystone Identity Service"
$ docker exec keystone-server keystone --os-token $TOKEN --os-endpoint http://localhost:35357/v2.0/ endpoint-create --service keystone --publicurl 'http://localhost:5000/v2.0' --adminurl 'http://localhost:35357/v2.0' --internalurl 'http://localhost:5000/v2.0'
```

### Create admin user
```
$ docker exec keystone-server keystone --os-token $TOKEN --os-endpoint http://localhost:35357/v2.0/ user-create --name admin --pass password
$ docker exec keystone-server keystone --os-token $TOKEN --os-endpoint http://localhost:35357/v2.0/ role-create --name admin
$ docker exec keystone-server keystone --os-token $TOKEN --os-endpoint http://localhost:35357/v2.0/ tenant-create --name admin
$ docker exec keystone-server keystone --os-token $TOKEN --os-endpoint http://localhost:35357/v2.0/ user-role-add --user admin --role admin --tenant admin
```


Links
-----

  * [GitLab](https://gitlab.com/gbraad/openstack-keystone)
  * [GitHub](https://github.com/gbraad/docker-openstack-keystone)
  * [Docker Hub](https://hub.docker.com/r/gbraad/openstack-keystone)


Authors
-------

| [!["Gerard Braad"](http://gravatar.com/avatar/e466994eea3c2a1672564e45aca844d0.png?s=60)](http://gbraad.nl "Gerard Braad <me@gbraad.nl>") |
|---|
| [@gbraad](https://twitter.com/gbraad)  |
