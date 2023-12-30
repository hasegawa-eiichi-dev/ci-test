import math

func `+`*(a: SomeInteger, b: SomeFloat): float {.inline.} =
  return a.toFloat() + b

func `+`*(a: SomeFloat, b: SomeInteger): float {.inline.} =
  return a + b.toFloat()

func `-`*(a: SomeInteger, b: SomeFloat): float {.inline.} =
  return a.toFloat() - b

func `-`*(a: SomeFloat, b: SomeInteger): float {.inline.} =
  return a - b.toFloat()

func `*`*(a: SomeInteger, b: SomeFloat): float {.inline.} =
  return a.toFloat() * b

func `*`*(a: SomeFloat, b: SomeInteger): float {.inline.} =
  return a * b.toFloat()

func `/`*(a: SomeInteger, b: SomeFloat): float {.inline.} =
  return a.toFloat() / b

func `/`*(a: SomeFloat, b: SomeInteger): float {.inline.} =
  return a / b.toFloat()

func divmod*(dividend: SomeFloat, divisor: SomeInteger): tuple[d: int, m: float] {.inline.} =
  let quot = (dividend / divisor).floor.toInt()
  let rem = dividend - divisor * quot
  return (quot, rem)

func divmod*(dividend: SomeInteger, divisor: SomeFloat): tuple[d: int, m: float] {.inline.} =
  let quot = (dividend / divisor).floor.toInt()
  let rem = dividend - divisor * quot
  return (quot, rem)

func divmod*(dividend, divisor: SomeFloat): tuple[d: int, m: float] {.inline.} =
  let quot = (dividend / divisor).floor.toInt()
  let rem = dividend - divisor * quot
  return (quot, rem)
