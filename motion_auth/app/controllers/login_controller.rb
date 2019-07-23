class LoginController < PM::XLFormScreen
  form_options on_save: :signInPressed

  def form_data
    [
      {
        title: "Login",
        cells: [
          {
            title: "Username",
            name: :email,
            placeholder: "username",
            type: :email,
            auto_correction: :no,
            auto_capitalization: :none
          },{
            title: "Password",
            name: :password,
            placeholder: "required",
            type: :password,
            secure: true
          },
          {

            title: "Login",
            name: :save,
            type: :button,
            on_click: -> (cell){
               on_save(nil)
            }
          }
        ]
      }]
  end

  def signInPressed
    $auth = AWSCognitoIdentityPasswordAuthenticationDetails.alloc
      .initWithUsername(values['email'], password: values['password'])
  end

  # should get called magically
  def getPasswordAuthenticationDetails
    puts "youre in"
    if !values['email']
      values['email'] = "hey"
    end
    $input = AWSCognitoIdentityPasswordAuthenticationInput.alloc.lastKnownUsername
    app.delegate.open_authenticated_root
  end

  # should get called magically
  def didCompletePasswordAuthenticationStepWithError
    app.alert("error")
  end
end
