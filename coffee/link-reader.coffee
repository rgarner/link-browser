# A Chrome content script. Responds to message {askFor: 'links'} and sends a JSON array as a response

chrome.extension.onMessage.addListener (request, sender, sendResponse) ->
  return if request.askFor != "links"
  sendResponse(getLinks());

getLinks = ->
  linkTags = document.getElementsByTagName 'link'
  linkJSON = { 'links': [] };

  for linkTag in linkTags  
    linkJSON.links.push { 
      rel: linkTag.rel, 
      href: linkTag.href, 
      title: linkTag.title,
      type: linkTag.type,
      media: linkTag.media }

  linkJSON




