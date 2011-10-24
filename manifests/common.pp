
# Class: resolver::common
#
# This class manages /etc/resolv.conf
#
# Parameters:
#   - $resolver_conf:
#       The location of resolv.conf
#   - $search_domains:
#       An optional array of search domains to include in resolv.conf
#   - $dns_servers:
#       A mandatory array of DNS servers to include in resolv.conf
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
#    include "resolver::common"
#
class resolver::common {

   $resolver_conf     = "/etc/resolv.conf"


     if $search_domains {
        notice "Search domains defined"
     } else {
        warning "No search domains defined. Defaulting to ."
        $search_domains = [ "." ]
     }

     if $dns_servers {
        notice "DNS servers provided"
     } else {
        err "No DNS servers provided!"
     }

     file {
        $resolver_conf:
           ensure  => present,
           mode    => 644,
           content => template("resolver/resolv.conf.erb"),
     }
}


