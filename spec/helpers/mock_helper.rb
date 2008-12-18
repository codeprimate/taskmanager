module MockHelper
  Dir.new((mock_root = "#{RAILS_ROOT}/spec/mocks/")).entries.select{|f| f.match(/_mock.rb$/)}.each{|f| require(mock_root + f)}
end
