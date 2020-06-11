//: [Previous](@previous)
/*
 싱글톤 클래스를 이용한 방법
 */


class User {
  static let shared = User()
  var friends: [Friends] = []
  var blocks: [Friends] = []
}

struct Friends: Equatable {
  let name: String
}


class FriendList {
  func addFriend(name: String) {
//    let user = User()
//    let friend = Friends(name: name)
//    user.friends.append(friend)
    // "원빈", "장동건", "정우성" 3명을 친구로 추가했을 때
    // 최종적으로 user.friends 에 들어있는 friend 의 숫자는?
//    print(user.friends)
    
    let user = User.shared
    let friend = Friends(name: name)
    user.friends.append(friend)
  }
  
  
  func blockFriend(name: String) {
    let friend = Friends(name: name)
    
    if let index = User.shared.friends.firstIndex(of: friend) {
      User.shared.friends.remove(at: index)
    }
    if !User.shared.blocks.contains(friend) {
      User.shared.blocks.append(friend)
    }
  }
}


var friendList = FriendList()
friendList.addFriend(name: "원빈")
friendList.addFriend(name: "장동건")
friendList.addFriend(name: "정우성")
User.shared.friends



friendList.blockFriend(name: "원빈")
User.shared.friends
User.shared.blocks




// User vs User.shared 비교

let userInit = User()
userInit.friends
userInit.blocks

let userShared = User.shared
userShared.friends
userShared.blocks




//: [Next](@next)
