#include "redfomatter.h"
#include "main_ui.h"
#include <vector>
#include <string>

#include <cpprest/http_client.h>
#include <cpprest/filestream.h>
#include <iostream>

using namespace web;
using namespace web::http;
using namespace web::http::client;
using namespace concurrency::streams;

const std::string REDMINE_URL = "";
const std::string API_KEY = "";

std::vector<std::vector<std::string>> fetch_issues()
{
    try
    {
        http_client client(U(REDMINE_URL));
        uri_builder builder(U("/issues.json?assigned_to_id=me"));
        builder.append_query(U("key"), U(API_KEY));
        std::vector<std::vector<std::string>> result;
        client.request(methods::GET, builder.to_string()).then([](http_response response)
                                                               {
            if (response.status_code()==status_codes::OK){
                return response.extract_json();
            }else{
                throw std::runtime_error("Failed to fetch issues. HTTP Status: "+std::to_string(response.status_code()));
            } })
            .then([&result](json::value jsonResponse)
                  {
            std::cout<<"Redmine Issues: "<<std::endl;
            auto issues=jsonResponse[U("issues")];
            for (const auto& issue: issues.as_array()){
                auto id=issue.at(U("id")).as_integer();
                auto subject=issue.at(U("subject")).as_string();
                auto author=issue.at(U("assigned_to"));
                auto name=author.at(U("name"));
                std::cout<<"ID "<<id<<" name:"<<name<<" Subject: "<<subject <<std::endl;
                result.push_back({std::to_string(id),subject});
            } })
            .wait();

        return result;
    }
    catch (const std::exception &e)
    {
        std::cerr << "Error: " << e.what() << '\n';
    }
}

int main()
{
    std::cout << "Fetching Redmine Issues..." << std::endl;
    std::vector<std::vector<std::string>> table_data = fetch_issues();
    std::cout << "size: " << table_data.size() << std::endl;
    auto app = HelloWorld::create();

    auto model = std::make_shared<slint::VectorModel<std::shared_ptr<slint::Model<slint::StandardListViewItem>>>>();
    for (const auto &row : table_data)
    {
        auto shared_row = std::make_shared<slint::VectorModel<slint::StandardListViewItem>>();
        for (const auto &cell : row)
        {
            std::cout << cell << std::endl;
            auto item = slint::StandardListViewItem();
            item.text = cell;
            shared_row->push_back(item);
        }
        model->push_back(shared_row);
    }

    app->set_row_data(model);
    app->show();
    app->run();
    return 0;
}