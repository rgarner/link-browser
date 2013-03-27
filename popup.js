// Copyright (c) 20123 Russell Garner. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

var linkEnumerator = {
  addListOfLinks: function() {
    var linkTags;

    chrome.tabs.getSelected(null, function(tab) {
      chrome.tabs.sendMessage(tab.id, {askFor: 'links'}, function(response) {
        linkTags = response.links;
        var ul = document.getElementById('links');

        if (linkTags.length === 0) {
            var li = ul.appendChild(document.createElement('li'));
            li.innerText = 'No link tags found.';
            return;
        }

        for (var i = 0; i < linkTags.length; i++) {
            var linkTag = linkTags[i];
            var li = ul.appendChild(document.createElement('li'));
            var a = li.appendChild(document.createElement('a'));
            a.href = linkTag.href;
            a.innerText = linkTag.href;
        }        

        });
    });  
  }
};

document.addEventListener('DOMContentLoaded', function () {
  linkEnumerator.addListOfLinks();
});
