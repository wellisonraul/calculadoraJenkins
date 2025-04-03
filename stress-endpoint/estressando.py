import requests
import time
import threading

URL = "http://localhost:8090/ping"
REQUESTS_PER_SECOND = 10  # Ajuste para gerar mais carga
DURATION = 30  # Tempo total do teste em segundos

def stress_endpoint():
    start_time = time.time()
    while time.time() - start_time < DURATION:
        try:
            response = requests.get(URL)
            print(f"Status Code: {response.status_code}")
        except requests.exceptions.RequestException as e:
            print(f"Erro ao acessar {URL}: {e}")
        time.sleep(1 / REQUESTS_PER_SECOND)  # Controla a taxa de requisições

# Rodar múltiplas threads para aumentar a carga
NUM_THREADS = 5  # Ajuste para gerar mais carga simultânea
threads = []

for _ in range(NUM_THREADS):
    thread = threading.Thread(target=stress_endpoint)
    thread.start()
    threads.append(thread)

for thread in threads:
    thread.join()

print("Teste de estresse finalizado!")
