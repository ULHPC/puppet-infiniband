-*- mode: markdown; mode: visual-line;  -*-

# Infiniband Puppet Module 

[![Puppet Forge](http://img.shields.io/puppetforge/v/ULHPC/infiniband.svg)](https://forge.puppetlabs.com/ULHPC/infiniband)
[![License](http://img.shields.io/:license-GPL3.0-blue.svg)](LICENSE)
![Supported Platforms](http://img.shields.io/badge/platform-debian|centos|redhat-lightgrey.svg)
[![Documentation Status](https://readthedocs.org/projects/ulhpc-puppet-infiniband/badge/?version=latest)](https://readthedocs.org/projects/ulhpc-puppet-infiniband/?badge=latest)

Install and configure infiniband

      Copyright (c) 2017 UL HPC Devops Team aka. S. Varrette, H. Cartiaux, V. Plugaru, S. Diehl and C. Parisot  <hpc-sysadmins@uni.lu>
      

| [Project Page](https://github.com/ULHPC/puppet-infiniband) | [Sources](https://github.com/ULHPC/puppet-infiniband) | [Documentation](https://ulhpc-puppet-infiniband.readthedocs.org/en/latest/) | [Issues](https://github.com/ULHPC/puppet-infiniband/issues) |

## Synopsis

Install and configure infiniband.

This module implements the following elements: 

* __Puppet classes__:
    - `infiniband` 
    - `infiniband::common` 
    - `infiniband::common::debian` 
    - `infiniband::common::redhat` 
    - `infiniband::modules` 
    - `infiniband::params` 
    - `infiniband::subnetmanager` 
    - `infiniband::subnetmanager::common` 
    - `infiniband::subnetmanager::debian` 
    - `infiniband::subnetmanager::redhat` 

* __Puppet definitions__: 

All these components are configured through a set of variables you will find in
[`manifests/params.pp`](manifests/params.pp). 

_Note_: the various operations that can be conducted from this repository are piloted from a [`Rakefile`](https://github.com/ruby/rake) and assumes you have a running [Ruby](https://www.ruby-lang.org/en/) installation.
See `docs/contributing.md` for more details on the steps you shall follow to have this `Rakefile` working properly. 

## Dependencies

See [`metadata.json`](metadata.json). In particular, this module depends on 

* [puppetlabs/stdlib](https://forge.puppetlabs.com/puppetlabs/stdlib)
* [ULHPC/kernel](https://forge.puppetlabs.com/ULHPC/kernel)
* [puppet/yum](https://forge.puppetlabs.com/puppet/yum)
* [ULHPC/rclocal](https://forge.puppetlabs.com/ULHPC/rclocal)

## Overview and Usage

### Class `infiniband`

This is the main class defined in this module.
It accepts the following parameters: 

* `$ensure`: default to 'present', can be 'absent'

Use it as follows:

     include ' infiniband'

See also [`tests/init.pp`](tests/init.pp)

### Class `infiniband::modules`

See [`tests/modules.pp`](tests/modules.pp)
### Class `infiniband::subnetmanager`

See [`tests/subnetmanager.pp`](tests/subnetmanager.pp)
### Class `infiniband::subnetmanager::debian`

See [`tests/subnetmanager/debian.pp`](tests/subnetmanager/debian.pp)
### Class `infiniband::subnetmanager::redhat`

See [`tests/subnetmanager/redhat.pp`](tests/subnetmanager/redhat.pp)


## Librarian-Puppet / R10K Setup

You can of course configure the infiniband module in your `Puppetfile` to make it available with [Librarian puppet](http://librarian-puppet.com/) or
[r10k](https://github.com/adrienthebo/r10k) by adding the following entry:

     # Modules from the Puppet Forge
     mod "ULHPC/infiniband"

or, if you prefer to work on the git version: 

     mod "ULHPC/infiniband", 
         :git => 'https://github.com/ULHPC/puppet-infiniband',
         :ref => 'production' 

## Issues / Feature request

You can submit bug / issues / feature request using the [ULHPC/infiniband Puppet Module Tracker](https://github.com/ULHPC/puppet-infiniband/issues). 

## Developments / Contributing to the code 

If you want to contribute to the code, you shall be aware of the way this module is organized. 
These elements are detailed on [`docs/contributing.md`](contributing/index.md).

You are more than welcome to contribute to its development by [sending a pull request](https://help.github.com/articles/using-pull-requests). 

## Puppet modules tests within a Vagrant box

The best way to test this module in a non-intrusive way is to rely on [Vagrant](http://www.vagrantup.com/).
The `Vagrantfile` at the root of the repository pilot the provisioning various vagrant boxes available on [Vagrant cloud](https://atlas.hashicorp.com/boxes/search?utf8=%E2%9C%93&sort=&provider=virtualbox&q=svarrette) you can use to test this module.

See [`docs/vagrant.md`](vagrant.md) for more details. 

## Online Documentation

[Read the Docs](https://readthedocs.org/) aka RTFD hosts documentation for the open source community and the [ULHPC/infiniband](https://github.com/ULHPC/puppet-infiniband) puppet module has its documentation (see the `docs/` directly) hosted on [readthedocs](http://ulhpc-puppet-infiniband.rtfd.org).

See [`docs/rtfd.md`](rtfd.md) for more details.

## Licence

This project and the sources proposed within this repository are released under the terms of the [GPL-3.0](LICENCE) licence.


[![Licence](https://www.gnu.org/graphics/gplv3-88x31.png)](LICENSE)
