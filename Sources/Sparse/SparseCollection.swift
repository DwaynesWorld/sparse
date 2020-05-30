import Foundation

public struct SparseCollectionOptions {
  var useTimestamps: Bool = false
  var corruptionThreshold: Float = 0.1
}

public struct SparseCollection {
  public let name: String
  
  let namespace: String
  let database: SparseDatabase
  let options: SparseCollectionOptions
  let persistence: Persistence
  let indexes: Any? = nil
  let ttlIndexes: Any? = nil
  
  public init(_ name: String, database: SparseDatabase) throws {
    try self.init(name, database: database, withOptions: SparseCollectionOptions())
  }
  
  public init(_ name: String, database: SparseDatabase, withOptions options: SparseCollectionOptions) throws {
    self.name = name
    self.namespace = "\(database.name)/\(name)"
    self.options = options
    self.database = database
    
    self.persistence = try Persistence(
      fileName: self.namespace,
      inMemory: database.inMemory,
      corruptionThreshold: database.corruptionThreshold,
      beforeDeserialization: nil,
      afterSerialization: nil
    )
    
    self.dropIndexes()
    self.persistence.loadCollection()
  }
}
