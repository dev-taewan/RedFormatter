#pragma once
#include <QAbstractlistModel>
#include <QQmlEngine>

class IssueItem{
public:
    QString name;
    QString description;
};

class IssueList : public QAbstractListModel
{
    Q_OBJECT
    QML_ELEMENT
public:
    enum ItemRoles{
        NameRole=Qt::UserRole+1,
        DescriptionRole,

    };
    explicit IssueList(QObject *parent = nullptr);
    int rowCount(const QModelIndex &parent=QModelIndex())const override;
    QVariant data(const QModelIndex &index,int role=Qt::DisplayRole) const override;
    Q_INVOKABLE void addItem(const QString &name,const QString &description);
protected:
    QHash<int,QByteArray> roleNames() const override;
private:
    QList<IssueItem> m_items;
};

