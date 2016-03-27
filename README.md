#jboss-dv

This cookbook installs JBoss Data Virtualization (DV) in existing JBoss EAP installation. EAP installation is not part of this cookbook. It must be installed before by using [jboss-eap](https://supermarket.chef.io/cookbooks/jboss-eap) cookbook.

As JBoss DV installer is given by Red Hat only as izPack installer, the cookbook uses silent mode of izPack to do the install.


##Requirements

###Platforms

This has only be tested on:

* RHES 5
* CentOS 6

###Cookbook

* Java is not managed. It is recommended to install it with [java](https://supermarket.chef.io/cookbooks/javap) cookbook.
* Use of [jboss-eap](https://supermarket.chef.io/cookbooks/jboss-eap) cookbook is required. It is a dependency and some of its attributes are used by jboss-dv.
* JBoss DV installer jar file must be downloaded from JBoss DV website, with JBoss developer account.

##Attributes

Following [jboss-eap](https://supermarket.chef.io/cookbooks/jboss-eap) attributes are used:

* `node['jboss-eap']['jboss_home']` - Home directory of JBoss EAP. Default value is set by jboss-eap cookbook to `#{node['jboss-eap']['install_path']}/#{node['jboss-eap']['symlink']}`
* `node['jboss-eap']['admin_passwd']` - Can be used for `node['jboss-dv']['master_passwd']`attribute. See explanation below.

Following attributes are only for JBoss DV:

* `node['jboss-dv']['version']` - DV version to install. Default value is `6.2.0.redhat-3`.
* `node['jboss-dv']['package_url']` - URL to get JBoss DV installer. Default value is `http://example.com/jboss-dv-installer-#{node['jboss-dv']['version']}.jar'
`
* `node['jboss-dv']['checksum']` - sha256sum of package_url file
* `node['jboss-dv']['master_passwd']` - Master password of JBoss DV. Value has to be >= 8 characters, with one numeric, one special character. If attribute is not specified, then value of `node['jboss-eap']['admin_passwd']` is used.

##License & Authors

* Author: Jean-Pierre Matsumoto  
[https://github.com/jpmat296/](https://github.com/jpmat296/)

```text
Copyright 2015-2016, Jean-Pierre Matsumoto

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
