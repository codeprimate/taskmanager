rspec_base = File.expand_path("#{RAILS_ROOT}/vendor/plugins/rspec/lib")

$LOAD_PATH.unshift(rspec_base) if File.exist?(rspec_base)
require 'spec/rake/spectask'
require 'spec/rake/verify_rcov'
require 'lib/build_settings'

RCov::VerifyTask.new(:verify_rcov) { |t| t.threshold = 100.0 }

include BuildSettings

desc "Run specs and rcov"
Spec::Rake::SpecTask.new(:cruise_coverage) do |t|
  t.spec_opts = ['--options', "#{RAILS_ROOT}/spec/rspec_rcov.opts"]
  t.spec_files = FileList['spec/**/*_spec.rb']
  # t.rcov_dir = coverage_dir
  t.rcov = true
  t.rcov_opts = ['--exclude', 'test/*,spec/*,stories/*,vendor/*,gems/*,/Library/Ruby/Gems/*,/usr/local/lib/site_ruby/*', '--rails', '--text-report']
end

desc 'Custom curise task for RSpec'  
task :cruise do  
     ENV['RAILS_ENV'] = 'test'  
   
  if File.exists?(Dir.pwd + "/config/database.yml")  
    if Dir[Dir.pwd + "/db/migrate/*.rb"].empty?  
    raise "No migration scripts found in db/migrate/ but database.yml exists, " +  
          "CruiseControl won't be able to build the latest test database. Build aborted."  
    end  

    # perform standard Rails database cleanup/preparation tasks if they are defined in project  
    # this is necessary because there is no up-to-date development database on a continuous integration box  
    if Rake.application.lookup('db:test:purge') 
      CruiseControl::invoke_rake_task 'db:test:purge' 
    end 

    if Rake.application.lookup('db:migrate') 
      CruiseControl::reconnect 
      CruiseControl::invoke_rake_task 'db:migrate' 
    end
        
  end 

  CruiseControl::invoke_rake_task 'metrics:cyclomatic_complexity'
  system("cp metrics/cyclomatic_complexity #{cyclomatic_dir} ")
  
  CruiseControl::invoke_rake_task 'metrics:stats'
  system("cp metrics/stats.log #{stats_dir}/stats.log ")

  CruiseControl::invoke_rake_task 'metrics:flog'
  system("cp metrics/flog #{flog_dir} ")

  CruiseControl::invoke_rake_task 'cruise_coverage' 
  system("cp coverage #{coverage_dir} ")

  CruiseControl::invoke_rake_task 'verify_rcov'  

  
end