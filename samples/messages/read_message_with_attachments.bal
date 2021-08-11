// Copyright (c) 2021, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
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

import ballerina/log;
import ballerina/os;
import ballerinax/googleapis.gmail as gmail;

public function main() returns error? {

gmail:GmailConfiguration gmailConfig = {
    oauthClientConfig: {
        refreshUrl: gmail:REFRESH_URL,
        refreshToken: os:getEnv("REFRESH_TOKEN"),
        clientId: os:getEnv("CLIENT_ID"),
        clientSecret: os:getEnv("CLIENT_SECRET")
    }
};

gmail:Client gmailClient = check new(gmailConfig);

    log:printInfo("Read a message with an attachment");

    // ID of the message to read with an attachment.
    string sentMessageId = "<MESSAGE_ID>"; 

    gmail:Message|error response = gmailClient->readMessage(sentMessageId);
    
    if (response is gmail:Message) {
       if (response?.msgAttachments is gmail:MessageBodyPart[] ) {
            log:printInfo("Attachment retrieved " + (<gmail:MessageBodyPart[]>response?.msgAttachments).toString());
       } else {
            log:printError("No attachment exists for this message");
       }
    } else {
        log:printError("Failed to get attachments");
    }
    log:printInfo("End!");
}
