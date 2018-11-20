require 'fileutils'

ROOT = "./"
YMER = "./ymer"
MIMER = "./mimer"
BRAGE = "./ymer/brage"

CONFIG = {
  'pollen_sida' => File.join(ROOT),
  'pollen_utkast' => File.join(ROOT),
  'pollen_ext' => "html.pm"
}

# definitioner
def ask(message, valid_options)
  if valid_options
    answer = get_stdin("#{message} #{valid_options.to_s.gsub(/"/, '').gsub(/,/, '/')}") while !valid_options.include?(answer)
  else
    answer = get_stdin(message)
  end
  answer
end

def get_stdin(message)
  print message
  STDIN.gets.chomp
end



# taskar
desc "tabort mappar: compiled"
task :rensa do
  sh 'find . -type d -iname "compiled" | xargs rm -rfv'
end

namespace :utkast do
  namespace :skapa do
    namespace :pollen do
      desc "Att skapa ett nyt artikel med stilen:mstill"
      task :utkastMstill => [:rensa]
      task :utkastMstill, :title do |t, args|
        FileUtils.mkdir_p "#{CONFIG['pollen_utkast']}" unless FileTest.directory?(CONFIG['pollen_utkast'])
        if args.title
          title = args.title
        else
          title = get_stdin("Ange ett namn: ")
        end
        slug = title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
        begin
          date = (ENV['date'] ? Time.parse(ENV['date']) : Time.now).strftime('%Y-%m-%d')
          idag = (ENV['date'] ? Time.parse(ENV['date']) : Time.now).strftime('%d/%m/%Y')
        end
        filnamn = File.join(CONFIG['pollen_utkast'], "#{date}-#{slug}-pm.#{CONFIG['pollen_ext']}")

        if File.exist?(filnamn)
          abort("Nej!!") if ask("Filen #{filnamn} finns redan. Vill du skriva över?", ['j','N'] ) == 'n'
        end

        puts "Jag har skapat ett nytt utkast: #{filnamn}"

        open(filnamn, 'w') do |post|
          post.puts '#lang pollen/markup'
          post.puts '◊headline{◊sub{,WHusUtopi}}'
          post.puts '◊(define-meta background "svartalv/header.jpeg")'
          post.puts "◊define-meta[publish-date]{#{idag}}"
          # post.puts '◊(define-meta publish-date "#{idag}")'
          post.puts '◊(define-meta author "Hugo Bernstein")'
          post.puts '◊(define-meta categories "blog")'
          post.puts '◊(define-meta toc "true")'
          post.puts ''
          post.puts '◊image["100vw" "svartalv/cover.jpeg"]{cover img}'
          post.puts '◊section{Purpose/Syftet}'
          post.puts 'previously,'
          post.puts "◊nosection{Källor}"
          post.puts '◊ol[#:class "hebrew"]{'
          post.puts '  ◊li{◊link[""]{}}'
          post.puts "}"
          post.puts '◊;figure["svartalv/header.jpeg" #:width "100vw" #:label "fig:plot"]{något}'

        end
      end
    end
  end
end
