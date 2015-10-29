class inkscope::ha_inkscope_config(
    $controllers,
    $public_virtual_ip,
    $internal_virtual_ip,
){
    include inkscope::params
    require inkscope::inkscope_common
    $virtual_ips            = [$public_virtual_ip, $internal_virtual_ip]
    $order                  = '300'

    $listen_port            = $inkscope::params::inkscope_port
    $server_names           = filter_hash($controllers, 'name')
    $ipaddresses            = filter_hash($controllers, 'internal_address')
    $mode                   = 'tcp'


  Haproxy::Service        { use_include => true }
  Haproxy::Balancermember { use_include => true }



  haproxy::listen { 'inkscope':
    order     => $order,
    ipaddress => $virtual_ips,
    ports     => $listen_port,
    options   => {
        option => ['httplog'],
    'balance' => 'roundrobin'
    },
    mode      => $mode,
  }

  haproxy::balancermember { 'inkscope':
    order             => $order,
    listening_service => $name,
    server_names      => $server_names,
    ipaddresses       => $ipaddresses,
    ports             => $listen_port,
    options           => 'check',
    define_cookies    => false,
    define_backups    => false,
  }


  service { 'haproxy':
    enable  => true,
    ensure  => running,
  }

}