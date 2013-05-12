class UrlMappings {

	static mappings = {
        "/$controller/$action?/$id?"{
            constraints {
                // apply constraints here
            }
        }

        "/oauth/success"(controller: "shiroOAuth", action: "onSuccess")
        "/oauth/callback/$provider"(controller: "oauth", action: "callback")
        "/"(view: "ticbox")
        "500"(view:'/error')
	}
}
