# == Define: icingaweb2::module::fileshipper::import
#
# Manage a basedir to import files with the fileshipper module.
#
# === Parameters
#
# [*import*]
#   The name of the import.  Default: resource title.
#
# [*basedir*]
#   The basedir of your import.
#
define icingaweb2::module::fileshipper::import(
  String $basedir,
  String $import  = $title,
){
  assert_private("You're not supposed to use this defined type manually.")

  $conf_dir        = $::icingaweb2::params::conf_dir
  $module_conf_dir = "${conf_dir}/modules/fileshipper"

  icingaweb2::inisection { "fileshipper-import-${basedir}":
    section_name => $basedir,
    target       => "${module_conf_dir}/imports.ini",
    settings     => {
      'basedir' => $basedir,
    }
  }
}
