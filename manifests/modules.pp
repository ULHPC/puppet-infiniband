# File::      <tt>modules.pp</tt>
# Author::    UL HPC Devops Team (hpc-sysadmins@uni.lu)
# Copyright:: Copyright (c) 2015 S. Varrette, H. Cartiaux, V. Plugaru, S. Diehl aka. UL HPC Management Team
# License::   Gpl-3.0
#
# ------------------------------------------------------------------------------
# = Class: infiniband::modules
#
#
#
# Note: respect the Naming standard provided here[http://projects.puppetlabs.com/projects/puppet/wiki/Module_Standards]

class infiniband::modules {

    # Load the variables used in this module. Check the params.pp file
    require infiniband::params

    # install the modules
    kernel::module { $infiniband::modulelist :
        ensure  => $infiniband::ensure,
    }
}
