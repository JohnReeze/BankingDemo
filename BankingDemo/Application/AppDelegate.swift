//
//  Copyright © 2020 Surf. All rights reserved.
//

import PluggableApplicationDelegate
import UIKit

@UIApplicationMain
class AppDelegate: PluggableApplicationDelegate {

    // MARK: - Properties

    override var services: [ApplicationService] {
        return [
            LaunchingApplicationService()
        ]
    }

}
