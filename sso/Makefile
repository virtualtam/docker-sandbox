# Gitea setup
GITEA := docker compose exec gitea gitea
GITEA_CONFIG := /etc/gitea/app.ini

gitea-create-admin:
	$(GITEA) admin user create \
		--admin \
		--username gitadmin \
		--password gitadmin123 \
		--email gitadmin@gitea.docker
.PHONY: gitea-create-admin

gitea-list-users:
	$(GITEA) admin user list
.PHONY: gitea-list-users

gitea-config:
	docker compose exec gitea sed -i 's/^ENABLE_OPENID_SIGNIN.*/ENABLE_OPENID_SIGNIN = false/' $(GITEA_CONFIG)
	docker compose exec gitea sed -i 's/^ENABLE_OPENID_SIGNUP.*/ENABLE_OPENID_SIGNUP = false/' $(GITEA_CONFIG)
	docker compose exec gitea sed -i 's/^DISABLE_REGISTRATION.*/DISABLE_REGISTRATION = true/' $(GITEA_CONFIG)
	docker compose exec gitea sed -i 's/^ALLOW_ONLY_EXTERNAL_REGISTRATION.*/ALLOW_ONLY_EXTERNAL_REGISTRATION = true/' $(GITEA_CONFIG)
	docker compose restart gitea
.PHONY: gitea-config
