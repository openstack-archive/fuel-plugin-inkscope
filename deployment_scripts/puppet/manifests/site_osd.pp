$fuel_settings = parseyaml(file('/etc/astute.yaml'))

class { 'inkscope::inkscope_common':}
class { 'inkscope::sysprobe':}