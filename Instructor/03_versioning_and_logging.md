# Improved Versioning and Logging in Instructor

## Context
Instructor has been enhanced to support better versioning and logging by separating prompt templates and variables. This allows for more secure logging, better version control, and easier debugging.

## Simple Working Example
Here's a basic example of how to use the improved versioning and logging in Instructor:

```python
from pydantic import BaseModel, SecretStr

class UserContext(BaseModel):
    name: str
    address: SecretStr

class Address(BaseModel):
    street: SecretStr
    city: str
    state: str
    zipcode: str

def normalize_address(address: Address):
    context = UserContext(name="scolvin", address=address)
    address = client.create(
        model="gpt-4o",
        messages=[
            {
                "role": "user", 
                "content": "{{ user.name }} is `{{ user.address.get_secret_value() }}`, normalize it to an address object"
            },
        ],
        context={"user": context},
    )
    print(context)
    # > UserContext(name='scolvin', address="******")
    print(address)
    # > Address(street='******', city="Toronto", state="Ontario", zipcode="M5A 0J3")
    logger.info(f"Normalized address: {address}", extra={"user_context": context, "address": address})
    return address
```

## Detailed Guidance
1. **Define the Pydantic Models**: Create Pydantic models for the context and address.
2. **Implement the Normalization Function**: Use the `create` method to normalize the address.
3. **Log the Results**: Use structured logging to log the results securely.

## Advanced Example
Let's create a more advanced example that includes version control and logging:

```python
from pydantic import BaseModel, SecretStr
import logging

class UserContext(BaseModel):
    name: str
    address: SecretStr

class Address(BaseModel):
    street: SecretStr
    city: str
    state: str
    zipcode: str

class Document(BaseModel):
    title: str
    content: str
    version: int = 1

    def save(self):
        self.version += 1
        logger.info(f"Document saved with version {self.version}")

def normalize_address(address: Address):
    context = UserContext(name="scolvin", address=address)
    address = client.create(
        model="gpt-4o",
        messages=[
            {
                "role": "user", 
                "content": "{{ user.name }} is `{{ user.address.get_secret_value() }}`, normalize it to an address object"
            },
        ],
        context={"user": context},
    )
    print(context)
    # > UserContext(name='scolvin', address="******")
    print(address)
    # > Address(street='******', city="Toronto", state="Ontario", zipcode="M5A 0J3")
    logger.info(f"Normalized address: {address}", extra={"user_context": context, "address": address})
    return address

# Example usage
doc = Document(title="My First Document", content="This is the content of the document.")
doc.save()
# > Document saved with version 2

doc.content = "This is the updated content of the document."
doc.save()
# > Document updated to version 3
```

## Pitfalls to Watch Out For
- Ensure that sensitive information is handled securely using `SecretStr`.
- Be cautious with logging to avoid exposing sensitive information.

## Conclusion
Improved versioning and logging in Instructor allows for more secure and maintainable prompt management. This tutorial provides both a simple and an advanced example to get you started with versioning and logging in Instructor.