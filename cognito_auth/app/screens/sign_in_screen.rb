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
            signInPressed
           }
         }
       ]
     }
   ]
 end

  def signInPressed
    $auth = AWSCognitoIdentityPasswordAuthenticationDetails.alloc
      .initWithUsername(values['email'], password: values['password'])
    $passwordAuthenticationCompletion.result = $auth
  end

  def getPasswordAuthenticationDetails
    puts "youre in"
    if !values['email']
      values['email'] = "hey"
    end
    $input = AWSCognitoIdentityPasswordAuthenticationInput.alloc.lastKnownUsername
    app.delegate.open_authenticated_root
  end

  def didCompletePasswordAuthenticationStepWithError
    app.alert("error")
  end
end
