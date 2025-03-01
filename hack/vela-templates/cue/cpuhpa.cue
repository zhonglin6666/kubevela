outputs: cpuhpa: {
	apiVersion: "autoscaling/v2beta2"
	kind:       "HorizontalPodAutoscaler"
	metadata: name: context.name
	spec: {
		scaleTargetRef: {
			apiVersion: "apps/v1"
			kind:       "Deployment"
			name:       context.name
		}
		minReplicas: parameter.min
		maxReplicas: parameter.max
		metrics: [{
			type: "Resource"
			resource: {
				name: "cpu"
				target: {
					type:               "Utilization"
					averageUtilization: parameter.cpuUtil
				}
			}
		}]
	}
}
parameter: {
	min:     *1 | int
	max:     *10 | int
	cpuUtil: *50 | int
}
