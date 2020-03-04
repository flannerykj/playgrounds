import UIKit

// ABSTRACT FACTORY

// Abstract classes...
protocol PizzaStore {
    var ingredientFactory: PizzaIngredientFactory { get set }
}
extension PizzaStore {
    func orderPizza(type: String) -> Pizza {
        let pizza = makePizza(type: type)
        pizza.prepare()
        pizza.bake()
        pizza.box()
        pizza.cut()
        return pizza
    }
    
    func makePizza(type: String) -> Pizza {
        switch type {
        case "cheese":
            return CheesePizza(ingredientFactory: self.ingredientFactory)
        case "veggie":
            return VeggiePizza(ingredientFactory: self.ingredientFactory)
        default:
            fatalError()
        }
    }
}
protocol PizzaIngredientFactory {
    var sauce: String { get set }
    var cheese: String { get set }
    var dough: String { get set }
    var veggies: [String] { get set }
    var pepperoni: String { get set }
    var porkBased: [String] { get set } // NYC only
}

protocol Pizza {
    var name: String { get set }
    var ingredientFactory: PizzaIngredientFactory { get set }
    func addToppings()
    // var ingredientFactory: PizzaIngredientFactory { get set }
    init(ingredientFactory: PizzaIngredientFactory)
}
extension Pizza {
    func prepare() {
        print("Preparing " + name)
        print("Tossing dough: \(ingredientFactory.dough)")
        print("Adding sauce: \(ingredientFactory.sauce)")
        print("Adding cheese: \(ingredientFactory.cheese)")
        self.addToppings()
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
// Implementations...
class CheesePizza: Pizza {
    var name: String = "Cheese Pizza"
    var ingredientFactory: PizzaIngredientFactory
    
    required init(ingredientFactory: PizzaIngredientFactory) {
        self.ingredientFactory = ingredientFactory
    }
    
    func addToppings() {}
}
class VeggiePizza: Pizza {
    var name: String = "Cheese Pizza"
    var ingredientFactory: PizzaIngredientFactory

    required init(ingredientFactory: PizzaIngredientFactory) {
        self.ingredientFactory = ingredientFactory
    }
    
    func addToppings() {
        for veggie in ingredientFactory.veggies {
            print("Adding veggie: \(veggie)")
        }
    }
}

class NYPizzaStore: PizzaStore {
    var ingredientFactory: PizzaIngredientFactory = NYPizzaIngredientFactory()
}
class ChicagoPizzaStore: PizzaStore {
    var ingredientFactory: PizzaIngredientFactory = ChicagoPizzaIngredientFactory()
}
class NYPizzaIngredientFactory: PizzaIngredientFactory {
    var sauce: String = "Marinara"
    var cheese: String = "Mozarella"
    var dough: String = "Thin crust"
    var veggies: [String] = ["Peppers", "Olives", "Mushrooms"]
    var pepperoni: String = "Cured ham"
    var sausage: String? = "Italian Sausage"
    var bacon: String? = nil
}
class ChicagoPizzaIngredientFactory: PizzaIngredientFactory {
    var sauce: String = "Plum tomato sauce"
    var cheese: String = "Mozarella + Cheddar blend"
    var dough: String = "Thick crust"
    var veggies = ["Mushrooms", "Artichokes"]
    var pepperoni: String = "Salami"
    var sausage: String? = nil
    var bacon: String? = "Canadian Bacon"
}

let nyStore = NYPizzaStore()
nyStore.orderPizza(type: "veggie")
