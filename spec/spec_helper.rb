# This file is copied to ~/spec when you run 'ruby script/generate rspec'
# from the project root directory.
ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'spec'
require 'spec/rails'

require File.expand_path(File.dirname(__FILE__) + "/helpers/mock_helper")
include MockHelper

include AuthenticatedTestHelper

Spec::Runner.configure do |config|
  config.use_transactional_fixtures = true
  config.use_instantiated_fixtures  = false
  config.fixture_path = RAILS_ROOT + '/spec/fixtures/'
end

module Spec
  module Mocks
    module Methods
      def stub_association!(association_name, methods_to_be_stubbed={}, mock_association=nil)
        mock_association = Spec::Mocks::Mock.new(association_name.to_s) if mock_association.nil?
        methods_to_be_stubbed.each do |method, return_value|
          mock_association.stub!(method).and_return(return_value)
        end
        self.stub!(association_name).and_return(mock_association)
      end

      def stub_belongs_to_assoc!(association_name, mock_association=nil)

        mock_association = Spec::Mocks::Mock.new(association_name.to_s) if mock_association.nil?
        # methods_to_be_stubbed.each do |method, return_value|
        #   mock_association.stub!(method).and_return(return_value)
        # end

        methods = {}
        methods["#{association_name.to_s}".to_sym] = mock_association
        methods["build_#{association_name.to_s}".to_sym] = mock_association
        methods["create_#{association_name.to_s}".to_sym] = mock_association
        methods["#{association_name.to_s}=".to_sym] = true
        methods["#{association_name.to_s}_id".to_sym] = mock_association.id

        methods.each do |method, return_value|
          self.stub!(method).and_return(return_value)
        end
      end

      def stub_has_many_assoc!(association_name, mock_association=nil)

        child_methods = {}

        child_methods[:delete] = true
        child_methods[:clear] = true
        child_methods[:empty?] = false
        child_methods[:size] = [mock_association].length
        child_methods[:find] = mock_association
        child_methods[:exist?] = true
        child_methods[:build] = mock_association
        child_methods[:create] = mock_association
        child_methods[:first] = mock_association
        child_methods[:last] = mock_association

        mock_association = Spec::Mocks::Mock.new(association_name.to_s) if mock_association.nil?
        child_methods.each do |method, return_value|
          mock_association.stub!(method).and_return(return_value)
        end

        methods = {}
        # collection(force_reload = false) Returns an array of all the associated objects. An empty array is returned if none are found.
        methods["#{association_name.to_s}".to_sym] = mock_association
        # # collection<<(object, …) Adds one or more objects to the collection by setting their foreign keys to the collection‘s primary key.
        # methods["#{association_name.to_s}<<".to_sym] = true
        # collection=objects Replaces the collections content by deleting and adding objects as appropriate.
        methods["#{association_name.to_s}=".to_sym] = mock_association
        # collection_singular_ids Returns an array of the associated objects’ ids
        methods["#{association_name.to_s}_singular_ids".to_sym] = [mock_association.id]
        # collection_singular_ids=ids Replace the collection with the objects identified by the primary keys in ids
        methods["#{association_name.to_s}_singular_ids=".to_sym] = true

        methods.each do |method, return_value|
          self.stub!(method).and_return(return_value)
        end

      end

    end
  end
end
