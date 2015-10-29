class inkscope::inkscope_common (

){
  include inkscope::params

  package { $inkscope::params::required_packages:
    ensure => present,
  }
  package { $inkscope::params::inkscope_common_package:
    ensure => present,
  }

  file { '$inkscope::params::ps_utils_path' :
    ensure  => present,
    path    => $inkscope::params::ps_utils_path,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => file('/etc/fuel/plugins/inkscope-2.0/puppet/modules/inkscope/files/psutil-2.2.0.tar.gz'),
    require => Package["$inkscope::params::inkscope_common_package"],
  }

  exec {'install_psutil':
    command => "/usr/bin/pip install $inkscope::params::ps_utils_path",
    path => '/usr/sbin:/usr/bin:/sbin:/bin',
    require => File["$inkscope::params::ps_utils_path"]
  }


  $ceph_rest_api_host   = $inkscope::params::ceph_rest_api_host
  $inkscope_port        = $inkscope::params::inkscope_port
  $mongodb_set          = $inkscope::params::mongodb_set
  $inkscope_user        = $inkscope::params::inkscope_user
  $inkscope_password    = $inkscope::params::inkscope_password
  $mongo_replicat       = $inkscope::params::mongo_replicat
  $rado_gw_url          = $inkscope::params::rado_gw_url


  file { '$inkscope::params::inkscope_conf_file' :
    ensure  => present,
    path    => $inkscope::params::inkscope_conf_file,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => template('inkscope/ink.conf.erb'),
    require => Package["$inkscope::params::inkscope_common_package"],
  }

}