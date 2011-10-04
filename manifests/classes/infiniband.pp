# File::      <tt>infiniband.pp</tt>
# Author::    Sebastien Varrette (Sebastien.Varrette@uni.lu)
# Copyright:: Copyright (c) 2011 Sebastien Varrette
# License::   GPLv3
#
# ------------------------------------------------------------------------------
# = Class: infiniband
#
# Configure and manage infiniband
#
# == Parameters:
#
# $ensure:: *Default*: 'present'. Ensure the presence (or absence) of infiniband
#
# == Actions:
#
# Install and configure infiniband
#
# == Requires:
#
# n/a
#
# == Sample Usage:
#
#     import infiniband
#
# You can then specialize the various aspects of the configuration,
# for instance:
#
#         class { 'infiniband':
#             ensure => 'present'
#         }
#
# == Warnings
#
# /!\ Always respect the style guide available
# here[http://docs.puppetlabs.com/guides/style_guide]
#
#
# [Remember: No empty lines between comments and class definition]
#
class infiniband( $ensure = $infiniband::params::ensure ) inherits infiniband::params
{
    info ("Configuring infiniband (with ensure = ${ensure})")

    if ! ($ensure in [ 'present', 'absent' ]) {
        fail("infiniband 'ensure' parameter must be set to either 'absent' or 'present'")
    }

    case $::operatingsystem {
        debian, ubuntu:         { include infiniband::debian }
        redhat, fedora, centos: { include infiniband::redhat }
        default: {
            fail("Module $module_name is not supported on $operatingsystem")
        }
    }
}

# ------------------------------------------------------------------------------
# = Class: infiniband::common
#
# Base class to be inherited by the other infiniband classes
#
# Note: respect the Naming standard provided here[http://projects.puppetlabs.com/projects/puppet/wiki/Module_Standards]
class infiniband::common {

    # Load the variables used in this module. Check the infiniband-params.pp file
    require infiniband::params

    # install the required packages
    package { $infiniband::params::packagelist :
        ensure  => "${infiniband::ensure}",
    }

    ### Add (or remove) the modules at the end (create a stage to be run at the
    ### end for this purpose)  
    stage { 'infiniband_last':  require => Stage['main'] }
    #stage { 'sysadmin_first': before  => Stage['main'] }
    class { 'infiniband::modules':
        stage => 'infiniband_last'
    }
}

# ------------------------------------------------------------------------------
# = Class: infiniband::modules
#
#  install the kernel modules associated to infiniband
#
# Note: respect the Naming standard provided here[http://projects.puppetlabs.com/projects/puppet/wiki/Module_Standards]
class infiniband::modules {

    # Load the variables used in this module. Check the infiniband-params.pp file
    require infiniband::params

    # install the modules
    kernel::module { $infiniband::params::modulelist :
       ensure  => "${infiniband::ensure}", 
    }
}

# ------------------------------------------------------------------------------
# = Class: infiniband::debian
#
# Specialization class for Debian systems
class infiniband::debian inherits infiniband::common { }

# ------------------------------------------------------------------------------
# = Class: infiniband::redhat
#
# Specialization class for Redhat systems
class infiniband::redhat inherits infiniband::common { }



