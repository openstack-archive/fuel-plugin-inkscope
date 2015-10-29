class inkscope::sysprobe (

){
  include inkscope::params
  require inkscope::inkscope_common

  package { $inkscope::params::inkscope_sysprobe_package:
    ensure => present,
  }

  service { "$inkscope::params::inkscope_sysprobe_service" :
    ensure      => running,
    enable      => true,
    require     => Package["$inkscope::params::inkscope_sysprobe_package"]
 }

  exec { "sys_start":
    command => "/etc/init.d/sysprobe start",
    require     => Package["$inkscope::params::inkscope_sysprobe_package"]
  }
}