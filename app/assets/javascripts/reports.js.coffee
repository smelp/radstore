# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
  $("#reportTable1").dataTable(
    fnDrawCallback: (oSettings) ->
      return  if oSettings.aiDisplay.length is 0
      nTrs = $("#reportTable1 tbody tr")
      iColspan = nTrs[0].getElementsByTagName("td").length
      sLastGroup = ""
      i = 0

      while i < nTrs.length
        iDisplayIndex = oSettings._iDisplayStart + i
        sGroup = oSettings.aoData[oSettings.aiDisplay[iDisplayIndex]]._aData[0]
        unless sGroup is sLastGroup
          nGroup = document.createElement("tr")
          nCell = document.createElement("td")
          nCell.colSpan = iColspan
          nCell.className = "group"
          nCell.innerHTML = sGroup
          nCell.style.fontWeight = 'bold'
          nCell.style.backgroundColor = '#CCFFCC'
          nCell.style.borderBottom = 'solid'
          nCell.style.borderBottomWidth = '1px'
          nGroup.appendChild nCell
          nTrs[i].parentNode.insertBefore nGroup, nTrs[i]
          sLastGroup = sGroup
        i++

    aoColumnDefs: [
      bVisible: false
      aTargets: [0]
    ]
    aaSortingFixed: [[0, "asc"]]
    aaSorting: [[1, "asc"]]
    sDom: "t"
  )

  $("#reportTable2").dataTable(
    fnDrawCallback: (oSettings) ->
      return  if oSettings.aiDisplay.length is 0
      nTrs = $("#reportTable2 tbody tr")
      iColspan = nTrs[0].getElementsByTagName("td").length
      sLastGroup = ""
      i = 0

      while i < nTrs.length
        iDisplayIndex = oSettings._iDisplayStart + i
        sGroup = oSettings.aoData[oSettings.aiDisplay[iDisplayIndex]]._aData[0]
        unless sGroup is sLastGroup
          nGroup = document.createElement("tr")
          nCell = document.createElement("td")
          nCell.colSpan = iColspan
          nCell.className = "group"
          nCell.innerHTML = sGroup
          nCell.style.fontWeight = 'bold'
          nCell.style.backgroundColor = '#CCFFCC'
          nCell.style.borderBottom = 'solid'
          nCell.style.borderBottomWidth = '1px'
          nGroup.appendChild nCell
          nTrs[i].parentNode.insertBefore nGroup, nTrs[i]
          sLastGroup = sGroup
        i++

    aoColumnDefs: [
      bVisible: false
      aTargets: [0]
    ]
    aaSortingFixed: [[0, "asc"]]
    aaSorting: [[1, "asc"]]
    sDom: "t"
  )

  $("#reportTable3").dataTable(
    fnDrawCallback: (oSettings) ->
      return  if oSettings.aiDisplay.length is 0
      nTrs = $("#reportTable3 tbody tr")
      iColspan = nTrs[0].getElementsByTagName("td").length
      sLastGroup = ""
      i = 0

      while i < nTrs.length
        iDisplayIndex = oSettings._iDisplayStart + i
        sGroup = oSettings.aoData[oSettings.aiDisplay[iDisplayIndex]]._aData[0]
        unless sGroup is sLastGroup
          nGroup = document.createElement("tr")
          nCell = document.createElement("td")
          nCell.colSpan = iColspan
          nCell.className = "group"
          nCell.innerHTML = sGroup
          nCell.style.fontWeight = 'bold'
          nCell.style.backgroundColor = '#CCFFCC'
          nCell.style.borderBottom = 'solid'
          nCell.style.borderBottomWidth = '1px'
          nGroup.appendChild nCell
          nTrs[i].parentNode.insertBefore nGroup, nTrs[i]
          sLastGroup = sGroup
        i++

    aoColumnDefs: [
      bVisible: false
      aTargets: [0]
    ],
    aaSortingFixed: [[0, "desc"]],
    aaSorting: [[1, "desc"]],
    iDisplayLenght: 200,
    sDom: "t"
  )
