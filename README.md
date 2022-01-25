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
  - name: group1
    hosts:
      - test.api.jia-huang.com:80
      - test.api.jia-huang.com:443
    rules:
      - path: /
        total:
          limit_unit: second
          limit_requests: 100
        token:
          header_name: "token"
          limit_unit: second
          limit_requests: 20
        ip:
          limit_unit: second
          limit_requests: 20
      - path: /f007dev/admin-gateway/pay/error_mapping/
        token:
          limit_unit: minute
          limit_requests: 3

ratelimit:
  image:
    repository: envoyproxy/ratelimit
    pullPolicy: IfNotPresent
    # Overrides the image tag whose default is the chart appVersion.
    tag: "4d2efd61"
  replicaCount: 1
  imagePullSecrets: []
  nameOverride: ""
  fullnameOverride: ""

  podAnnotations: {}

  podSecurityContext: {}
  # fsGroup: 2000

  securityContext: {}
    # capabilities:
    #   drop:
    #   - ALL
    # readOnlyRootFilesystem: true
    # runAsNonRoot: true
  # runAsUser: 1000

  resources: {}
    # We usually recommend not to specify default resources and to leave this as a conscious
    # choice for the user. This also increases chances charts run on environments with little
    # resources, such as Minikube. If you do want to specify resources, uncomment the following
    # lines, adjust them as necessary, and remove the curly braces after 'resources:'.
    # limits:
    #   cpu: 100m
    #   memory: 128Mi
    # requests:
    #   cpu: 100m
  #   memory: 128Mi

  autoscaling:
    enabled: false
    minReplicas: 1
    maxReplicas: 100
    targetCPUUtilizationPercentage: 80
    # targetMemoryUtilizationPercentage: 80

  nodeSelector: {}

  tolerations: []

  affinity: {}

redis:
  install: true
  usePassword: true
  password: UZ23jFR3N7
  cluster:
    enabled: false
  metrics:
    enabled: false
  master:
    persistence:
      enabled: false
```