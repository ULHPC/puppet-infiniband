# File::      <tt>subnetmanager/debian.pp</tt>
# Author::    S. Varrette, H. Cartiaux, V. Plugaru, S. Diehl aka. UL HPC Management Team (hpc-sysadmins@uni.lu)
# Copyright:: Copyright (c) 2015 S. Varrette, H. Cartiaux, V. Plugaru, S. Diehl aka. UL HPC Management Team
# License::   Gpl-3.0
#
# ------------------------------------------------------------------------------
# = Class: infiniband::subnetmanager::debian
#
# Specialization class for Debian systems
class infiniband::subnetmanager::debian inherits infiniband::subnetmanager::common {

    package { $infiniband::params::sm_utilspackages:
        ensure => $infiniband::ensure,
    }

}