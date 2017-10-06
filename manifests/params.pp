# File::      <tt>params.pp</tt>
# Author::    S. Varrette, H. Cartiaux, V. Plugaru, S. Diehl aka. UL HPC Management Team (hpc-sysadmins@uni.lu)
# Copyright:: Copyright (c) 2015 S. Varrette, H. Cartiaux, V. Plugaru, S. Diehl aka. UL HPC Management Team
# License::   Gpl-3.0
#
# ------------------------------------------------------------------------------
# = Class: infiniband::params
#
# In this class are defined as variables values that are used in other
# infiniband classes.
# This class should be included, where necessary, and eventually be enhanced
# with support for more OS
#
# Resources: http://publib.boulder.ibm.com/infocenter/lnxinfo/v3r0m0/index.jsp?topic=%2Fperformance%2Fhowtos%2Frecoveribv.htm
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
    $ensure = 'present'

    #### MODULE INTERNAL VARIABLES  #########
    # (Modify to adapt to unsupported OSes)
    #######################################
    $packagelist = $::operatingsystem ? {
        /(?i-mx:ubuntu|debian)/ => [
                                    'libdapl-dev',
                                    'libdapl2',
                                    'ibutils',
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
                                    ],
        default => []
    }
    $grouppackagename = $::operatingsystem ? {
        /(?i-mx:centos|fedora|redhat)/ => $::lsbmajdistrelease ? {
            '5'     => 'OpenFabrics Enterprise Distribution',
            default => 'Infiniband Support'
        },
        default => ''
    }

    $modulelist = $::operatingsystem ? {
        /(?i-mx:ubuntu|debian)/ => [
                                    'mlx4_ib',
                                    'ib_ipoib',
                                    'ib_uverbs',
                                    'ib_umad',
                                    'rdma_cm',
                                    'rdma_ucm',
                                    ],
        /(?i-mx:centos|fedora|redhat)/ => $::lsbmajdistrelease ? {
          '7'     => [ 'mlx5_ib' ],
          default => []
        },
        default => []
    }

    $extra_packages = $::operatingsystem ? {
        /(?i-mx:centos|fedora|redhat)/ => $::lsbmajdistrelease ? {
            '5'     => [ 'infiniband-diags', 'perftest', ],
            '6'     => [ 'infiniband-diags', 'perftest', 'mstflint' ],
            default => [ 'infiniband-diags', 'perftest', 'mstflint', 'rdma-core-devel' ],
        },
        default => [ 'infiniband-diags' ]
    }


    # This part is used only on CentOS
    $openib_servicename = $::operatingsystem ? {
        /(?i-mx:centos|fedora|redhat)/ => $::lsbmajdistrelease ? {
            '5'     => 'openibd',
            default => 'rdma',
        },
        default  => 'openibd'
    }
    $openib_processname = $::operatingsystem ? {
        /(?i-mx:centos|fedora|redhat)/ => $::lsbmajdistrelease ? {
            '5'     => 'openib',
            default => 'rdma',
        },
        default  => 'openibd'
    }


    # This part is dedicated to subnet manager (sm) for Infiniband
    $sm_packagename = $::operatingsystem ? {
        default => 'opensm'
    }

    $sm_utilspackages = $::operatingsystem ? {
        default => [ 'opensm-doc' ]
    }

    $sm_servicename = $::operatingsystem ? {
        /(?i-mx:ubuntu|debian)/ => 'opensm-boot',
        default                 => 'opensm'
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
        /(?i-mx:ubuntu|debian)/ => '/etc/opensm/opensm.conf',
        default                 => "/etc/${openib_servicename}/opensm.conf",
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


}
