terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
    }
  }
}

resource "oci_announcements_service_announcement_subscription" "announcement_subscription" {
  compartment_id = var.compartment_id
  display_name   = var.subscription_display_name
  ons_topic_id   = var.notification_topic_id
}

resource "oci_announcements_service_announcement_subscriptions_filter_group" "announcement_subscriptions_filter_group" {
  for_each                     = var.filter_groups
  announcement_subscription_id = oci_announcements_service_announcement_subscription.announcement_subscription.id
  name                         = each.key
  dynamic "filters" {
    for_each = toset(each.value.filters_value)
    content {
      type  = each.value.filters_type
      value = filters.key
    }
  }
}
