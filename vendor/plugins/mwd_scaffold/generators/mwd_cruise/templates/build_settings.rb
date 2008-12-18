module BuildSettings
  attr_reader :coverage_dir
  
  def coverage_dir
    @coverage_dir ||= ( "#{ENV['CC_BUILD_ARTIFACTS']}/coverage/" || 'coverage' )
  end

  def cyclomatic_dir
    @cyclomatic_dir ||= ( "#{ENV['CC_BUILD_ARTIFACTS']}/cyclomatic_complexity" || 'metrics/cyclomatic_complexity' )
  end

  def stats_dir
    @stats_dir ||= ( "#{ENV['CC_BUILD_ARTIFACTS']}" || 'metrics' )
  end

  def flog_dir
    @flog_dir ||= ( "#{ENV['CC_BUILD_ARTIFACTS']}/flog" || 'metrics/flog' )
  end
  
end