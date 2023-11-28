require "httparty"
require "json"
require_relative "lib/scraper"

puts "Running WOTD scraper..."
scraper = Scraper.new.get_wotd

puts "Updating README.md..."
readme = File.read("README.md")
wotd = <<-WOTD
<!-- START WORD OF THE DAY -->
<table>
  <tr><td><strong>Japanese:</strong> <a href="#{scraper.word_audio_url}">🔊</a></td><td>#{scraper.word}</td></tr>#{(!scraper.kana.empty? && scraper.word != scraper.kana) ? "\n  <tr><td><strong>Reading:</strong></td><td>#{scraper.kana}</td></tr>" : ""}
  <tr><td><strong>Part of speech:</strong></td><td>#{scraper.part_of_speach}</td></tr>
  <tr><td><strong>English:</strong></td><td>#{scraper.translation}</td></tr>
  <tr><td><strong>Example sentence:</strong> <a href="#{scraper.sentence_audio_url}">🔊</a></td><td>#{scraper.example_sentence}</td></tr>#{!scraper.example_sentence_kana.empty? ? "\n  <tr><td><strong>Reading:</strong></td><td>#{scraper.example_sentence_kana}</td></tr>" : ""}
  <tr><td><strong>English:</strong></td><td>#{scraper.example_sentence_translation}</td></tr>
</table>
<!-- END WORD OF THE DAY -->
WOTD
updated_readme = readme
  .gsub("\n", "\r")
  .gsub(/<!-- START WORD OF THE DAY -->(.*)<!-- END WORD OF THE DAY -->/, wotd.chomp)
  .gsub("\r", "\n")

File.open("README.md", "w") { |file| file.puts(updated_readme) }

puts "Done 🎉"
