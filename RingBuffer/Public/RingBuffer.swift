public struct RingBuffer<Element> {
  var _storage: [Element?]
  var _popIndex = 0
  var _pushIndex = 0
  
  public init(capacity: Int) {
    _storage = Array(repeating: nil, count: capacity)
  }
}

extension RingBuffer {
  public var count: Int {
    _pushIndex - _popIndex
  }
  
  public var capacity: Int {
    _storage.count
  }
  
  public var isEmpty: Bool {
    count == 0
  }
  
  public var isFull: Bool {
    count >= capacity
  }
  
  public var start: Element? {
    isEmpty ? nil : _storage[wrapped: _pushIndex - 1]
  }
  
  public var end: Element? {
    isEmpty ? nil : _storage[wrapped: _popIndex]
  }
  
  public mutating func write(_ newElement: Element) {
    precondition(!isFull)
    _storage[wrapped: _pushIndex] = newElement
    _pushIndex += 1
  }
  
  public mutating func read() -> Element? {
    guard !isEmpty else {
      return nil
    }
    let removedElement = _storage[wrapped: _popIndex]
    _popIndex += 1
    _resetIndex()
    return removedElement
  }
  
  @discardableResult
  public mutating func resize(to newCapacity: Int) -> Bool {
    let count = count
    guard newCapacity > count else {
      return false
    }
    var newStorage: [Element?] = []
    newStorage.reserveCapacity(newCapacity)
    for i in 0..<count {
      newStorage[i] = _storage[wrapped: _popIndex + i]
    }
    _storage = newStorage
    _popIndex = 0
    _pushIndex = count
    return true
  }
}
