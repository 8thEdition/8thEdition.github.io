import './css/all.css';
import {SwaggerUIBundle, SwaggerUIStandalonePreset} from 'swagger-ui-dist';

import $ from 'jquery';

var urls = [];

$.getJSON("config.json", function(api_docs) {
    for( var i = 0; i < api_docs.length; i++ ) {
        var api_doc = api_docs[i]
        urls.push({
            "name": api_doc["category"],
            "url": `dist/api_docs/${api_doc["file_name"]}`
        });
    }
    const ui = SwaggerUIBundle({
      urls: urls,
      dom_id: '#swagger-ui',
      deepLinking: true,
      presets: [
        SwaggerUIBundle.presets.apis,
        SwaggerUIStandalonePreset
      ],
      plugins: [
        SwaggerUIBundle.plugins.DownloadUrl
      ],
      layout: "StandaloneLayout"
    })
    window.ui = ui
});

