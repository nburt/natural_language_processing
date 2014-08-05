# Setup

1. Create a .env file and add your Alchemy API key. See the .env.example file.
1. `rake db:create db:migrate`
1. `bundle install`
1. Run tests with `rspec` or `rake spec`

# Working with the API

You can post json data to `/api/terms` and you will receive a JSON response with the extracted keywords.

### Example post request/response

###### Request

```
body = {
  "filename": "test.txt",
  "source_text": "Hello, my name is Nathanael Burt. I'm from Irvine, CA.",
  "max_retrieve": "2"
}

POST '/api/terms', body, {'Accept' => 'application/json'}
```

###### Response

```
{
    "query_id": 31,
    "created_at": "2014-07-29T19:10:29.534Z",
    "terms": [
        {
            "text": "Nathanael Burt",
            "count": 1,
            "relevance": "0.969646"
        },
        {
            "text": "Irvine",
            "count": null,
            "relevance": "0.618389"
        }
    ]
}
```

This API will run both an entity analysis and a keyword analysis. Since keyword analysis does not return a count, keywords that are pulled out will have a count of "null".
