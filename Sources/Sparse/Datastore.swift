import Foundation

public struct DataStoreOptions {
  var filename: String?
  var timestampData: Bool = false
  var inMemoryOnly: Bool = false
  var autoload: Bool = false
  var corruptAlertThreshold: Float = 0.1
  var onload: ((Result<(), Error>) -> Void)?
  var afterSerialization: (() -> Void)?
  var beforeDeserialization: (() -> Void)?
  var compareStrings: ((String, String) -> ComparisonResult)?
}

public struct Datastore {
  let filename: String?
  let timestampData: Bool
  let inMemoryOnly: Bool
  let autoload: Bool
  let compareStrings: ((String, String) -> ComparisonResult)?
  let executor: Executor
  let persistence: Persistence
  let indexes: Any? = nil
  let ttlIndexes: Any? = nil
  
  public init() throws {
    try self.init(withOptions: DataStoreOptions())
  }
  
  public init(withOptions options: DataStoreOptions) throws {
    self.filename = options.filename
    self.timestampData = options.timestampData
    self.autoload = options.autoload
    self.compareStrings = options.compareStrings
    self.inMemoryOnly = self.filename == nil ? true : options.inMemoryOnly
    self.executor = self.inMemoryOnly ? Executor(ready: true) : Executor()
    self.persistence = try Persistence(
      filename: self.filename,
      inMemoryOnly: self.inMemoryOnly,
      corruptAlertThreshold: options.corruptAlertThreshold,
      beforeDeserialization: options.beforeDeserialization,
      afterSerialization: options.afterSerialization)
    
    // TODO: Add index initialization
    
    if self.autoload { self.loadDatabase(completion: options.onload) }
  }
  
  /// Loads the database from the datafile, and
  /// trigger the execution of buffered commands if any
  public func loadDatabase(completion: ((Result<(), Error>) -> Void)?) {
    //TODO: Add Impl
  }
  
  /// Gets an array of all the data in the database
  public func getAll() -> Any? { return nil }
  
  /// Resets all currently defined indexes
  public func resetIndexes() {
    // TODO: Impl
  }
  
  /// Ensure an index is kept for this field. Same parameters as lib/indexes
  /// For now this function is synchronous, we need to test how much time it takes
  /// We use an async API for consistency with the rest of the code
  public func ensureIndexes(
    fieldName: String,
    unique: Bool,
    sparse: Bool,
    expiration: Int,
    completion: (Result<(), Error>) -> Void) {
    
    // TODO: Impl
  }
  
  /// Remove an index.
  public func removeIndex(
    fieldName: String,
    completion: (Result<(), Error>) -> Void) {
  
    // TODO: Impl
  }
  
  /// Add one or several document(s) to all indexes
  public func appendToIndexes(doc: Any) {
     // TODO: Impl
  }
  
  /// Remove one or several document(s) from all indexes
  public func removeFromIndexes(doc: Any) {
    // TODO: Impl
  }
  
  /// Update one or several documents in all indexes
  /// To update multiple documents, oldDoc must be an array of { oldDoc, newDoc } pairs
  ///If one update violates a constraint, all changes are rolled back
  public func updateIndexes(old: Any, new: Any) {
    // TODO: Impl
  }
  
  /// Return the list of candidates for a given query
  /// Crude implementation for now, we return the candidates given by the first usable index if any
  /// We try the following query types, in this order: basic match, $in match, comparison match
  /// One way to make it better would be to enable the use of multiple indexes if the first usable index
  /// returns too much data. I may do it in the future.
  /// Returned candidates will be scanned to find and remove all expired documents
  public func getCandidates(
    query: Any,
    removeStaleDocs: Bool,
    completion: (Result<(), Error>) -> Void) {
    
    // TODO: Impl
  }
  
  public func createNewId() {
    // TODO: Impl
  }
  
  public func prepareDocumentForInsertion (doc: Any) {
    // TODO: Impl
  }
  
  public func insert() {
    // TODO: Impl
  }
  
  public func count(
    query: Any,
    completion: (Result<(), Error>) -> Void) {
    
    // TODO: Impl
  }
  
  public func find(
    query: Any,
    projection: Any,
    completion: (Result<(), Error>) -> Void) {
    
    // TODO: Impl
  }
  
  public func findOne(
    query: Any,
    projection: Any,
    completion: (Result<(), Error>) -> Void) {
    
    // TODO: Impl
  }
  
  public func update() {
    // TODO: Impl
  }
  
  // MARK: - Private Methods
  private func insert(
    doc: Any,
    completion: (Result<Any, Error>) -> Void) {
    
    // TODO: Impl
  }
  
  private func insertInCache(doc: Any) {
    // TODO: Impl
  }
  
  private func insertMultipleDocsInCache (docs: Any) {
    // TODO: Impl
  }
  
  private func update(
    query: Any,
    updateQuery: Any,
    options: Any,
    completion: (Result<(), Error>) -> Void) {
    
    // TODO: Impl
  }
}
