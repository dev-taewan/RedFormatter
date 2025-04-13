#pragma once
#include <QAbstractlistModel>
#include <QQmlEngine>
#include <QtQuick>
class WorkTableItem{
public:
    QString work_id;
    QString work_title;
    QString work_type;
    QString deadline;
    QString achievment_rate;
    QString result_output;
    QString etc_issue;

};
class IssueWorkTable:public QAbstractListModel
{
    Q_OBJECT
    QML_ELEMENT
public:
    enum ItemRoles{
        IdRole=Qt::UserRole+1,
        WorkTitleRole,
        WorkTypeRole,
        DeadLineRole,
        AchievmentRateRole,
        ResultOutputRole,
        EtcIssueRole,
    };
    Q_ENUM(ItemRoles);
    explicit IssueWorkTable(QObject *parent = nullptr);
    int rowCount(const QModelIndex &parent=QModelIndex())const override;
    Q_INVOKABLE void addItem(const QString work_id,const QString work_title,const QString work_type,const QString deadline ,const QString achievment_rate,const QString result_output,const QString etc_issue);
    QVariant data(const QModelIndex &index,int role=Qt::DisplayRole) const override;

    Q_INVOKABLE void GetCurrentWorkTable(QString issue_id);
    Q_INVOKABLE void updateItem(int index, const QString &newType,int role);

    bool setData(const QModelIndex &index, const QVariant &value, int role) override;

    Q_INVOKABLE QList<WorkTableItem> getWorkTableList();
protected:
    QHash<int,QByteArray> roleNames() const override;
private:
    QList<WorkTableItem> m_items;

};
