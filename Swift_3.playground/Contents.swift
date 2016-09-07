//: Playground - Type Constraints


//Extensions of Array with Integer Type
extension Array where Element: Integer {
    var total: Element {
        return isEmpty ? 0 : reduce(0,+)
    }
}
let votes = [1,2,3,4,5]
votes.total



//Extensions of Collection with Double Type
extension Collection where Iterator.Element == Double, Index == Int {
    
    var total: Iterator.Element {
        return reduce(0,+)
    }
    
    var average: Iterator.Element {
        return isEmpty ? 0 : (reduce(0,+))/Double((endIndex-startIndex))
    }
}

let doubleItems = [1.0,2.0,3.0,4.0]
let total = doubleItems.total
let avg = doubleItems.average
print(total,avg)







//Extensions of Array with Comparable Protocol
extension Array where Element: Comparable {
    
    //Sorting
    func sortedArray() -> [Element] {
        return self.sorted {$0 < $1 }
    }
    
    //Remove Duplicates
    mutating func removeDuplicates() -> [Element] {
        var uniqueElements = [Element]()
        
        for item in self where !uniqueElements.contains(item) {
            uniqueElements.append(item)
        }
        return uniqueElements
    }
}


//Extensions of Array with Hashable Protocol
extension Array where Element: Hashable {
    mutating func appendUnique(item: Element) {
        for value in self where value.hashValue == item.hashValue {
            return
        }
        self.append(item)
    }
}

var items = [1,2,3,4]
items.appendUnique(item: 5)
items.appendUnique(item: 4)






//Extensions of Array with Custom Protocol
protocol StringProtocol {
    func hasPrefix(_ prefix: String) -> Bool
    func hasSuffix(_ suffix: String) -> Bool
    func lowercased() -> String
}

extension String: StringProtocol {}

extension Array where Element: StringProtocol {
    
    func filterByPrefix(prefix: String) -> [Element] {
        return filter { $0.lowercased().hasPrefix(prefix.lowercased()) }
    }
    
    func filterBySuffix(suffix: String) -> [Element] {
        return filter { $0.lowercased().hasSuffix(suffix.lowercased()) }
    }
}

let strings = ["Mohit", "Abhas", "Piyush"]
strings.filterByPrefix(prefix: "a")





//Extensions of Swift Generic Data Types with Custom Protocol

protocol MyProtocol {}

extension Int: MyProtocol {}
extension String: MyProtocol {}

struct MyStack<T: MyProtocol> {
    var items = [T]()
    
    mutating func append(item: T) {
        items.append(item)
    }
}

var stringStack = MyStack<String>()
stringStack.append(item: "piyush")
stringStack.append(item: "Abhas")
print(stringStack.items)




//Class conform to Comparable Protocol
class Teacher: Comparable {
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

func ==(lhs: Teacher, rhs: Teacher) -> Bool {
    return lhs.name == rhs.name
}

func < (lhs: Teacher, rhs: Teacher) -> Bool {
    return lhs.age < rhs.age
}

var one = Teacher(name: "Bob",age: 20)
var two = Teacher(name: "Mike", age: 23)

one == two
one < two



//Class Constraint to Generic Class
class Media { }
class Clip { }
class Photo: Media { }
class Movie: Media { }

class Album<T: Media> {
    var items = [T]()
}

let photo = Album<Photo>()
let movie = Album<Movie>()
//let clip = Album<Clip>() //error


//Generic structs
struct Stack<T, E: Hashable> {
    
    var items: Array<T> = Array<T>()
    var dict = [E: T]()
    
    mutating func push(item: T) {
        items.append(item)
    }
    
    mutating func pop() -> T?  {
        guard let lastItem = items.popLast() else {
            return nil
        }
        return lastItem
    }
}

var myStack = Stack<String, Int>()
myStack.push(item: "Piyush")
myStack.push(item: "Abhas")
myStack.push(item: "Mohit")
myStack.items