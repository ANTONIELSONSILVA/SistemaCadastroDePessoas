from flask import Flask, request, jsonify
import requests

app = Flask(__name__)

# Rota para consulta de CEP
@app.route('/consulta-cep', methods=['GET'])
def consulta_cep():
    # Recebe o CEP da requisição
    cep = request.args.get('cep')
    if not cep:
        return jsonify({'error': 'CEP não informado'}), 400
    
    # Consulta a API externa (ViaCEP)
    url = f'https://viacep.com.br/ws/{cep}/json/'
    response = requests.get(url)

    if response.status_code != 200:
        return jsonify({'error': 'Erro ao consultar API externa'}), 500

    # Retorna o resultado para o cliente
    return jsonify(response.json())

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
