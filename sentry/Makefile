.env: env.tmpl
	cp env.tmpl .env
	sed -i "s/SENTRY_DB_PASSWORD.*/SENTRY_DB_PASSWORD=$$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)/" .env
	sed -i "s/SENTRY_SECRET_KEY.*/SENTRY_SECRET_KEY=$$(docker run --rm sentry config generate-secret-key)/" .env

sentry-migrate: .env
	docker-compose up -d memcached postgres redis
	docker-compose run sentry sentry upgrade

sentry: sentry-migrate
	docker-compose up -d
