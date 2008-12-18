#!/usr/bin/env ruby  
  
html_path = "doc/spec/report.html"  
  
system "rake spec" # run the spec. send progress to screen. save html results to html_path  
  
# find out how many errors were found  
html = open(html_path).read  
examples = html.match(/(\d+) examples/)[0].to_i rescue 0  
failures = html.match(/(\d+) failures/)[0].to_i rescue 0  
pending = html.match(/(\d+) pending/)[0].to_i rescue 0  
  
if failures.zero?  
  puts "0 failures! #{examples} run, #{pending} pending"  
else  
  puts "\aDID NOT COMMIT YOUR FILES!"  
  puts "View spec results at #{File.expand_path(html_path)}"  
  puts  
  puts "#{failures} failures! #{examples} run, #{pending} pending"  
  exit 1  
end