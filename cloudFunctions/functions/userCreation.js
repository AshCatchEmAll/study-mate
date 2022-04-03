
const cors = require("cors")({ origin: true });

const functions = require("firebase-functions");
const admin = require("firebase-admin");
const {
  createRecipient,
  createRecipientItem,
  createEmail,
  createPullFeature,
  sendPullNotification,
  listContainerMedia,
  createUserContainer,
} = require("./botdoc");

exports.createUserDocument = functions.auth.user().onCreate(async (user) => {
  const uid = user.uid;
  const email = user.email;
  const containerID = await requestDocuments(email);
  return admin.firestore().collection("Users").doc(uid).set({
    email: email,
    uid: uid,
    subjects: [],
    school: "none",
    verified: false,
    containerID: containerID,
  });
});

async function requestDocuments(email) {
  try {
    const containerID = await createUserContainer();
    const recipietID = await createRecipient(containerID, email, "");
    await createRecipientItem(recipietID, email);
    await createEmail(containerID);
    await createPullFeature(containerID);
    await sendPullNotification(containerID);
    return containerID;
  } catch (e) {
    console.log("error in requestDocuments : ", e);
  }
}

exports.callBackUrl = functions.https.onRequest((req, res) => {
  cors(req, res, async () => {
    console.log(req.body);
  });
});

exports.checkIfDocumentSubmitted = functions.https.onRequest((req, res) => {
  cors(req, res, async () => {
    const user = await admin.firestore().collection("Users").doc(uid).get();
    const data = user.data();
    const docSubmited = await listContainerMedia(data["containerID"]);
   
    return res.json({data:docSubmited})
  });
});
