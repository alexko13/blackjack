class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button> 
    <button class="play-button">Place Bet</button>
    <div class="chip-container"></div>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @model.get('playerHand').stand()
    'click .play-button' : -> @model.playAgain()
    'click .chip': (event) -> @model.get('playerBank').bet($(event.target).closest("div").data("value"))

  initialize: ->
    @model.get('deck').on('newGame', @render, @)
    @render()
    

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.chip-container').html new BankView(model: @model.get 'playerBank').el
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

