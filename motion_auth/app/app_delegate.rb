class PoolDelegateHandler
  def initialize screen_callback
    @screen_callback = screen_callback
  end

  def show_login_controller
    @loginController = LoginController.alloc.init
    self.navigationController.pushViewController(@loginController, animated:true)
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
    setup_cognito
    rootViewController = UIViewController.alloc.init
    rootViewController.title = 'motion_auth'
    rootViewController.view.backgroundColor = UIColor.whiteColor
    navigationController = UINavigationController.alloc.initWithRootViewController(rootViewController)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = navigationController
    @window.makeKeyAndVisible
    @pool_delegate_handler = PoolDelegateHandler.new(lambda { show_login_controller })
    $app = self
    true
  end

  def startPasswordAuthentication
    Dispatch::Queue.main.async do
      #@screen_callback.call
      show_login_controller
    end
  end

  def show_login_controller
    @loginController = LoginController.alloc.init
    self.navigationController.pushViewController(@loginController, animated:true)
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
