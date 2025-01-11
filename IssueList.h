#pragma once
#include <QObject>
#include <QQmlEngine>

class IssueList : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
public:
    explicit IssueList(QObject *parent = nullptr);

    Q_INVOKABLE QString process(const QString &input);

    QString name() const;
    void setName(const QString &newName);

signals:
    void nameChanged();

private:
    QString m_name="First name";

};
