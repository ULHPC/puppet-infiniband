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

    # Add the rc.local file such that the hostname are currectly displayed when
    # the IB commands are used (such as ibhosts which list the IB cards)
    update::rc_local { 'infiniband': 
        ensure => "${infiniband::ensure}",
        source => "puppet:///modules/infiniband/rc.local.infiniband",
        order  => 50
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
class infiniband::redhat inherits infiniband::common {

  # THE COMMANDS OPERATED ON COLUMBUS 

  #  79  modprobe ipmi_si
  #  80  modprobe ipmi_devintf
  #  81  yum search dstat
  #  82  ifconfig 
  #  83  ifconfig -a
  #  84  dmesg 
  #  85  selinuxenabled 
  #  86  echo $?
  #  87  yum install screen
  #  88  screen
  #  89  cd
  #  90  screen -x
  #  91  screen -
  #  92  modprobe ipmi_si
  #  93  modprobe ipmi_devintf
  #  94  yum search ipmitool
  #  95  yum install OpenIPMI-tools.x86_64
  #  96  ipmitool lan print
  #  97  ifconfig -a
  #  98  dmesg |grep eth2
  #  99  ethtool eth2
  # 100  lspci 
  # 101  lspci |grep Myr
  # 102  yum grouplist
  # 103  yum groupinstall "OpenFabrics Enterprise Distribution"
  # 104  /etc/init.d/iptables stop
  # 105  /etc/init.d/iptables save
  # 106  cat /etc/sysconfig/iptables
  # 107  chkconfig iptables off
  # 108  chkconfig --list | grep ipta
  # 109  vim /etc/sysconfig/selinux 
  # 110  ibstat
  # 111  chkconfig --list|grep -i openi
  # 112  chkconfig openibd on
  # 113  chkconfig --list|grep -i openi
  # 114  /etc/init.d/openibd start
  # 115  ifconfig 
  # 116  ibstat
  # 117  ibstat
  # 118  ibstat
  # 119  ibstat
  # 120  ibstat
  # 121  ibstat
  # 122  ibstat
  # 123  ibstat
  # 124  ibstat
  # 125  ibstat
  # 126  ibstat
  # 127  ibstat
  # 128  ibstat
  # 129  ibstat
  # 130  ibstat
  # 131  ifconfig 
  # 132  ifconfig -a
  # 133  cd /etc/sysconfig/network-scripts/
  # 134  vim ifcfg-ib0 ifcfg-eth0 -o
  # 135  ifup ib0
  # 136  ifconfig 
  # 137  ifconfig 
  # 138  vim ifcfg-ib0 
  # 139  ifdown ib0
  # 140  ifup ib0
  # 141  ifconfig 
  # 142  ping 10.228.250.3
  # 143  Il faut rebooter le noeuds ;)
  # 144  screen
  # 145  screen -x

}



