# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


#Number Picker Plugin - TobyJ
(($) ->

  $.fn.numberPicker = ->
    dis = 'disabled'
    @each ->
      picker = $(this)
      p = picker.find('button:last-child')
      m = picker.find('button:first-child')
      input = picker.find('input')
      min = parseInt(input.attr('min'), 10)
      max = parseInt(input.attr('max'), 10)

      inputFunc = (picker) ->
        i = parseInt(input.val(), 10)
        if i <= min or !i
          input.val min
          p.prop dis, false
          m.prop dis, true
        else if i >= max
          input.val max
          p.prop dis, true
          m.prop dis, false
        else
          p.prop dis, false
          m.prop dis, false
        return

      changeFunc = (picker, qty) ->
        q = parseInt(qty, 10)
        i = parseInt(input.val(), 10)
        if i < max and q > 0 or i > min and !(q > 0)
          input.val i + q
          inputFunc picker
        return

      m.on 'click', ->
        changeFunc picker, -1
        return
      p.on 'click', ->
        changeFunc picker, 1
        return
      input.on 'change', ->
        inputFunc picker
        return
      inputFunc picker
      #init
      return

  return
) jQuery

$(document).ready ->
  $('.quantity').numberPicker()

  $('.add-to-cart').click ->
    $('body').append('<div class="message is-primary notificationMessage">
      <div class="message-header">
        <p>Уведомление</p>
        <button class="delete" aria-label="delete"></button>
      </div>
      <div class="message-body">
        Товар добавлен в корзину!
      </div>
    </div>
    ');

    if document.querySelectorAll('.message .delete').length > 0
      for element,i in document.querySelectorAll('.message .delete')
        do (element, i)->
          $notification = element.closest('.message')
          element.addEventListener 'click', ->
            $notification.remove()
            return
  return

# ---
# generated by js2coffee 2.2.0