#pragma once
<<<<<<< HEAD
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

=======
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
>>>>>>> bc1a527 (qt set)
