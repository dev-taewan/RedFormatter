#include "IssueList.h"

IssueList::IssueList(QObject *parent)
    : QObject{parent}
{}

QString IssueList::process(const QString &input)
{
    return "Processed: "+input;
}

QString IssueList::name() const
{
    return m_name;
}

void IssueList::setName(const QString &newName)
{
    if (m_name == newName)
        return;
    m_name = newName;
    emit nameChanged();
}
