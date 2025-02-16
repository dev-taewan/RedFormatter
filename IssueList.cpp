

#include "IssueList.h"
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
IssueList::IssueList(QObject *parent):QAbstractListModel(parent) {}

int IssueList::rowCount(const QModelIndex &parent) const
{
    return m_items.count();
}

QVariant IssueList::data(const QModelIndex &index, int role) const
{
    if(!index.isValid() || index.row() <0 || index.row()>=m_items.count()){
        return QVariant();
    }

    const IssueItem &item=m_items[index.row()];
    switch(role){
    case IdRole:
        return item.issue_id;
    case IssueTitleRole:
        return item.issue_title;
    case AchievmentRateRole:
        return item.achievment_rate;
    case IsOverdueRole:
        return item.is_overdue;
    case DeadLineRole:
        return item.deadline;
    default:
        return QVariant();
    }
}
void IssueList::fetch_issues()
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
            .then([this](json::value jsonResponse)
                  {
                      std::cout<<"Redmine Issues: "<<std::endl;
                      auto issues=jsonResponse[U("issues")];
                      QList<IssueItem> newItems;
                      for (const auto &issue : issues.as_array()) {
                          QString id;
                          if (issue.has_field(U("id"))) {
                              id = QString::number(issue.at(U("id")).as_integer());
                          } else {
                              continue;  // ID 없는 이슈는 무시
                          }
                          QString name;
                          if (issue.has_field(U("assigned_to"))) {
                              auto author = issue.at(U("assigned_to"));
                              name = QString::fromStdString(author.at(U("name")).as_string());
                          } else {
                              continue;  // ID 없는 이슈는 무시
                          }


                          QString subject = issue.has_field(U("subject"))
                                                ? QString::fromStdString(issue.at(U("subject")).as_string())
                                                : "No Title";

                          QString deadline = issue.has_field(U("due_date"))
                                                 ? QString::fromStdString(issue.at(U("due_date")).as_string())
                                                 : "No Deadline";

                          IssueItem item;
                          item.issue_id = id;
                          item.author=name;
                          item.issue_title = subject;
                          item.deadline = deadline;

                          std::cout << "ID: " << item.issue_id.toStdString()
                                    << "name: " << item.author.toStdString()
                                    << " Deadline: " << item.deadline.toStdString()
                                    << " Subject: " << item.issue_title.toStdString()
                                    << std::endl;

                          newItems.append(item);
                      }
                      QMetaObject::invokeMethod(QCoreApplication::instance(), [this, newItems]()
                                                {
                                                    beginInsertRows(QModelIndex(), rowCount(), rowCount() + newItems.size() - 1);
                                                    m_items.append(newItems);
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
void IssueList::addItem(const QString issue_id, const QString issue_title,int achievment_rate,bool is_overdue,QString deadline)
{
    beginInsertRows(QModelIndex(),rowCount(),rowCount());
    IssueItem item;
    item.issue_id=issue_id;
    item.issue_title=issue_title;
    item.achievment_rate=achievment_rate;
    item.deadline=deadline;
    item.is_overdue=is_overdue;
    m_items<<item;
    endInsertRows();
}

QHash<int, QByteArray> IssueList::roleNames() const
{
    QHash<int,QByteArray> roles;
    roles[IdRole]="id";
    roles[Author]="author";
    roles[IssueTitleRole]="title";
    roles[AchievmentRateRole]="achievement";
    roles[IsOverdueRole]="isoverdue";
    roles[DeadLineRole]="deadline";
    return roles;
}
