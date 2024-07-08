let json = {
    "type": "html",
    "children": [
      {
        "type": "head",
        "children": [
          {
            "type": "title",
            "text": "My JSON-based HTML Page"
          }
        ]
      },
      {
        "type": "body",
        "children": [
          {
            "type": "h1",
            "text": "Welcome to My Page"
          },
          {
            "type": "p",
            "text": "This is a simple example of creating an HTML page using JSON."
          },
          {
            "type": "ul",
            "children": [
              {
                "type": "li",
                "text": "List Item 1"
              },
              {
                "type": "li",
                "text": "List Item 2"
              }
            ]
          }
        ]
      }
    ]
  }

  const jsonToHtml = (json) => {
    let element = null;
    if (json.type === 'html') {
      element = document.createElement('html');
      element.innerHTML = json.children.map(child => jsonToHtml(child)).join('');
    } else if (json.type === 'head' || json.type === 'body') {
      element = document.createElement(json.type);
      element.innerHTML = json.children.map(child => jsonToHtml(child)).join('');
    } else if (json.type === 'title') {
      element = document.createElement('title');
      element.textContent = json.text;
    } else {
      element = document.createElement(json.type);
      if (json.text) {
        element.textContent = json.text;
      }
      if (json.children) {
        element.innerHTML = json.children.map(child => jsonToHtml(child)).join('');
      }
    }
    return element;
  };
  
  const pageJson = {
    // ... JSON object from above ...
  };
  
  const htmlElement = jsonToHtml(pageJson);
  document.body.appendChild(htmlElement);