# File::      <tt>common/debian.pp</tt>
# Author::    S. Varrette, H. Cartiaux, V. Plugaru, S. Diehl aka. UL HPC Management Team (hpc-sysadmins@uni.lu)
# Copyright:: Copyright (c) 2015 S. Varrette, H. Cartiaux, V. Plugaru, S. Diehl aka. UL HPC Management Team
# License::   Gpl-3.0
#
# ------------------------------------------------------------------------------
# = Class: infiniband::common::debian
#
# Specialization class for Debian systems
class infiniband::common::debian inherits infiniband::common {

    # install the required packages
    package { $infiniband::params::packagelist :
        ensure  => $infiniband::ensure,
    }

    package { $infiniband::params::extra_packages :
        ensure  => $infiniband::ensure,
    }

    # Bad packaging under Debian ;) 
    # Add the rc.local file such that the hostname are currectly displayed when
    # the IB commands are used (such as ibhosts which list the IB cards)
    require rclocal
    rclocal::update { 'infiniband':
        ensure => $infiniband::ensure,
        source => 'puppet:///modules/infiniband/rc.local.infiniband',
        order  => 50,
    }

}
