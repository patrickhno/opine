
Rake::Task["gemspec"].enhance do
  spec = "opine.gemspec"
  text = File.read(spec)
  text.gsub!(/^(.*<cocoa>.*)$/, '\1 if RUBY_PLATFORM =~ /darwin/')
  text.gsub!(/^(.*<stench>.*)$/, '\1 if RUBY_PLATFORM =~ /cygwin|mingw|mswin|windows/')
  File.open(spec, 'w') { |file| file.write(text) }
end
