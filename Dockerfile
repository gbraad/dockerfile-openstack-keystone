FROM registry.gitlab.com/gbraad/centos:7
MAINTAINER Gerard Braad <me@gbraad.nl>

RUN yum update -y && \
    yum install -y centos-release-openstack-mitaka && \
    yum install -y openstack-keystone openstack-utils openstack-selinux && \
    yum clean all

EXPOSE 5000
EXPOSE 35357

ADD run_command.sh /tmp/
CMD /tmp/run_command.sh
