
const { default: fetch } = require("node-fetch");
const {writeFile} = require('fs');
const {promisify} = require('util');
const writeFilePromise = promisify(writeFile);

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
    console.log(jsonData)
		
  } catch (e) {
    console.log("Error in listContainerMedia : ", e);
  }
}


async function downloadMedia(media_id){
	try {
		const token = await getJWT();
		console.log(token)
   await fetch(`https://api.botdoc.io/v1/module_container_pushpull/${media_id}/download/`, {
      method: "GET",
      headers: {
        Authorization: `JWT ${token}`,
        "Content-Type": "application/json",
      },
      
    }).then(x => x.arrayBuffer())
      .then(x => writeFilePromise(`./${media_id}.pdf`, Buffer.from(x)));;
 
  } catch (e) {
    console.log("Error in downloadMedia : ", e);
  }
	

}


//#1 Pass in containerID to list container media
listContainerMedia(1493167)

//#2 Then download the media that was added
//Note that there can be more than one media in the container
downloadMedia("1493165")

