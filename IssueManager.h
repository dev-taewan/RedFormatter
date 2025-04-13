#pragma once
#include <QObject>
#include <QQmlEngine>
#include <QtQuick>
#include "TreeModel.h"
#include "IssueWorkTable__.h"
class IssueManager:public QObject
{
    Q_OBJECT
    QML_ELEMENT
public:

    explicit IssueManager(QObject *parent = nullptr);
    //~IssueManager();
    Q_INVOKABLE void GetWorkTable(const QList<WorkTableItem> &issue_work_table);
    Q_INVOKABLE void GetTodayWorkPlan( TreeItem *today_work_table,int depth);
    Q_INVOKABLE void GetNextWorkPlan( TreeItem *next_work_table);
    Q_INVOKABLE void AddFile(const QString &file_path);
    Q_INVOKABLE bool WriteWorkPlan();


private:
    QList<QString> today_work_list;
    QList<QString> next_work_list;
    QList<QString> issue_work_list;
    QList<QString> issue_add_file_list;
};



