require "selenium-webdriver"

class Scraper
  attr_reader :word, :kana, :translation, :part_of_speech, :word_audio_url,
              :example_sentence, :example_sentence_kana, :example_sentence_translation,
              :sentence_audio_url

  def get_wotd
    options = Selenium::WebDriver::Chrome::Options.new(args: ["--headless=new"])
    driver = Selenium::WebDriver.for(:chrome, options: options)

    driver.get("https://wotd.transparent.com/widget/?lang=japanese")

    wait = Selenium::WebDriver::Wait.new(timeout: 15)
    wait.until { !driver.find_element(:css, ".js-wotd-wordsound-plus").text.empty? }

    @word = driver.find_element(:css, ".js-wotd-wordsound-plus").text
    @kana = driver.find_element(:css, ".js-wotd-word-transliterated").text
    @translation = driver.find_element(:css, ".js-wotd-translation").text
    @part_of_speech = driver.find_element(:css, ".js-wotd-wordtype").text
    @word_audio_url = driver.find_element(:css, ".native-word source").dom_attribute("src")

    @example_sentence = driver.find_element(:css, ".js-wotd-phrasesound-plus").text
    @example_sentence_kana = driver.find_element(:css, ".js-wotd-phrase-transliterated").text
    @example_sentence_translation = driver.find_element(:css, ".js-wotd-enphrase").text
    @sentence_audio_url = driver.find_element(:css, ".native-example source").dom_attribute("src")

    self
  ensure
    driver&.quit
  end
end
