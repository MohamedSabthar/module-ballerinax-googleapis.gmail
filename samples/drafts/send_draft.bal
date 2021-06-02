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

gmail:GmailConfiguration gmailConfig = {
    oauthClientConfig: {
        refreshUrl: gmail:REFRESH_URL,
        refreshToken: os:getEnv("REFRESH_TOKEN"),
        clientId: os:getEnv("CLIENT_ID"),
        clientSecret: os:getEnv("CLIENT_SECRET")
    }
};

gmail:Client gmailClient = new(gmailConfig);

public function main(string... args) {
    
    log:printInfo("Send draft");
    // The user's email address. The special value **me** can be used to indicate the authenticated user.
    string userId = "me";
    
    // The ID of the existing draft we want to send.
    string createdDraftId = "<DRAFT_ID>"; 

    gmail:MessageResponse |error sendDraftResponse = gmailClient->sendDraft(userId, createdDraftId);
    
    if (sendDraftResponse is gmail:MessageResponse) {
        log:printInfo("Sent the draft successfully: ",
                      status =  sendDraftResponse.id !== "" && sendDraftResponse.threadId !== "");
    } else {
        log:printError("Failed to send the draft");
    }

    log:printInfo("End!");
}
