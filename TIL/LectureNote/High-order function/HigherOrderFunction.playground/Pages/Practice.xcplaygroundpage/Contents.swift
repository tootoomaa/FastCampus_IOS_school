//: [Previous](@previous)
import Foundation

// 키노트 문제 참고
/*:
 ---
 ## Practice 1
 ---
 */
print("\n---------- [ Practice 1 ] ----------\n")

struct Pet {
  enum PetType {
    case dog, cat, snake, pig, bird
  }
  var type: PetType
  var age: Int
}

var myPet = [
  Pet(type: .dog, age: 13),
  Pet(type: .dog, age: 2),
  Pet(type: .dog, age: 7),
  Pet(type: .cat, age: 9),
  Pet(type: .snake, age: 4),
  Pet(type: .pig, age: 5),
]


myPet[0].age + myPet[1].age



// 1번
func sumDogAge1(pets: [Pet]) -> Int {
  var sum:Int = 0
  for i in pets {
    sum += i.age
  }
  return sum
}

func sumDogAge(pets: [Pet]) -> Int {
  return pets
    .filter({ $0.type == .dog})
    .reduce(0) { $0 + $1.age }
}
sumDogAge(pets: myPet)
sumDogAge1(pets: myPet)



func oneYearOlder(of pets: [Pet]) -> [Pet] {
  var temp = [Pet]()
  pets.map { (pet)  in
    temp.append(Pet(type: pet.type, age: pet.age+1))
  }
  return temp
}

oneYearOlder(of: myPet)




/*:
 ---
 ## Practice 2
 ---
 */
print("\n---------- [ Practice 2 ] ----------\n")


let immutableArray = Array(1...40)
var resultArray:[Int] = []


func getIndexkey(_ index:Int,_ number:Int) -> Int {
  return index * number
}

// 1.  배열의 각 요소  * index  값을 반환

func mulIndexNumber(index:Int,number:Int) -> Int {
  return index * number
}


// 2. 짝수 여부를 판별하는 함수

func isMultipleTwo(number:Int) -> Bool {
  return number%2 == 0 ? true : false
}

//isMultipleTwo(number: 2)

// 3. 두 개의 숫자를 더하여 반환하는 함수
func sumNumbers(left:Int, right:Int) -> Int {
  return left + right
}

immutableArray.enumerated()
  .map { (index, number) in return index * number }
  .filter { $0 % 2 == 0 ? true : false }
  .reduce(0) { $0 + $1 }

immutableArray.enumerated()
  .map(mulIndexNumber(index:number:))
  .filter(isMultipleTwo(number:))
  .reduce(0, sumNumbers(left:right:))

immutableArray.enumerated()
  .map { $0 * $1 }
  .filter { $0%2 == 0 ? true : false }
  .reduce(0){ $0 + $1 }

immutableArray.enumerated()
  .map( * )
  .filter (.isMultiple(of: 2))
  .reduce( 0,+ )
//: [Next](@next)
