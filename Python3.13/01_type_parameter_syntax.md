# Python 3.13 Tutorial: Type Parameter Syntax

Python 3.13 introduces a new syntax for declaring type parameters, making it easier to work with generic types and improving type hinting capabilities.

## What's New?

In Python 3.13, you can now use square brackets `[]` to declare type parameters directly in class and function definitions, similar to other languages like Java or C#.

## Example

Here's how you can use the new type parameter syntax:

```python
  def identity[T](x: T) -> T:
      return x

  class Stack[T]:
      def __init__(self):
          self.items: list[T] = []

      def push(self, item: T) -> None:
          self.items.append(item)

      def pop(self) -> T:
          return self.items.pop()
```

## Benefits

1. Clearer syntax for generic types
2. Improved readability of type-hinted code
3. Better integration with static type checkers

## Conclusion

The new type parameter syntax in Python 3.13 enhances the language's support for generic programming and type hinting, making it easier for developers to write and maintain type-safe code.