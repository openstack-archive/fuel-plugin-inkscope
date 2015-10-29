class inkscope::params {

  if $::osfamily == 'Debian' {

    $required_packages      = [ 'lshw', 'sysstat', 'python-pip', 'python-dev', 'python-pymongo']
    $apache_service_name    = 'apache2'
    $ps_utils_path          = '/tmp/psutil-2.2.0.tar.gz'
    $apache_port_file       = '/etc/apache2/ports.conf'
    $apache_site_file       = '/etc/apache2/sites-available/inkScope.conf'
    $inkscope_port          = '8100'


    $inkscope_conf_file             = '/opt/inkscope/etc/inkscope.conf'
    $inkscope_common_package        = 'inkscope-common'
    $inkscope_sysprobe_package      = 'inkscope-sysprobe'
    $inkscope_cephrestapi_package   = 'inkscope-cephrestapi'
    $inkscope_cephprobe_package     = 'inkscope-cephprobe'
    $inkscope_admviz_package        = 'inkscope-admviz'


    $inkscope_sysprobe_service      = 'sysprobe'
    $inkscope_cephrestapi_service   = 'ceph-rest-api'
    $inkscope_cephprobe_service     = 'cephprobe'

    $rest_api_port                  = '8100'
    $inkscope_user                  = 'inkscope'
    $inkscope_password              = 'inkscope'

    $nodes_hash                 = $::fuel_settings['nodes']

    $mongodb_set                    = mongo_hosts($::fuel_settings['nodes'])
    $mongodb_set2                    = mongo_hosts($::fuel_settings['nodes'], 'array')
    if size($mongodb_set2)  > 1 {
    $mongo_replicat                 = '1'
    } else {
    $mongo_replicat                 = '0'
    }


    $controller = concat(filter_nodes($nodes_hash,'role','primary-controller'), filter_nodes($nodes_hash,'role','controller'))
    $controller_node_public  = $::fuel_settings['public_vip']
    $controller_node_address = $::fuel_settings['management_vip']


    $rado_gw_url                    = $controller_node_public
    $ceph_rest_api_host             = $controller_node_public

  } elsif($::osfamily == 'RedHat') {

    $required_packages      = [ 'sysstat', 'python-pip', 'python-devel', 'python-pymongo']
    $apache_service_name    = 'httpd'
    $ps_utils_path          = '/tmp/psutil-2.2.0.tar.gz'
    $apache_port_file       = '/etc/httpd/conf/ports.conf'
    $apache_site_file       = '/etc/httpd/conf.d/inkScope.conf'
    $inkscope_port          = '8100'


    $inkscope_conf_file             = '/opt/inkscope/etc/inkscope.conf'
    $inkscope_common_package        = 'inkscope-common'
    $inkscope_sysprobe_package      = 'inkscope-sysprobe'
    $inkscope_cephrestapi_package   = 'inkscope-cephrestapi'
    $inkscope_cephprobe_package     = 'inkscope-cephprobe'
    $inkscope_admviz_package        = 'inkscope-admviz'


    $inkscope_sysprobe_service      = 'sysprobe'
    $inkscope_cephrestapi_service   = 'ceph-rest-api'
    $inkscope_cephprobe_service     = 'cephprobe'

    $rest_api_port                  = '8100'
    $inkscope_user                  = 'inkscope'
    $inkscope_password              = 'inkscope'

    $nodes_hash                 = $::fuel_settings['nodes']

    $mongodb_set                    = mongo_hosts($::fuel_settings['nodes'])
    $mongodb_set2                    = mongo_hosts($::fuel_settings['nodes'], 'array')
    if size($mongodb_set2)  > 1 {
    $mongo_replicat                 = '1'
    } else {
    $mongo_replicat                 = '0'
    }


    $controller = concat(filter_nodes($nodes_hash,'role','primary-controller'), filter_nodes($nodes_hash,'role','controller'))
    $controller_node_public  = $::fuel_settings['public_vip']
    $controller_node_address = $::fuel_settings['management_vip']


    $rado_gw_url                    = $controller_node_public
    $ceph_rest_api_host             = $controller_node_public


  } else {
    fail("unsuported osfamily ${::osfamily}, currently Debian and Redhat are the only supported platforms")
  }


}