# Cilium Gateway API: GatewayClass stuck in "Waiting for controller"

## Symptoms

- `GatewayClass cilium` and `Gateway` show `Accepted/Programmed = Unknown`, reason `Pending`, message `Waiting for controller`
- Condition timestamps are `1970-01-01T00:00:00Z`
- No `cilium-gateway-*` Service is created, so BGP has nothing to advertise
- Cilium operator logs contain:
  `Required GatewayAPI resources are not found, please refer to docs for installation instructions`

## Cause

Cilium is installed by Talos at bootstrap, before Flux applies the Gateway API CRDs.
The Cilium operator checks for the CRDs **only once at startup**. If they are missing
at that moment, the Gateway controller is never registered, and it does not retry
after the CRDs appear later.

## Fix

```bash
kubectl -n kube-system rollout restart deploy/cilium-operator
kubectl -n kube-system rollout status deploy/cilium-operator
```

Verify:

```bash
kubectl get gatewayclass cilium          # ACCEPTED = True
kubectl -n network get gateway gateway   # PROGRAMMED = True
kubectl -n network get svc | grep cilium-gateway
```

## Prevention

Make sure the Gateway API CRDs exist before the Cilium operator starts. Options:

1. Include the CRDs in the Talos machine config