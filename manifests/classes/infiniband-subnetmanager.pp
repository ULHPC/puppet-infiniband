# File::      <tt>infiniband-subnetmanager.pp</tt>
# Author::    Sebastien Varrette (<Sebastien.Varrette@uni.lu>)
# Copyright:: Copyright (c) 2011 Sebastien Varrette (www[http://varrette.gforge.uni.lu])
# License::   GPLv3
#
# ------------------------------------------------------------------------------
# = Class: infiniband::subnetmanager
#
# Configure the subnet manager for Infiniband
#
# == Parameters:
#
# $ensure:: *Default*: 'present'. Ensure the presence (or absence) of infiniband::subnetmanager
#
# == Actions:
#
# Install and configure infiniband::subnetmanager
#
# == Requires:
#
# n/a
#
# == Sample usage:
#
#     import infiniband::subnetmanager
#
# You can then specialize the various aspects of the configuration,
# for instance:
#
#      class { 'infiniband::subnetmanager':
#          ensure => 'present'
#      }
#
# == Warnings
#
# /!\ Always respect the style guide available
# here[http://docs.puppetlabs.com/guides/style_guide]
#
# [Remember: No empty lines between comments and class definition]
#
class infiniband::subnetmanager ( $ensure = $infiniband::params::ensure ) inherits infiniband::params {

    info ("Configuring infiniband::subnetmanager (with ensure = ${ensure})")

    if ! ($ensure in [ 'present', 'absent' ]) {
        fail("infiniband::subnetmanager 'ensure' parameter must be set to either 'absent' or 'present'")
    }

    case $::operatingsystem {
        debian, ubuntu:         { include infiniband::subnetmanager::debian }
        #redhat, fedora, centos: { include infiniband::subnetmanager::redhat }
        default: {
            fail("Module $module_name is not supported on $operatingsystem")
        }
    }
}

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
        name   => "${infiniband::params::sm_packagename}",
        ensure => "${infiniband::ensure}"
    }

    package { $infiniband::params::sm_utilspackages:
        ensure => "${infiniband::ensure}"
    }

    exec { "create ${infiniband::params::sm_configfile}":
        command     => "opensm --routing_engine ftree --create-config ${infiniband::params::sm_configfile} l",
        path        => "/usr/bin:/usr/sbin:/bin",
        require     => Package['opensm'],
        unless      => "test -f ${infiniband::params::sm_configfile}",
    }
    
    file { "${infiniband::params::sm_configfile}":
        owner   => "${infiniband::params::sm_configfile_owner}",
        group   => "${infiniband::params::sm_configfile_group}",
        mode    => "${infiniband::params::sm_configfile_mode}",
        ensure  => "${infiniband::ensure}",
        notify  => Service['opensm'],
        require => Exec["create ${infiniband::params::sm_configfile}"]
    }

    service { 'opensm':
        name       => "${infiniband::params::sm_servicename}",
        enable     => true,
        ensure     => running,
        hasrestart => "${infiniband::params::hasrestart}",
        pattern    => "${infiniband::params::sm_processname}",
        hasstatus  => "${infiniband::params::hasstatus}",
        require    => Package['opensm'],
        #subscribe  => File["${infiniband::params::sm_configfile}"],
    }



}

# ------------------------------------------------------------------------------
# = Class: infiniband::subnetmanager::debian
#
# Specialization class for Debian systems
class infiniband::subnetmanager::debian inherits infiniband::subnetmanager::common { }

# ------------------------------------------------------------------------------
# = Class: infiniband::subnetmanager::redhat
#
# Specialization class for Redhat systems
class infiniband::subnetmanager::redhat inherits infiniband::subnetmanager::common { }







