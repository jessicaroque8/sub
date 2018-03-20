# sub
A Rails API backend for a mobile app to manage class instructor substitute requests for users of the MINDBODY business software (https://www.mindbodyonline.com/).

To launch:
1. Install dependencies as needed:
   * Ruby 2.4.1 (https://www.ruby-lang.org/en/downloads/)
   * Rails 5.1.5
      `$ gem install rails -v 5.1.5`
   * MINDBODY Developer Account (https://developers.mindbodyonline.com/Home/SignUp)
2. Install the project gems.
   `$ bundle install`
3. Configure environment variables with your MINDBODY Sandbox API credentials using the Figaro gem.
   * `$ bundle exec figaro install`
   * In config/application.yml:
   ```
   mindbody_source_name: SOURCE_NAME
   mindbody_source_key: SOURCE_KEY
   mindbody_siteid: SITE_ID
   ```
4. Follow the instructions in db/seeds.rb to modify the file with seeds relevant to your MINDBODY Sandbox. Then,
   `$ rails db:reset`
5. Launch the server.
   `$ rails server`
6. Setup and launch the frontend client. See the README for sub_frontend submodule.
