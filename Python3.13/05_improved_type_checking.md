# Python 3.13 Tutorial: Improved Type Checking

Python 3.13 brings significant improvements to its type checking capabilities, enhancing the language's support for static typing.

## What's New?

Python 3.13 introduces more precise type checking, better inference, and new type-related features to help developers write more robust and type-safe code.

## Examples

Let's explore some of the new type checking improvements in Python 3.13:

1. Enhanced type inference:

```python
  def process_data(data: list[int | str]) -> dict[str, int]:
      result = {}
      for item in data:
          if isinstance(item, str):
              result[item] = len(item)
          else:
              result[str(item)] = item
      return result

  # The type checker can now infer more precise types
  data = [1, "hello", 42, "world"]
  processed = process_data(data)
  print(processed)
  # Output: {'1': 1, 'hello': 5, '42': 42, 'world': 5}
```

2. Improved union type handling:

```python
  from typing import Union

  def stringify(value: Union[int, float, str]) -> str:
      return str(value)

  # The type checker now handles unions more accurately
  result1 = stringify(42)
  result2 = stringify(3.14)
  result3 = stringify("hello")

  print(result1, result2, result3)
  # Output: 42 3.14 hello
```

3. New type aliases:

```python
  from typing import TypeAlias

  Vector2D: TypeAlias = tuple[float, float]

  def calculate_distance(point1: Vector2D, point2: Vector2D) -> float:
      x1, y1 = point1
      x2, y2 = point2
      return ((x2 - x1) ** 2 + (y2 - y1) ** 2) ** 0.5

  p1 = (0.0, 0.0)
  p2 = (3.0, 4.0)
  distance = calculate_distance(p1, p2)
  print(f"Distance: {distance}")
  # Output: Distance: 5.0
```

## Benefits

1. More accurate type checking and error detection
2. Improved code reliability and maintainability
3. Better IDE support and autocompletion

## Conclusion

The improved type checking features in Python 3.13 provide developers with powerful tools to write more robust and type-safe code, leading to fewer runtime errors and improved overall code quality.