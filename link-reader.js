/* A Chrome content script. Responds to message {askFor: 'links'} and sends a JSON array as a response */

chrome.extension.onMessage.addListener(
  function(request, sender, sendResponse) {
    if (request.askFor != "links")
    	return;

    sendResponse(getLinks());
    console.log('link-reader listener done');
  }
);

function getLinks() {
	var linkTags = document.getElementsByTagName('link');
	var linkJSON = { 'links': [] };

	for (var i = 0; i < linkTags.length; i++) {
		var linkTag = linkTags[i]
		linkJSON.links.push({ 
      rel: linkTag.rel, 
      href: linkTag.href, 
      type: linkTag.type 
    });
	};

	return linkJSON;
}





