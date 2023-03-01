## Summary
Terraform module for OCI Announcement Subscription.
Configure announcement subscriptions to receive important information about service status.

## Dependencies
* notification-topic

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_oci"></a> [oci](#provider\_oci) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [oci_announcements_service_announcement_subscription.announcement_subscription](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/announcements_service_announcement_subscription) | resource |
| [oci_announcements_service_announcement_subscriptions_filter_group.announcement_subscriptions_filter_group](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/announcements_service_announcement_subscriptions_filter_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_compartment_id"></a> [compartment\_id](#input\_compartment\_id) | The OCID of the compartment where you want to create the announcement subscription | `string` | n/a | yes |
| <a name="input_filter_groups"></a> [filter\_groups](#input\_filter\_groups) | A list of filter groups for the announcement subscription. | `map(any)` | n/a | yes |
| <a name="input_notification_topic_id"></a> [notification\_topic\_id](#input\_notification\_topic\_id) | The OCID of the Notifications service topic | `string` | n/a | yes |
| <a name="input_subscription_display_name"></a> [subscription\_display\_name](#input\_subscription\_display\_name) | The display name of the subscription | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->    