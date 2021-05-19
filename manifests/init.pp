# File::      <tt>init.pp</tt>
# Author::    UL HPC DevOps Team (hpc-sysadmins@uni.lu)
# Copyright:: Copyright (c) 2015 S. Varrette, H. Cartiaux, V. Plugaru, S. Diehl aka. UL HPC Management Team
# License::   Gpl-3.0
#
# ------------------------------------------------------------------------------
# = Class: infiniband
#
# Install and configure infiniband
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
#     include 'infiniband'
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
class infiniband(
    $ensure             = $infiniband::params::ensure,
    $modulelist         = $infiniband::params::modulelist,
    $openib_servicename = $infiniband::params::openib_servicename
)
inherits infiniband::params
{
    info ("Configuring infiniband (with ensure = ${ensure})")

    if ! ($ensure in [ 'present', 'absent' ]) {
        fail("infiniband 'ensure' parameter must be set to either 'absent' or 'present'")
    }

    case $::operatingsystem {
        'debian', 'ubuntu':         { include ::infiniband::common::debian }
        'redhat', 'fedora', 'centos': { include ::infiniband::common::redhat }
        default: {
            fail("Module ${module_name} is not supported on ${::operatingsystem}")
        }
    }
}
