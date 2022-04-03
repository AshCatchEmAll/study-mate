const { default: fetch } = require("node-fetch");
const functions = require("firebase-functions");
const admin = require("firebase-admin");




async function getJWT() {
  try {
    const response = await fetch("https://api.botdoc.io/v1/auth/get_token", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        api_key: "b45e40f844596bb6196b39a0e54ed1c72dff88f7",
        email: "aashishvichare10@gmail.com",
      }),
    });
    const jsonData = await response.json();

    return jsonData["token"];
  } catch (e) {
    console.log("Error creating User container : ", e);
  }
}
 async function createUserContainer() {
  try {
    const token = await getJWT();
    console.log(token);
    const response = await fetch(
      "https://api.botdoc.io/v1/module_container/container/",
      {
        method: "POST",
        headers: {
          Authorization: `JWT ${token}`,
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          page_type: "pushpull",
          callback_url: "https://us-central1-princeton-9a321.cloudfunctions.net/callBackUrl",
        }),
      }
    );
    const jsonData = await response.json();
    return jsonData.id;
  } catch (e) {
    console.log("Error creating User container : ", e);
  }
}

 async function createRecipient(container_id, firstName, lastName) {
  try {
    const token = await getJWT();
    console.log(token);
    const response = await fetch(
      `https://api.botdoc.io/v1/module_container/container/${container_id}/re
  cipient/`,
      {
        method: "POST",
        headers: {
          Accept: "application/json",
          Authorization: `JWT ${token}`,
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          first_name: firstName,
          last_name: lastName,
        }),
      }
    );
    const jsonData = await response.json();
    return jsonData.id;
    /**
      {
    id: 1581328,
    container: 1493055,
    active: true,
    first_name: '',
    last_name: null,
    created: '2022-04-03T09:09:49.797238Z',
    updated: '2022-04-03T09:09:49.797282Z'
  }
  
  **/
  } catch (e) {
    console.log("Error in createRecipient : ", e);
  }
}

 async function createRecipientItem(recipient_id, email) {
  try {
    const token = await getJWT();
    console.log(token);
    const response = await fetch(
      `https://api.botdoc.io/v1/module_container/recipient/${recipient_id}/reci
  pient_item/`,
      {
        method: "POST",
        headers: {
          Accept: "application/json",
          Authorization: `JWT ${token}`,
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          interface_class: "email",
          value: email,
        }),
      }
    );
    const jsonData = await response.json();
    console.log(jsonData);
    /**
      {
    id: 1584234,
    recipient: 1581328,
    value: 'aashishvichare9@gmail.com',
    interface_class: 'email',
    created: '2022-04-03T09:13:45.140846Z',
    updated: '2022-04-03T09:13:45.140879Z',
    link: null
  }
  **/
  } catch (e) {
    console.log("Error in createRecipientItem : ", e);
  }
}

 async function createEmail(container_id) {
  try {
    const token = await getJWT();
    console.log(token);
    const response = await fetch(
      `https://api.botdoc.io/v1/module_container/container/${container_id}/e
  mail/`,
      {
        method: "POST",
        headers: {
          Accept: "application/json",
          Authorization: `JWT ${token}`,
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          subject: "Requesting Verification Documents",
          body: "Study mate is requesting documents for verification",
        }),
      }
    );
    const jsonData = await response.json();
    console.log(jsonData);
    /**
      {
    id: 1486101,
    container: 1493055,
    subject: 'Requesting Verification Documents',
    body: 'Study mate is requesting documents for verification',
    created: '2022-04-03T09:20:04.745374Z',
    updated: '2022-04-03T09:20:04.745402Z'
  }
  **/
  } catch (e) {
    console.log("Error in createEmail : ", e);
  }
}

 async function createPullFeature(container_id) {
  try {
    const token = await getJWT();
    console.log(token);
    const response = await fetch(
      `https://api.botdoc.io/v1/module_container_pushpull/pushpullfeatu
  re/`,
      {
        method: "POST",
        headers: {
          Accept: "application/json",
          Authorization: `JWT ${token}`,
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          message: "Please attach documents",
          allowed_file_extensions: [ "pdf"],
          type: "pull",
          container: container_id,
        }),
      }
    );
    const jsonData = await response.json();
    console.log(jsonData);
    /**
      {
    id: 1645100,
    message: 'Please attach documents',
    receiver_message: null,
    requester_privatenotes: null,
    type: 'pull',
    is_draft: false,
    is_expired: false,
    complete: false,
    container: 1493055,
    updated: '2022-04-03T09:22:53.523951Z',
    allowed_file_extensions: [ 'csv', 'png', 'jpg', 'pdf' ],
    max_file_size: null,
    max_files: null
  }
  **/
  } catch (e) {
    console.log("Error in createPullFeature : ", e);
  }
}


 async function sendPullNotification(container_id) {
    try {
          const token = await getJWT();
          console.log(token)
      const response = await fetch(`https://api.botdoc.io/v1/module_container/container/${container_id}/send_notification/`, {
        method: "POST",
        headers: {
                  Accept: 'application/json',
          Authorization: `JWT ${token}`,
          "Content-Type": "application/json",
        },
        
      });
    //  
          /**
      [
    {
      id: 1518651,
      recipient_item: 1584234,
      state: 'send',
      contact_first_name: '',
      contact_last_name: null,
      contact_method_value: 'aashishvichare9@gmail.com',
      contact_method_interface_class: 'email',
      created: '2022-04-03T09:25:31.445690Z',
      updated: '2022-04-03T09:25:31.502193Z',
      was_sent: false,
      removed: false,
      link: 'https://secure.botdoc.io/s/EYx4HUr3'
    }
  ]
  **/
    } catch (e) {
      console.log("Error in sendPullNotification : ", e);
    }
  }
  





 async function listContainerMedia(container_id) {
    try {
          const token = await getJWT();
          console.log(token)
      const response = await fetch(`https://api.botdoc.io/v1/media/?request=${container_id}`, {
        method: "GET",
        headers: {
                  Accept: 'application/json',
          Authorization: `JWT ${token}`,
          "Content-Type": "application/json",
        },
        
      });
      const jsonData = await response.json();
      if(jsonData.results.length>0){
          return true;
      }else{
          return false;
      }
      console.log(jsonData)
          /**
      {
    links: { next: null, previous: null },
    count: 1,
    total_pages: 1,
    results: [
      {
        id: 1387300,
        name: 'PXL_20220403_092941168.jpg',
        content_type: 'image/jpeg',
        bytes: 2387484,
        extension: 'jpg',
        file: '6de6811cd1da17670826e4f3c2bad98d.jpg',
        total_chunks: 1,
        metadata: [Object],
        created: '2022-04-03T09:35:28.809298Z',
        updated: '2022-04-03T09:35:30.642464Z',
        current_chunk: 1,
        file_checksum: '9fe1f8860a91dfe80d20bfdf649bb0d5',
        removed_at: null,
        removed_requested_from: null,
        media_download: [],
        times_downloaded: 0,
        state: 'available',
        max_allowed_times_downloaded: 6,
        tag: null,
        request: 1493064
      }
    ]
  }
  **/
    } catch (e) {
      console.log("Error in listContainerMedia : ", e);
    }
  }


  module.exports = {createEmail,createPullFeature,createRecipient,createRecipientItem,createUserContainer,sendPullNotification,listContainerMedia}