#include "IssueManager.h"
#include <vector>
#include <string>
#include <QCoreApplication>
#include <cpprest/http_client.h>
#include <cpprest/filestream.h>
#include <iostream>

using namespace web;
using namespace web::http;
using namespace web::http::client;
using namespace concurrency::streams;

const std::string REDMINE_URL="";
const std::string API_KEY="";
IssueManager::IssueManager(QObject *parent):QObject(parent) {}
Q_INVOKABLE void GetTodayWorkPlan(const TreeItem &today_work_table);
Q_INVOKABLE void GetNextWorkPlan(const TreeItem &next_work_table);

void IssueManager::GetWorkTable(const QList<WorkTableItem> &issue_work_table)
{
    std::cout<<"GetWorkTable"<<std::endl;
    for(auto &item:issue_work_table)
    {
        std::cout<<item.work_title.toStdString()<<std::endl;





       // "⭐RF\r\n\r\nh2. 날짜: YYYY-MM-DD\r\n\r\nh3. ⏳\b업무 리스트\r\n\r\n|_.번호|_.업무| 종류|_.기한|_.진행률|결과물|_.특이사항|\r\n|=.1|레드마인 서포터 설계|⚒️ 설계|01.23 (3)|20% ✅✅☑️☑️☑️☑️☑️☑️☑️☑️| |_.특이사항|\r\n|=.2|레드마인 서포터 기술 조사|❓ 조사|01.27 (3)|20% ✅✅☑️☑️☑️☑️☑️☑️☑️☑️| |_.특이사항|\r\n\r\nh2. ⏰ 오늘 진행 내용:\r\n\r\nh3. ⚒️ 레드마인 서포터 설계 \r\n\r\n# class uml 작성\r\n## staruml 통해서 작성\r\n## 작성한 uml 경로 []\r\n# 동료 검토\r\n## 피드백: ~~~\r\n# *%{color:red}❗이슈:%* (%{color:orange}  진행 중%)\r\n## *%{color:blue} 설계 단계에서 고려하지 못한 요구 사항 발생%*\r\n### 추가 요구사항 분석 결과 현재 구조 일부 변경 필요 \r\n### 해당 기능 연결 가능하도록 uml 설계 변경 진행중\r\n\r\nh3. ⚒️ 레드마인 서포터 기술 조사 \r\n\r\n# Redmine API 조사\r\n## RestAPI 사용 가능\r\n# 구현할 플랫폼\r\n## c++,qml,conan 사용해서 진행 \r\n\r\nh2. ⓘ 추가 사항:\r\n\r\n# 설계 추가 사항으로 본 일감이 1일 연기 됩니다.\r\n\r\nh2. ⏳ 이어서 진행할 업무 리스트:\r\n\r\n# ⚒️ 레드마인 서포터 설계\r\n## 변경된 설계내용 동료 검토\r\n# ⚒️ 구현\r\n",
    }
    issue_work_list.append("⭐RF\r\n\r\n");
    issue_work_list.append("h2. 날짜: YYYY-MM-DD\r\n\r\n");
    issue_work_list.append("h3. ⏳\b업무 리스트\r\n\r\n");
    issue_work_list.append("|_.번호|_.업무| 종류|_.기한|_.진행률|결과물|_.특이사항|\r\n");

    for(auto &item:issue_work_table)
    {
        QString rate_box="";
        for(int i=0;i<10;i++)
        {
            if(i<item.achievment_rate.toInt()/10)
            rate_box+="✅";
            else
             rate_box+="☑️";
        }

        QString achievment_rate=item.achievment_rate+"% "+ rate_box;
        std::cout<<("|=."+item.work_id+"|"+item.work_title+"|"+item.work_type+"|"+item.deadline+"|"+achievment_rate+"|"+item.result_output+"|"+item.etc_issue+"|\r\n").toStdString()<<std::endl;
        issue_work_list.append("|=."+item.work_id+"|"+item.work_title+"|"+item.work_type+"|"+item.deadline+"|"+achievment_rate+"|"+item.result_output+"|"+item.etc_issue+"|\r\n");
    }

}

void IssueManager::GetTodayWorkPlan( TreeItem *item,int depth=0)
{
    std::cout<<"GetTodayWorkPlan"<<std::endl;
    // int child_count=today_work_table->childCount();
    // TreeItem * item=today_work_table;
    // QString tab="#";
    // while(child_count==0)
    // {
    //     for(int idx=0;idx<child_count;idx++)
    //     {

    //         today_work_list.append(tab+" "+item->child(idx)->data().toString());

    //     }
    // }
    // for(int idx=0;idx<today_work_table->childCount();idx++)
    // {

    //     today_work_table->child(idx);

    // }
    /*int rowCount = today_work_table->rowCount(parent);

    for (int row = 0; row < rowCount; ++row) {
        QModelIndex index = today_work_table->index(row, 0, parent);
        if (!index.isValid()) continue;

        QString indentation = QString(" ").repeated(depth * 2);  // 들여쓰기
        qDebug() << indentation + today_work_table->data(index).toString(); // 아이템 출력

        // 자식 아이템이 있으면 재귀적으로 탐색
        if (today_work_table->hasChildren(index)) {
            printTreeItems(today_work_table, index, depth + 1);
        }
    }*/

    if (!item) return;
    //int depth=depth;
    QString indentation = QString(" ").repeated(depth * 2); // 들여쓰기
    qDebug() << "node: "<<indentation + item->data().toString(); // 현재 노드 출력
    qDebug() << "node title: "<<item->data().toList()[1].toString(); // 현재 노드 출력

    //qvariance to QList=


    for (int i = 0; i < item->childCount(); ++i) {

        GetTodayWorkPlan(item->child(i), depth + 1); // 자식 노드 순회
    }
}
void IssueManager::GetNextWorkPlan( TreeItem *next_work_table)
{

    std::cout<<"GetNextWorkPlan"<<std::endl;

}
void IssueManager::AddFile(const QString &file_path)
{std::cout<<"AddFile"<<std::endl;}

bool IssueManager::WriteWorkPlan()
{

        // Redmine 서버 URL (사용자의 실제 서버 URL로 변경)
        utility::string_t redmine_url = U("http://your-redmine-server");

        // Redmine API 키 (사용자의 실제 API 키로 변경)
        utility::string_t api_key = U("your-api-key");

        // 기존 이슈 ID (실제 이슈 ID로 변경)
        int issue_id = 123;

        // 업로드할 이미지 파일 경로 (실제 파일 경로로 변경)
        utility::string_t file_path = U("path/to/image.png");

        // 파일 열기
        auto file_stream = std::make_shared<concurrency::streams::istream>();
        pplx::task<void> open_task = concurrency::streams::fstream::open_istream(file_path)
                                         .then([=](concurrency::streams::istream stream) {
                                             *file_stream = stream;
                                         });
        open_task.wait();

        if (!file_stream->is_open()) {
            std::cout << "파일을 열지 못했습니다." << std::endl;
            return 1;
        }

        // HTTP 클라이언트 생성
        http_client client(redmine_url);

        // 1. 파일 업로드 요청
        http_request upload_request(methods::POST);
        upload_request.set_request_uri(U("/uploads.json?filename=image.png"));
        upload_request.headers().add(U("X-Redmine-API-Key"), api_key);
        upload_request.headers().set_content_type(U("application/octet-stream"));
        upload_request.set_body(*file_stream);

        http_response upload_response = client.request(upload_request).get();

        if (upload_response.status_code() == status_codes::Created) {
            json::value upload_json = upload_response.extract_json().get();
            if (upload_json.has_field(U("upload")) && upload_json[U("upload")].has_field(U("token"))) {
                utility::string_t token = upload_json[U("upload")][U("token")].as_string();

                // 2. 이슈 업데이트 요청
                http_request update_request(methods::PUT);
                update_request.set_request_uri(U("/issues/") + utility::conversions::to_string_t(std::to_string(issue_id)) + U(".json"));
                update_request.headers().add(U("X-Redmine-API-Key"), api_key);
                update_request.headers().set_content_type(U("application/json"));

                // JSON 본문 생성
                json::value update_body;
                json::value issue;
                json::value uploads = json::value::array();
                json::value upload;
                upload[U("token")] = json::value::string(token);
                upload[U("filename")] = json::value::string(U("image.png"));
                upload[U("content_type")] = json::value::string(U("image/png"));
                uploads[0] = upload;
                issue[U("uploads")] = uploads;
                update_body[U("issue")] = issue;

                update_request.set_body(update_body);

                http_response update_response = client.request(update_request).get();

                if (update_response.status_code() == status_codes::OK) {
                    std::cout << "이미지가 이슈에 성공적으로 첨부되었습니다. Journals에서 확인 가능합니다." << std::endl;
                } else {
                    std::cout << "이슈 업데이트 실패. 상태 코드: " << update_response.status_code() << std::endl;
                }
            } else {
                std::cout << "업로드 토큰을 찾을 수 없습니다." << std::endl;
            }
        } else {
            std::cout << "파일 업로드 실패. 상태 코드: " << upload_response.status_code() << std::endl;
        }

        return 0;

}
