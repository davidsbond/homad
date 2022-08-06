resource "consul_key_prefix" "minio" {
  path_prefix = "homad/minio/"
  subkeys = {
    MINIO_BROWSER              = "on"
    MINIO_DOMAIN               = "api.minio.homelab.dsb.dev,ui.minio.homelab.dsb.dev"
    MINIO_BROWSER_REDIRECT_URL = "https://ui.minio.homelab.dsb.dev"
    MINIO_SITE_REGION          = "homelab"
    MINIO_SITE_NAME            = "homelab"
    MINIO_PROMETHEUS_AUTH_TYPE = "public"
  }
}
