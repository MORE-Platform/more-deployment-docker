# Setup Limesurvey for MORE

Follow these steps to set up and configure limesurvey for MORE

1. Go to `https://lime.${BASE_DOMAIN}/admin/`
   1. Login with the pre-configured admin-user
   2. Change the password to something secure
2. Security Settings
   1. SSL should be enabled through deployment (traefik ssl termination)
   2. Go to `Configuration > Global > Security` and enable the `Force HTTPS`-switch
   3. Save
3. General Settings
   1. Go to `Configuration > Global > General` and enter "MORE Survey" as `Site name`
   2. Switch to `Email settings` and configure outbound mail (optional)
   3. Switch to `Bounce settings` and configure inbound mail (optional)
   4. Switch to `Language` and update the language-settings (optional)
   5. Switch to `Interfaces` and enable the RPC interface JSON-RPC and toggle "Publish API on /admin/remotecontrol".
4. User Permissions
   1. Go to `Confiugration > User roles`
   2. Klick `Add user role`
   3. Enter `MORE Survey Manager` as `name` and provide a `description`
   4. In the list, klick on `Edit permissions`
   5. Select `Create` for `Survey groups`
   6. Select `Create` for `Surveys`
   7. Select `Create` for `User groups`
   8. Save
5. Authentication
   1. Go to `Configuration > Plugins` and press the `Scan files`-button
   2. Enable the `AuthOAuth2`-Plugin
   3. Configure the `AuthOAuth2`-Plugin
      1. Enter `Client ID` and `Client Secret` from the Auth-Server
      2. Add `Authorize URL`, `Access Token URL` and `User Details URL`
      3. Enter the `Scopes`: `openid`
      4. `Identifier Attribute` is `E-Mail`
      5. `Key for username` -> `preferred_username`
      6. `Key for email` -> `email`
      7. `Key for name` -> `name`
      8. Tick the `Use as default login` - the classic login form can always be accessed via `${BASE_URL}/admin/authentication/sa/login/authMethod/Authdb`
      9. Tick the `Create new users` checkbox
      10. Add the role `MORE Survey Manager` created earlier to the list of `Global roles for new users`
      11. Save and close
      12. Enable the plugin
6. Congratulations, you should be done!
