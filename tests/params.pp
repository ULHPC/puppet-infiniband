# File::      <tt>params.pp</tt>
# Author::    S. Varrette, H. Cartiaux, V. Plugaru, S. Diehl aka. UL HPC Management Team (hpc-sysadmins@uni.lu)
# Copyright:: Copyright (c) 2016 S. Varrette, H. Cartiaux, V. Plugaru, S. Diehl aka. UL HPC Management Team
# License::   Gpl-3.0
#
# ------------------------------------------------------------------------------
# You need the 'future' parser to be able to execute this manifest (that's
# required for the each loop below).
#
# Thus execute this manifest in your vagrant box as follows:
#
#      sudo puppet apply -t --parser future /vagrant/tests/params.pp
#
#

include 'infiniband::params'

$names = ["ensure", "packagelist", "grouppackagename", "modulelist", "extra_packages", "openib_servicename", "openib_processname", "sm_packagename", "sm_utilspackages", "sm_servicename", "sm_processname", "hasstatus", "hasrestart", "sm_configfile", "sm_configfile_mode", "sm_configfile_owner", "sm_configfile_group"]

notice("infiniband::params::ensure = ${infiniband::params::ensure}")
notice("infiniband::params::packagelist = ${infiniband::params::packagelist}")
notice("infiniband::params::grouppackagename = ${infiniband::params::grouppackagename}")
notice("infiniband::params::modulelist = ${infiniband::params::modulelist}")
notice("infiniband::params::extra_packages = ${infiniband::params::extra_packages}")
notice("infiniband::params::openib_servicename = ${infiniband::params::openib_servicename}")
notice("infiniband::params::openib_processname = ${infiniband::params::openib_processname}")
notice("infiniband::params::sm_packagename = ${infiniband::params::sm_packagename}")
notice("infiniband::params::sm_utilspackages = ${infiniband::params::sm_utilspackages}")
notice("infiniband::params::sm_servicename = ${infiniband::params::sm_servicename}")
notice("infiniband::params::sm_processname = ${infiniband::params::sm_processname}")
notice("infiniband::params::hasstatus = ${infiniband::params::hasstatus}")
notice("infiniband::params::hasrestart = ${infiniband::params::hasrestart}")
notice("infiniband::params::sm_configfile = ${infiniband::params::sm_configfile}")
notice("infiniband::params::sm_configfile_mode = ${infiniband::params::sm_configfile_mode}")
notice("infiniband::params::sm_configfile_owner = ${infiniband::params::sm_configfile_owner}")
notice("infiniband::params::sm_configfile_group = ${infiniband::params::sm_configfile_group}")

#each($names) |$v| {
#    $var = "infiniband::params::${v}"
#    notice("${var} = ", inline_template('<%= scope.lookupvar(@var) %>'))
#}
