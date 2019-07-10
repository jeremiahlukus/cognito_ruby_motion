class SignInScreen < PM::XLFormScreen
  title "Sign In"
  stylesheet SignInScreenStylesheet

  def form_data
    [
      {
        cells: [
          {
            title:       'Email',
            name:        :email,
            type:        :email,
            placeholder: 'Enter your email',
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
    # clientId 3mcdk545usdhekr76rclp6s7ct
    #"us-east-1:fc903ee0-5978-41c1-b5ec-fa035d26c6b4", // Identity pool ID
    #
    puts "your in"

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
