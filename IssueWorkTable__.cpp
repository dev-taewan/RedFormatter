#include "IssueWorkTable__.h"
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
IssueWorkTable::IssueWorkTable(QObject *parent):QAbstractListModel(parent) {}
int IssueWorkTable::rowCount(const QModelIndex &parent) const
{
    return m_items.count();
}
QVariant IssueWorkTable::data(const QModelIndex &index, int role) const
{
    if(!index.isValid() || index.row() <0 || index.row()>=m_items.count()){
        return QVariant();
    }

    const WorkTableItem &item=m_items[index.row()];
    switch(role){
    case IdRole:
        return item.work_id;
    case WorkTitleRole:
        return item.work_title;
    case WorkTypeRole:
        return item.work_type;
    case AchievmentRateRole:
        return item.achievment_rate;
    case DeadLineRole:
        return item.deadline;
    case ResultOutputRole:
        return item.result_output;
    case EtcIssueRole:
        return item.etc_issue;
    default:
        return QVariant();
    }

}
void IssueWorkTable::GetCurrentWorkTable(QString issue_id)
{
    try
    {
        std::cout<<"call issue id: "<<issue_id.toStdString()<<std::endl;
        http_client client(U(REDMINE_URL));
        uri_builder builder(U("/issues/"+issue_id.toStdString()+".json?include=journals"));
        builder.append_query(U("key"), U(API_KEY));
        std::vector<std::vector<std::string>> result;

        client.request(methods::GET, builder.to_string()).then([](http_response response)
                                                               {
                                                                   if (response.status_code()==status_codes::OK){
                                                                       return response.extract_json();
                                                                   }else{
                                                                       throw std::runtime_error("Failed to fetch issues. HTTP Status: "+std::to_string(response.status_code()));
                                                                   } })
            .then([this](json::value jsonResponse)
                  {
                      //std::cout<<"Issue detail: "<<std::endl;
                      auto issue=jsonResponse[U("issue")];
                      QList<WorkTableItem> workTableRows;
                      //for (const auto &item : issue.as_array()) {
                          // QString id;
                          // if (issue.has_field(U("id"))) {
                          //     id = QString::number(issue.at(U("id")).as_integer());
                          // } else {
                          //     continue;  // ID 없는 이슈는 무시
                          // }
                          // QString name;
                          // if (issue.has_field(U("assigned_to"))) {
                          //     auto author = issue.at(U("assigned_to"));
                          //     name = QString::fromStdString(author.at(U("name")).as_string());
                          // } else {
                          //     continue;  // ID 없는 이슈는 무시
                          // }


                          auto journals = issue.at(U("journals"));

                          // for (const auto &journal : journals.as_array()) {
                          //     auto note=journal.at(U("notes")).as_string();
                          //                 std::cout<<note<<std::endl;
                          // }

                          for(int note_idx=journals.size()-1;0<=note_idx;note_idx--)
                          {
                              //std::cout<<note_idx<<std::endl;
                              auto journal_list=journals.as_array();
                              auto note=QString::fromStdString(journal_list[note_idx].at(U("notes")).as_string());
                              if(! (note.startsWith("⭐RF")))
                                  break;
                              QStringList lines = note.split("\r\n"); // 줄 단위로 분리
                              QStringList parsedData;
                              if (lines[6]=="|_.번호|_.업무| 종류|_.기한|_.진행률|결과물|_.특이사항|")
                              {
                                  for (int i = 7; i < lines.size(); i++) { // 첫 세 줄과 마지막 두 줄은 제외합니다.
                                      QString line = lines[i];
                                      QStringList rows = line.split("|"); // 열 단위로 분리합니다.
                                      if (rows.size() >= 7) {
                                          for (const auto &table_item:rows){
                                              if(table_item.toStdString()!= "")
                                              {
                                                  //std::cout<<"table item: " <<table_item.toStdString()<<std::endl;
                                                  parsedData.append(table_item);
                                              }
                                          }
                                      }

                                  }

                              }
                              if(parsedData.size()>0)
                              {


                                  for(int column=0;column<parsedData.size()/7;column++)
                                  {
                                      WorkTableItem worktable_row_item;
                                      worktable_row_item.work_id=parsedData[column*7+0].replace("=.","");
                                      worktable_row_item.work_title=parsedData[column*7+1];
                                      worktable_row_item.work_type=parsedData[column*7+2];
                                      worktable_row_item.deadline=parsedData[column*7+3];
                                      worktable_row_item.achievment_rate=parsedData[column*7+4].split("%")[0];
                                      worktable_row_item.result_output=parsedData[column*7+5];
                                      worktable_row_item.etc_issue=parsedData[column*7+6];
                                      workTableRows.append(worktable_row_item);
                                  }
                                  parsedData.clear();
                                  break;
                              }

                          }


                      QMetaObject::invokeMethod(QCoreApplication::instance(), [this, workTableRows]()
                                                {
                                                    beginInsertRows(QModelIndex(), rowCount(), rowCount() + workTableRows.size() - 1);
                                                    m_items.append(workTableRows);
                                                    endInsertRows();
                                                });


                  })
            .wait();
    }
    catch (const std::exception &e)
    {
        std::cerr <<" Issue List Error: " << e.what() << '\n';
    }
}
void IssueWorkTable::updateItem(int index, const QString &value,int role) {
    std::cout<<"update cpp call "<< index<< "role: "<<role<<std::endl;
    if (index < 0 || index >= m_items.size())
        return;
    switch(role){
    case IdRole:
        m_items[index].work_id=value;
        break;
    case WorkTitleRole:
        std::cout<<"role title "<<value.toStdString()<<std::endl;

        m_items[index].work_title=value;
        break;
    case WorkTypeRole:
        std::cout<<"role update "<<value.toStdString()<<std::endl;
        m_items[index].work_type=value;
        break;
    case AchievmentRateRole:
        m_items[index].achievment_rate=value;
        break;
    case DeadLineRole:
        m_items[index].deadline=value;
        break;
    case ResultOutputRole:
        m_items[index].result_output=value;
        break;
    case EtcIssueRole:
        m_items[index].etc_issue=value;
        break;
    }
    emit dataChanged(this->index(index), this->index(index), {role});
}

// 🔥 QAbstractListModel 표준 방식으로 데이터 수정 가능하게 setData 오버라이드
bool IssueWorkTable::setData(const QModelIndex &index, const QVariant &value, int role) {
    if (!index.isValid() || index.row() >= m_items.size())
        return false;

    WorkTableItem &item = m_items[index.row()];

    if (role == WorkTypeRole) {
        item.work_type = value.toString();
        emit dataChanged(index, index, {role});
        return true;
    }

    return false;
}

QList<WorkTableItem> IssueWorkTable::getWorkTableList()
{
    return m_items;
}
void IssueWorkTable::addItem(const QString work_id,const QString work_title,const QString work_type,const QString deadline ,const QString achievment_rate,const QString result_output,const QString etc_issue)
{
    beginInsertRows(QModelIndex(),rowCount(),rowCount());
    WorkTableItem item;
    item.work_id=work_id;
    item.work_title=work_title;
    item.work_type=work_type;
    item.deadline=deadline;
    item.achievment_rate=achievment_rate;
    item.result_output=result_output;
    item.etc_issue=etc_issue;
    m_items<<item;
    endInsertRows();
}
QHash<int, QByteArray> IssueWorkTable::roleNames() const
{
    QHash<int,QByteArray> roles;
    roles[IdRole]="id";
    roles[WorkTitleRole]="title";
    roles[WorkTypeRole]="type";
    roles[AchievmentRateRole]="achievement";
    roles[DeadLineRole]="deadline";
    roles[ResultOutputRole]="result";
    roles[EtcIssueRole]="etc";
    return roles;
}
// #include <cpprest/http_client.h>
// #include <cpprest/filestream.h>
// #include <cpprest/json.h>
// #include <iostream>
// #include <memory>

// using namespace web;
// using namespace web::http;
// using namespace web::http::client;

// int main() {
//     // Redmine 서버 URL (사용자의 실제 서버 URL로 변경)
//     utility::string_t redmine_url = U("http://your-redmine-server");

//     // Redmine API 키 (사용자의 실제 API 키로 변경)
//     utility::string_t api_key = U("your-api-key");

//     // 기존 이슈 ID (실제 이슈 ID로 변경)
//     int issue_id = 123;

//     // 업로드할 이미지 파일 경로 (실제 파일 경로로 변경)
//     utility::string_t file_path = U("path/to/image.png");

//     // 파일 열기
//     auto file_stream = std::make_shared<concurrency::streams::istream>();
//     pplx::task<void> open_task = concurrency::streams::fstream::open_istream(file_path)
//                                      .then([=](concurrency::streams::istream stream) {
//                                          *file_stream = stream;
//                                      });
//     open_task.wait();

//     if (!file_stream->is_open()) {
//         std::cout << "파일을 열지 못했습니다." << std::endl;
//         return 1;
//     }

//     // HTTP 클라이언트 생성
//     http_client client(redmine_url);

//     // 1. 파일 업로드 요청
//     http_request upload_request(methods::POST);
//     upload_request.set_request_uri(U("/uploads.json?filename=image.png"));
//     upload_request.headers().add(U("X-Redmine-API-Key"), api_key);
//     upload_request.headers().set_content_type(U("application/octet-stream"));
//     upload_request.set_body(*file_stream);

//     http_response upload_response = client.request(upload_request).get();

//     if (upload_response.status_code() == status_codes::Created) {
//         json::value upload_json = upload_response.extract_json().get();
//         if (upload_json.has_field(U("upload")) && upload_json[U("upload")].has_field(U("token"))) {
//             utility::string_t token = upload_json[U("upload")][U("token")].as_string();

//             // 2. 이슈 업데이트 요청
//             http_request update_request(methods::PUT);
//             update_request.set_request_uri(U("/issues/") + utility::conversions::to_string_t(std::to_string(issue_id)) + U(".json"));
//             update_request.headers().add(U("X-Redmine-API-Key"), api_key);
//             update_request.headers().set_content_type(U("application/json"));

//             // JSON 본문 생성
//             json::value update_body;
//             json::value issue;
//             json::value uploads = json::value::array();
//             json::value upload;
//             upload[U("token")] = json::value::string(token);
//             upload[U("filename")] = json::value::string(U("image.png"));
//             upload[U("content_type")] = json::value::string(U("image/png"));
//             uploads[0] = upload;
//             issue[U("uploads")] = uploads;
//             update_body[U("issue")] = issue;

//             update_request.set_body(update_body);

//             http_response update_response = client.request(update_request).get();

//             if (update_response.status_code() == status_codes::OK) {
//                 std::cout << "이미지가 이슈에 성공적으로 첨부되었습니다. Journals에서 확인 가능합니다." << std::endl;
//             } else {
//                 std::cout << "이슈 업데이트 실패. 상태 코드: " << update_response.status_code() << std::endl;
//             }
//         } else {
//             std::cout << "업로드 토큰을 찾을 수 없습니다." << std::endl;
//         }
//     } else {
//         std::cout << "파일 업로드 실패. 상태 코드: " << upload_response.status_code() << std::endl;
//     }

//     return 0;
// }
