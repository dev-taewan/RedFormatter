

#include "IssueList.h"
// #include <vector>
// #include <string>
// #include <QCoreApplication>
// #include <cpprest/http_client.h>
// #include <cpprest/filestream.h>
// #include <iostream>

// using namespace web;
// using namespace web::http;
// using namespace web::http::client;
// using namespace concurrency::streams;

// const std::string REDMINE_URL="";
// const std::string API_KEY="";
// IssueList::IssueList(QObject *parent):QAbstractListModel(parent) {}

// int IssueList::rowCount(const QModelIndex &parent) const
// {
//     return m_items.count();
// }

// QVariant IssueList::data(const QModelIndex &index, int role) const
// {
//     if(!index.isValid() || index.row() <0 || index.row()>=m_items.count()){
//         return QVariant();
//     }
//     const IssueItem &item=m_items[index.row()];
//     switch(role){
//     case NameRole:
//         return item.name;
//     case DescriptionRole:
//         return item.description;
//     default:
//         return QVariant();
//     }
// }
// void IssueList::fetch_issues()
// {
//     try
//     {
//         http_client client(U(REDMINE_URL));
//         uri_builder builder(U("/issues.json?assigned_to_id=me"));
//         builder.append_query(U("key"), U(API_KEY));
//         std::vector<std::vector<std::string>> result;

//         client.request(methods::GET, builder.to_string()).then([](http_response response)
//                                                                {
//                                                                    if (response.status_code()==status_codes::OK){
//                                                                        return response.extract_json();
//                                                                    }else{
//                                                                        throw std::runtime_error("Failed to fetch issues. HTTP Status: "+std::to_string(response.status_code()));
//                                                                    } })
//             .then([this](json::value jsonResponse)
//                   {
//                       std::cout<<"Redmine Issues: "<<std::endl;
//                       auto issues=jsonResponse[U("issues")];
//                       QList<IssueItem> newItems;
//                       for (const auto& issue: issues.as_array()){
//                           auto id=issue.at(U("id")).as_integer();
//                           auto subject=issue.at(U("subject")).as_string();
//                           auto author=issue.at(U("assigned_to"));
//                           auto name=author.at(U("name")).as_string();
//                           std::cout<<"ID "<<id<<" name:"<<name<<" Subject: "<<subject <<std::endl;
//                           //result.push_back({std::to_string(id),subject});

//                           IssueItem item;
//                           item.name = QString::fromStdString(name);
//                           item.description = QString::fromStdString(subject);
//                           newItems.append(item);

//                       }
//                       QMetaObject::invokeMethod(QCoreApplication::instance(), [this, newItems]()
//                                                 {
//                                                     beginInsertRows(QModelIndex(), rowCount(), rowCount() + newItems.size() - 1);
//                                                     m_items.append(newItems);
//                                                     endInsertRows();
//                                                 });


//                                                                                               })
//             .wait();
//     }
//     catch (const std::exception &e)
//     {
//         std::cerr << "Error: " << e.what() << '\n';
//     }
// }
// void IssueList::addItem(const QString &name, const QString &description)
// {
//     beginInsertRows(QModelIndex(),rowCount(),rowCount());
//     IssueItem item;
//     item.name=name;
//     item.description=description;
//     m_items<<item;
//     endInsertRows();
// }

// QHash<int, QByteArray> IssueList::roleNames() const
// {
//     QHash<int,QByteArray> roles;
//     roles[NameRole]="name";
//     roles[DescriptionRole]="description";
//     return roles;
// }
