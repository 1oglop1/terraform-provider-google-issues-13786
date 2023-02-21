# steps to repoduce

1. Create 2 secrets in secret manager (`secret1` and `secret2`)
2. export environment variable `GOOGLE_PROJECT=<your project>`
3. `terraform init`
4. `terraform apply` - observe everything works as expected
5. edit `main.tf` Lines 23 and 28 and change `local.secret_id_1` -> `local.secret_id_2`
6. `terraform apply` and observer error
```
Error waiting for Updating Job: Error code 13, message: spec.template.spec.volumes[0].secret.items[0].key: Permission denied on secret: projects/123345678/secrets/secret2/versions/latest for Revision service account cloudrun-job-talented-boar@gcp-project-257509.iam.gserviceaccount.com. The service account used must be granted the 'Secret Manager Secret Accessor' role (roles/secretmanager.secretAccessor) at the secret, project or higher level.
```