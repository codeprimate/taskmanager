class <%= class_name %> < ActiveRecord::Base

  #
  # MODEL RELATIONSHIPS
  #


  #
  # MODEL VALIDATIONS
  #


  #
  # MODEL STATE MACHINE
  #
  acts_as_state_machine :initial => :active, :column => 'state'

  state :active
  state :suspended
  state :deleted
  
  event :activate  do
    transitions :from => [:deleted, :suspended], :to => :active
  end
  
  event :suspend do
    transitions :from => :active, :to => :suspended
  end
  
  event :delete do
    transitions :from => [:active, :suspended], :to => :deleted
  end

  #
  # MODEL METHODS
  #

end
