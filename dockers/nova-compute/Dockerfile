FROM centos:7.6.1810

MAINTAINER Fernando Martinez <fernando.martinezmeana@altran.com>

# Install openvswitch
RUN yum update -y
RUN yum install gcc gcc-c++ autoconf automake libtool openssl-devel python-devel desktop-file-utils groff graphviz checkpolicy selinux-policy-devel python-sphinx python-twisted-core python-zope-interface python-six libcap-ng-devel unbound unbound-devel wget rpm-build -y
RUN yum clean all
RUN useradd ovs
RUN su - ovs
RUN wget http://openvswitch.org/releases/openvswitch-2.11.0.tar.gz
RUN mkdir -p ~/rpmbuild/SOURCES
RUN cp openvswitch-2.11.0.tar.gz ~/rpmbuild/SOURCES/
RUN tar xfz openvswitch-2.11.0.tar.gz
RUN rpmbuild -bb --nocheck openvswitch-2.11.0/rhel/openvswitch-fedora.spec
RUN exit
RUN yum localinstall /home/ovs/rpmbuild/RPMS/x86_64/openvswitch-2.11.0-1.el7.x86_64.rpm -y

# Install nova
RUN yum update -y
RUN yum -y install centos-release-openstack-stein
RUN sed -i -e "s/enabled=1/enabled=0/g" /etc/yum.repos.d/CentOS-OpenStack-stein.repo
RUN yum -y install qemu-kvm libvirt virt-install
RUN yum --enablerepo=centos-openstack-stein,epel -y install openstack-nova-compute install openstack-neutron openstack-neutron-ml2 openstack-neutron-openvswitch
RUN yum clean all

EXPOSE 5900-5999

ADD run-nova-compute.sh /run-nova-compute.sh
RUN chmod -v +x /run-nova-compute.sh

CMD ["/run-nova-compute.sh"]
