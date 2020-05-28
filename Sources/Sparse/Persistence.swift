import Foundation

enum PersistenceError: Error {
  case invalidFilename(message: String)
  case serializationHooks(message: String)
}

struct Persistence {
  let filename: String?
  let inMemoryOnly: Bool
  let corruptAlertThreshold: Float
  let beforeDeserialization: (() -> Void)?
  let afterSerialization: (() -> Void)?
  
  init(
    filename: String?,
    inMemoryOnly: Bool,
    corruptAlertThreshold: Float,
    beforeDeserialization: (() -> Void)?,
    afterSerialization: (() -> Void)?) throws {
    
    self.filename = filename
    self.inMemoryOnly = inMemoryOnly
    self.corruptAlertThreshold = corruptAlertThreshold
    
    if !self.inMemoryOnly && filename != nil && filename?.last == "~" {
      throw PersistenceError.invalidFilename(message: "The datafile name can't end with a ~, which is reserved for crash safe backup files")
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
  
  /// Check if a directory exists and create it on the fly if it is not the case
  func ensureDirectoryExists(directory: String, completion: (Result<(), Error>)) {
    // TODO: Impl
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
  
  func treatRawData() {
    // TODO: Impl
  }
  
  func loadDatabase() {
    // TODO: Impl
  }
}
