Writes every new Kubernetes Event as a JSON line to stdout. The vlagent of victoria-metrics-k8s-stack
collects it like any other container log, so Events end up in VictoriaLogs and outlive the ~1h
retention of the API server.

Query examples (the Events are in the `kubernetes-event-exporter` namespace, the Event fields are
flattened JSON keys, `_msg` is the Event message):

    kubernetes.pod_namespace:=kubernetes-event-exporter reason:=FailedScheduling
    kubernetes.pod_namespace:=kubernetes-event-exporter involvedObject.name:~"backup-nfs" | sort by (_time)
    kubernetes.pod_namespace:=kubernetes-event-exporter type:=Warning

Notes:
- Only newly created Events are exported, later updates of an Event (its `count` going up) are ignored.
- Events older than 60s are skipped on start, nothing is backfilled.
- To keep only warnings, add `type: Warning` to the `match` entry in `config.yaml`.
- The image is not maintained very actively upstream, pin the tag and check for updates now and then.
