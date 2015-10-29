class inkscope::ceph_rest_api (

){
  include inkscope::params
  require inkscope::inkscope_common


  package { $inkscope::params::inkscope_cephrestapi_package:
    ensure => present,
  }

  service { "$inkscope::params::inkscope_cephrestapi_service" :
    ensure      => running,
    enable      => true,
    hasstatus   => true,
    hasrestart  => true,
    require => Package["$inkscope::params::inkscope_cephrestapi_package"]
 }

  exec {'radogw-admin':
      command => "/usr/bin/radosgw-admin user create --uid=inkscope --display-name=\"Inkscope Admin RGW\" --email=root@orange.com --secret=inkscopeadmsecret --access-key=inkscopeadmkey --system",
      path => '/usr/sbin:/usr/bin:/sbin:/bin',
  }


}