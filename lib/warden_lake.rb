require 'warden'

require "warden_lake/version"
require "warden_lake/engine"

require "warden_lake/manager"
require "warden_lake/strategies/password_strategy"

module WardenLake
  def self.default_user_class=(klass)
    @default_user_class = klass
  end

  def self.default_user_class
    @default_user_class ||= User
  end

  def self.default_scope=(scope)
    @default_user_class = @scope_mapping[scope]
  end

  def self.default_user_class
    @default_user_class ||= User
  end

  def self.add_scope_mapping(scope, user_class)
    @scope_mapping ||= {}
    @scope_mapping[:scope] = user_class
  end

  def self.scope_mapping=(scopes_with_mapping)
    @scope_mapping = scopes_with_mapping
  end

  def self.scope_mapping
    @scope_mapping ||= {}
  end

  def self.identity_field=(identity_field)
    @identity_field = identity_field
  end

  def self.identity_field
    @identity_field
  end

  def self.fetch_user_class(scope)
    @scope_mapping[scope]
  end

end
