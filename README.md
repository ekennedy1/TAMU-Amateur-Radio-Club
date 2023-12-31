# README 
 
## Introduction ## 
 
This application was created for use by the TAMU Amateur Radio Club - W5AC. This application features an inventory, and equipment check-out/check-in system. 

 
 
## Requirements ## 
 
This code has been run and tested on: 
 
* Ruby - 3.1.2 
* Rails – 7.0.7.2 
* Ruby Gems - Listed in `Gemfile` 
* PostgreSQL - 13.7 
 
 
## External Deps  ## 
 
* Docker - Download latest version at https://www.docker.com/products/docker-desktop 
* Heroku CLI - Download latest version at https://devcenter.heroku.com/articles/heroku-cli 
* Git - Download latest version at https://git-scm.com/book/en/v2/Getting-Started-Installing-Git 
 
## Installation ## 
 
Download this code repository by using git: 
 
 `git clone https://github.com/ekennedy1/TAMU-Amateur-Radio-Club.git` 
 
 
## Tests ## 
 
An RSpec test suite is available and can be ran using: 
 
  `rspec spec/` 
 
## Execute Code ## 
 
Run the following code in Powershell if using windows or the terminal using Linux/Mac 
 
  `cd TAMU-Amateur-Radio-Club` 
 
  `docker run --rm -it --volume "$(pwd):/rails_app" -e DATABASE_USER=test_app -e DATABASE_PASSWORD=test_password -p 3000:3000 dmartinez05/ruby_rails_postgresql:latest` 
 
  `cd rails_app` 
 
Install the app 
 
  `bundle install && rails webpacker:install && rails db:create && db:migrate` 
 
Run the app 
  `rails server --binding:0.0.0.0` 
 
The application can be seen using a browser and navigating to http://localhost:3000/ 
 
## Environmental Variables/Files ## 
 
Google OAuth2 support requires two keys to function as intended: Client ID and Client Secret 
 
Create a new file called application.yml in the /config folder and add the following lines: 
 
  `GOOGLE_OAUTH_CLIENT_ID: 'YOUR_GOOGLE_OAUTH_CLIENT_ID_HERE'` 
 
  `GOOGLE_OAUTH_CLIENT_SECRET: 'YOUR_GOOGLE_OAUTH_CLIENT_SECRET_HERE'` 
 
 
## Deployment ## 
 
Setup a Heroku account: https://signup.heroku.com/ 
 
From the heroku dashboard select `New` -> `Create New Pipline` 
 
Name the pipeline, and link the respective git repo to the pipline 
 
Our application does not need any extra options, so select `Enable Review Apps` right away 
 
Click `New app` under review apps, and link your test branch from your repo 
 
Under staging app, select `Create new app` and link your main branch from your repo 
 
-------- 
 
To add environment variables to enable google oauth2 functionality, head over to the settings tab on the pipeline dashboard 
 
Scroll down until `Reveal config vars` 
 
Add both your client id and your secret id, with fields `GOOGLE_OAUTH_CLIENT_ID` and `GOOGLE_OAUTH_CLIENT_SECRET` respectively 
 
Now once your pipeline has built the apps, select `Open app` to open the app 
 
With the staging app, if you would like to move the app to production, click the two up and down arrows and select `Move to production` 
 
And now your application is setup and in production mode! 
 
 
## CI/CD ## 
 
For continuous development, we set up Heroku to automatically deploy our apps when their respective github branches are updated. 
 
  `Review app: test branch` 
 
  `Production app: main branch` 
 
For continuous integration, we set up a Github action to run our specs, security checks, linter, etc. after every push or pull-request. This allows us to automatically ensure that our code is working as intended. 
 
## References ## 
 
- https://www.w3schools.com/howto/howto_js_filter_table.asp 
 
## Support ## 
 
Admins looking for support should first look at the application help page. 
Users looking for help seek out assistance from the customer. 
