# Enhanced Validation with Pydantic in Instructor

## Context
Instructor now supports enhanced validation using Pydantic. This allows for more robust input validation and handling of sensitive information through the use of Pydantic's validation context.

## Simple Working Example
Here's a basic example of how to use Pydantic for validation in Instructor:

```python
from pydantic import BaseModel, ValidationInfo, field_validator

class Response(BaseModel):
    text: str

    @field_validator('text')
    @classmethod
    def no_banned_words(cls, v: str, info: ValidationInfo):
        context = info.context
        if context:
            banned_words = context.get('banned_words', set())
            banned_words_found = [word for word in banned_words if word.lower() in v.lower()]
            if banned_words_found:
                raise ValueError(f"Banned words found in text: {', '.join(banned_words_found)}, rewrite it but just without the banned words")
        return v

    @field_validator('text')
    @classmethod
    def redact_regex(cls, v: str, info: ValidationInfo):
        context = info.context
        if context:
            redact_patterns = context.get('redact_patterns', [])
            for pattern in redact_patterns:
                v = re.sub(pattern, '****', v)
        return v

response = client.create(
    model="gpt-4o",
    response_model=Response,
    messages=[
        {
            "role": "user", 
            "content": """
                Write about a {{ topic }}

                {% if banned_words %}
                You must not use the following banned words:

                <banned_words>
                {% for word in banned_words %}
                * {{ word }}
                {% endfor %}
                </banned_words>
                {% endif %}
              """
        },
    ],
    context={
        "topic": "jason and now his phone number is 123-456-7890",
        "banned_words": ["jason"],
        "redact_patterns": [
            r"\b\d{3}[-.]?\d{3}[-.]?\d{4}\b",  # Phone number pattern
            r"\b\d{3}-\d{2}-\d{4}\b",          # SSN pattern
        ],
    },
    max_retries=3,
)

print(response.text)
# > While i can't say his name anymore, his phone number is ****
```

## Detailed Guidance
1. **Define the Pydantic Model**: Create a Pydantic model with field validators.
2. **Implement Validation Logic**: Use `field_validator` to implement custom validation logic.
3. **Pass Context to Validators**: Access the context in validators using `ValidationInfo`.

## Advanced Example
Let's create a more advanced example that includes multiple validation rules:

```python
from pydantic import BaseModel, ValidationInfo, field_validator

class User(BaseModel):
    username: str
    email: str
    age: int

    @field_validator('username')
    @classmethod
    def validate_username(cls, v: str, info: ValidationInfo):
        if len(v) < 3 or len(v) > 20:
            raise ValueError('Username must be between 3 and 20 characters.')
        return v

    @field_validator('email')
    @classmethod
    def validate_email(cls, v: str, info: ValidationInfo):
        if '@' not in v:
            raise ValueError('Invalid email address.')
        return v

    @field_validator('age')
    @classmethod
    def validate_age(cls, v: int, info: ValidationInfo):
        if v < 18 or v > 99:
            raise ValueError('Age must be between 18 and 99.')
        return v

user = User(username="john_doe", email="john@example.com", age=25)
print(user)
# > User(username='john_doe', email='john@example.com', age=25)

invalid_user = User(username="jd", email="john@example", age=17)
# > Raises validation errors
```

## Pitfalls to Watch Out For
- Ensure that the context dictionary keys match the expected keys in the validators.
- Be cautious with regular expressions to avoid incorrect redactions.

## Conclusion
Enhanced validation with Pydantic in Instructor allows for more robust input handling and sensitive information management. This tutorial provides both a simple and an advanced example to get you started with Pydantic validation in Instructor.