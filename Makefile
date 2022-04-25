start:
	@PORT=9988 docker-compose up -d --build

clean:
	@PORT=9988 docker-compose down -v
