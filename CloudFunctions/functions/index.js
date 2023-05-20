const functions = require("firebase-functions");
const signature = "";//Em xin phép xoá các thông tin private để đảm bảo an toàn cho server
// The Firebase Admin SDK to access Firestore.
// CORS Express middleware to enable CORS Requests.

// Firebase Setup
const admin = require('firebase-admin');
// @ts-ignore
const serviceAccount = require('./service-account.json');
const {log} = require("firebase-functions/lib/logger");
admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
    databaseURL: `https://${process.env.GCLOUD_PROJECT}.firebaseio.com`,
});
const userCollectionPath = "users";
const interactionCollection = "interactions";
const premiumExpireAtField = "premium_expire_at";
// We use Request to make the basic authentication request in our example.
const db = admin.firestore();

Date.prototype.addDays = function (days) {
    let date = new Date(this.valueOf());
    date.setDate(date.getDate() + days);
    return date;
}

exports.getEmail = functions.https.onRequest(async (req, res) => {
    try {
        const db = admin.firestore();
        const collection = db.collection("users");
        if (collection != null) {
            collection.where('username', '==', req.body.username).get().then(snapshot => {
                console.log(snapshot.size);
                if (snapshot.size === 1) {
                    const email = snapshot.docs[0].get('email');
                    return res.status(200).json({'success': true, data: {'email': email}});
                } else {
                    return res.status(401).json({'success': false, 'error': 'unauthorized'});
                }

            });
        }

    } catch (e) {
        return res.status(401).json({'success': false, 'error': 'unauthorized'});
    }
})
exports.matchCollectionChange = functions.firestore
    .document(`/${interactionCollection}/{interactionId}`)
    .onWrite(async (change, context) => {
        //check if interaction type is matched
        console.log('' + context.params.interactionId);
        const matched = 4;
        let interacted_type_1 = change.after.data()["interacted_type"];
        let current_user = change.after.data()["current_user"];
        let interacted_user = change.after.data()["interacted_user"];
        console.log(`interacted_type_1 == matched=> ${interacted_type_1 === matched}`);
        if (interacted_type_1 === matched) {
            //send Notification to both user
            let current_user_token = (await db.collection('FCMTokens').doc(current_user["username"]).get()).get('token');
            // create notification
            let title = 'Chúc mừng bạn đã có tương hợp mới với ' + interacted_user["name"];
            // send notification
            sendNotification(current_user_token, title, );
        }

})
;


exports.matchCollectionChange = functions.firestore
    .document(`/${interactionCollection}/{interactionId}`)
    .onWrite(async (change, context) => {
        const like = 2;
        const matched = 4;
        console.log('' + context.params.interactionId);
        let interacted_type_1 = change.after.data()["interacted_type"];
        let current_user = change.after.data()["current_user"];
        let interacted_user = change.after.data()["interacted_user"];
        console.log(`interacted_type_1 == like=> ${interacted_type_1 === like}`);
        if (interacted_type_1 === like) {
            try {
                const interactCollection = db.collection(interactionCollection);
                console.log(`matchCollection != null=> ${interactCollection != null}`);

                if (interactCollection != null) {
                    const snapshot = await interactCollection.doc(`${interacted_user["username"]}_${current_user["username"]}`).get();
                    let type = (await snapshot.ref.get()).get('interacted_type');

                    console.log('snapshot.exists' + snapshot.exists);
                    console.log(`like= ${like}`);
                    console.log(`type= ${type}`);
                    console.log(`type===like= ${type === like}`);

                    if (snapshot.exists && type === like) {
                        await interactCollection.doc(`${interacted_user["username"]}_${current_user["username"]}`).update({interacted_type: matched});
                        await interactCollection.doc(`${current_user["username"]}_${interacted_user["username"]}`).update({interacted_type: matched});
                        console.log('switch to matched type');
                        /* let current_user_token = (await db.collection('FCMTokens').doc(current_user_id_1).get()).get('token');
                        let interacted_user_token = (await db.collection('FCMTokens').doc(interacted_user_id_1).get()).get('token');
                        var allPromises = [];
                        console.log('current_user_token: ' + current_user_token);
                        console.log('interacted_user_token:' + interacted_user_token);
                        let title = 'Chúc mừng bạn đã có tương hợp mới với ' + interacted_user["name"];
                        let payload = {
                            notification: {
                                title: title,
                                click_action: "FLUTTER_NOTIFICATION_CLICK",
                            },
                            data: {
                                title: title,
                                user: JSON.stringify(interacted_user),
                            }
                        };

                        const promise1 = admin.messaging().sendToDevice(current_user_token, payload).then((response) => {
                            console.log('message sent to ' + interacted_user["name"]);
                        }).catch((error) => {
                            console.log(error);
                        });
                        allPromises.push(promise1);
                        title = 'Chúc mừng bạn đã có tương hợp mới với ' + current_user["name"];

                        payload = {
                            notification: {
                                title: title,
                                click_action: "FLUTTER_NOTIFICATION_CLICK",
                            },
                            data: {
                                title: title,
                                user: JSON.stringify(current_user),
                            }
                        };
                        const promise2 = admin.messaging().sendToDevice(interacted_user_token, payload).then((response) => {
                            console.log('message sent to ' + current_user["name"]);
                        }).catch((error) => {
                            console.log(error);
                        });
                        allPromises.push(promise2)
                        return Promise.all(allPromises);*/
                    }
                }

            } catch (e) {
                console.log(e);
                return Promise.resolve();
            }
        }
        return Promise.resolve();
    });


exports.paymentTransaction = functions.https.onRequest(async (req, res) => {
    // Grab the text parameter.
    const original = JSON.stringify(req.body);
    console.log('start paymentTransaction webhook');
    console.log('req.body=> ' + original);
    const db = admin.firestore();
    let min = 1000;
    let aMonth = 15000;
    let halfOfYear = 35000;
    let aYear = 50000;
    try {
        const data = JSON.parse(original);
        if (data.signature === signature) {

            if (data.amount > min) {
                let userCollection = db.collection(userCollectionPath);
                if (userCollection != null) {
                    userCollection.where('username', '==', data.comment.toLowerCase()).get().then(async snapshot => {
                        console.log('exist username = ' + data.comment);
                        if (snapshot.size === 1) {
                            let message;
                            const user = snapshot.docs[0].ref;
                            let expireDatesJson = snapshot.docs[0].get(premiumExpireAtField);
                            let expireDate = new Date(expireDatesJson);
                            console.log('expireDate = ' + expireDate.getDate());
                            let now = Date.now();
                            let isPremiumUser = expireDate > now;
                            let addDay;
                            if (data.amount === aMonth) {
                                addDay = 30;
                            } else if (data.amount === halfOfYear) {
                                addDay = 30 * 6;
                            } else if (data.amount === aYear) {
                                addDay = 365
                            } else {
                                addDay = ~~(data.amount / 1000);
                            }
                            message = !isPremiumUser ? 'Nâng cấp' : 'Gia hạn';
                            let newExpireDate = isPremiumUser ? addDays(expireDate, addDay) : addDays(now, addDay);
                            // expireDate= expireDate.setDate(expireDate.getDate()+addDay);
                            console.log(`expireDate= ${newExpireDate}`);
                            await user.update({premium_expire_at: newExpireDate.toISOString()},);
                            let fcmToken = (await db.collection(`${userCollectionPath}`).doc(user.id).get()).get('token');
                            let isSend = await sendNotification(fcmToken, `${message} tài khoản Premium thành công!`, `Tài khoản của bạn đã được thêm ${addDay} ngày vip.\nHết hạn lúc ${newExpireDate.toLocaleDateString("vi-VN")}!`);
                            if (isSend) {
                                res.status(200).json({
                                    'success': true,
                                    data: {'message': `User ${data.comment} - ${user.id} đã nạp ${addDay} ngày vip.Hết hạn lúc ${newExpireDate.toLocaleDateString('vi-VN')}`}
                                });
                            } else {
                                res.status(200).json({
                                    'success': false,
                                    'error': 'send notification failed'
                                });
                            }
                            return Promise.resolve();
                        } else {
                            res.status(200).json({'success': false, 'error': 'username not exist'});
                            return Promise.resolve();
                        }
                    });
                }
            } else {
                res.status(200).json({result: `Not enough money (<${min})`});
            }
        } else {
            res.status(200).json({'success': false, 'error': 'Signature error'});
        }
        return Promise.resolve();

    } catch (e) {
        console.log(e);
        res.status(200).json({'success': false, 'error': 'Rejected'});

        return Promise.reject();

    }
});

// rest of the code will be written here

//
// exports.onCreateMessage = functions.firestore//Notification
//     .document('channels/{chatRoomID}/messages/{message}')
//     .onCreate(async (snap, context) => {
//         const chatRoomID = context.params.chatRoomID;
//         const message = snap.data();
//         const chatRoomRef = await admin.firestore().collection('channels')
//             .doc(chatRoomID).get();
//
//         //setDate to Chatroom
//         await chatRoomRef.ref.update({
//             last_message: message
//         });
//         // const senderUserRef = await admin.firestore().collection('channels').doc(message.sender_id).get();
//         //getUserList add  then number;
//         const joinedUserList = Object.entries(chatRoomRef.data()["members"]);//convert obejct to map.
//         joinedUserList.forEach(async (value, key, map) => {
//             console.log(value[0]);
//             if (value[0]["sender_id"] !== message["sender_id"]) {
//                 return admin.messaging().sendToDevice(`${value[0]}`, {
//                     notification: {
//                         title: senderUserRef.data().name,
//                         body: message.messageType === CHAT_MESSAGE_TYPE_EMOJI ? '[STICKER]' : message.message,
//                         clickAction: 'FLUTTER_NOTIFICATION_CLICK',
//                         sound: 'default'
//                     }
//                     , data: {
//                         notificationType: message.messageType.toString()
//                     }
//                 });
//             }
//         });
//     });
exports.handleIncomingCall = functions.firestore
    .document('calls/{callId}')
    .onWrite(async (change, context) => {
        const callData = change.after.data();
        const callerId = callData.callerId;
        const calleeId = callData.calleeId;
        const status = callData.status;

        if (status === 'pending') {
            // Send a push notification to the callee using Firebase Cloud Messaging
            // to let them know that they have a new call invitation.
            const callerDoc = await admin.firestore().collection('users').doc(callerId).get();
            const callerName = callerDoc.data().name;
            const callerPhotoUrl = callerDoc.data().photoUrl;
            const calleeDoc = await admin.firestore().collection('users').doc(calleeId).get();
            // get the callee's FCM token from collection 'users'
            // Update the call document to reflect the fact that a notification has been sent.
            await change.after.ref.update({ status: 'notified' });
        } else if (status === 'accepted') {
            // Create a new Jitsi meeting and join the caller and callee to it.

            // Update the call document to reflect the fact that the call has been accepted.
            await change.after.ref.update({ status: 'in-progress' });
        } else if (status === 'declined') {
            // Update the call document to reflect the fact that the call has been declined.
            await change.after.ref.update({ status: 'declined' });
        } else {
            console.log(`Unknown call status: ${status}`);
        }
    });


async function sendNotification(fcmToken, title, body, data) {
    const payload = {
        token: fcmToken,
        notification: {
            title: title,
            body: body,
            click_action: "FLUTTER_NOTIFICATION_CLICK",
        },
        data: data
    };
    try {
        let response = await admin.messaging().send(payload);
        console.log('Successfully sent message:', response);
        return true;
    } catch (e) {
        console.log(e);
        return false;
    }
    // admin.messaging().send(payload).then((response) => {
    //     // Response is a message ID string.
    // }).catch((error) => {
    //     return {error: error.code};
    // });
}

function addDays(date, days) {
    let result = new Date(date);
    result.setDate(result.getDate() + days);
    return result;
}
