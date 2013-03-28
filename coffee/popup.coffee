# Copyright (c) 20123 Russell Garner. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

$b = DOMBrew

class LinkEnumerator
  @addLink: (root, linkTag) ->
    $b(root).append($b('tr')
      .append($b('td', linkTag.rel))
      .append($b('td')
        .append($b('a', href: linkTag.href, title: linkTag.href, text: linkTag.href )))
      .append($b('td',  class: 'type', text: linkTag.type))
      .append($b('td',  linkTag.media)))

  @addListOfLinks: ->
    chrome.tabs.getSelected null, (tab) ->
      chrome.tabs.sendMessage tab.id, { askFor: 'links' }, (linkTags) ->
        root = document.getElementById 'links'

        unless linkTags?
          td = $b(root).append($b('tr').append($b('td', 'No link tags found.')))
          return

        LinkEnumerator.addLink root, linkTag for linkTag in linkTags

document.addEventListener 'DOMContentLoaded', ->
  LinkEnumerator.addListOfLinks()          