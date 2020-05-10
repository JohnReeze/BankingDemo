//
//

import PluggableApplicationDelegate

final class LaunchingApplicationService: NSObject, ApplicationService {

    // MARK: - ApplicationService

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = DetailProductModuleConfigurator().configure()
        let navVC = UINavigationController(rootViewController: vc)
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()

        return true
    }

}
