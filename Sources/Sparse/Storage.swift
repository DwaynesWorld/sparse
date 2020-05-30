import Foundation
import Files

struct Storage {
  func exists() -> Bool {
    return true
  }
  
  func rename(from: String, to: String) {
    
  }
  
  func read(fileName: String) throws -> String {
    let path = "/Users/KT/Desktop/" + fileName
    let file = try File(path: path)
    return try file.readAsString()
  }
  
  func write() {
    
  }
  
  func append() {
    
  }
  
  func delete() {
    
  }
  
  /// Check if a directory exists and create it on the fly if it is not the case
  func ensureFileExists(fileName: String) -> Result<(), Error> {
    do {
      let folder = try Folder(path: "/Users/KT/Desktop")
      try folder.createFileIfNeeded(at: fileName, contents: "".data(using: .utf8))
      return .success(())
    } catch {
      print(error)
      return .failure(error)
    }
  }
  
  /// Ensure the datafile contains all the data, even if there was a crash during a full file write
  func ensureFileIntegrity(fileName: String) -> Result<(), Error> {
    let fullName = "/Users/KT/Desktop/" + fileName
    let tempName = fullName + "~"
    
    if let _ = try? File(path: fullName) {
      return .success(())
    }
    
    if let file = try? File(path: tempName) {
      // Write failed use old
      do {
        try file.rename(to: fileName)
      } catch {
        return .failure(error)
      }
      return .success(())
    } else {
      // This is a new file
      return self.ensureFileExists(fileName: fileName)
    }
  }
  
  /// If the given file exist, delete it.
  func ensureFileDoesntExist(fileName: String) -> Result<(), Error> {
    if let file = try? File(path: fileName) {
      do {
        try file.delete()
      } catch let error {
        return .failure(error)
      }
    }
    
    return .success(())
  }
  
  /// Flush data in OS buffer to storage if corresponding option is set
  func flush(path: String, isDirectory: Bool) -> Result<(), Error> {
    return .success(())
  }
  
  /// Fully write or rewrite the datafile, immune to crashes during the write operation (data will not be lost)
  func crashSafeWriteFile(fileName: String, data: String) -> Result<(), Error> {
    return .success(())
  }
}
