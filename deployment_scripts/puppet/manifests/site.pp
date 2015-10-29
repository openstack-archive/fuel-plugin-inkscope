$fuel_settings = parseyaml(file('/etc/astute.yaml'))

#class { 'inkscope::inkscope_db':}
class { 'inkscope::inkscope_common':}
class { 'inkscope::inkscope_admviz':}
class { 'inkscope::ceph_rest_api':}
class { 'inkscope::ceph_probe':}
class { 'inkscope::sysprobe':}