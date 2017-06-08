# File::      <tt>common.pp</tt>
# Author::    UL HPC Devops Team (hpc-sysadmins@uni.lu)
# Copyright:: Copyright (c) 2015 S. Varrette, H. Cartiaux, V. Plugaru, S. Diehl aka. UL HPC Management Team
# License::   Gpl-3.0
#
# ------------------------------------------------------------------------------
# = Class: infiniband::common
#
# Base class to be inherited by the other infiniband classes, containing the common code.
#
# Note: respect the Naming standard provided here[http://projects.puppetlabs.com/projects/puppet/wiki/Module_Standards]

class infiniband::common {

    # Load the variables used in this module. Check the params.pp file
    require infiniband::params

    ### Add (or remove) the modules at the end (create a stage to be run at the
    ### end for this purpose)
    stage { 'infiniband_last':  require => Stage['main'] }
    #stage { 'sysadmin_first': before  => Stage['main'] }
    class { 'infiniband::modules':
    stage => 'infiniband_last'
  }


}
