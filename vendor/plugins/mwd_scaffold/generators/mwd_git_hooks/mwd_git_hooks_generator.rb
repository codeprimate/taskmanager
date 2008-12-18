class MwdGitHooksGenerator < Rails::Generator::Base 
  def manifest 
    record do |m| 
      m.template('pre-commit.rb', File.join('.git', 'hooks', 'pre-commit'))
      system('chmod +x ./.git/hooks/pre-commit')
      m.template('post-commit.rb', File.join('.git', 'hooks', 'post-commit'))
      system('chmod +x ./.git/hooks/post-commit')
    end 
  end
end
