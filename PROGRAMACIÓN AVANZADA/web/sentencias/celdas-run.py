from flask import Flask, render_template, request, jsonify
import pandas as pd
import matplotlib.pyplot as plt
import io
import base64

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('sentencias.html')

@app.route('/run_cell', methods=['POST'])
def run_cell():
    data = {
        'A': [1, 2, 3, 4],
        'B': [10, 20, 30, 40]
    }
    df = pd.DataFrame(data)
    
    # Generar un gráfico
    img = io.BytesIO()
    plt.figure()
    df.plot(kind='bar')
    plt.savefig(img, format='png')
    img.seek(0)
    plot_url = base64.b64encode(img.getvalue()).decode()
    
    return jsonify({'plot_url': plot_url})

if __name__ == '__main__':
    app.run(debug=True)
