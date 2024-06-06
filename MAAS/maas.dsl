workspace {

    model {
        u = person "User"
        m = softwareSystem "MAAS" {
            rack = container "Rack controller" {
                tags "extracomp"
            }
            tftp = container "TFTP server" {
                tags "maascomp"
            }
            psql = container "MAAS DB" {
                tags "extracomp"
            }
            api = container "REST API server" {
                tags "extracomp"
            }
            agent = container "MAAS agent (Go)" {
                tags "extracomp"
            }
            region = container "Region controller" {
                tags "extracomp"
        		adsvc = component "Active Discovery Service" {
	        		tags "maascomp"
		        }
                dbtsksvc = component "Database Task Service" {
                    tags "maascomp"
                }
    		    httpsvc = component "HTTP Service" {
	    		    tags "maascomp"
		        }
        		impressvc = component "Import Resources Service" {
	        		tags "maascomp"
		        }
        		ipcsvc = component "IPC Master Service" {
	        		tags "maascomp"
		        }
        		ntpsvc = component "Network Time Protocol Service" {
	        		tags "maascomp"
		        }
        		promsvc = component "Prometheus Service" {
	        		tags "maascomp"
		        }
        		psqlsvc = component "Postgres Listener Service" {
	        		tags "maascomp"
		        }
        		racksvc = component "Rack Controller Service" {
	        		tags "maascomp"
		        }
    	    	regcsvc =  component "Region Controller Service" {
	    	    	tags "maascomp"
    	    	}
	    	    regsvc = component "Region Service" {
		    	    tags "maascomp"
    		    }
        		revdnssvc = component "Reverse DNS Service" {
	        		tags "maascomp"
		        }
    		    statmonsvc = component "Status Monitor Service" {
	    		    tags "maascomp"
		        }
    		    statsvc = component "Stats Service" {
	    		    tags "maascomp"
		        }
        		tempsvc = component "Temporal Service" {
	        		tags "maascomp"
		        }
        		webappsvc = component "Web Application Service" {
	        		tags "maascomp"
		        }
            }
            nginx = container "Nginx server" {
                tags "extsvc"
            }
            dhcp = container "Bundled DHCP server" {
                tags "extsvc"
            }
            ntp = container "Bundled NTP server" {
                tags "extsvc"
            }
            dns = container "Bundled DNS server" {
                tags "extsvc"
            }
            sp = container "Squid proxy" {
                tags "extsvc"
            }
        }
        machinerack = element "Rack of machines" {
            tags "machines"
        }
        
        imageserver = element "SimpleStreams image server" {
            tags "extsvc"
        }
        prometheus = element "Prometheus server" {
            tags "extsvc"
        }
        loki = element "Loki server" {
            tags "extsvc"
        }

        adsvc -> psql "reads and writes to"
        adsvc -> psqlsvc "consumes"
        adsvc -> rack "gathers info from"
        api -> httpsvc "passes commands to"
        dbtsksvc -> psql "reads and writes to"
        dbtsksvc -> regcsvc "proxies for"
        httpsvc -> psqlsvc "consumes"
        imageserver -> region "Downloads supported images"
        impressvc -> webappsvc "updates"
        impressvc -> imageserver "downloads from"
        impressvc -> psqlsvc "consumes"
        ipcsvc -> racksvc "spawns"
        ipcsvc -> regsvc "spawns"
        nginx -> httpsvc "passes commands to"
        ntpsvc -> ntp "updates"
        prometheus -> loki "uses rules from"
        promsvc -> prometheus "writes observations to"
        promsvc -> loki "updates rules in"
        promsvc -> statsvc "updates service status"
        psqlsvc -> psql "listens to"
        rack -> machinerack "to provision"
        racksvc -> dhcp "manages"
        racksvc -> psql "reads and writes to"
        regcsvc -> dns "configures"
        regcsvc -> psqlsvc "consumes"
        regcsvc -> sp
        regcsvc -> ntpsvc "configures"
        regsvc -> regcsvc "feeds"
        revdnssvc -> psqlsvc "consumes"
        revdnssvc -> psql "reads and writes to"
        statmonsvc -> dns "monitors health of"
        statsvc -> psql "reads and writes to"
        tempsvc -> statmonsvc "spawns"
        u -> api "Uses scripts or CLI"
        u -> nginx "Uses Web UI"
        webappsvc -> psqlsvc "consumes"
    }

    views {
        systemLandscape {
            include *
            autolayout tb
        }
        systemContext m {
            include *
            autolayout tb
        }
        container m {
            include *
            autolayout tb
        }
        component region {
            include *
        }
        styles {
            element "maascomp" {
                background #1168bd
                color #ffffff
                shape RoundedBox
            }
            element "extracomp" {
                background #18b18d
                color #ffffff
            }
            element "extsvc" {
                background #bd1168
                color #ffffff
                shape RoundedBox
            }
            element "machines" {
                background #11bd68
	            color #ffffff
	            shape Circle
	        }
        }
    }
}
