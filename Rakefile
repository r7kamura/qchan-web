namespace :doc do
  desc "Generate SVG files from doc/dot/*.dot"
  task :dot do
    require "pathname"
    Pathname.glob("doc/dot/*.dot").each do |dot|
      svg = Pathname.new("doc/png/#{dot.basename('.dot')}.png")
      svg.parent.mkpath
      dot.parent.mkpath
      sh "dot -o #{svg} -Tpng #{dot}"
    end
  end
end

desc "Run web server on localhost:4000"
task :server do
  `ruby -run -e httpd . -p 4000`
end

desc "Compile coffee scripts into javascripts"
task :compile do
  files = Dir.glob("coffee/**/*.js.coffee").sort
  files -= ["coffee/main.js.coffee"]
  files << "coffee/main.js.coffee"
  sh "coffee --watch --join javascripts/main.js --compile #{files.join(' ')}"
end

task default: :server
