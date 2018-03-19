# sub
A MINDBODY API client to manage staff sub requests.

To launch:
1. Install dependencies as needed:
   * Ruby (https://www.ruby-lang.org/en/downloads/)
   * Rails
      `$ gem install rails`
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
4. Follow the instructions in db/seed.rb to modify the file with seeds relevant to your MINDBODY Sandbox. Then,
   `$ rails db:reset`
5. Launch the server.
   `$ rails server`
6. Setup and launch the client. See the README for sub_frontend submodule.
