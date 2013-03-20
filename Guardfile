# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'rspec' do
  watch(%r{^.+_spec\.rb$})
  watch(%r{^(.+)\.rb$})     { |m| "#{m[1]}_spec.rb" }
end
