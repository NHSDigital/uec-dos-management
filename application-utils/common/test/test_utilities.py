from common import utilities


def test_default_salutation():
    "Test salutation"
    expected_salutation = "Hello"
    actual_salutation = utilities.get_salutation("English")
    assert actual_salutation == expected_salutation


def test_german_salutation():
    "Test salutation"
    expected_salutation = "Servus"
    actual_salutation = utilities.get_salutation("German")
    assert actual_salutation == expected_salutation
