# Editable text
$.fn.inlineEdit = (replaceWith, connectWith)->
  elem = $(this)
  okBtn = elem.siblings(".ok-button")
  closeBtn = elem.siblings(".close")
  elem.hide()
  okBtn.show()
  closeBtn.show()
  elem.after(replaceWith)
  replaceWith.focus()
  replaceWith.val(elem.text())
  okBtn.click ->
    if replaceWith.val() != ""
      connectWith.val(replaceWith.val()).change()
      elem.text(replaceWith.val())
    replaceWith.remove()
    okBtn.hide()
    closeBtn.hide()
    elem.show()
  closeBtn.click ->
    replaceWith.remove()
    okBtn.hide()
    closeBtn.hide()
    elem.show()

# Add new skills
$('.add-skills').click ->
  replaceWith = $("<input name='temp' type='text'>")
  select = $("select")
  $('#addSkillBtn').show()
  select.show()
  elem = $(this)
  elem.hide()
  elem.after(replaceWith)
  replaceWith.focus()
  $('#addSkillBtn').click ->
    if replaceWith.val() != ""
      newSkill = "<div class='skill #{select.val()}'>#{replaceWith.val()}<span class='close'></span></div>"
      $("#skillsContainer").append(newSkill)
      closeBtn = $("#skillsContainer").last().children().children()
      closeBtn.click ->
        el = $(this)[0]
        removeParent(el)
      restoreDefault(replaceWith, select, $('#addSkillBtn'), elem)
  $('body').click (e)->
    selectClicked = e.target.parentElement.classList.contains('add-skills-container')
    selectOptionClicked = e.target.parentElement.parentElement.classList.contains('add-skills-container')
    unless selectClicked or selectOptionClicked
      restoreDefault(replaceWith, select, $('#addSkillBtn'), elem)

restoreDefault = (replaceField, selectField, okBtn, elementToShow)->
  replaceField.val("")
  selectField.prop('selectedIndex', 0)
  replaceField.remove()
  okBtn.hide()
  selectField.hide()
  elementToShow.show()

$('.editable').click ->
  replaceWith = $("<input name='temp' type='text'>")
  connectWith = $("input[name='#{this.classList[0]}']")
  $(this).inlineEdit(replaceWith, connectWith)

# Delete skills
removeParent = (btn)->
  elem = btn.parentElement
  if elem.parentElement
    elem.parentElement.removeChild(elem)

$('.skills .close').click ->
  removeParent(this)
  return false
