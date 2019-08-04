class PoolDelegateHandler
  def initialize screen_callback
    puts "init"
    @screen_callback = screen_callback
    startPasswordAuthentication
  end

  def show_login_controller
    puts "Login screen"
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @login_controller = LoginController.alloc.init
    @navigation_controller = UINavigationController.alloc.init
    @navigation_controller.pushViewController(@login_controller, animated:false)
    @window.rootViewController = @navigation_controller
    @window.makeKeyAndVisible
  end

  # should get called magically
  def startPasswordAuthentication
    Dispatch::Queue.main.async do
      @screen_callback.call
      show_login_controller
    end
  end
end

class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
     dictionary = NSDictionary.alloc.initWithDictionary({
       'serviceClass' => AWSServiceConfiguration,
       'awsCognitoIdentityClass' =>  AWSCognitoIdentityUserPool
     })
     @cyalert = CYAlert.new
     @cyalert.show(dictionary)
    #setup_cognito
    true
  end

  def startPasswordAuthentication
    Dispatch::Queue.main.async do
      #@screen_callback.call
      show_login_controller
    end
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
end
