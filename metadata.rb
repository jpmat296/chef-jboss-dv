name 'jboss-dv'
maintainer 'Jean-Pierre Matsumoto'
maintainer_email 'jpmat296@gmail.com'
license 'all_rights'
description 'Installs/Configures JBoss Data Virtualization service'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.1.0'
source_url 'https://github.com/jpmat296/chef-jboss-dv'
license 'Apache v2.0'
supports 'redhat', '~> 5.2'
supports 'centos', '~> 6.0'

depends 'jboss-eap', '~> 2.1.1'
