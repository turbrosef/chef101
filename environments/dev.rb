#dev environment conf file 
name "dev"
description "Devlopment environment"
cookbook "apache", "0.1.5"
override_attributes({ #overrides cookbook author
	"author" => {
		"name" => ".:TurbroseF:."
	}
})

#default_attributes({ #overrides cookbook author with default precedence
#        "author" => {
#                        "name" => ".:TurbroseF:."
#                                }
#                                })i
