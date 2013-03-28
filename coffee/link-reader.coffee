# A Chrome content script. Responds to message {askFor: 'links'} and sends a JSON array as a response

# Listen for others asking for links
chrome.extension.onMessage.addListener (request, sender, sendResponse) ->
  return if request.askFor != "links"
  sendResponse(getLinks());

# Return an array of JSON-serialized links
getLinks = ->
  for linkTag in document.getElementsByTagName 'link'
    { 
      rel: linkTag.rel, 
      href: linkTag.href, 
      title: linkTag.title,
      type: linkTag.type,
      media: linkTag.media 
    } 




