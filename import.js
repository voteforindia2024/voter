const fs = require("fs");
const csv = require("csv-parser");
const axios = require("axios");

const PB_URL = "http://127.0.0.1:8090";
const COLLECTION = "corporatorElectionData";

const EMAIL = "voteforindia2024@gmail.com";
const PASSWORD = "voteforindia20092024";
const CSV_FILE = "./corporatorElectionData.csv";

async function getToken() {
  const res = await axios.post(
    `${PB_URL}/api/collections/_superusers/auth-with-password`,
    {
      identity: EMAIL,
      password: PASSWORD,
    }
  );
  return res.data.token;
}

async function importCSV() {
  const token = await getToken();
  const rows = [];

  // ✅ FORCE UTF-8
  fs.createReadStream(CSV_FILE, { encoding: "utf8" })
    .pipe(csv())
    .on("data", (row) => rows.push(row))
    .on("end", async () => {
      let success = 0;
      let failed = 0;

      for (const row of rows) {
        try {
          // 🔧 Remove BOM if present
          if (row["ID"]) {
            row.ID = row["ID"];
            delete row["ID"];
          }

          // 🔢 Convert numbers
        //   row.constno = Number(row.constno);
        //   row.yadibhag = Number(row.yadibhag);
        //   row.vno = Number(row.vno);
        //   row.age = Number(row.age);
        //   row.familyqty = Number(row.familyqty);
        //   row.addressN = Number(row.addressN);
        //   row.redgreen = Number(row.redgreen);
        //   row.voting = Number(row.voting);

          await axios.post(
            `${PB_URL}/api/collections/${COLLECTION}/records`,
            row,
            {
              headers: {
                Authorization: `Bearer ${token}`,
                "Content-Type": "application/json",
              },
            }
          );

          success++;
          if (success % 100 === 0) {
            console.log(`✔ Imported ${success}`);
          }
        } catch (err) {
          failed++;
          console.error(
            "❌ Failed row:",
            row,
            err.response?.data || err.message
          );
        }
      }

      console.log("✅ Import finished");
      console.log("✔ Success:", success);
      console.log("❌ Failed:", failed);
    });
}

importCSV();
