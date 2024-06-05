workspace {

    model {
        u = person "User"
        m = softwareSystem "MAAS components" {
            webapp = container "MAAS" {
                region = component "Region controller"   {
                    tags "maascomp"
                }
                rack = component "Rack controller" {
                    tags "maascomp"
                }
                tftp = component "TFTP server" {
                    tags "maascomp
                }
                psql = component "MAAS DB" {
                    tags "maascomp"
                }
                api = component "REST API server" {
                    tags "maascomp"
                }
                agent = component "MAAS agent (Go)" {
                    tags "maascomp"
                }
            }
        }
        machinerack = element "Rack of machines" {
            tags "machines"
        }
        dhcp = element "Bundled DHCP server" {
            tags "extsvc"
        }
        ntp = element "Bundled NTP server" {
            tags "extsvc"
        }
        dns = element "Bundled DNS server" {
            tags "extsvc"
        }
        sp = element "Squid proxy" {
            tags "extsvc"
        }
        imageserver = element "SimpleStreams image server" {
            tags "extsvc"
        }


        u -> region "Provisions machines (via MAAS UI)"
        imageserver -> region "Downloads updated images"
        region -> agent "Controls power and proxies images"
        region -> rack "Push network configurations"
        rack -> dhcp "Write network configuration"
        ntp -> rack "Configure machine NTP"
        region -> api "Tightly coupled with"
        region -> ntp "Configure NTP"
        region -> psql "Reads and writes"
        region -> dns "Configure authoritative DNS"
        rack -> dns "Proxy recursive DNS queries"
        rack -> machinerack "Provisions (via BMC), answers queries"
        agent -> machinerack "Controls power (via BMC)"
        rack -> tftp "Pushes images to"
        region -> sp "Proxies via"
        tftp -> machinerack "Pushes images to"
        dhcp -> machinerack "Provides IP addresses via DORA"
        u -> api "Provisions machines (via scripts or CLI)"
    }

    views {
        component webapp {
            include *
            autoLayout lr
        }
        styles {
            element "maascomp" {
                background #1168bd
                color #ffffff
                shape RoundedBox
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
