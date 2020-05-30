//

import Foundation

extension SparseCollection {
  /// Create an index for the specified field. If it is
  /// called on a collection that already has the index,
  /// nothing happens.
  public func createIndex(fieldName: String, unique: Bool, sparse: Bool, expiration: Int) {
    // TODO: Impl
  }
  
  /// Remove an index.
  public func dropIndex(fieldName: String) {
    // TODO: Impl
  }
  
  /// Resets all currently defined indexes
  public func dropIndexes() {
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
  /// If one update violates a constraint, all changes are rolled back
  public func updateIndexes(old: Any, new: Any) {
    // TODO: Impl
  }
}
