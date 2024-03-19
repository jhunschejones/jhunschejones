# Word of the day development instructions

### Overview
The word of the day script scrapes a webpage that contains a Japanese word of the day and uses the data to update the README in this repository. The script is run on GitHub Actions in order to provide a live-updating personal repository for my GitHub account 🤖

### Running the script locally
1. `bundle install`
2. `brew install jq` _(if you don't have it installed yet)_
3. `./bin/install mac`
4. `./bin/run`
