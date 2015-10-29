class inkscope::inkscope_admviz (

){
  include inkscope::params
  require inkscope::inkscope_common

  $inkscope_port            = $inkscope::params::inkscope_port
  $ceph_rest_api_host       = $inkscope::params::ceph_rest_api_host
  $rest_api_port            = $inkscope::params::rest_api_port
  $controller_node_public   = $inkscope::params::controller_node_public
  $controller_node_address  = $inkscope::params::controller_node_address
  $controller               = $inkscope::params::controller


  class { 'inkscope::ha_inkscope_config' :
    controllers             => $controller,
    public_virtual_ip       => $controller_node_public,
    internal_virtual_ip     => $controller_node_address,
  } ->
      exec { "p_haproxy_restart":
      command => "/usr/sbin/crm resource restart p_haproxy",
    }

  package { $inkscope::params::inkscope_admviz_package:
    ensure => present,
  }
    if $::osfamily == 'Debian' {
       exec { "proxy_http":
        command => "/usr/sbin/a2enmod proxy_http",
        notify  => Service[$inkscope::params::apache_service_name],
      }
      exec { "rewrite_http":
        command => "/usr/sbin/a2enmod rewrite",
        notify  => Service[$inkscope::params::apache_service_name],
      }
  }
  $listen_inkscope = "*:${inkscope_port}"
  exec { "apache_port_config":
    command => "/bin/echo Listen $listen_inkscope >> $inkscope::params::apache_port_file",
    unless  => "/bin/egrep \"$inkscope_port\" $inkscope::params::apache_port_file",
    notify  => Service[$inkscope::params::apache_service_name],
  }

  exec { "ceph_user":
    command => "/usr/bin/ceph auth get-or-create client.restapi mds 'allow' osd 'allow *' mon 'allow *' > /etc/ceph/ceph.client.restapi.keyring",
  }


  ceph_conf {
      'client.restapi/log_file ': value => '/dev/null';
      'client.restapi/keyring  ': value => '/etc/ceph/ceph.client.restapi.keyring';
  }



  file { $inkscope::params::apache_site_file :
    ensure  => present,
    path    => $inkscope::params::apache_site_file,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => template('inkscope/inkScope.conf.erb'),
    notify  => Service[$inkscope::params::apache_service_name],
    require => Exec["apache_port_config"],
  }

    if $::osfamily == 'Debian' {
       exec { "enable_Inkscope":
        command => "/usr/sbin/a2ensite inkScope.conf",
        notify  => Service[$inkscope::params::apache_service_name],
        require => File["$inkscope::params::apache_site_file"],
      }
    }
  firewall {'251 allow tcp port for inkscope':
        chain   => 'INPUT',
        port   => $inkscope_port,
        proto   => 'tcp',
        action  => accept,
  }

    service { $inkscope::params::apache_service_name:
          ensure     => running,
          enable    => true,
          hasstatus  => true,
          hasrestart => true,
    }

  }