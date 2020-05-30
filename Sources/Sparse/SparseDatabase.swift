import Foundation
import NIO

public struct SparseDatabaseOptions {
  var numberOfThreads: Int?
  var inMemory: Bool = false
  var autoload: Bool = false
  var corruptionThreshold: Float = 0.1
}

public struct SparseDatabase {
  let name: String
  var inMemory: Bool = false
  var autoload: Bool = false
  var corruptionThreshold: Float = 0.1
  let operationExecutor: OperationExecutor
  
  init(_ name: String = ":inmemory", options: SparseDatabaseOptions? = nil) throws {
    self.name = name
    self.inMemory = name == ":inmemory" ? true : options?.inMemory ?? false
    
    let numberOfThreads = options?.numberOfThreads ?? ProcessInfo.processInfo.processorCount
    let eventLoopGroup = MultiThreadedEventLoopGroup(numberOfThreads: numberOfThreads)
    
    self.operationExecutor = OperationExecutor(
      eventLoopGroup: eventLoopGroup,
      numberOfThreads: numberOfThreads
    )
  }
  
  init(options: SparseDatabaseOptions? = nil) throws {
    try self.init(":inmemory", options: options)
  }
}
