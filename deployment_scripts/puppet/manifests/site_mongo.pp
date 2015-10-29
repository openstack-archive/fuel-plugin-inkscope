$fuel_settings = parseyaml(file('/etc/astute.yaml'))

class { 'inkscope::inkscope_db':}