# UICollectionView

## 기초 이론

- 정의
  - 정렬된 자료들을 사용자가 원하는 형식에 맞게 유연하게 표현할 수 있는 객체
  - UITableView 와 비슷하지만 데이터를 다양하게 표현하는데는 CollectionView가 더 확장성이 있음
  - UICollectionView vs UITableView
    - ![200616_collectionView&TableView](../image/200616/200616_collectionView&TableView.png)

- 데이터 표현 방식 ( Content & Latout )
  - ![200616_MergingContentandLayout](../image/200616/200616_MergingContentandLayout.png)
- 관련 class 및 protocol for collection views

| PerPose                                    | Class / Protocol                                             |
| ------------------------------------------ | ------------------------------------------------------------ |
| Top-level containment <br />and management | UICollectionView<br />UICollectionViewController             |
| Content<br />mangement                     | **[Protocol]** UICollectionVeiwDataSource <br />**[Protocol]** UICollectionVeiwDelegate |
| Presentation                               | UICollectionReuseableView<br />UICollectionViewCell          |
| Layout                                     | UICollectionViewLayout<br />UICollectionViewLayoutAttributes<br />UICollectionVeiwUpdateItem |
| Flow Layout                                | UICollectionViewLayot<br />**[Protocol]** UICollectionviewDelegateFlowLayout |

- 표현되는 요소의 3가지 타입
  1. 셀 ( Cell )
     - 컬렉션 뷰의 단일 데이터 항목을 표현하는 개체이며, 레아이웃에 의해 배치되는 주요 요소
     - 각 셀은 다중 섹션으로 나누거나 하나의 그룹으로 묶어 표현할 수 있음
     - 컬렉션 뷰의 컨텐츠 영역에 셀들을 배열하는 것이 레아웃 객체(Layout object)의 주요 업무
  2. 보조(보충) 뷰 (Supplementary views)
     - 섹션 또는 컬렉션 뷰 자체에 대한 헤더와 푸터 같은 역할을 하는 뷰
     - 셀처럼 데이터를 표현할수 있을 것은 같지만, 유저가 선택할 수 없는 뷰
     - 선택사항이며, 유저가 선택할 수 없고 레아아웃 객체를 통해 정의
  3. 장식 뷰 (Decoration Views)
     - 컬렉션 뷰의 배경을 꾸미는 데 사용하는 시각적 장식용 뷰
     - 선택사항이며, 유저가 선택할 수 없고 레이아웃 객체를 통해 정의



#### **CollectionViewLayout**

![200616_CollectionViewLayout](../image/200616/200616_CollectionViewLayout.png)



#### **FlowLayout**

- UICollectionViewFlowLayoutClass 
- Scroll Direction - vertical / Horizontal

![200616_FlowLayout](../image/200616/200616_FlowLayout.png)



#### **Section Layout**

![200616_Section Layout](../image/200616/200616_Section Layout.png)

#### 

#### **UICollectionViewDelegateFlowLayout Protocol**

![200616_UICollectionViewDelegateFlowLayout Protocol](../image/200616/200616_UICollectionViewDelegateFlowLayout Protocol.png)



#### Section Inset

![200616_Section Inset](../image/200616/200616_Section Inset.png)



#### Line spacing

![200616_Line spacing](../image/200616/200616_Line spacing.png)



#### Item Size

![200616_Item Size](../image/200616/200616_Item Size.png)



#### **Header / Footer Size**

![200616_Header:FooterSize](../image/200616/200616_Header:FooterSize.png)

#### **Layout Metrics**

![200616_LayoutMetrics](../image/200616/200616_LayoutMetrics.png)

#### **Cell Hierarchy**

![200616_CellHierarchy](../image/200616/200616_CellHierarchy.png)

#### **The State of a Cell**

![200616_The State of a Cell](../image/200616/200616_The State of a Cell.png)



### LectureNote :point_right: [링크](../LectureNote/CollectionView.pdf)

