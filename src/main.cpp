#include "redfomatter.h"
#include <vector>
#include <string>

#include <cpprest/http_client.h>
#include <cpprest/filestream.h>
#include <iostream>

using namespace web;
using namespace web::http;
using namespace web::http::client;
using namespace concurrency::streams;

// Redmine API 기본 설정
const std::string REDMINE_URL = ""; // Redmine 서버 주소
const std::string API_KEY = "";               // Redmine API 키

// Issue 목록 조회 함수
void fetch_issues() {
    try {
        // HTTP 클라이언트 생성
        http_client client(U(REDMINE_URL));

        // API 경로 설정
        uri_builder builder(U("/issues.json"));
        builder.append_query(U("key"), U(API_KEY)); // API 키 추가

        // GET 요청 보내기
        client.request(methods::GET, builder.to_string()).then([](http_response response) {
            if (response.status_code() == status_codes::OK) {
                return response.extract_json();
            } else {
                throw std::runtime_error("Failed to fetch issues. HTTP Status: " + std::to_string(response.status_code()));
            }
        }).then([](json::value jsonResponse) {
            std::cout << "Redmine Issues:" << std::endl;
            auto issues = jsonResponse[U("issues")];
            for (const auto& issue : issues.as_array()) {
                auto id = issue.at(U("id")).as_integer();
                auto subject = issue.at(U("subject")).as_string();
                std::cout << "ID: " << id << ", Subject: " << subject << std::endl;
            }
        }).wait();

    } catch (const std::exception& e) {
        std::cerr << "Error: " << e.what() << std::endl;
    }
}

// 메인 함수
int main() {
    std::cout << "Fetching Redmine Issues..." << std::endl;
    fetch_issues();
    return 0;
}
