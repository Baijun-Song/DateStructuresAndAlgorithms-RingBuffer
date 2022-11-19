extension RingBuffer: Sequence {
  public func makeIterator() -> some IteratorProtocol {
    var currentIndex = _popIndex
    let iterator = AnyIterator {
      if currentIndex < _pushIndex {
        let index = currentIndex
        currentIndex += 1
        return _storage[wrapped: index]
      } else {
        return nil
      }
    }
    return iterator
  }
}

