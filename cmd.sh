#!/usr/bin/env bash

CMD=${1}

if [ "$CMD" == "gen-openapi-spec" ]; then
  api_docs=($(jq -r -n "inputs[].file_name" config.json))
  input_folder=api_docs
  output_folder=dist/api_docs

  for api_doc in "${api_docs[@]}";
  do
    output_file=${output_folder}/${api_doc}
    mkdir -p ${output_folder}
    swagger-merger -i ${input_folder}/$api_doc -o ${output_file}
    echo ${output_file} is generated
  done
elif [ "$CMD" == "create-new-category" ]; then
    while [[ $# -gt 1 ]]; do
      case $2 in
        -c|--category)
          category="$3"
          shift # past argument
          shift # past value
          ;;
        -*|--*)
          echo "Unknown option $3"
          exit 1
          ;;
      esac
    done

    doc_utils=api_docs/${category}/
    doc_file_name=${category}.yaml
    doc_file=api_docs/${doc_file_name}
    if [[ -d ${doc_utils} ]]; then
      echo "${doc_utils} already exists"
    else
      mkdir ${doc_utils}
      cp api_docs/example/* ${doc_utils}
    fi

    if [[ -f ${doc_file} ]]; then
      echo "${doc_file} already exists"
    else
      cp api_docs/example.yaml ${doc_file}
    fi
    jq -r  --arg category ${category} --arg file_name ${doc_file_name} '. += [{"category": $category, "file_name": $file_name}]' config.json > config.json.tmp
    mv config.json.tmp config.json
else
    echo "Invalid command"
    exit 1
fi