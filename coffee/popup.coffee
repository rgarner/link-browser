# Copyright (c) 20123 Russell Garner. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

class LinkEnumerator
  @newTab: (href) ->
    chrome.tabs.create(url: href)

  @addLink: (root, linkTag) ->
    _class = if linkTag.rel == 'alternate' then 'class="alternate"' else null
    $('#links').append("""
        <tr>
          <td #{_class}>#{linkTag.rel}</td>
          <td><a href="#{linkTag.href}" title="#{linkTag.title}">#{linkTag.href}</a></td>
          <td>#{linkTag.type}</td>
          <td>#{linkTag.media}</td>
        </tr>
      """)

  @addListOfLinks: ->
    chrome.tabs.getSelected null, (tab) ->
      chrome.tabs.sendMessage tab.id, { askFor: 'links' }, (linkTags) ->
        root = document.getElementById 'links'

        unless linkTags?
          td = $b(root).append($b('tr').append($b('td', 'No link tags found.')))
          return

        linkTags.sort (a, b) ->
          return 0 if a.rel == b.rel
          return -1 if a.rel == 'alternate'
          if a.rel >= b.rel then 1 else -1

        LinkEnumerator.addLink root, linkTag for linkTag in linkTags

        $('#links a').click ->
          console.log($(this)); 
          chrome.tabs.create url: $(this).attr('href')
          false


document.addEventListener 'DOMContentLoaded', ->
  LinkEnumerator.addListOfLinks()          