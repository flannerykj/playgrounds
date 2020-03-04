import UIKit

class Waitress {
    var unplacedOrders: [Order] = []
    var inProgressOrders: [Order] = []
    var deliveredOrders: [Order] = []
    
    func takeOrder(_ orderName: String, from customer: Customer) {
        let order = Order(name: orderName, customer: customer)
        unplacedOrders.append(order)
    }
    func placeOrders(with cook: ShortOrderCook) {
        cook.receiveOrders(unplacedOrders)
        inProgressOrders.append(contentsOf: unplacedOrders)
        unplacedOrders = []
    }
    
    func deliverFood(_ foodItems: [FoodItem]) {
        for item in foodItems {
            item.order.customer.receiveFood()
            
        }
    }
    init() {}
}

class Customer {
    var waitress: Waitress
    
    func placeOrder(_ orderName: String) -> Order {
        waitress.takeOrder(orderName, from: self)
    }
    
    func receiveFood() {
        print("Customer :)")
    }
    init(waitress: Waitress) {
        self.waitress = waitress
    }
}

class ShortOrderCook {
    var inProgressOrders: [Order] = []
    func receiveOrders(_ orders: [Order]) {
        inProgressOrders.append(contentsOf: orders)
    }
    func makeOrders() -> [FoodItem] {
        var completed: [FoodItem] = []
        while inProgressOrders.count > 0 {
            if let order = inProgressOrders.popLast() {
                completed.append(FoodItem(order: order))
            }
        }
        return completed
    }
    init() {}
}

class FoodItem {
    var order: Order
    
    init(order: Order) {
        self.order = order
    }
}
class Order {
    var name: String
    var customer: Customer
    
    func orderUp() {
        
    }
    init(name: String, customer: Customer) {
        self.name = name
        self.customer = customer
    }
}

let waitress = Waitress()
let customer1 = Customer(waitress: waitress)
let customer2 = Customer(waitress: waitress)

let cook = ShortOrderCook()

customer1.placeOrder("Burger with cheese")
customer2.placeOrder("BLT")

waitress.placeOrders(with: cook)

let completedFood = cook.makeOrders()

waitress.deliverFood(completedFood)



