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
| [oci_monitoring_alarm.monitoring_alarm](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/monitoring_alarm) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alarm_map"></a> [alarm\_map](#input\_alarm\_map) | display name: the display name for alarm;<br>    metric compartment id: the OCID of the compartment containing the metric being evaluated by the alarm<br>    namespace: the source service or application emitting the metric that is evaluated by the alarm<br>    query: the Monitoring Query Language (MQL) expression to evaluate for the alarm<br>    severity: the perceived type of response required when the alarm is in the "FIRING" state | <pre>map(object({<br>    display_name          = string,<br>    metric_compartment_id = string,<br>    namespace             = string,<br>    query                 = string,<br>    severity              = string,<br>  }))</pre> | n/a | yes |
| <a name="input_compartment_id"></a> [compartment\_id](#input\_compartment\_id) | The OCID of the compartment containing the alarm. | `string` | `""` | no |
| <a name="input_is_enabled"></a> [is\_enabled](#input\_is\_enabled) | Alarms enabled or disabled. | `bool` | `false` | no |
| <a name="input_message_format"></a> [message\_format](#input\_message\_format) | format of alarm message | `string` | `"ONS_OPTIMIZED"` | no |
| <a name="input_metric_compartment_id_in_subtree"></a> [metric\_compartment\_id\_in\_subtree](#input\_metric\_compartment\_id\_in\_subtree) | Only needed if metric\_compartment\_id = <tenancy OCID> | `bool` | `false` | no |
| <a name="input_notification_topic_id"></a> [notification\_topic\_id](#input\_notification\_topic\_id) | the OCID of notification topic. | `string` | n/a | yes |
| <a name="input_pending_duration"></a> [pending\_duration](#input\_pending\_duration) | The period of time that the condition defined in the alarm must persist before the alarm state changes from 'OK' to 'FIRING'. | `string` | `"PT5M"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->