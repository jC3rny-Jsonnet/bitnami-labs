// These are the defaults for this components configuration.
// When calling the function to generate the component's manifest,
// you can pass an object structured like the default to overwrite default values.
{
  local defaults = self,
  disableNameSuffixHash: true,
  name: error 'must provide name',
  nameSuffix: 'sealed',
  namespace: error 'must provide namespace',
  // https://github.com/bitnami-labs/sealed-secrets#scopes
  // These are the possible scopes:
  //  - strict (default): the secret must be sealed with exactly the same name and namespace. These attributes become part of the encrypted data and thus changing name and/or namespace would lead to "decryption error".
  //  - namespace-wide: you can freely rename the sealed secret within a given namespace.
  //  - cluster-wide: the secret can be unsealed in any namespace and can be given any name.
  scope: '', 
  type: 'Opaque',
  encryptedData: error 'must provide encryptedData',
  commonAnnotations:: {},
  commonLabels:: {},
}
