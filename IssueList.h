#pragma once
#include <QAbstractlistModel>
#include <QQmlEngine>
#include <QtQuick>
class IssueItem{
public:
    QString issue_id;
    QString issue_title;
    QString author;
    int achievment_rate=0;
    bool is_overdue=false;
    QString deadline;
};

class IssueList : public QAbstractListModel
{
    Q_OBJECT
    QML_ELEMENT
public:
    enum ItemRoles{
        IdRole=Qt::UserRole+1,
        Author,
        IssueTitleRole,
        AchievmentRateRole,
        IsOverdueRole,
        DeadLineRole,
    };
    explicit IssueList(QObject *parent = nullptr);
    int rowCount(const QModelIndex &parent=QModelIndex())const override;
    QVariant data(const QModelIndex &index,int role=Qt::DisplayRole) const override;
    Q_INVOKABLE void addItem(const QString issue_id, const QString issue_title,int achievment_rate,bool is_overdue,QString deadline);
    Q_INVOKABLE void fetch_issues();
protected:
    QHash<int,QByteArray> roleNames() const override;
private:
    QList<IssueItem> m_items;
};

