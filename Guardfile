# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'rspec', :zeus => true, :all_after_pass => false, :notification => true do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/unit/lib/#{m[1]}_spec.rb" }
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/integration/lib/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { "spec" }

  # Rails
  watch(%r{^app/(.+)\.rb$})                           { |m| "spec/unit/#{m[1]}_spec.rb" }
  watch(%r{^app/(.+)\.rb$})                           { |m| "spec/integration/#{m[1]}_spec.rb" }
  watch(%r{^spec/support/(.+)\.rb$})                  { "spec" }
  # watch(%r{^app/controllers/(.+)_(controller)\.rb$})  { |m| ["spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb"] }
  # watch('config/routes.rb')                           { "spec/controllers" }
  # watch('app/controllers/application_controller.rb')  { "spec/controllers" }
end
