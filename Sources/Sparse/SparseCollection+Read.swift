//

import Foundation

extension SparseCollection {
  public func find(query: Any, projection: Any) {
    // TODO: Impl
  }
  
  public func findOne(query: Any, projection: Any) {
    // TODO: Impl
  }
  
  public func count(query: Any) {
    // TODO: Impl
  }
  
  /// Return the list of candidates for a given query
  /// Crude implementation for now, we return the candidates given by the first usable index if any
  /// We try the following query types, in this order: basic match, $in match, comparison match
  /// One way to make it better would be to enable the use of multiple indexes if the first usable index
  /// returns too much data. I may do it in the future.
  /// Returned candidates will be scanned to find and remove all expired documents
  private func getCandidates(query: Any, removeStaleDocs: Bool) {
    // TODO: Impl
  }
}
