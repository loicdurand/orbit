# API Contract: AiService for OpenAI

This document specifies the request and response structure for the internal `AiService` that communicates with the OpenAI API.

**Service**: `AiService`  
**Endpoint**: `https://api.openai.com/v1/chat/completions`

---

## 1. Extract Information from Note

This action sends the content of a user's note to the AI to extract structured data and identify potential reminders.

### Request Body

The `AiService` will construct a request to the OpenAI API with the following structure. The user's note will be placed in the `user` message content.

```json
{
  "model": "gpt-4o-mini",
  "response_format": { "type": "json_object" },
  "messages": [
    {
      "role": "system",
      "content": "You are a helpful assistant for the Orbit app. Your task is to extract structured information from the user's note. The user wants to remember details about their contacts. Identify key entities like names of people, places, potential reminders based on dates, and topics of interest. Respond with a JSON object with two keys: 'extracted_data' and 'suggested_reminder'."
    },
    {
      "role": "user",
      "content": "J'ai vu Marc, sa fille Léa rentre au CP demain, il aime le Whisky japonais."
    }
  ]
}
```

### Success Response (200 OK)

The expected JSON object returned from the API should follow this schema.

**Schema**:

```json
{
  "type": "object",
  "properties": {
    "extracted_data": {
      "type": "object",
      "description": "Key-value pairs of information extracted from the note. Keys could be 'children', 'interests', 'work', etc.",
      "properties": {
        "children": { "type": "array", "items": { "type": "string" } },
        "interests": { "type": "array", "items": { "type": "string" } }
      }
    },
    "suggested_reminder": {
      "type": "object",
      "description": "A suggested reminder if a future event is mentioned.",
      "properties": {
        "title": { "type": "string" },
        "due_date": { "type": "string", "format": "date" },
        "context": { "type": "string" }
      },
      "required": ["title", "due_date"]
    }
  }
}
```

**Example Response Body**:

```json
{
  "extracted_data": {
    "children": ["Léa"],
    "interests": ["Whisky japonais"]
  },
  "suggested_reminder": {
    "title": "Ask Marc how Léa's first day of school went",
    "due_date": "2025-11-24",
    "context": "You noted that his daughter Léa was starting CP tomorrow."
  }
}
```

### Error Responses

- **400 Bad Request**: The request was malformed (e.g., invalid JSON). The `AiService` should log this error.
- **401 Unauthorized**: The API key is invalid or missing. The app should inform the user that the AI service is not configured correctly.
- **429 Too Many Requests**: The API rate limit has been exceeded. The `AiService` should implement exponential backoff.
- **500 Internal Server Error**: An error occurred on OpenAI's end. The `AiService` should retry the request a few times before failing.
