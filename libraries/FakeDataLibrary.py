"""Biblioteca Robot Framework para gerar dados de teste fictícios com Faker.

Todos os dados retornados (nomes, e-mails, CPFs, telefones) são gerados
aleatoriamente a cada execução — nenhum dado real é utilizado neste projeto.
"""
from faker import Faker
from robot.api.deco import keyword, library

fake = Faker("pt_BR")


@library(scope="GLOBAL")
class FakeDataLibrary:

    @keyword("Gerar Nome Fake")
    def gerar_nome_fake(self):
        return fake.name()

    @keyword("Gerar Email Fake")
    def gerar_email_fake(self):
        return fake.unique.email()

    @keyword("Gerar Cpf Fake")
    def gerar_cpf_fake(self):
        return fake.cpf()

    @keyword("Gerar Telefone Fake")
    def gerar_telefone_fake(self):
        return fake.phone_number()
