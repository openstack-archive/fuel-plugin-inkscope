class inkscope::inkscope_db (

){
  include inkscope::params

  $db_user      = 'admin'
  $db_pwd       = $::fuel_settings['ceilometer']['db_password']
  $ink_db_user  = $inkscope::params::inkscope_user
  $ink_dc_pwd   = $inkscope::params::inkscope_password

  file { '/tmp/inkscope_database.sh' :
    ensure  => present,
    path    => '/tmp/inkscope_database.sh',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => file('/etc/fuel/plugins/inkscope-2.0/puppet/modules/inkscope/files/inkscope_database.sh'),
  }


   exec { "inkscope_db":
    command => "bash -c \"/tmp/inkscope_database.sh  ${db_user} ${db_pwd} ${ink_db_user} ${ink_dc_pwd} \"",
    path => '/usr/sbin:/usr/bin:/sbin:/bin',
    require => File['/tmp/inkscope_database.sh'],
  }

}