#
# Cookbook Name:: jboss-dv
# Recipe:: default
#
# Copyright 2015-2016, Jean-Pierre Matsumoto
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'jboss-eap'

package_filename=File.basename("#{node['jboss-dv']['package_url']}")
auto_xml_path="#{node['jboss-eap']['jboss_home']}/auto-install-dv-#{node['jboss-dv']['version']}.xml"

# Download
remote_file "#{Chef::Config[:file_cache_path]}/#{package_filename}" do
  source "#{node['jboss-dv']['package_url']}"
  checksum "#{node['jboss-dv']['checksum']}"
  mode '0755'
end

# XML file with IzPack data for silent automatic installation
template "#{auto_xml_path}" do
  source 'auto-install-dv.xml.erb'
  mode   '0644'
end

# If DV master_passwd is not specified, then fallback to EAP admin_passwd
password = node['jboss-dv']['master_passwd']
if password.nil?
  password = node['jboss-eap']['admin_passwd']
end

# DV masterPassword is in .variables file
template "#{auto_xml_path}.variables" do
  source 'auto-install-dv.xml.variables.erb'
  mode   '0600'
  variables({ :password => password })
  not_if { File.exists? "#{auto_xml_path}.installed" }
end

# Run installer.jar
execute 'Run silent install for JBoss DV' do
  command "java -jar #{Chef::Config[:file_cache_path]}/#{package_filename} #{auto_xml_path}"
  cwd "#{node['jboss-eap']['jboss_home']}"
  action :run
  not_if { File.exists? "#{auto_xml_path}.installed" }
end

# Delete variables file since it contains password in clear text
template "#{auto_xml_path}.variables" do
  action :delete
end

# Stamp file to remember DV is installed
file "#{auto_xml_path}.installed" do
  mode  '0644'
  action :create
end
