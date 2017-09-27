//Firebase functions setup
const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp(functions.config().firebase);

//register to onWrite event of my node news
exports.sendPushNotification = functions.database.ref('/news/{id}').onWrite(event => {
    //get the snapshot of the written data
    const snapshot = event.data;
    //create a notofication
    const payload = {
        notification: {
            title: snapshot.child("title").val(),
            body: snapshot.child("message").val(),
            badge: '1',
            sound: 'default',
        }
    };
    
    //send a notification to all fcmToken that are registered
    //In my case the users device token are stored in a node called 'fcmToken'
    //and all user of my app will receive the notification
    return admin.database().ref('fcmToken').once('value').then(allToken => {
        if (allToken.val()){
            const token = Object.keys(allToken.val());
            return admin.messaging().sendToDevice(token, payload).then(response => {
                console.log("Successfully sent message:", response);
            });
        }
    });
});