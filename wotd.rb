require "httparty"
require "json"
require "pry"
require "rss"
require_relative "lib/scraper"

# response = HTTParty.get("https://feeds.feedblitz.com/japanese-word-of-the-day")
# rss = RSS::Parser.parse(response.body)
# title = rss.items.first.title
# details_table = rss.items.first.description.gsub("\r", "").gsub("\n", "")
# date = Time.parse(rss.items.first.pubDate.to_s).strftime("%m/%-d/%Y")

# binding.pry

scraper = Scraper.new.get_wotd
readme = File.read("README.md")
wotd = <<-WOTD
<!-- START WORD OF THE DAY -->
<table>
  <tr><td><strong>Japanese:</strong> <a href="#{scraper.word_audio_url}">🔊</a></td><td>#{scraper.word}</td></tr>
  <tr><td><strong>Kana:</strong></td><td>#{scraper.kana}</td></tr>
  <tr><td><strong>Part of speech:</strong></td><td>#{scraper.part_of_speach}</td></tr>
  <tr><td><strong>English:</strong></td><td>#{scraper.translation}</td></tr>
  <tr><td><strong>Example sentence:</strong> <a href="#{scraper.sentence_audio_url}">🔊</a></td><td>#{scraper.example_sentence}</td></tr>
  <tr><td><strong>Kana:</strong></td><td>#{scraper.example_sentence_kana}</td></tr>
  <tr><td><strong>English:</strong></td><td>#{scraper.example_sentence_translation}</td></tr>
</table>
<!-- END WORD OF THE DAY -->
WOTD
updated_readme = readme
  .gsub("\n", "\r")
  .gsub(/<!-- START WORD OF THE DAY -->(.*)<!-- END WORD OF THE DAY -->/, wotd.chomp)
  .gsub("\r", "\n")

File.open("README.md", "w") { |file| file.puts(updated_readme) }