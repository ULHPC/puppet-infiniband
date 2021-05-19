# File::      <tt>subnetmanager.pp</tt>
# Author::    S. Varrette, H. Cartiaux, V. Plugaru, S. Diehl aka. UL HPC Management Team (hpc-sysadmins@uni.lu)
# Copyright:: Copyright (c) 2015 S. Varrette, H. Cartiaux, V. Plugaru, S. Diehl aka. UL HPC Management Team
# License::   Gpl-3.0
#
# ------------------------------------------------------------------------------
# = Class: infiniband::subnetmanager
#
# Configure the subnet manager for Infiniband
#
# == Parameters:
#
# $ensure:: *Default*: 'present'. Ensure the presence (or absence) of infiniband::subnetmanager
# $routing_engine:: *Default*: 'ftree'. This option chooses routing engine(s) to
#      use instead of Min Hop algorithm (default).  Multiple routing engines can be
#      specified separated by commas so that specific ordering of routing algorithms
#      will be tried if earlier routing engines fail.
#      Supported engines: minhop, updn, file, ftree, lash, dor 
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
class infiniband::subnetmanager (
    $ensure         = $infiniband::params::ensure,
    $routing_engine = 'ftree'
)
inherits infiniband::params
{

    info ("Configuring infiniband::subnetmanager (with ensure = ${ensure})")

    # ensure the presence (or absence) of infiniband
    $ensure = $::infiniband_ensure ? {
        ''      => 'present',
        default => $::infiniband_ensure
    }

    case $::operatingsystem {
        'debian', 'ubuntu':         { include infiniband::subnetmanager::debian }
        'redhat', 'fedora', 'centos': { include infiniband::subnetmanager::redhat }
        default: {
            fail("Module ${module_name} is not supported on ${::operatingsystem}")
        }
    }
}

