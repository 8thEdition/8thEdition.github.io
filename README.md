# Prerequisite
```
brew install npm
brew install jq
```

## How to Build Swagger UI
```
npm install
npm run build
```

## How to Generate OpenAPI Spec
```
npm run gen
```

# How to Start Local Server for API Doc
```
npm run server
# url: http://127.0.0.1:8001/index.html
```


## How to Add New API Category
1. Create new openAPI spec template
    ```
    ./cmd.sh create-new-category -c $category
    ```
3. modify api_docs/$category.yaml and api_docs/$category/*
