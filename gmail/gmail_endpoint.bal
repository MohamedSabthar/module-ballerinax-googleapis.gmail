// Copyright (c) 2018, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/http;
import wso2/oauth2;

documentation{
    Represents GMail endpoint

    F{{oauthEP}} - OAuth2 endpoint
    F{{gMailConfig}} - GMail endpoint configuration
    F{{gMailConnector}} - GMail connector
}
public type Client object {
    public {
        oauth2:APIClient oauthEP;
        GMailConfiguration gMailConfig;
        GMailConnector gMailConnector;
    }

    documentation{
        Gets called when the gMail endpoint is beign initialized.

        P{{gMailConfig}} - GMail connector configuration
    }
    public function init(GMailConfiguration gMailConfig) {
        gMailConfig.oAuth2ClientConfig.useUriParams = true;
        self.oauthEP.init(gMailConfig.oAuth2ClientConfig);
        self.gMailConnector.oauthEndpoint = self.oauthEP;
    }

    documentation{
        Register gMail connector endpoint.

        P{{serviceType}} = The type of the service to be registered.
    }
    public function register(typedesc serviceType) {

    }

    documentation{
        Starts the gMail connector endpoint.
    }
    public function start() {

    }

    documentation{
        Returns the connector that client code uses.
    }
    public function getClient() returns GMailConnector {
        return self.gMailConnector;
    }

    documentation {
        Stops the registered service.
    }
    public function stop() {

    }
};

documentation{
    Represents the GMail client endpoint configuration.

    F{{oAuth2ClientConfig}} - The OAuth2 Client endpoint configuration.
}
public type GMailConfiguration {
    oauth2:OAuth2ClientEndpointConfiguration oAuth2ClientConfig;
};
