resource "google_service_account" "compute_engine" {
  account_id = "${local.game_name}-${local.environment}-${local.region}-gce-svc"
  display_name = "Service Account"
}