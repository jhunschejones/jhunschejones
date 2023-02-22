require "selenium-webdriver"

class Scraper

  attr_reader :word, :kana, :translation, :part_of_speach, :word_audio_url,
              :example_sentence, :example_sentence_kana, :example_sentence_translation,
              :sentence_audio_url

  def get_wotd
    service = Selenium::WebDriver::Service.chrome(path: chromedriver_path)
    driver_args = ["--headless"]
    options = Selenium::WebDriver::Chrome::Options.new(args: driver_args)
    driver = Selenium::WebDriver.for(:chrome, service: service, options: options)
    driver.get("https://wotd.transparent.com/widget/?lang=japanese")

    sleep 5

    @word = driver.find_element(:css, ".js-wotd-wordsound-plus").text
    @kana = driver.find_element(:css, ".js-wotd-word-transliterated").text
    @translation = driver.find_element(:css, ".js-wotd-translation").text
    @part_of_speach = driver.find_element(:css, ".js-wotd-wordtype").text
    @word_audio_url = driver.find_element(:css, ".native-word").find_element(:xpath, ".//*[local-name()='source'][1]").dom_attribute("src")

    @example_sentence = driver.find_element(:css, ".js-wotd-phrasesound-plus").text
    @example_sentence_kana = driver.find_element(:css, ".js-wotd-phrase-transliterated").text
    @example_sentence_translation = driver.find_element(:css, ".js-wotd-enphrase").text
    @sentence_audio_url = driver.find_element(:css, ".native-example").find_element(:xpath, ".//*[local-name()='source'][1]").dom_attribute("src")

    self
  end

  private

  def chromedriver_path
    @chromedriver_path ||= begin
      return "bin/chromedriver" if File.exist?("bin/chromedriver")
      return "/usr/local/bin/chromedriver" if File.exist?("/usr/local/bin/chromedriver")
      raise "Sorry, I couldn't find the chromedriver binanary"
    end
  end
end
