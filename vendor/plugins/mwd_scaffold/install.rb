# Copy custom assets
puts "\nInstalling Assets"

for path in [ ['shared', '_icon_show.html.erb'],
              ['shared', '_icon_edit.html.erb'],
              ['shared', '_icon_reset_password.html.erb'],
              ['shared', '_icon_delete.html.erb'],
              ['shared', '_icon_change_password.html.erb'],
              ['shared', '_icon_deactivate.html.erb'],
              ['shared', '_icon_activate.html.erb'] ]
  source = File.join(File.dirname(__FILE__),'assets',*path)
  
  destination = File.join(RAILS_ROOT, 'app', 'views', *path)
  
  print "  #{path.join('/')} "
  
  if File.exists?(destination)
    if FileUtils.cmp(source, destination)
      puts "identical"
    else
      print "exits, overwrite [yN]?"
      if gets("\n").chomp.downcase.first == 'y'
        FileUtils.cp source, destination
      else
        puts "    ...skipped"; next
      end
    end
  else
    puts "create"
    FileUtils.mkdir_p File.dirname(destination)
    FileUtils.cp source, destination
  end
end

# for path in [ ['javascripts', 'ext_datetime.js'],
#               ['javascripts', 'ext_searchfield.js'],
#               ['stylesheets', 'ext_scaffold.css'],
#               ['images', 'ext_scaffold', 'arrowRight.gif'],
#               ['images', 'ext_scaffold', 'arrowLeft.gif'] ]
for path in [ ['images', 'icons', 'edit.gif'],
              ['images', 'icons', 'edit.png'],
              ['images', 'icons', 'editdelete.gif'],
              ['images', 'icons', 'editdelete.png'],
              ['images', 'icons', 'locked.gif'],
              ['images', 'icons', 'locked.png'],
              ['images', 'icons', 'reload.gif'],
              ['images', 'icons', 'reload.png'],
              ['images', 'icons', 'reset.gif'],
              ['images', 'icons', 'reset.png'],
              ['images', 'icons', 'unlocked.gif'],
              ['images', 'icons', 'unlocked.png'],
              ['images', 'icons', 'view_detailed.gif'],
              ['images', 'icons', 'view_detailed.png']
            ]
  
  source = File.join(File.dirname(__FILE__),'assets',*path)
  
  destination = File.join(RAILS_ROOT,'public',*path)
  
  print "  #{path.join('/')} "
  
  if File.exists?(destination)
    if FileUtils.cmp(source, destination)
      puts "identical"
    else
      print "exits, overwrite [yN]?"
      if gets("\n").chomp.downcase.first == 'y'
        FileUtils.cp source, destination
      else
        puts "    ...skipped"; next
      end
    end
  else
    puts "create"
    FileUtils.mkdir_p File.dirname(destination)
    FileUtils.cp source, destination
  end
end




puts <<_MSG

_MSG
