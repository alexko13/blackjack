class window.BankView extends Backbone.View

  template: _.template '<span>Total: <%= bankroll %> </span>'
  
  initialize: ->
    chips = @model.getChipCounts()
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @model.attributes
    for chipType, numChips of @model.getChipCounts()
      for num in [0...numChips]
        @$el.append($('<div class="chip" data-value="' + chipType + '"><p>' + chipType + '</p></div>'))
