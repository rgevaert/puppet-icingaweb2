# == Class: icingaweb2::module::fileshipper
#
# Install and enable the fileshipper module.
#
# === Parameters
#
# [*ensure*]
#   Enable or disable module. Defaults to `present`
#
# [*git_repository*]
#   Set a git repository URL. Defaults to github.
#
# [*git_revision*]
#   Set either a branch or a tag name, eg. `master` or `v2.0.0`.
#
# [*importsources*]
#   A hash of importsources. The hash expects a `patten` and a `url` for each importsource. The regex pattern is to
#   match the ticket ID, eg. `/#([0-9]{4,6})/`. Place the ticket ID in the URL, eg.
#   `https://my.ticket.system/tickets/id=$1`
#
#   Example:
#   importsources => {
#     system1 => {
#       pattern => '/#([0-9]{4,6})/',
#       url     => 'https://my.ticket.system/tickets/id=$1'
#     }
#   }
#
class icingaweb2::module::fileshipper(
  Enum['absent', 'present'] $ensure         = 'present',
  String                    $git_repository = 'https://github.com/Icinga/icingaweb2-module-fileshipper.git',
  Optional[String]          $git_revision   = undef,
  Hash                      $importsources  = {},
){
  create_resources('icingaweb2::module::fileshipper::importsource', $importsources)

  icingaweb2::module {'fileshipper':
    ensure         => $ensure,
    git_repository => $git_repository,
    git_revision   => $git_revision,
  }
}
