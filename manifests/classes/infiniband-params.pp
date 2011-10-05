# File::      <tt>infiniband-params.pp</tt>
# Author::    Sebastien Varrette (Sebastien.Varrette@uni.lu)
# Copyright:: Copyright (c) 2011 Sebastien Varrette
# License::   GPL v3
#
# ------------------------------------------------------------------------------
# = Class: infiniband::params
#
# In this class are defined as variables values that are used in other
# infiniband classes.
# This class should be included, where necessary, and eventually be enhanced
# with support for more OS
#
# == Warnings
#
# /!\ Always respect the style guide available
# here[http://docs.puppetlabs.com/guides/style_guide]
#
# The usage of a dedicated param classe is advised to better deal with
# parametrized classes, see
# http://docs.puppetlabs.com/guides/parameterized_classes.html
#
# [Remember: No empty lines between comments and class definition]
#
class infiniband::params {

    ######## DEFAULTS FOR VARIABLES USERS CAN SET ##########################
    # (Here are set the defaults, provide your custom variables externally)
    # (The default used is in the line with '')
    ###########################################

    # ensure the presence (or absence) of infiniband
    $ensure = $infiniband_ensure ? {
        ''      => 'present',
        default => "${infiniband_ensure}"
    }

    #### MODULE INTERNAL VARIABLES  #########
    # (Modify to adapt to unsupported OSes)
    #######################################
    $packagelist = $::operatingsystem ? {
        default => [
                    'libdapl-dev',
                    'libdapl2',
                    'ibutils',
                    'infiniband-diags',
                    'libibcommon-dev',
                    'libibcommon1',
                    'libibmad1',
                    'libibmad-dev',
                    'libibumad1',
                    'libibumad-dev',
                    'ibverbs-utils',
                    'libibverbs-dev',
                    'libibverbs1',
                    'libmlx4-1',
                    'libmlx4-dev',
                    'librdmacm-dev',
                    'librdmacm1',
                    'rdmacm-utils',
                    'libsdp1',
                    'ofed-docs',
                    'libopensm2',
                    ]
    }

    $modulelist = $::operatingsystem ? {
        default => [
                    'mlx4_ib',
                    'ib_ipoib',
                    'ib_uverbs',
                    'ib_umad',
                    'rdma_cm',
                    'rdma_ucm',
                    ]
    }

    # This part is dedicated to subnet manager (sm) for Infiniband
    $sm_packagename = $::operatingsystem ? {
        default => 'opensm'
    }

    $sm_utilspackages = $::operatingsystem ? {
        default => [ 'opensm-doc' ]
    }

    $sm_servicename = $::operatingsystem ? {
        default  => 'opensm'
    }

    $sm_processname = $::operatingsystem ? {
        default  => 'opensm'
    }

    $hasstatus = $::operatingsystem ? {
        /(?i-mx:ubuntu|debian)/        => false,
        /(?i-mx:centos|fedora|redhat)/ => true,
        default => true,
    }

    $hasrestart = $::operatingsystem ? {
        default => true,
    }

    $sm_configfile = $::operatingsystem ? {
        default => '/etc/opensm/opensm.conf',
    }

    $sm_configfile_mode = $::operatingsystem ? {
        default => '0640',
    }

    $sm_configfile_owner = $::operatingsystem ? {
        default => 'root',
    }

    $sm_configfile_group = $::operatingsystem ? {
        default => 'root',
    }



    # $pkgmanager = $::operatingsystem ? {
    #     /(?i-mx:ubuntu|debian)/          => [ '/usr/bin/apt-get' ],
    #     /(?i-mx:centos|fedora|redhat)/ => [ '/bin/rpm', '/usr/bin/up2date', '/usr/bin/yum' ],
    #     default => []
    # }


}

