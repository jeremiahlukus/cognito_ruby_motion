class PoolDelegateHandler
  def initialize screen_callback
    mp "setting screen callback"
    @screen_callback = screen_callback
  end

  def finalize
    puts "in pool del final"
    super
  end

  def startPasswordAuthentication()
    Dispatch::Queue.main.async do
      @screen_callback.call
    end
  end
end

class AppDelegate < PM::Delegate
  include CDQ # Remove this if you aren't using CDQ

  status_bar true, animation: :fade

  # Without this, settings in StandardAppearance will not be correctly applied
  # Remove this if you aren't using StandardAppearance
  ApplicationStylesheet.new(nil).application_setup

  def on_load(app, options)
    cdq.setup # Remove this if you aren't using CDQ
  end

  def finalize
    puts "in finalize"
    super
  end

  def show_signin
    mp "startPasswordAuthentication called"
    open SignInScreen.new(nav_bar: true)
  end

  def method_missing(m, *args)
    puts m
    super
  end

  def setup_cognito
    mp "setup cognito called"
    AWSDDLog.sharedInstance.logLevel = AWSLogLevelVerbose
    @serviceConfiguration = AWSServiceConfiguration.alloc.initWithRegion(
      CognitoIdentityUserPoolRegion,
      credentialsProvider: nil
    )
    @cognitoConfiguration = AWSCognitoIdentityUserPoolConfiguration.alloc.initWithClientId(
      CognitoIdentityUserPoolAppClientId,
      clientSecret: CognitoIdentityUserPoolAppClientSecret,
      poolId: CognitoIdentityUserPoolId
    )
    AWSCognitoIdentityUserPool.registerCognitoIdentityUserPoolWithConfiguration(
      @serviceConfiguration,
      userPoolConfiguration: @cognitoConfiguration,
      forKey: "UserPool"
    )
    @pool = AWSCognitoIdentityUserPool.CognitoIdentityUserPoolForKey("UserPool")
    @pool.delegate = @pool_delegate_handler
  end

  def open_authenticated_root
    open_tab_bar HomeScreen.new(nav_bar: true) #, HomeScreen.new(nav_bar: false)
  end

  def application(application, didFinishLaunchingWithOptions: launchOptions)
    @pool_delegate_handler = PoolDelegateHandler.new(lambda { show_signin })
    $app = self
    setup_cognito
    true
  end
end
