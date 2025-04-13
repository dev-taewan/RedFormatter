#pragma once

#include <QList>
#include <QVariant>

class TreeItem {
public:

    explicit TreeItem(const QVariant &data, TreeItem *parent = nullptr);
    ~TreeItem();

    void appendChild(TreeItem *child);
    void removeChild(int row);
    TreeItem *child(int row);
    int childCount() const;
    int row() const;
    QVariant data() const;
    TreeItem *parentItem();
    void setData(const QVariant &data);

private:
    QList<TreeItem*> m_childItems;
    QVariant m_itemData;
    TreeItem *m_parentItem;
};

