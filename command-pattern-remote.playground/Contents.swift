import UIKit

// Random objects we want to control via single remote
struct Lights {
    func turnOn() {
        print("lights turned on")
    }
    func turnOff() {
        print("lights turned off")
    }
}

struct GarageDoor {
    func open() {
        print("garage door opened")
    }
    func close() {
        print("garage door closed")
    }
}

struct CeilingFan {
    func start() {
        print("ceiling fan is on")
    }
    func stop() {
        print("ceiling fan is off")
    }
}

// Abstractions.

protocol Command {
    func execute()
    func undo()
}

struct LightsCommand: Command {
    var lights: Lights
    
    func execute() {
        lights.turnOn()
    }
    
    func undo() {
        lights.turnOff()
    }
}

struct GarageDoorCommand: Command {
    var garageDoor: GarageDoor

    func execute() {
        garageDoor.open()
    }
    
    func undo() {
        garageDoor.close()
    }
}

struct CeilingFanCommand: Command {
    var ceilingFan: CeilingFan
    
    func execute() {
        ceilingFan.start()
    }
    func undo() {
        ceilingFan.stop()
    }
}

struct RemoteControl {
    var lights: Command
    var garageDoor: Command
    var ceilingFan: Command
}
let lights = Lights()
let garageDoor = GarageDoor()
let ceilingFan = CeilingFan()


let remote = RemoteControl(lights: LightsCommand(lights: lights),
                           garageDoor: GarageDoorCommand(garageDoor: garageDoor),
                           ceilingFan: CeilingFanCommand(ceilingFan: ceilingFan))

remote.lights.execute()
