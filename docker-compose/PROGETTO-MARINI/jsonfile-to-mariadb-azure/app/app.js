'use strict'

// load libs
const mariadb = require("mariadb");
const fs = require("fs");
const path = require("path")

// the json config file
const appConfig = require("/cfg-data/config.json");

// path mounted to edge-fileserver app
const fileserverPath = "/usr/src/app/ftpserver";


function readJsonFile() {
    // return first founded json file content or null if no json file was find

    return new Promise((resolve, reject) => {

        try {
            // init ftp json data
            let ftpJson = null;

            // get current filenames in directory with json extension
            let files = fs.readdirSync(fileserverPath);

            // search for json file
            for (let i = 0; i < files.length; i++) {

                if (files[i].endsWith(".json") || files[i].endsWith(".JSON")) {

                    console.log(new Date().toISOString(), "- Found new file", files[i]);
                    // read json file
                    let ftpData = fs.readFileSync(path.join(fileserverPath, files[i]), 'utf8');
                    // parse json
                    ftpJson = JSON.parse(ftpData);

                    // delete file after reading
                    fs.unlinkSync(path.join(fileserverPath, files[i]));
                    console.log(new Date().toISOString(), "- File", files[i], "loaded and deleted.");

                    break;
                }
            }

            // return json file
            resolve(ftpJson);
        }
        catch (error) {
            reject(error);
        }

    });
}

function writeToMaria(jsonData) {
    // parse json data and send them to mariadb

    return new Promise(async (resolve, reject) => {

        try {
            // get config of query from config file
            let insertTableName = appConfig.insertTableName;
            let insertColumns = appConfig.insertColumns;
            // get an array of ? based on number of columns for query string
            let insertValuesPlaceholders = insertColumns.map((col) => { return "?" });

            // get connection to maria db
            let mariaDBConn = await mariaDBPool.getConnection();

            // initialize values array
            let values = [];

            // INSERT HERE JSON PARSING CODE
            // e.g. columns ordered list
            // column_1, column_2, column_3, column_4
            // e.g. of values assignment based on columns order
            // values[0] = jsonData.column_1;
            // values[1] = jsonData.column_2;
            // values[2] = jsonData.column_3;
            // values[3] = jsonData.column_4;

            // check if values length is the same as columns length
            if (values.length == insertColumns.length) {

                // create insert query
                // e.g. INSERT INTO myTable (column_1, column_2, column_3, column_4) VALUES (?, ?, ?, ?)
                let query = "INSERT INTO ";
                query += insertTableName + " ";
                query += "(" + insertColumns.join(" ,") + ") ";
                query += "VALUES (" + insertValuesPlaceholders.join(" ,") + ")";

                // execute query to maria db
                const queryResponse = await mariaDBConn.query(query, values);
                console.log(new Date().toISOString(), "- New insert with ID", queryResponse.insertId, "in MariaDB with columns",
                    insertColumns.join(), "and values", values.join(), ".");
            }
            else {
                console.log(new Date().toISOString(), "- ERROR inserting data in MariaDB, columns length is different from values length.");
            }
        }
        catch (error) {
            reject(error);
        }

    });

}

async function mainLoop() {
    // main loop function

    try {

        // get json file
        let ftpJson = await readJsonFile();

        // check if content file exist
        if (ftpJson) {
            // parse and write data to MariaDB
            await writeToMaria(ftpJson);
        }

    } catch (error) {
        console.log(new Date().toISOString(), "- ERROR:", error);
    }

    // call again loop
    setTimeout(mainLoop(), 250);
}

// START
console.log(new Date().toISOString(), "- App jsonfile-to-maria-azure v.0.0.1 started!");

// initialize mariadb connection pool
const mariaDBPool = mariadb.createPool({
    host: appConfig.mariaDBHost,
    user: appConfig.mariaDBUser,
    password: appConfig.mariaDBPassword,
    connectionLimit: 5
});
console.log(new Date().toISOString(), "- MariaDB Connection Pool created.");

// start main loop
mainLoop();