import greeting

def test_default_greeting():
    "Test greeting"
    expected_salutation = "Hello"
    name = "Tim"
    address = greeting.get_greeting(name,"English")
    assert address == expected_salutation+name

def test_german_greeting():
    "Test german greeting"
    expected_salutation = "Servus"
    name = "Tim"
    address = greeting.get_greeting(name,"German")
    assert address == expected_salutation+name
