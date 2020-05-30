import Foundation
import NIO

/// A protocol for operation types to conform to. An `Operation` instance corresponds to any single operation a user
/// can perform with the driver's API that requires I/O.
protocol Operation {
  /// The result type this operation returns.
  associatedtype OperationResult
  
  /// Executes this operation using the provided connection and optional session, and returns its corresponding
  /// result type.
  func execute() throws -> OperationResult
}

struct OperationExecutor {
  /// A group of event loops to use for running operations in the thread pool.
  private let eventLoopGroup: EventLoopGroup
  /// The thread pool to execute operations in.
  private let threadPool: NIOThreadPool
  /// Operation Exceutor ready status
  var ready: Bool = false
  
  init(eventLoopGroup: EventLoopGroup, numberOfThreads: Int) {
    self.eventLoopGroup = eventLoopGroup
    self.threadPool = NIOThreadPool(numberOfThreads: numberOfThreads)
    self.threadPool.start()
    self.ready = true
  }
  
  /// Closes the executor's underlying thread pool.
  func shutdown() -> EventLoopFuture<Void> {
    let promise = self.eventLoopGroup.next().makePromise(of: Void.self)
    self.threadPool.shutdownGracefully { error in
      if let error = error {
        promise.fail(error)
        return
      }
      promise.succeed(Void())
    }
    return promise.futureResult
  }
  
  /// Closes the executor's underlying thread pool synchronously.
  func syncShutdown() throws {
    try self.threadPool.syncShutdownGracefully()
  }
  
  func execute<T: Operation>(_ operation: T) -> EventLoopFuture<T.OperationResult> {
    self.threadPool.runIfActive(eventLoop: self.eventLoopGroup.next(), { try operation.execute() })
  }
  
  func makeFailedFuture<T>(_ error: Error) -> EventLoopFuture<T> {
    self.eventLoopGroup.next().makeFailedFuture(error)
  }
  
  func makeSucceededFuture<T>(_ value: T) -> EventLoopFuture<T> {
    self.eventLoopGroup.next().makeSucceededFuture(value)
  }
  
  func makePromise<T>(of type: T.Type) -> EventLoopPromise<T> {
    self.eventLoopGroup.next().makePromise(of: type)
  }
}
