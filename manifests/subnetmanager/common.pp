# File::      <tt>subnetmanager/common.pp</tt>
# Author::    S. Varrette, H. Cartiaux, V. Plugaru, S. Diehl aka. UL HPC Management Team (hpc-sysadmins@uni.lu)
# Copyright:: Copyright (c) 2015 S. Varrette, H. Cartiaux, V. Plugaru, S. Diehl aka. UL HPC Management Team
# License::   Gpl-3.0
#
# ------------------------------------------------------------------------------
# = Class: infiniband::subnetmanager::common
#
# Base class to be inherited by the other infiniband::subnetmanager classes
#
# Note: respect the Naming standard provided
# here[http://projects.puppetlabs.com/projects/puppet/wiki/Module_Standards]
class infiniband::subnetmanager::common {

    # Load the variables used in this module. Check the infiniband-params.pp file
    require infiniband::params

    package { 'opensm':
        ensure => $infiniband::ensure
        name   => $infiniband::params::sm_packagename,
    }

    exec { "create ${infiniband::params::sm_configfile}":
        command => "opensm --routing_engine ${infiniband::subnetmanager::routing_engine} --create-config ${infiniband::params::sm_configfile} l",
        path    => '/usr/bin:/usr/sbin:/bin',
        require => Package['opensm'],
        unless  => "test -f ${infiniband::params::sm_configfile}",
    }
    
    file { $infiniband::params::sm_configfile:
        ensure  => $infiniband::ensure,
        owner   => $infiniband::params::sm_configfile_owner,
        group   => $infiniband::params::sm_configfile_group,
        mode    => $infiniband::params::sm_configfile_mode,
        notify  => Service['opensm'],
        require => Exec["create ${infiniband::params::sm_configfile}"]
    }

    service { 'opensm':
        ensure     => running,
        name       => $infiniband::params::sm_servicename,
        enable     => true,
        hasrestart => $infiniband::params::hasrestart,
        pattern    => $infiniband::params::sm_processname,
        hasstatus  => $infiniband::params::hasstatus,
        require    => Package['opensm'],
    }

}
