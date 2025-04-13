#include "TreeModel.h"

TreeModel::TreeModel(QObject *parent)
    : QAbstractItemModel(parent) {
    m_rootItem = new TreeItem("Root");
}

TreeModel::~TreeModel() {
    delete m_rootItem;
}

QVariant TreeModel::data(const QModelIndex &index, int role) const {
    std::cout<<"row "<< index.row()<<" column: "<<index.column()<<"  role: "<<role<<std::endl;
    if (!index.isValid())
        return QVariant();


    if(role==TextRole)
    {
        TreeItem *item = getItem(index);
        return item->data();

    }
    else
        return QVariant();
}

QModelIndex TreeModel::index(int row, int column, const QModelIndex &parent) const {
    if (!hasIndex(row, column, parent))
        return QModelIndex();

    TreeItem *parentItem = getItem(parent);
    TreeItem *childItem = parentItem->child(row);

    if (childItem)
        return createIndex(row, column, childItem);

    return QModelIndex();
}

QModelIndex TreeModel::parent(const QModelIndex &index) const {
    if (!index.isValid())
        return QModelIndex();

    TreeItem *childItem = getItem(index);
    TreeItem *parentItem = childItem->parentItem();

    if (parentItem == m_rootItem)
        return QModelIndex();

    return createIndex(parentItem->row(), 0, parentItem);
}

int TreeModel::rowCount(const QModelIndex &parent) const {
    TreeItem *parentItem = getItem(parent);
    return parentItem->childCount();
}

int TreeModel::columnCount(const QModelIndex &parent) const {
    Q_UNUSED(parent);
    return 1;
}

Qt::ItemFlags TreeModel::flags(const QModelIndex &index) const {
    if (!index.isValid())
        return Qt::NoItemFlags;
    return Qt::ItemIsSelectable | Qt::ItemIsEnabled;
}

TreeItem *TreeModel::getItem(const QModelIndex &index) const {
    if (index.isValid()) {
        TreeItem *item = static_cast<TreeItem*>(index.internalPointer());
        if (item) return item;
    }
    return m_rootItem;
}

// void TreeModel::insertNode(int row, const QString &name) {
//     TreeItem *parentItem = m_rootItem;

//     beginInsertRows(QModelIndex(), row, row);
//     parentItem->appendChild(new TreeItem(name, parentItem));
//     endInsertRows();
// }

// void TreeModel::insertChild(const QModelIndex &parentIndex, const QString &name) {

//     TreeItem *parentItem = getItem(parentIndex);
//     if (!parentItem) return;
//     beginInsertRows(parentIndex, parentItem->childCount(), parentItem->childCount());
//     parentItem->appendChild(new TreeItem(name, parentItem));
//     endInsertRows();
// }
void TreeModel::insertNode(int row, const QList<QString> &values) {
    TreeItem *parentItem = m_rootItem;

    beginInsertRows(QModelIndex(), row, row);
    parentItem->appendChild(new TreeItem(values, parentItem));
    endInsertRows();
}

void TreeModel::insertChild(const QModelIndex &parentIndex, const QList<QString> &values) {

    TreeItem *parentItem = getItem(parentIndex);
    if (!parentItem) return;
    beginInsertRows(parentIndex, parentItem->childCount(), parentItem->childCount());
    parentItem->appendChild(new TreeItem(values, parentItem));
    endInsertRows();
}
void TreeModel::removeNode(const QModelIndex &index) {


    if (!index.isValid()) return;

    TreeItem *item = getItem(index);
    TreeItem *parentItem = item->parentItem();
    if (!parentItem) return;  // ✅ root 노드는 삭제할 수 없음

    int row = index.row();

    // 🔹 자식들을 먼저 삭제 (재귀적 삭제)
    while (item->childCount() > 0) {
        QModelIndex childIndex = this->index(0, 0, index);
        removeNode(childIndex);
    }

    beginRemoveRows(index.parent(), row, row);  // ✅ 부모 기준에서 제거 시작
    parentItem->removeChild(row);  // ✅ 부모에서 제거 (delete 호출 X)
    endRemoveRows();  // ✅ 모델 업데이트 완료 후 삭제

    delete item;  // ✅ 안전하게

    // if (!parentIndex.isValid()) return;  // ✅ 유효성 체크

    // TreeItem *parentItem = getItem(parentIndex.parent());
    // if (!parentItem) return;  // ✅ null 체크

    // int row = parentIndex.row();
    // TreeItem *childItem = getItem(parentIndex);
    // if (!childItem) return;  // ✅ 삭제 대상 체크

    // beginRemoveRows(parentIndex, row, row);  // ✅ 먼저 호출
    // parentItem->removeChild(row);  // ✅ 부모에서 먼저 제거
    // std::cout<<"parent1"<<std::endl;
    // //delete childItem;  // ✅ 그다음 삭제
    // std::cout<<"parent2"<<std::endl;
    // endRemoveRows();

}
QHash<int, QByteArray> TreeModel::roleNames() const
{
    QHash<int,QByteArray> roles;
    roles[TextRole]="text";
    return roles;
}
bool TreeModel::setValue(const QModelIndex &index, const QVariant &value, int role) {
    if (!index.isValid())
        return false;
    // QString val=value.toString();
    // std::cout<<"set: " <<val.toStdString()<<std::endl;
    TreeItem *item = getItem(index);
    if (!item)
        return false;

    if (role == TextRole) {
        item->setData(value); // TreeItem에서 setText 메서드가 필요함
        emit dataChanged(index, index, {role});
        return true;
    }

    return false;
}
QVariant TreeModel::getData(const QModelIndex &index, int role)
{

    TreeItem *item = getItem(index);
    if (!item)
        return false;

    if (role == TextRole) {

        return item->data();
    }
return false;
}

TreeItem* TreeModel::getAllData()
{
    //TreeItem item;
    // for(int i=0;i<m_rootItem->childCount();i++)
    // {
    //     std::cout<< m_rootItem->child(i)->data().toString().toStdString() <<std::endl;

    // }
    std::cout<<"getAllData "<<m_rootItem->childCount()<<std::endl;

    return m_rootItem;
}
