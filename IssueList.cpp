

#include "IssueList.h"

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
    case NameRole:
        return item.name;
    case DescriptionRole:
        return item.description;
    default:
        return QVariant();
    }
}

void IssueList::addItem(const QString &name, const QString &description)
{
    beginInsertRows(QModelIndex(),rowCount(),rowCount());
    IssueItem item;
    item.name=name;
    item.description=description;
    m_items<<item;
    endInsertRows();
}

QHash<int, QByteArray> IssueList::roleNames() const
{
    QHash<int,QByteArray> roles;
    roles[NameRole]="name";
    roles[DescriptionRole]="description";
    return roles;
}
