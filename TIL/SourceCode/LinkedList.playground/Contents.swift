import Foundation

protocol LinkedListStack {
  var isEmpty: Bool { get } // 노드가 있는지 여부
  var size: Int { get }     // 전체 개수
  func push(node: Node)     // 데이터 삽입
  func peek() -> String?    // 마지막 데이터 확인
  func pop() -> String?     // 데이터 추출
}


final class Node {
  var value: String
  var next: Node?
  
  init(value: String) {
    self.value = value
  }
}

final class SingleLinkedList: LinkedListStack {
  
  private var head: Node? = nil
  var beforeNode: Node? = nil
  var isEmpty: Bool { head == nil }
  var size: Int = 0
  
  private var lastNode:Node? {
    guard var currentNode = head else { return nil }  // 현재 노트가 head 면 중지
    while let nextNode = currentNode.next {
      currentNode = nextNode                  // 다음 노드가 있을 경우 다음 노드를 현재 노드로
    }
    return currentNode
  }
  
  func push(node: Node) {
    size += 1
    if let lastNode = lastNode {
      lastNode.next = node
    } else {
      head = node
    }
  }
  
  func peek() -> String? {
    lastNode?.value
  }
  
  func pop() -> String? {
    guard var currentNode = head else { return nil }
    while let _ = currentNode.next?.next {
      currentNode = currentNode.next!
    }
    size -= 1
    
    if let popValue = currentNode.next?.value {
      currentNode.next = nil
      return popValue
    } else {
      defer { head = nil } // defer - {} 종료되는 시점에 마지막으로 실행됨
      return head!.value
    }
  }
}


let linkedList = SingleLinkedList()
linkedList.isEmpty

linkedList.push(node: Node(value: "A"))
linkedList.push(node: Node(value: "B"))
linkedList.peek()
linkedList.size

linkedList.isEmpty
linkedList.pop()
linkedList.size

linkedList.push(node: Node(value: "C"))
linkedList.push(node: Node(value: "D"))
linkedList.peek()
linkedList.size

linkedList.pop()
linkedList.pop()
linkedList.pop()
linkedList.pop()
linkedList.size
linkedList.isEmpty
