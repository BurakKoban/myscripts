import hvac

client = hvac.Client(url='https://vault.ops.bcaa.bc.ca', token="hvs.AREj5T4Xmhg7Zc2pwRESrsML")
print(client.is_authenticated())
read_response = client.secrets.kv.read_secret_version(path='secret')

print(read_response['data']['data']['abc'])

