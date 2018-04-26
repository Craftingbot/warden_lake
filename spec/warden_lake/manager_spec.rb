RSpec.describe WardenLake::Manager do
  before(:each) do
    @app = lambda{|e| Rack::Resposnse.new('resonse').finish}
    class ::User

    end

    class ::AdminUser

    end
  end

  it 'WardenLake::Manager should be a instance of Warden::Manager' do
    m = WardenLake::Manager.new(@app, scope_mapping: {user: User, admin: AdminUser}, default_scope: :user)
    expect(m).to be_an_instance_of(Warden::Manager)
  end

  it 'WardenLake::Manager should has scope with class mapping' do
    m = WardenLake::Manager.new(@app, scope_mapping: {user: User, admin: AdminUser}, default_scope: :user)
    expect(WardenLake.default_user_class).to eq(User)
    expect(WardenLake.fetch_user_class(:admin)).to eq(AdminUser)
  end
end
