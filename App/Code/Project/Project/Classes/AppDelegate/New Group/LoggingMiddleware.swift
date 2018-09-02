import Foundation

import Domain

import ReSwift

let loggingMiddleware: Middleware<AppState> = { dispatch, getState in
    return { next in
        return { action in

            // Perform middleware logic
            Log.debug(
                "\n------------------------------------\n" +
                    "| \(action) \n" +
                "--------------------------------------\n")

            // Call next middleware
            return next(action)
        }
    }
}
