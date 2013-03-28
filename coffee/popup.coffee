# Copyright (c) 20123 Russell Garner. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

class LinkEnumerator
  @addLink: (root, linkTag) ->
    li = root.appendChild document.createElement('li')
    a = li.appendChild document.createElement('a')
    a.href = linkTag.href
    a.innerText = linkTag.href

  @addListOfLinks: ->
    chrome.tabs.getSelected null, (tab) ->
      chrome.tabs.sendMessage tab.id, { askFor: 'links' }, (linkTags) ->
        root = document.getElementById 'links'

        unless linkTags?
          li = root.appendChild(document.createElement('li'))
          li.innerText = 'No link tags found.'
          return

        LinkEnumerator.addLink root, linkTag for linkTag in linkTags

document.addEventListener 'DOMContentLoaded', ->
  LinkEnumerator.addListOfLinks()          