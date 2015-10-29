class inkscope::ceph_probe (

){
  include inkscope::params
  require inkscope::inkscope_common


  package { $inkscope::params::inkscope_cephprobe_package:
    ensure => present,
  }

  service { "$inkscope::params::inkscope_cephprobe_service" :
    ensure     => running,
    enable    => true,
    hasstatus  => true,
    hasrestart => true,
    require => Package["$inkscope::params::inkscope_cephprobe_package"]
 }
}