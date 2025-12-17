const axios = require("axios");

const PB_URL = "http://127.0.0.1:8090";
const COLLECTION = "corporatorElectionData";

// 🔐 Superuser credentials
const EMAIL = "voteforindia2024@gmail.com";
const PASSWORD = "voteforindia20092024";

// Get superuser auth token
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

// Delete all records from collection
async function deleteAllRecords() {
  const token = await getToken();
  let page = 1;
  let totalDeleted = 0;

  while (true) {
    const res = await axios.get(
      `${PB_URL}/api/collections/${COLLECTION}/records`,
      {
        headers: {
          Authorization: `Bearer ${token}`,
        },
        params: {
          page,
          perPage: 500,
        },
      }
    );

    const records = res.data.items;

    if (!records || records.length === 0) {
      break;
    }

    for (const record of records) {
      await axios.delete(
        `${PB_URL}/api/collections/${COLLECTION}/records/${record.id}`,
        {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        }
      );

      totalDeleted++;
      if (totalDeleted % 100 === 0) {
        console.log(`🗑 Deleted ${totalDeleted} records`);
      }
    }
  }

  console.log("✅ All records deleted successfully");
}

// Run
deleteAllRecords().catch((err) => {
  console.error("❌ Error deleting records:", err.response?.data || err.message);
});
