# Test Telegram Bot in Golang
This is a simple Telegram bot implemented in Golang using the Cobra CLI library and the telebot package.
Bot: t.me/hetmanruslan_bot

## Installation
To run this bot, you need to have Go installed on your system. You can install it from [here](https://go.dev/doc/install).

Clone the repository:
```shell
git clone https://github.com/HetmanRuslan/kbot.git
```

Navigate to the project directory:
```shell
cd ./kbot
```

Build and run the bot:
```shell
go build && ./kbot start
```

## Usage
This bot listens for incoming messages and performs actions based on the commands or text received.

### Commands
* **/start:** Starts the bot and responds "Hello!".
* **/something:** Responds with "Lorem ipsum".
* **/version:** Responds with the version of the bot.

### Other Messages
The bot will **reverse** any other text messages it receives.

## Configuration
This bot requires a Telegram Bot Token (TELE_TOKEN) environment variable to be set. You can obtain a token by creating a bot on Telegram using the BotFather.

Set the environment variable:
```shell
export TELE_TOKEN="your-bot-token"
```

## Dependencies
* [Cobra](https://github.com/spf13/cobra): A CLI library for Go.
* [telebot](https://gopkg.in/telebot.v3): A Telegram bot framework for Go.

## License
MIT License
