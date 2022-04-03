const functions = require('firebase-functions');
const admin = require('firebase-admin');
const { createUserDocument, callBackUrl, checkIfDocumentSubmitted } = require('./userCreation');
const { changeMessageStatus, changeLastMessage } = require('./chat');
admin.initializeApp(functions.config().firebase);

const firestore = functions.firestore;
exports.createUserDocument = createUserDocument;
exports.changeMessageStatus = changeMessageStatus;
exports.changeLastMessage = changeLastMessage;
exports.callBackUrl = callBackUrl
exports.checkIfDocumentSubmitted = checkIfDocumentSubmitted;