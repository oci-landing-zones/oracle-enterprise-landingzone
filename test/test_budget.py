from pytest_terraform import terraform
import pytest

# unit tests for budget module
@pytest.mark.unit
@terraform("budget", scope="session")
def test_oci_budget_target_name(budget):
    print(budget)
    actual_budget_target_name = budget["oci_budget_budget.oci_budget.display_name"]
    expected_budget_target_name = "OCI-ELZ-BGT-T"
    assert actual_budget_target_name == expected_budget_target_name


@pytest.mark.unit
@terraform("budget", scope="session")
def test_oci_budget_amount(budget):
    actual_budget_amount = budget["oci_budget_budget.oci_budget.amount"]
    expected_budget_amount = 100000
    assert actual_budget_amount == expected_budget_amount


@pytest.mark.unit
@terraform("budget", scope="session")
def test_oci_budget_alert_rule_threshold(budget):
    actual_budget_alert_rule_threshold = budget["oci_budget_alert_rule.oci_budget_rule.threshold"]
    expected_budget_alert_rule_threshold = 100
    assert actual_budget_alert_rule_threshold == expected_budget_alert_rule_threshold


@pytest.mark.unit
@terraform("budget", scope="session")
def test_oci_budget_alert_rule_recipients(budget):
    actual_budget_alert_rule_recipients = budget["oci_budget_alert_rule.oci_budget_rule.recipients"]
    expected_budget_alert_rule_recipients = "example@example.com"
    assert actual_budget_alert_rule_recipients == expected_budget_alert_rule_recipients
