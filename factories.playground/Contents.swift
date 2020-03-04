import UIKit

// Design Principle: Depend upon abstractions. Do not depend upon concrete classes.

// FACTORY METHOD: Defines an interface for creating an object, but lets subclasses decide which class to instantiate.
// Lets a class defer instantiation to the sublcass.

// The CREATOR (abstract) - defines an abstract factory method that the subclasses implement to produce products.
protocol PizzaStore {
    func createPizza(type: String) -> Pizza
}
extension PizzaStore {
    
    // Depends on an abstract product (Pizza) produced by a concreate implementation of the interface.
    func orderPizza(type: String) -> Pizza {
        let pizza = createPizza(type: type)
        pizza.prepare()
        pizza.bake()
        pizza.box()
        pizza.cut()
        return pizza
    }
}

// The PRODUCT (abstract) - produced by the factory
protocol Pizza {
    var name: String { get set }
    var sauce: String { get set }
    var cheese: String { get set }
    var dough: String { get set }
    var toppings: [String] { get set }
}
extension Pizza {
    func prepare() {
        print("Preparing " + name)
        print("Tossing dough: \(dough)")
        print("Adding sauce: \(sauce)")
        print("Adding cheese: \(cheese)")
        for topping in toppings {
            print("Adding topping: \(topping)")
        }
    }
    func bake() {
        print("Baking")
    }
    func box() {
        print("Boxing")
    }
    func cut() {
        print("Cutting")
    }
}

// Implementation ...
// Concrete CREATOR
class NYPizzaStore: PizzaStore {
    func createPizza(type: String) -> Pizza {
        switch type {
        case "cheese":
            return NYCheesePizza()
        case "veggie":
            return NYVeggiePizza()
        default:
            fatalError()
        }
    }
    
    // Concrete PRODUCTS
    class NYCheesePizza: Pizza {
        var sauce: String = "Marinara"
        var cheese: String = "Mozarella"
        var dough: String = "Thin crust"
        var toppings: [String] = ["Parmesan"]
        var name: String = "New York Cheese Pizza"
    
        init() {}
    }
    
    class NYVeggiePizza: Pizza {
        var sauce: String = "Marinara"
        var cheese: String = "Mozarella"
        var dough: String = "Thin crust"
        var toppings: [String] = ["Peppers", "Olives", "Mushrooms"]
        var name: String = "New York Veggie Pizza"
    
        init() {}
    }
}
// Concrete CREATOR
class ChicagoPizzaStore: PizzaStore {
    func createPizza(type: String) -> Pizza {
        switch type {
        case "cheese":
            return ChicagoCheesePizza()
        case "veggie":
            return ChicagoVeggiePizza()
        default:
            fatalError()
        }
    }
    // Concrete PRODUCTS
    class ChicagoCheesePizza: Pizza {
        var name: String = "Chicago Cheese Pizza"
        var sauce: String = "Plum tomato sauce"
        var cheese: String = "Mozarella + Cheddar blend"
        var dough: String = "Thick crust"
        var toppings: [String] = ["Oregano"]
        
        init() {}
    }
    class ChicagoVeggiePizza: Pizza {
        var name: String = "Chicago Veggie Pizza"
        var sauce: String = "Plum tomato sauce"
        var cheese: String = "Mozarella + Cheddar blend"
        var dough: String = "Thick crust"
        var toppings: [String] = ["Mushrooms", "Artichokes"]
        
        init() {}
    }
}

let nyStore = NYPizzaStore()
nyStore.orderPizza(type: "cheese")

let chicagoStore = ChicagoPizzaStore()
chicagoStore.orderPizza(type: "veggie")

// ABSTRACT FACTORY: Provides an interface for creating families of related or dependent objects without specifying
// their concrete classes


