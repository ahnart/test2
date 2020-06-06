package com.example.auth;


import java.util.Iterator;

import org.apache.commons.lang.StringUtils;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.scribejava.core.builder.ServiceBuilder;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.github.scribejava.core.model.OAuthRequest;
import com.github.scribejava.core.model.Response;
import com.github.scribejava.core.model.Verb;
import com.github.scribejava.core.oauth.OAuth20Service;
import com.example.dto.userDTO;;

public class SNSLogin {
//	
//	private OAuth20Service oauthService;
//	private SnsValue sns;
//	
//	public SNSLogin(SnsValue sns) {
//		this.oauthService = new ServiceBuilder(sns.getClientId())
//				.apiSecret(sns.getClientSecret())
//				.callback(sns.getRedirectUrl())
//				.scope("profile")
//				.build(sns.getApi20Instance());
//		
//		this.sns = sns;
//	}
//
//	public String getNaverAuthURL() {
//		return this.oauthService.getAuthorizationUrl();
//	}
}



