class window.BankView extends Backbone.View

  template: _.template '<p>Total: <%= bankroll %> </p> <p>Current Bet: <%= currentBet %></p>'
  
  initialize: ->
    chips = @model.getChipCounts()
    @render()
    @model.on("change:currentBet", @render, @);
    @model.on("change:bankroll", @render, @);
    @model.on("newGame", @removeChips, @);

  removeChips: ->
    @$el.children.detach()
    @$el.html @template @model.attributes

  render: ->
    @$el.children().detach()
    @$el.html @template @model.attributes
    for chipType, numChips of @model.getChipCounts()
      for num in [0...numChips]
        @$el.append($('<div class="chip" data-value="' + chipType + '"><p>' + chipType + '</p></div>'))
