test:
	docker-compose -f docker-compose-testing.yml build
	docker-compose -f docker-compose-testing.yml up  --abort-on-container-exit
