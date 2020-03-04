import UIKit

class FHIRSchema {
    var schemaName: String
    
    init(schemaName: String) {
        self.schemaName = schemaName
    }
}

class ObservationFHIRSchema: FHIRSchema {
    
}

// Decorators
class FHIRSchemaDecorator: FHIRSchema {
    var schemaName: String {
        return self.wrappedObject.schemaName
    }
    
    var wrappedObject: FHIRSchema
    
    init(wrappedObject: FHIRSchema) {
        self.wrappedObject = wrappedObject
    }
}






