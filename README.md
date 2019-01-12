Build status: [![CircleCI](https://circleci.com/gh/jimmyasyraf/shopify_marketplace_api.svg?style=svg)](https://circleci.com/gh/jimmyasyraf/shopify_marketplace_api)

# README
This is the Shopify Marketplace API as part of the developer intern challenge. The hosted version is [here](http://shopify-marketplace-api-staging-2037944263.us-east-1.elb.amazonaws.com)

## Environment Setup
1. Install [Docker](https://docs.docker.com/docker-for-mac/install)
2. Build container image
```
docker-compose build
```
3. Run container
```
docker-compose up
```
4. Initialize database
```
docker-compose run rails db:create
docker-compose run rails db:migrate
```
5. Go to [http://localhost:3000/docs](http://localhost:3000/docs) to test the API

## Testing
To run tests
```
rails test
```
