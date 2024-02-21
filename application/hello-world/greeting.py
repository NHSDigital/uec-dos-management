from common import utilities


def get_greeting(name, language):
    salutation = utilities.get_salutation(language)
    return salutation + name
