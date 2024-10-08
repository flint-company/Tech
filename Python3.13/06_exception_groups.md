# Python 3.13 Tutorial: Exception Groups and except*

## Context

Python 3.13 introduces Exception Groups and the `except*` statement, allowing for better handling of multiple concurrent exceptions, particularly useful in asynchronous programming.

## What's New?

- `ExceptionGroup`: A new exception type that can hold multiple exceptions.
- `except*` statement: A new syntax for catching exception groups.

## Simple Working Example

Here's a basic example demonstrating Exception Groups and `except*`:

```python
def process_data(data):
    errors = []
    for item in data:
        try:
            # Some processing that might raise exceptions
            if item < 0:
                raise ValueError(f"Negative value: {item}")
            if item > 100:
                raise OverflowError(f"Value too large: {item}")
        except Exception as e:
            errors.append(e)
    
    if errors:
        raise ExceptionGroup("Data processing errors", errors)

try:
    process_data([-1, 50, 101, 200])
except* ValueError as eg:
    print(f"Caught {len(eg.exceptions)} ValueErrors")
except* OverflowError as eg:
    print(f"Caught {len(eg.exceptions)} OverflowErrors")
````


## Detailed Guidance

1. Use `ExceptionGroup` to group multiple related exceptions.
2. The `except*` statement allows you to catch specific exception types from an `ExceptionGroup`.
3. You can nest `ExceptionGroup`s for more complex error hierarchies.

## Things to Watch Out For

- `except*` only catches exceptions from `ExceptionGroup`s, not regular exceptions.
- Regular `except` clauses take precedence over `except*` clauses.
- Be careful when re-raising exceptions within `except*` blocks, as it can lead to nested `ExceptionGroup`s.

## Conclusion

Exception Groups and `except*` provide a powerful way to handle multiple exceptions simultaneously, improving error handling in complex and concurrent Python applications.