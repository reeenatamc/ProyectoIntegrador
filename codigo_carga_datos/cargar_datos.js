const mysql = require('mysql');
const fs = require('fs');
const csv = require('csv-parser');

const connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: 'UTPL2023',
  database: 'pi_db'
});

connection.connect((err) => {
  if (err) {
    console.error('Error conectando a la base de datos:', err);
    return;
  }
  console.log('Conectado a la base de datos MySQL');
});

function validarYConvertirHora(hora) {
  const regexHora = /^([0-1]?[0-9]|2[0-3]):([0-5][0-9]):([0-5][0-9])$/;
  if (regexHora.test(hora)) {
    return hora;
  } else {
    const partes = hora.split(':');
    if (partes.length === 3) {
      const horas = parseInt(partes[0], 10);
      const minutos = parseInt(partes[1], 10);
      const segundos = parseInt(partes[2], 10);
      if (!isNaN(horas) && !isNaN(minutos) && !isNaN(segundos)) {
        const horasValidas = Math.min(Math.max(horas, 0), 23);
        const minutosValidos = Math.min(Math.max(minutos, 0), 59);
        const segundosValidos = Math.min(Math.max(segundos, 0), 59);
        return `${horasValidas.toString().padStart(2, '0')}:${minutosValidos.toString().padStart(2, '0')}:${segundosValidos.toString().padStart(2, '0')}`;
      }
    }
    return '00:00:00';
  }
}

function subirDatosDesdeCSV(rutaCSV) {
  const resultados = [];
  
  fs.createReadStream(rutaCSV)
    .pipe(csv())
    .on('data', (data) => {
      const filaSeleccionada = {
        fecha_detencion: data.fecha_detencion_aprehension || 'SIN DATO',
        hora_detencion: validarYConvertirHora(data.hora_detencion_aprehension) || 'SIN DATO',
        tipo: data.tipo || 'SIN DATO',
        condicion: data.condicion || 'SIN DATO',
        movilizacion: data.movilizacion || 'SIN DATO',
        presunta_flagrancia: data.presunta_flagrancia || 'SIN DATO',
        presunta_modalidad: data.presunta_modalidad || 'SIN DATO',
        flagrante_boleta: 'SIN DATO',
        lugar: data.lugar || 'SIN DATO',
        tipo_lugar: data.tipo_lugar || 'SIN DATO',
        infraccion: data.presunta_infraccion || 'SIN DATO',
        subinfraccion: data.presunta_subinfraccion || 'SIN DATO',
        anio: new Date(data.fecha_detencion_aprehension).getFullYear(),
        Detenido_id: resultados.length + 1,
        arma_id_arma: data.nac || 1,
        Subcircuito_id_subcircuito: data.codigo_subcircuito || -1
      };
      resultados.push(filaSeleccionada);
    })
    .on('end', () => {
      resultados.forEach((fila) => {
        const query = `
          INSERT INTO detencion (
            fecha_detencion, hora_detencion, tipo, condicion, movilizacion, 
            presunta_flagrancia, presunta_modalidad, flagrante_boleta, lugar, 
            tipo_lugar, infraccion, subinfraccion, anio, Detenido_id, 
            arma_id_arma, Subcircuito_id_subcircuito
          ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        `;
        const valores = [
          fila.fecha_detencion, fila.hora_detencion, fila.tipo, fila.condicion,
          fila.movilizacion, fila.presunta_flagrancia, fila.presunta_modalidad, 
          fila.flagrante_boleta, fila.lugar, fila.tipo_lugar, fila.infraccion, 
          fila.subinfraccion, fila.anio, fila.Detenido_id, fila.arma_id_arma, 
          fila.Subcircuito_id_subcircuito
        ];
        connection.query(query, valores, (err, res) => {
          if (err) {
            console.error('Error insertando datos:', err);
            return;
          }
        });
      });

      connection.end();
    });
}

subirDatosDesdeCSV('NUEVOsubcircuitos.csv');
