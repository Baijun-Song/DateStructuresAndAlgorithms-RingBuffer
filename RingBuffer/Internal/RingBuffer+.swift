extension RingBuffer {
  mutating func _resetIndex() {
    if isEmpty {
      _pushIndex = 0
      _popIndex = 0
    }
  }
}
