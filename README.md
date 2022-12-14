# es-query

CLI tool to search, post, put and delete data on elasticsearch clusters.

## Description

Bash script based on curl and jquery to easy query elasticsearch cluster from the command line.

I'd would be nice to be as powerful as kibana dev-tools, but at the moment is just a bash script.

## Requirements

* bash
* curl
* jquery

## Install

* Download the repository
* run `bash install.sh`

This will install `es-query` executable on `~/bin` in your HOME directory.

It will create a `.es-query` directory in your HOME directory with two files

* .env (environment variables for elasticsearch HOST, USER and PASSWORD)
* es-query_bash_completion (bash completion for es-query)
  
### .env file

```
USERNAME="elastic"
PASSWORD="changeme"
URL="localhost:9200"
```

## Usage
### Basic example usage:

```
es-query GET _cat/indices?pretty
```

### Basic search

	es-query get metricbeat*/_search

### Search from json file
	
	es-query get metricbeat*/_search file.json

You can use a json file with a search or aggregation

```
{
  "size": 0,
  "aggs": {
    "nodes": {
      "terms": {
        "field": "agent.hostname",
        "size": 100
      }
    }
  }
}
```

This results as follows

```
✔ ~/GitHub/es-query [main ↑·1|…2]
12:58 $ ./es-query GET metricbeat*/_search test.json
{
  "took": 27,
  "timed_out": false,
  "_shards": {
    "total": 1,
    "successful": 1,
    "skipped": 0,
    "failed": 0
  },
  "hits": {
    "total": {
      "value": 10000,
      "relation": "gte"
    },
    "max_score": null,
    "hits": []
  },
  "aggregations": {
    "nodos": {
      "doc_count_error_upper_bound": 0,
      "sum_other_doc_count": 0,
      "buckets": [
        {
          "key": "rig1",
          "doc_count": 136930
        }
      ]
    }
  }
}
```

### PUT option

You can use PUT with data coming from a file as follows: 

```
$ cat cluster-settings.json
{
  "persistent": {
    "cluster.routing.allocation.enable": null
  }
}
```

```
./es-query PUT _cluster/settings cluster-settings.json
```

## Options

* GET
* PUT
* POST
* DELETE

## Status

All commands work

## TODO

* add option to use json file with search query inside  ✅
* add autocompletion (In progress) ❌
* Implement es-query like https://github.com/asciimoo/wuzz ❌