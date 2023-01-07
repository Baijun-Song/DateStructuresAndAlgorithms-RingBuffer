extension RingBuffer: Sequence {
  @inlinable
  public func makeIterator() -> AnyIterator<Element> {
    var currentIndex = popIndex
    let iterator = AnyIterator {
      if currentIndex < pushIndex {
        let index = currentIndex
        currentIndex += 1
        return storage[wrapped: index]
      } else {
        return nil
      }
    }
    return iterator
  }
}

