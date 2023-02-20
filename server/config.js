const mysql = require('mysql');

const dbConnect = mysql.createConnection({
    host: '127.0.0.1',
    user: 'root',
    password: 'root',
    port: '8889',
    database: 'easyapp',
})

dbConnect.connect((error) =>{
    if(error){ console.log(error) } 
    else { console.log("Mysql is connected ...") }
})

module.exports = dbConnect;
