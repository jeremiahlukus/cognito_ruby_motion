class AppDelegate < PM::Delegate
  include CDQ # Remove this if you aren't using CDQ

  status_bar true, animation: :fade

  # Without this, settings in StandardAppearance will not be correctly applied
  # Remove this if you aren't using StandardAppearance
  ApplicationStylesheet.new(nil).application_setup

  def on_load(app, options)
    cdq.setup # Remove this if you aren't using CDQ
  end

  def startPasswordAuthentication
    mp "startPasswordAuthentication called"
    open SignInScreen.new(nav_bar: true)
  end


  def setup_cognito
    mp "setup cognito called"
    AWSDDLog.sharedInstance.logLevel = AWSLogLevelVerbose
    serviceConfiguration = AWSServiceConfiguration.alloc.initWithRegion(
      AWSRegionUSEast1,
      credentialsProvider: nil
    )
    cognitoConfiguration = AWSCognitoIdentityUserPoolConfiguration.alloc.initWithClientId(
      CognitoIdentityUserPoolAppClientId,
      clientSecret: CognitoIdentityUserPoolAppClientSecret,
      poolId: CognitoIdentityUserPoolId
    )
    AWSCognitoIdentityUserPool.registerCognitoIdentityUserPoolWithConfiguration(
      serviceConfiguration,
      userPoolConfiguration: cognitoConfiguration,
      forKey: "UserPool"
    )
    $pool = AWSCognitoIdentityUserPool.CognitoIdentityUserPoolForKey("UserPool")
    $pool.delegate = self
  end

  def open_authenticated_root
    open_tab_bar HomeScreen.new(nav_bar: true) #, HomeScreen.new(nav_bar: false)
  end

  def application(application, didFinishLaunchingWithOptions: launchOptions)
    setup_cognito
  end
end
