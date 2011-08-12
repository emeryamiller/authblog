require 'ruby-growl'
require 'open3'

ENV["WATCHR"] = "1"
$spec_cmd = "env RSPEC_COLOR=true spec --drb --colour --format nested"
$cuke_cmd = "cucumber --color --drb --require features/step_definitions --require features/support"
$growl = Growl.new('localhost', 'Watchr', [:pass, :fail, :pending].map(&:to_s))

def growl_spec(message='')
  if message.match(/\s0\s(errors|failures)/)
    title = 'Watchr: All specs passed'
    notification_type = :pass
  elsif message.match(/(error|failure)/)
    title = 'Watchr: Specs are failing'
    notification_type = :fail
  elsif message.match(/pending/)
    title = 'Watchr: Pending specs'
    notification_type = :pending
  else
    title = 'Watchr: Running specs'
    message = 'Running specs'
    notification_type = $pending
  end
  $growl.notify notification_type.to_s, title, message
end

def run_spec(spec)
  cmd = "#{$spec_cmd} #{spec}"
  
  growl_spec
  system('clear')
  puts(cmd)
  
  last_output = ''
  stdin, stdout, stderr = Open3.popen3(cmd)
  stdout.each_line do |line|
    last_output = line
    puts line
  end
  
  growl_spec last_output.gsub(/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]/, '')
end

def run_all_specs
  run_spec '/spec'
end

def related_specs(path)
  Dir['spec/**/*.rb'].select { |file| file =~ /#{File.basename(path).split(".").first}_spec.rb/ }
end

def growl_feature(message='')
  if message.match(/failed/)
    title = 'Watchr: Scenarios are failing'
    notification_type = :fail
  elsif message.match(/passed/)
    title = 'Watchr: All scenarios passed'
    notification_type = :pass
  elsif message.match(/undefined/)
    title = 'Watchr: Undefined Steps'
    notification_type = :pending
  else
    title = 'Watchr: Running features'
    message = 'Running features'
    notification_type = :pending
  end
  $growl.notify notification_type.to_s, title, message
end

def run_feature(feature)  
  cmd = "#{$cuke_cmd} #{feature}"
  
  growl_feature
  system('clear')
  puts(cmd)
  
  last_output = []
  stdin, stdout, stderr = Open3.popen3(cmd)
  stdout.each_line do |line|
    last_output.replace([]) if line.strip.empty?
    last_output.push(line)
    puts line
  end
  
  growl_feature last_output.join('').gsub(/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]/, '')
end

def run_all_features
  run_feature '/features'
end

def run_suite
  run_all_specs
  run_all_features
end

@interrupted = false

# Ctrl-C
Signal.trap 'INT' do
  if @interrupted then
    @wants_to_quit = true
    abort("\n")
  else
    puts "Interrupt a second time to quit"
    @interrupted = true
    Kernel.sleep 1.5
  end
end

# Ctrl-\
Signal.trap 'QUIT' do
  puts " --- Running full suite ---\n\n"
  run_suite
end

watch('spec/spec_helper\.rb') { run_all_specs }
watch('spec/support/.*') { run_all_specs }
watch('spec/.*_spec\.rb') { |m| run_spec m[0] }
watch('app/.*\.rb') { |m| related_specs(m[0]).map {|tf| run_spec tf } }
watch('features/support/.*') { |m| run_all_features }
watch('features/.*\.feature') { |m| run_feature m[0] }

