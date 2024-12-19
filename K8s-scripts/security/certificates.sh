cat /etc/kubernetes/manifests/kube-apiserver.yaml

# To see the cetificate

openssl x509 -in /etc/kubernetes/pki/apiserver.crt -text -noout

# To generate a certificate for a new user

openssl genrsa -out user.key 2048 # User key
openssl req -new -key user.key -out user.csr -subj "/CN=user/O=system:masters" # Admin gets the key and creates a CSR

kubectl get csr # To see the DSR requests

kubectl certificate approve user # To approve the certificate
kubectl certificate deny user # To deny the certificate

# To View the certificate

kubectl get csr jane -o yaml

openssl x509 -req -in user.csr -CA /etc/kubernetes/pki/ca.crt -CAkey /etc/kubernetes/pki/ca.key -CAcreateserial -out user.crt -days 500


---

apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: user-csr
spec:
  request: <base64-encoded-csr>
  signerName: kubernetes.io/kubelet-apiserver-client
  usages:
  - digital signature
  - key encipherment
  - client auth