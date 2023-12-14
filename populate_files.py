from faker import Faker

# Crie um objeto Faker
fake = Faker('pt_BR')

# Defina o idioma para garantir nomes de cidades e endereços coerentes
fake.locale = 'pt_BR'

# Função para gerar dados fictícios de restaurante
def generate_restaurant_data():
    restaurant_id = fake.uuid4()[:8]
    restaurant_name = fake.company()
    restaurant_address = fake.address()
    restaurant_city = fake.city()

    return {
        'id': restaurant_id,
        'nome': restaurant_name,
        'endereço': restaurant_address,
        'cidade': restaurant_city
    }

def generate_client_data():
    client_id = fake.uuid4()[:8]
    client_name = fake.name()
    client_address = fake.address()
    client_city = fake.city()
    client_email = fake.email()
    client_telefone = fake.phone_number()

    return {
        'id': client_id,
        'nome': client_name,
        'endereço': client_address,
        'cidade': client_city,
        'email': client_email,
        'telefone': client_telefone
    }

def generate_pedido_data():
    pedido_numero = fake.uuid4()[:8]
    pedido_data = fake.date()
    pedido_hora = fake.time()
    pedido_status = fake.random_element(elements=('Pendente', 'Em preparo', 'Saiu para entrega', 'Entregue'))

    return {
        'numero': pedido_numero,
        'data': pedido_data,
        'hora': pedido_hora,
        'status': pedido_status
    }

def generate_produto_data():
    produto_id = fake.uuid4()[:8]
    produto_nome = fake.name()
    produto_preco = fake.random_element(elements=(10, 15, 20, 25, 30, 35, 40, 45, 50))

    return {
        'id': produto_id,
        'nome': produto_nome,
        'preco': produto_preco
    }

# Gere dados fictícios para 5 restaurantes
for _ in range(5):
    restaurant_data = generate_restaurant_data()
    client_data = generate_client_data()
    pedido_data = generate_pedido_data()
    produto_data = generate_produto_data()

print(restaurant_data, client_data, pedido_data, produto_data)
