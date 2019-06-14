# An Example of using GitHub OAuth with RoR

## Usage

It goes without saying, you need RoR to be installed on your machine. To start the application you should clone this repo and create `/config/local_env.yml` file with your `CLIENT_ID` and `CLIENT_SECRET` variables provided by [GitHub](https://developer.github.com/apps/building-oauth-apps/).

After that run following commands in your root directory: 

```bash
rake db:reset
rails s
```

Go to the `http://localhost:3000` and click the button `Login with GitHub`