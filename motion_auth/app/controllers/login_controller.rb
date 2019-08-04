class LoginController < UIViewController
  def viewDidLoad
    super
    self.title = 'Cognito Login'
    self.view.backgroundColor = UIColor.whiteColor

    @login_form = LoginFormView.build_login_form
    @login_form.login_button.addTarget(self, action: "login", forControlEvents: UIControlEventTouchUpInside)

    self.view.addSubview @login_form
  end
end
