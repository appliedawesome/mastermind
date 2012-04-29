describe HeistsController, "routes" do
  it 'routes requests to the appropriate actions' do
    {:get => '/heists'}.
      should route_to(:controller => 'heists', :action => 'index')
    {:get => '/heists/1'}.
      should route_to(:controller => 'heists', :action => 'show', :id => '1')
    {:get => '/heists/new'}.
      should route_to(:controller => 'heists', :action => 'new')
    {:post => '/heists'}.
      should route_to(:controller => 'heists', :action => 'create')
    {:get => '/heists/1/edit'}.
      should route_to(:controller => 'heists', :action => 'edit', :id => '1')
    {:put => '/heists/1'}.
      should route_to(:controller => 'heists', :action => 'update', :id => '1')
    {:delete => '/heists/1'}.
      should route_to(:controller => 'heists', :action => 'destroy', :id => '1')
  end
end