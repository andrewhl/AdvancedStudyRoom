
guard 'rspec', :zeus => true, :all_after_pass => false, :turnip => true do
  # Specs
  watch(%r{^spec/.+_spec\.rb$})
  watch('spec/spec_helper.rb')            { "spec" }

  # Lib
  watch(%r{^lib/(.+)\.rb$})               { |m| "spec/unit/lib/#{m[1]}_spec.rb" }
  watch(%r{^lib/(.+)\.rb$})               { |m| "spec/integration/lib/#{m[1]}_spec.rb" }

  # Rails App
  watch(%r{^app/(.+)\.rb$})               { |m| "spec/unit/#{m[1]}_spec.rb" }
  watch(%r{^app/(.+)\.rb$})               { |m| "spec/integration/#{m[1]}_spec.rb" }
  watch(%r{^spec/support/(.+)\.rb$})      { "spec" }

  # Acceptance
  watch(%r{^spec/.+\.feature$})
  watch(%r{^spec/steps/(.+)_steps\.rb$})        { |m| "spec/acceptance/#{m[1]}.feature" }
end
