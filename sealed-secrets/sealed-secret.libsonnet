local defaults = import 'sealed-secrets/sealed-secret-default-params.libsonnet';

function(params) {
  local ss = self,

  // Combine the defaults and the passed params to make the component's config.
  config:: defaults + params,

  // Safety checks for combined config of defaults and params
  assert std.isString(ss.config.type),
  assert std.isObject(ss.config.encryptedData),

  sealedSecret: {
    apiVersion: 'bitnami.com/v1alpha1',
    kind: 'SealedSecret',
    metadata: {
      annotations: ss.commonAnnotations,
      labels: ss.config.commonLabels,
      name:
        if !ss.config.disableNameSuffixHash then
          '%s-%s-%s' % [ss.config.name, ss.config.nameSuffix, ss.config.nameSuffixHash]
        else
          '%s-%s' % [ss.config.name, ss.config.nameSuffix],
      namespace: ss.config.namespace,
    },
    spec: {
      encryptedData: ss.config.encryptedData,
      template: {
        metadata: {
          annotations: ss.commonAnnotations + {
            'sealedsecrets.bitnami.com/managed': 'true',
          },
          labels: ss.config.commonLabels,
        },
        type: ss.config.type
      },
    },
  },

  commonAnnotations:: ss.config.commonAnnotations + { [if std.length(ss.config.scope) > 0 then 'sealedsecrets.bitnami.com/' + ss.config.scope]: 'true', }
}
