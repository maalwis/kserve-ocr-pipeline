# Helm Chart Deployment Cheat Sheet

## Install Release

### api-gateway
```bash
helm install my-api-gateway ./api-gateway
```

### ocr-model
```bash
helm install my-ocr ./ocr-model
```

**Note:** Helm installs chart as a "release" in your cluster.

## Install with Overrides

### Set replicas & image tag
```bash
helm install my-api-gateway ./api-gateway \
  --set replicaCount=2,image.tag=2.1
```

### Enable NodePort for ocr-model
```bash
helm install my-ocr ./ocr-model \
  --set service.type=NodePort
```

**Note:** `--set` applies overrides on top of `values.yaml`.

## Upgrade Release

### api-gateway (tag bump)
```bash
helm upgrade my-api-gateway ./api-gateway \
  --set image.tag=2.1
```

### ocr-model (resize + tag bump)
```bash
helm upgrade my-ocr ./ocr-model \
  --set replicaCount=2,image.tag=2.1
```

**Note:** `helm upgrade` updates live resources; handles rollout strategy.

## Recommended Alert

Consider using:
```bash
helm upgrade --install ... --atomic
```

**Note:** Ensures release is installed if missing, or upgraded cleanly with rollback on failure.

## Uninstall Release

### api-gateway
```bash
helm uninstall my-api-gateway
```

### ocr-model
```bash
helm uninstall my-ocr
```

**Note:** Removes everything created by Helm; equivalent to `helm delete`.

## Undo Mistake?

### Rollback to previous
```bash
helm rollback <release> [revision]
```

**Note:** Quick revert if upgrade misbehaves (built-in versioning).

## Check Status & Resources

### View release info
```bash
helm status my-api-gateway
```

### List all releases
```bash
helm list
```

### See deployed values
```bash
helm get values my-ocr
```
