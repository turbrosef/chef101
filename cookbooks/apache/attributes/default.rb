default["apache"]["sites"]["turbrosef2"] = { "site_title" => "turbrosef site cumming soon....", "port" => 80, "domain" => "turbrosef2.mylabserver.com"}
default["apache"]["sites"]["turbrosef2b"] = { "site_title" => "turbrosef2 cumming at ya bish...", "port" => 80, "domain" => "turbrosef2b.mylabserver.com"}
default["apache"]["sites"]["turbrosef3"] = { "site_title" => "turbrosef3 coming...", "port" => 80, "domain" => "turbrosef3.mylabserver.com"}

default["author"]["name"] = "TurbroseF"

case node["platform"]
when "centos"
	default["apache"]["package"] = "httpd"
when "ubuntu"
	default["apache"]["package"] = "apache2"
end 
