require 'warden_lake/failure_app'

module WardenLake
  class Delegator
    def call(env)
      WardenLake::FailureApp.call(env)
    end
  end
end
