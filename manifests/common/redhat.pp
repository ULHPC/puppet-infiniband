# File::      <tt>common/redhat.pp</tt>
# Author::    S. Varrette, H. Cartiaux, V. Plugaru, S. Diehl aka. UL HPC Management Team (hpc-sysadmins@uni.lu)
# Copyright:: Copyright (c) 2015 S. Varrette, H. Cartiaux, V. Plugaru, S. Diehl aka. UL HPC Management Team
# License::   Gpl-3.0
#
# ------------------------------------------------------------------------------
# = Class: infiniband::common::redhat
#
# Specialization class for Redhat systems
class infiniband::common::redhat inherits infiniband::common {

    # install the required packages
    exec { 'Install IB packages':
        command => "yum -y groupinstall '${infiniband::params::grouppackagename}'",
        path    => '/sbin:/usr/bin:/usr/sbin:/bin',
        user    => 'root',
        group   => 'root'
    }

    # install the extra packages
    package { $infiniband::params::extra_packages :
        ensure  => $infiniband::ensure,
        require => Exec['Install IB packages'],
    }
    
    service { 'openibd':
        ensure     => running,
        name       => $infiniband::params::openib_servicename,
        enable     => true,
        hasrestart => $infiniband::params::hasrestart,
        pattern    => $infiniband::params::openib_processname,
        hasstatus  => $infiniband::params::hasstatus,
        require    => Exec['Install IB packages'],
    }
}
