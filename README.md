Programming Golan Telegram bot

1. The bot can be access using t.me/olegign_bot

2. To start the bot navigate to the folder that has bot code and execute: ./kbot start

3. To test, type /start hello to the bot, the bot should respond back with the message "Hello I'm kbot <bot_version>"

New features added in v1.0.5

1. Usage of Makefile
2. Possibility to specifically build an executable depending on the input (examples: 'make linux', or 'make windows' or 'make macos')
3. Docker file builds an image using OS and architecture values passed through the variables
4. GCP is used as alternative repostiory for the docker push command set via configurable variable in Makefile
5. Clean command is set to remove created docker image


Added GitLeaks feature to avoid commiting with secrets.

The following gitleaks options were added and tested:
1. Gitleaks via pre-commit script
2. Gitleaks using GitHub Actions
