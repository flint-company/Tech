# Integrating Jinja Templating in Instructor

## Context
The Instructor framework has been enhanced to support Jinja templating. This integration allows for more complex prompt formatting, including list iteration and conditional logic, which improves chunk generation, few-shot examples, and dynamic rules.

## Simple Working Example
Here's a basic example of how to use Jinja templating in Instructor:

```python
client.create(
    model="gpt-4o",
    messages=[
        {
            "role": "user", 
            "content": """
                You are a {{ role }} tasked with the following question:

                <question>
                {{ question }}
                </question>

                Use the following context to answer the question, make sure to return [id] for every citation:

                <context>
                {% for chunk in context %}
                  <context_chunk>
                    <id>{{ chunk.id }}</id>
                    <text>{{ chunk.text }}</text>
                  </context_chunk>
                {% endfor %}
                </context>

                {% if rules %}
                Make sure to follow these rules:

                {% for rule in rules %}
                  * {{ rule }}
                {% endfor %}
                {% endif %}
            """
        },
    ],
    context={
        "role": "professional educator", 
        "question": "What is the capital of France?", 
        "context": [
            {"id": 1, "text": "Paris is the capital of France."}, 
            {"id": 2, "text": "France is a country in Europe."}
        ], 
        "rules": ["Use markdown."]
    }
)
```

### Visual Aid
![Jinja Template Rendering](./images/jinja_template_rendering.png)

## Detailed Guidance
1. **Define the Prompt Template**: Use Jinja syntax to define the prompt template in the `content` field.
2. **Pass the Context**: Provide a `context` dictionary to the `create` method, which will be used to render the template.
3. **Render the Template**: Instructor will render the prompt using the provided context, filling in the template variables.

## Advanced Example
Let's create a more advanced example that includes conditional logic and list iteration:

```python
client.create(
    model="gpt-4o",
    messages=[
        {
            "role": "user", 
            "content": """
                You are a {{ role }} tasked with the following question:

                <question>
                {{ question }}
                </question>

                Use the following context to answer the question, make sure to return [id] for every citation:

                <context>
                {% for chunk in context %}
                  <context_chunk>
                    <id>{{ chunk.id }}</id>
                    <text>{{ chunk.text }}</text>
                  </context_chunk>
                {% endfor %}
                </context>

                {% if rules %}
                Make sure to follow these rules:

                {% for rule in rules %}
                  * {{ rule }}
                {% endfor %}
                {% endif %}
            """
        },
    ],
    context={
        "role": "data scientist", 
        "question": "Explain the concept of overfitting in machine learning.", 
        "context": [
            {"id": 1, "text": "Overfitting occurs when a model learns the noise in the training data."}, 
            {"id": 2, "text": "It results in poor generalization to new data."}
        ], 
        "rules": ["Use clear and concise language.", "Provide examples."]
    }
)
```

## Pitfalls to Watch Out For
- Ensure that the context dictionary keys match the template variables.
- Be cautious with conditional logic to avoid rendering errors.

## Engagement
Try modifying the advanced example to include additional context chunks and rules. What happens if you add a new rule that conflicts with an existing one?

## Conclusion
Integrating Jinja templating in Instructor allows for more flexible and powerful prompt formatting. This tutorial provides both a simple and an advanced example to get you started with Jinja in Instructor.

## References and Further Reading
- [Jinja Documentation](https://jinja.palletsprojects.com/)
- [Instructor Documentation](https://python.useinstructor.com/)