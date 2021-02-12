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

```
Example usage:
es-query GET _cat/indices?pretty
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
