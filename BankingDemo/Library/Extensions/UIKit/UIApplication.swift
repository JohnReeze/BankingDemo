//
//  Copyright © 2020 Surf. All rights reserved.
//

import UIKit

extension UIApplication {

    static func appVersion() -> String? {
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        return appVersion
    }

}
