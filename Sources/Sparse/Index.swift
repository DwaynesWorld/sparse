import Foundation

struct IndexOptions {
  let fieldName: String
  let unique: Bool
  let sparse: Bool
}

struct Index {
  let options: IndexOptions
  let tree: SparseTree<String, Any>

  init(withOptions options: IndexOptions) {
    self.options = options
    self.tree = SparseTree<String, Any>()
  }
  
  init(fieldName: String) {
    let options = IndexOptions(fieldName: fieldName, unique: false, sparse: true)
    self.init(withOptions: options)
  }
  
  func reset() {
    
  }
  
  func drop() {
    
  }
  
  func insert() {
    
  }
  
  func update() {
    
  }
  
  func getBetween() {
    
  }
}
