# es-query

CLI tool to search, post, put and delete data on elasticsearch clusters.

## Descrption

Bash script based on curl and jquery to easy query elasticsearch cluster from the command line.

I'd would be nice to be as powerfull as kibana dev-tools, but at the moment is just a bash script.

## Requirements

* bash
* curl
* jquery

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
    "nodos": {
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

## Options

* GET
* PUT
* POST
* DELETE

## Status

At the moment, only GET option works but without arguments.

## TODO

* add option to use json file with search query inside
* add autocompletion
