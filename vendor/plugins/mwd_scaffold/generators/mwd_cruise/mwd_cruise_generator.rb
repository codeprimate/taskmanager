class MwdCruiseGenerator < Rails::Generator::Base 
  def manifest 
    record do |m| 
      m.template('rspec_rcov.opts', File.join('spec', 'rspec_rcov.opts'))
      m.template('cruise.rake', File.join('lib', 'tasks', 'cruise.rake'))
      m.template('build_settings.rb', File.join('lib', 'build_settings.rb'))
    end 
  end
end
