# lav4.sh

lav4.sh is a simple wrapper around the Linode APIv4 that includes basic
endpoint completion.

## Installation

* Install bash or zsh
* Add lav4.sh to your PATH
* Add your personal access token to ~/.lav4

For shell completion:
* Use bash or zsh
* Install jq
* Add 'source ./completion.sh' to your ~/.profile

## Example:

```
$ lav4.sh /datacenters | jq
{
  "total_results": 1,
  "datacenters": [
    {
      "id": "newark",
      "country": "us",
      "label": "Newark, NJ"
    }
  ],
  "page": 1,
  "total_pages": 1
}
```

You can use tab completion to autocomplete basic endpoints by typing / and then
hitting tab.