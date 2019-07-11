class SignInScreen < PM::XLFormScreen
  title "Sign In"
  stylesheet SignInScreenStylesheet

  def form_data
    [
      {
        cells: [
          {
            title:       'Username',
            name:        :username,
            type:        :email,
            placeholder: 'Enter your username',
            required:    true
          },
          {
            title:       'Password',
            name:        :password,
            type:        :password,
            placeholder: 'Enter your password',
            required:    true
          },
          {
            title: 'Sign In',
            name: :save,
            type: :button,
            on_click: -> (cell) {
              authenticate
            }
          }
        ]
      }
    ]
  end

  def authenticate
    $auth = AWSCognitoIdentityPasswordAuthenticationDetails.alloc
      .initWithUsername(values['email'], password: values['password'])
    $input = AWSCognitoIdentityPasswordAuthenticationInput.alloc.lastKnownUsername
    puts "youre in"
    app.delegate.open_authenticated_root

    # Auth.sign_in(email: values["email"], password: values["password"]) do |response|
    #   if response.success?
    #     puts "Success"
    #     puts Auth.authorization_header
    #     puts response.object
    #     if response.object.nil?
    #       app.alert "Sorry, there was an error. Response object is nil"
    #     else
    #       ApiClient.update_authorization_header(response.object)
    #       puts response
    #       role = response.object["role"].to_s
    #       check_role(role)
    #     end
    #   else
    #     mp response
    #     error_message = response.object["error"] if response.object
    #     app.alert "Sorry, there was an error. #{error_message}"
    #     mp response.error.localizedDescription
    #   end
    # end
  end
end
