import os
import psycopg2
from flask import Flask

app = Flask(__name__)

# Configuração do banco de dados usando variáveis de ambiente
DB_HOST = os.getenv("DB_HOST", "db")
DB_NAME = os.getenv("DB_NAME", "meu_banco")
DB_USER = os.getenv("DB_USER", "postgres")
DB_PASSWORD = os.getenv("DB_PASSWORD", "postgres")

# Conectar ao banco de dados PostgreSQL
def get_db_connection():
    conn = psycopg2.connect(
        host=DB_HOST,
        database=DB_NAME,
        user=DB_USER,
        password=DB_PASSWORD
    )
    return conn

# Criar tabela caso ainda não exista
def create_table():
    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute("""
        CREATE TABLE IF NOT EXISTS usuarios (
            id SERIAL PRIMARY KEY,
            nome TEXT NOT NULL
        )
    """)
    conn.commit()
    cur.close()
    conn.close()

# Rota para inserir um usuário no banco de dados
@app.route("/add/<nome>")
def add_user(nome):
    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute("INSERT INTO usuarios (nome) VALUES (%s)", (nome,))
    conn.commit()
    cur.close()
    conn.close()
    return f"Usuário {nome} adicionado com sucesso!"

# Rota para listar usuários
@app.route("/users")
def list_users():
    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute("SELECT * FROM usuarios")
    users = cur.fetchall()
    cur.close()
    conn.close()
    return {"usuarios": users}

@app.route("/")
def home():
    return "Aplicação Flask conectada ao PostgreSQL!"

if __name__ == "__main__":
    create_table()  # Criar tabela ao iniciar a aplicação
    app.run(host="0.0.0.0", port=5000)