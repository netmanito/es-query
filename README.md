# ES-Query

ES-Query or `esq` is a CLI tool to communicate with Elasticsearch using CURL.
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

This will install `esq` executable on `~/bin` in your HOME directory.

It will create a `.es-query` directory in your HOME directory with the following files

* .env.default (environment variables for elasticsearch HOST, USER and PASSWORD)
* .env (symbolic link to .env.default)
* es-query_bash_completion (bash completion for es-query)
  
### .env file

```
USERNAME="elastic"
PASSWORD="changeme"
URL="localhost:9200"
```

## Usage

```
$ esq [option] [query]
```

The following options are available.
## Options

* GET -> Get request to Elastic 
* PUT -> Put request to Elastic
* POST -> Post request to Elastic
* DELETE -> Delete request to Elastic
* ENV -> set|change environment variable
  
### Basic example usage:

```
esq GET _cat/indices?pretty
```

### Basic search

	esq get metricbeat*/_search

### Search from json file
	
	esq get metricbeat*/_search file.json

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
$ esq GET metricbeat*/_search test.json
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
$ esq PUT _cluster/settings cluster-settings.json
```

### Change connection settings

You can have more than one .env.file in your ~/.es-query directory and change by

The value needs to match the ending file name in format of `.env.value` . The `.env` file used is a symlink and can be updated at any time with

```
$ esq env mon
```

Executing `esq` will remove the existing symlink and create a new one based on the given name

```
0 lrwxr-xr-x   1 user  staff    30B Dec 15 16:29 .env -> /Users/user/.es-query/.env.mon
8 -rw-r--r--   1 user  staff    60B Dec 15 16:10 .env.default
8 -rw-r--r--   1 user  staff    76B Dec 15 16:09 .env.mon
```

## Status

All commands work

## TODO

* add option to use json file with search query inside  ✅
* multi environment support ✅
* add autocompletion (In progress) ❌
* Can autocomplete be as good as Kibana dev-tools? ❌
* Implement es-query with similarities to https://github.com/asciimoo/wuzz ? 🔨