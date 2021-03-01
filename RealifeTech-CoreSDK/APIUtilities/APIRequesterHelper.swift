//
//  APIRequesterHelper.swift
//  APIUtilities
//
//  Created by Olivier Butler on 05/10/2020.
//  Copyright © 2020 Realife Tech. All rights reserved.
//

import Foundation

public struct APIRequesterHelper {

    static var tokenManager: APITokenManagable = EmptyTokenManager()
    static var deviceId: String = ""
    static var baseUrl: String = ""

    /// Configures the API Requesters by creating a header variables manager.
    /// The manager is returned so other API modules can use the headers.
    /// - Parameter deviceID: An id unique to the specific physical device. Usually a 40 charachter UUID string.
    /// - Parameter clientID: The id used by the client e.g. "LS_0"
    /// - Parameter clientSecret: Code used to initially authenticate with our backend.
    /// - Parameter baseUrl: The API root which should be used for all queries, e.g. "http://api.website.com/production"
    public static func setupAPI(
        deviceId: String,
        clientId: String,
        clientSecret: String,
        baseUrl: String
    ) -> APITokenManagable {
        OAuthRequester.setDefaultOAuthParameters(clientId: clientId, clientSecret: clientSecret)
        self.baseUrl = baseUrl
        self.deviceId = deviceId
        let apiTokenManager = constructTokenManager()
        self.tokenManager = apiTokenManager
        return apiTokenManager
    }

    private static func constructTokenManager() -> APITokenManagable {
        let authorisationStore = AuthorisationStore()
        let authorisationWorker = AuthorisationWorker(authorisationStore: authorisationStore)
        let oAuthTokenRefreshWatcher = OAuthTokenRefreshWatcher()
        let oAuthRefreshOrWaitActionGenerator = OAuthRefreshOrWaitActionGenerator(
            authorisationWorker: authorisationWorker,
            oAuthTokenRefreshWatcher: oAuthTokenRefreshWatcher,
            authorisationStore: authorisationStore)
        return APITokenManager(
            authorisationStore: authorisationStore,
            oAuthRefreshOrWaitActionGenerator: oAuthRefreshOrWaitActionGenerator)
    }
}
