Swagger::Docs::Config.base_api_controller = ActionController::API

Swagger::Docs::Config.register_apis({
  "1.0" => {
    # the output location where your .json files are written to
    :api_file_path => "public/",
    # the URL base path to your API
    :base_path => "http://localhost:3000",
    # if you want to delete all .json files at each generation
    :clean_directory => true,
    # Ability to setup base controller for each api version. Api::V1::SomeController for example.
    :base_api_controller=> ActionController::API,
    # add custom attributes to api-docs
    :attributes => {
      :info => {
        "title" => "Shopify Marketplace API",
        "description" => "Documention for the Shopify Marketplace API. This is a part of Hazimi Asyraf's submission for Shopify's Summer 2019 Developer Intern Challenge",
        "contact" => "m.hazimiasyraf@gmail.com",
        "license" => "Apache 2.0",
        "licenseUrl" => "http://www.apache.org/licenses/LICENSE-2.0.html"
      }
    }
  }
})