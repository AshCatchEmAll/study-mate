const functions = require("firebase-functions");

exports.changeMessageStatus = functions.firestore
  .document("rooms/{roomId}/messages/{messageId}")
  .onWrite((change) => {
    const message = change.after.data();
    if (message) {
      if (["delivered", "seen", "sent"].includes(message.status)) {
        return null;
      } else {
        return change.after.ref.update({
          status: "delivered",
        });
      }
    } else {
      return null;
    }
  });

exports.changeLastMessage = functions.firestore
  .document("rooms/{roomId}/messages/{messageId}")
  .onUpdate((change, context) => {
    const message = change.after.data();
    if (message) {
      return db
        .doc("rooms/" + context.params.roomId)
        .update({ lastMessages: [message] });
    } else {
      return null;
    }
  });
