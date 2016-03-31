(function() {
  var removeParent, restoreDefault;

  $.fn.inlineEdit = function(replaceWith, connectWith) {
    var elem;
    elem = $(this);
    elem.hide();
    elem.after(replaceWith);
    replaceWith.focus();
    replaceWith.val(elem.text());
    return replaceWith.blur(function() {
      if ($(this).val() !== "") {
        connectWith.val($(this).val()).change();
        elem.text($(this).val());
      }
      $(this).remove();
      return elem.show();
    });
  };

  $('.add-skills').click(function() {
    var elem, replaceWith, select;
    replaceWith = $("<input name='temp' type='text'>");
    select = $("select");
    $('#addSkillBtn').show();
    select.show();
    elem = $(this);
    elem.hide();
    elem.after(replaceWith);
    replaceWith.focus();
    $('#addSkillBtn').click(function() {
      var closeBtn, newSkill;
      if (replaceWith.val() !== "") {
        newSkill = "<div class='skill " + (select.val()) + "'>" + (replaceWith.val()) + "<span class='close'></span></div>";
        $("#skillsContainer").append(newSkill);
        closeBtn = $("#skillsContainer").last().children().children();
        closeBtn.click(function() {
          var el;
          el = $(this)[0];
          return removeParent(el);
        });
        return restoreDefault(replaceWith, select, $('#addSkillBtn'), elem);
      }
    });
    return $('body').click(function(e) {
      if (!e.target.parentElement.classList.contains('add-skills-container')) {
        return restoreDefault(replaceWith, select, $('#addSkillBtn'), elem);
      }
    });
  });

  restoreDefault = function(replaceField, selectField, okBtn, elementToShow) {
    replaceField.val("");
    selectField.prop('selectedIndex', 0);
    replaceField.remove();
    okBtn.hide();
    selectField.hide();
    return elementToShow.show();
  };

  $('.editable').click(function() {
    var connectWith, replaceWith;
    replaceWith = $("<input name='temp' type='text'>");
    connectWith = $("input[name='" + this.classList[0] + "']");
    return $(this).inlineEdit(replaceWith, connectWith);
  });

  removeParent = function(btn) {
    var elem;
    elem = btn.parentElement;
    if (elem.parentElement) {
      return elem.parentElement.removeChild(elem);
    }
  };

  $('.close').click(function() {
    removeParent(this);
    return false;
  });

}).call(this);
