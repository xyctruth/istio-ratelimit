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

## Rate limits configuration:

`values.yaml`

```yaml
configuration:
  - name: test_api
    hosts:
      - test.api.jia-huang.com:80
      - test.api.jia-huang.com:443
    rules:
      - path: /
        total:
          limit_unit: second
          limit_requests: 100
        token:
          header_name: "x-token-1"
          limit_unit: second
          limit_requests: 20
        ip:
          limit_unit: second
          limit_requests: 20
      - path: /f007dev/admin-gateway/pay/error_mapping/
        token:
          limit_unit: minute
          limit_requests: 3
```