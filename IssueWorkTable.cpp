#include "IssueWorkTable.h"
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
                                      worktable_row_item.work_id=parsedData[column*7+0];
                                      worktable_row_item.work_title=parsedData[column*7+1];
                                      worktable_row_item.work_type=parsedData[column*7+2];
                                      worktable_row_item.deadline=parsedData[column*7+3];
                                      worktable_row_item.achievment_rate=parsedData[column*7+4];
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

    // ItemRoles{
    //     IdRole=Qt::UserRole+1,
    //         WorkTitleRole,
    //         WorkTypeRole,
    //         DeadLineRole,
    //         AchievmentRateRole,
    //         ResultOutputRole,
    //         EtcIssueRole,
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
