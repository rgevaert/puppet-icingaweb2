require 'spec_helper'

describe('icingaweb2::module::fileshipper', :type => :class) do
  let(:pre_condition) { [
      "class { 'icingaweb2': }"
  ] }

  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts
      end

      context "#{os} with git_revision 'v1.0.1'" do
        let(:params) { { :git_revision => 'v1.0.1', } }

        it { is_expected.to contain_icingaweb2__module('fileshipper')
          .with_install_method('git')
          .with_git_revision('v1.0.1')
        }
      end

      context "#{os} with a importsource" do
        let(:params) { {
            :git_revision => 'v1.0.1',
            :importsources => {
                'foo' => {
                    'pattern' => 'foobar',
                    'url' => 'barfoo'
                }
            }
        } }

        it { is_expected.to contain_icingaweb2__module__fileshipper__importsource('foo')
          .with_pattern('foobar')
          .with_url('barfoo')
        }

        it { is_expected.to contain_icingaweb2__inisection('fileshipper-importsource-foo')
          .with_section_name('foo')
          .with_target('/etc/icingaweb2/modules/fileshipper/config.ini')
          .with_settings( {'pattern' => 'foobar', 'url' => 'barfoo'} )
        }

        it { is_expected.to contain_icingaweb2__module('fileshipper')
          .with_install_method('git')
          .with_git_revision('v1.0.1')
        }
      end
    end
  end
end
