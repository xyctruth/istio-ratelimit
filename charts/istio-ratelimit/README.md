# istio-ratelimit

## Usage

[Helm](https://helm.sh) must be installed to use the charts.  Please refer to
Helm's [documentation](https://helm.sh/docs) to get started.

Once Helm has been set up correctly, add the repo as follows:

    helm repo add xyctruth https://xyctruth.github.io/istio-ratelimit

If you had already added this repo earlier, run `helm repo update` to retrieve
the latest versions of the packages.  You can then run `helm search repo
xyctruth` to see the charts.

To install the <chart-name> chart:

    helm install my-istio-ratelimit xyctruth/istio-ratelimit

To uninstall the chart:

    helm delete my-istio-ratelimit

## Rate limits policies:

The policies should be configured in `values.yaml`

| Key            | Type   | Description                                                                                                                                                  | 
|----------------|--------|--------------------------------------------------------------------------------------------------------------------------------------------------------------|
| key            | string | Policy Unique Identifier                                                                                                                                     |
| hosts          | array  | Matches the istio gateway host， Need to use port to distinguish between http and https ,(api.xyctruth.com:80,api.xyctruth.com:443).                          |
| path           | array  | Each path object has a separate flow limit count                                                                                                             |
| paths.type     | string | Matches the type of path  One of: (`prefix_match`,`contains_match`)                                                                                          |
| paths.value    | string | Matches the value                                                                                                                                            |
| limit_unit     | string | Rate limit unit , One of: (`second`,`minute`,`hour`,`day`)                                                                                                   |
| limit_requests | int    | Rate limit request count                                                                                                                                     |
| strategy       | array  | Further set rate limit strategy                                                                                                                              |
| strategy.type  | string | Further rate limit strategy type， One of: (`header`,`ip`) , <br/>`header`: Header Matches the Request Header  ,<br/>`ip`: Ip   Matches the Request Remote IP |

### Example 1

```yaml
policies:
  - key: group1
    hosts:
      - test.api.xyctruth.com:80
      - test.api.xyctruth.com:443
    paths:
      - type: prefix_match
        value: /
    limit_unit: second
    limit_requests: 100
    strategy:
      - type: ip
        limit_unit: second
        limit_requests: 50
      - type: header
        value: "x-token"
        limit_unit: second
        limit_requests: 10


  - key: group2
    hosts:
      - test.api.xyctruth.com:80
    paths:
      - type: contains_match
        value: /pay/error_mapping
      - type: contains_match
        value: /pay/method
    limit_unit: second
    limit_requests: 100
    strategy:
      - type: ip
        limit_unit: second
        limit_requests: 50
      - type: header
        value: "x-token"
        limit_unit: minute
        limit_requests: 5
```