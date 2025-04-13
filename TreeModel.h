#pragma once


#include <QAbstractlistModel>
#include <QQmlEngine>
#include <QtQuick>
#include "TreeItem.h"
#include <iostream>
class TreeModel : public QAbstractItemModel {
    Q_OBJECT
    QML_ELEMENT
public:
    enum ItemRoles{
        IdRole=Qt::UserRole+1,
        TextRole
    };
    explicit TreeModel(QObject *parent = nullptr);
    ~TreeModel();

    QVariant data(const QModelIndex &index, int role) const override;
    QModelIndex index(int row, int column, const QModelIndex &parent = QModelIndex()) const override;
    QModelIndex parent(const QModelIndex &index) const override;
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    int columnCount(const QModelIndex &parent = QModelIndex()) const override;
    Qt::ItemFlags flags(const QModelIndex &index) const override;

    //Q_INVOKABLE void insertNode(int row, const QString &name);
    //Q_INVOKABLE void insertChild(const QModelIndex &parentIndex, const QString &name);
    Q_INVOKABLE void insertNode(int row, const QList<QString> &values);
    Q_INVOKABLE void insertChild(const QModelIndex &parentIndex, const QList<QString> &values);
    Q_INVOKABLE void removeNode(const QModelIndex &parentIndex);
    Q_INVOKABLE bool setValue(const QModelIndex &index, const QVariant &value, int role = TextRole);
    Q_INVOKABLE QVariant getData(const QModelIndex &index, int role = TextRole);
    Q_INVOKABLE TreeItem* getAllData();
protected:
    QHash<int,QByteArray> roleNames() const override;
private:
    TreeItem *getItem(const QModelIndex &index) const;
    TreeItem *m_rootItem;

};

