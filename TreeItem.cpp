#include "TreeItem.h"
#include <iostream>
TreeItem::TreeItem(const QVariant &data, TreeItem *parent)
    : m_itemData(data), m_parentItem(parent) {}

TreeItem::~TreeItem() {
    qDeleteAll(m_childItems);
}

void TreeItem::appendChild(TreeItem *child) {
    m_childItems.append(child);
}

void TreeItem::removeChild(int row) {
    // if (row >= 0 && row < m_childItems.size()) {
    //     delete m_childItems.takeAt(row);
    // }
    if (row < 0 || row >= m_childItems.size()) return;

    TreeItem *child = m_childItems.takeAt(row);  // 리스트에서 제거 (delete X)
    child->m_parentItem = nullptr;  // ✅
    // for(int i=0;i<m_childItems.size();i++)
    // {
    //     delete m_childItems[i];
    // }
    // m_childItems.clear();
    // assert(0 <= m_childItems.size());
    // std::cout<<"item size: "<<m_childItems.size()<<std::endl;
    // // this is the range of objects we want to remove and delete
    // // (N elements, starting from index X)
    // auto range_begin = m_childItems.begin(),
    //     range_end = range_begin + m_childItems.size();
    // // delete each object in range
    // std::for_each(range_begin, range_end, [](TreeItem* ptr) {std::cout<<"item del "<<std::endl; delete ptr; });
    // // remove them from the list
    // std::cout<<"item del end"<<std::endl;
    // m_childItems.clear();
    // std::cout<<"item clear"<<std::endl;
}

TreeItem *TreeItem::child(int row) {
    return m_childItems.value(row);
}

int TreeItem::childCount() const {
    return m_childItems.size();
}

int TreeItem::row() const {
    return m_parentItem ? m_parentItem->m_childItems.indexOf(const_cast<TreeItem*>(this)) : 0;
}

QVariant TreeItem::data() const {
    qDebug() << "TreeItem::data() called, returning:" << m_itemData;
    return m_itemData;
}

TreeItem *TreeItem::parentItem() {
    return m_parentItem;
}
void TreeItem::setData(const QVariant &data) {
    m_itemData = data;
}
