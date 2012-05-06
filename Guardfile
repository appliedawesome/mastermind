guard 'spork' do
  watch('spec/spec_helper.rb')
  watch('Gemfile')
  watch('Gemfile.lock')
  watch('config/application.rb')
  watch('config/environment.rb')
  watch(%r{^config/environments/.*\.rb$})
  watch(%r{^config/initializers/.*\.rb$})
end

# guard 'rspec', :version => 2, :cli => "--color --format documentation --drb" do
#   watch(%r{^spec/.+_spec\.rb$})
#   watch('config/routes.rb')                           { "spec/routing" }
#   watch('app/controllers/application_controller.rb')  { "spec/controllers" }
#   watch(%r{^app/(.+)\.rb$})                           { |m| "spec/#{m[1]}_spec.rb" }
#   watch('spec/spec_helper.rb')                        { "spec" }
# end

# guard 'rspec', :version => 2, :cli => "--color --format documentation --drb" do
guard 'rspec', :version => 2, :cli => "--color --drb --format documentation" do
  watch('spec/spec_helper.rb')                        { "spec" }
  watch('config/routes.rb')                           { "spec/routing" }
  watch('app/controllers/application_controller.rb')  { "spec/controllers" }
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^app/(.+)\.rb$})                           { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^lib/(.+)\.rb$})                           { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch(%r{^app/controllers/(.+)_(controller)\.rb$})  do |m|
    ["spec/routing/#{m[1]}_routing_spec.rb", 
    "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb", "spec/acceptance/#{m[1]}_spec.rb"] 
  end
end

# guard 'cucumber', :cli => '--color --drb --format progress --profile guard --strict' do
# guard 'cucumber', :cli => "--drb --no-profile --format progress --strict", :run_all => { :cli => "--no-profile --format progress features" } do
#   
#   watch(%r{^features/.+\.feature$})
#   watch(%r{^features/support/.+$})          { 'features' }
#   watch(%r{^features/step_definitions/(.+)_steps\.rb$}) { |m| Dir[File.join("**/#{m[1]}.feature")][0] || 'features' }
# end

guard 'migrate' do
  watch(%r{^db/migrate/(\d+).+\.rb})
end


