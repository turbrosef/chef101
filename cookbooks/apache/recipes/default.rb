#
# Cookbook Name:: apache
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#installing apache 
if node["platform"] == "ubuntu"
	execute "apt-get update -y" do
	end
end
	

package "apache2" do 
	package_name node["apache"]["package"]
end

#adding source for document root use attributes from attributes/default.rb
node["apache"]["sites"].each do |sitename, data| 
  document_root = "/content/sites/#{sitename}" 
  
  directory document_root do 
	mode "0755"
	recursive true 
  end

#use node platform to install site conf.d by distrubution  
if node["platform"] == "ubuntu"
	template_location = "/etc/apache2/sites-enabled/#{sitename}.conf"
elsif node["platform"] == "centos"
	template_location = "/etc/httpd/conf.d/#{sitename}.conf"
end

#use vhost.erb template to make  /etc/http.d/conf.d per site 

template template_location  do 
	source "vhost.erb"
	mode "0644"
	variables(
		 :document_root => document_root, 
		 :port	=> data["port"],
		 :domain => data["domain"]  
	)
	notifies :restart, "service[httpd]" 	
end

#use index.html.erb template to create index.html file per site
template "/content/sites/#{sitename}/index.html" do 
	source "index.html.erb"
	mode "0644"
	variables(
		:site_title => data["site_title"],
		:comingsoon => "Coming Soon!"
	)
end

end

#removing welkcome.conf
execute "rm /etc/httpd/conf.d/welcome.conf" do 
	only_if do 
		File.exist?("/etc/httpd/conf.d/welcome.conf")
	end
	notifies :restart, "service[httpd]"
end

#removing README 
execute "rm /etc/httpd/conf.d/README" do 
	only_if do 
		File.exist?("/etc/httpd/conf.d/README")
	end

end

#starting apache 
service "httpd" do
	service_name node["apache"]["package"]
	action [:enable, :start]  
end

# adding php recipe 
#include_recipe "php::default"
