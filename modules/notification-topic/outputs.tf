output "topic_id" {
  value       = oci_ons_notification_topic.topic_service.id
  description = "The OCID of the topic created"
}

output "subscription_id" {
  description = "The subscriptions, indexed by ID."
  value       = { for sub in oci_ons_subscription.subscription_service : sub.id => sub }
}
