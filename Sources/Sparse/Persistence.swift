import Foundation

enum PersistenceError: Error {
  case invalidFileName(message: String)
  case serializationHooks(message: String)
}

struct Persistence {
  let storage: Storage
  let fileName: String
  let inMemory: Bool
  let corruptionThreshold: Float
  let beforeDeserialization: (() -> Void)?
  let afterSerialization: (() -> Void)?
  
  init(
    fileName: String,
    inMemory: Bool,
    corruptionThreshold: Float,
    beforeDeserialization: (() -> Void)?,
    afterSerialization: (() -> Void)?
  ) throws {
    self.storage = Storage()
    self.fileName = fileName
    self.inMemory = inMemory
    self.corruptionThreshold = corruptionThreshold
    
    if !self.inMemory && fileName.last == "~" {
      throw PersistenceError.invalidFileName(message: "The datafile name can't end with a ~, which is reserved for crash safe backup files")
    }
    
    if beforeDeserialization != nil && afterSerialization == nil {
      throw PersistenceError.serializationHooks(message: "Deserialization hook defined but serialization hook is nil, cautiously refusing to start db to prevent dataloss")
    }
    
    if beforeDeserialization == nil && afterSerialization != nil {
      throw PersistenceError.serializationHooks(message: "Serialization hook defined but deserialization hook is nil, cautiously refusing to start db to prevent dataloss")
    }
    
    self.beforeDeserialization = beforeDeserialization
    self.afterSerialization = afterSerialization
    
    if self.beforeDeserialization != nil && self.afterSerialization != nil {
      // TODO: Add sanity check to prevent dataloss
    }
  }
  
  /// Loads the collection data from the datafile, and
  /// trigger the execution of buffered commands if any
  func loadCollection() {
    if self.inMemory { return }
    
    let _ = self.storage.ensureFileIntegrity(fileName: self.fileName)
    if let data = try? self.storage.read(fileName: self.fileName) {
      self.parseRawData(data)
    }
  }
  
  func persistCachedDatastore(completion: (Result<(), Error>)) {
    // TODO: Impl
  }
  
  func persistNewState(docs: Any, completion: (Result<(), Error>)) {
    // TODO: Impl
  }
  
  func compactDatafile() {
    // TODO: Impl
  }
  
  func setAutoCompactionInterval() {
    // TODO: Impl
  }
  
  func stopAutoCompaction() {
    // TODO: Impl
  }
  
  func parseRawData(_ raw: String) {
    let _ = raw.split(separator: "\n").map {
      print($0)
    }
  }
}
