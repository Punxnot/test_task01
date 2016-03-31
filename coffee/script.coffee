$.fn.inlineEdit = (replaceWith, connectWith)->
  elem = $(this)
  elem.hide()
  elem.after(replaceWith)
  replaceWith.focus()
  replaceWith.val(elem.text())
  replaceWith.blur ->
    if $(this).val() != ""
      connectWith.val($(this).val()).change()
      elem.text($(this).val())
    $(this).remove()
    elem.show()

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
    unless e.target.parentElement.classList.contains('add-skills-container')
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

$('.close').click ->
  removeParent(this)
  return false
