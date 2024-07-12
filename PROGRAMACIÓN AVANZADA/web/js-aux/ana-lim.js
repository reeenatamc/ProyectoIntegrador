var csvFilePath = 'archivos/csv/tablas_analisis.csv';
Papa.parse(csvFilePath, {
    download: true,
    complete: function (results) {
        var tableData = results.data;
        var tableHtml = '';

        for (var i = 0; i < tableData.length; i++) {
            tableHtml += '<tr>';
            for (var j = 0; j < tableData[i].length; j++) {
                if (i === 0) {
                    tableHtml += '<th>' + tableData[i][j] + '</th>';
                } else {
                    tableHtml += '<td>' + tableData[i][j] + '</td>';
                }
            }
            tableHtml += '</tr>';
        }

        document.getElementById('tabla-datos').innerHTML = tableHtml;
    }
});