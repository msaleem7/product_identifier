# README

# Tech Stack
  - Ruby 2.6.7
  - Rails 6.0.3.7
  - Database Postresql

# Database Tables
  - products
    Database table to store products data and has following attributes in table

    - string   sku
    - array    image_urls
    - string   name
    - string   price
    - array    selected_options

    We will use above columns to store products data. We have index on sku so that we can fastest searching.

# Controllers
  - products_controller
    Here is the controller to interact with user requests about create and list of products

# Services
  - FetchSiteData
    FetchSiteData service class is here to crawl and store the data into products table. We will crawl name, price and image urls from site and save it to products table. We are running this job per SKU.
    This service will first scrape the data from website and then will create/update the products table for given SKU.

# LIVE Demo
  https://product-identifier-1.herokuapp.com
