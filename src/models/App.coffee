# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('playerHand').on('hit', @checkBust, @)
    @get('dealerHand').on('hit', @checkBust, @)
    @get('playerHand').on('stand', @playDealer, @)
    undefined

  bindListeners: ->
    @get('playerHand').on('hit', @checkBust, @)
    @get('dealerHand').on('hit', @checkBust, @)
    @get('playerHand').on('stand', @playDealer, @)

  playAgain:  -> 
    console.log 'playing again'
    @set 'playerHand', @get('deck').dealPlayer()
    console.log("set player hand")
    @set 'dealerHand', @get('deck').dealDealer()
    @bindListeners()
    @get('deck').playAgain()
    undefined

  checkBust: (hand) ->
    scores = hand.scores()
    if scores[0] > 21
      console.log 'bust'
      @playDealer()

  compare: ->
    player = @get 'playerHand'
    dealer = @get 'dealerHand'
    playerScore = player.finalScore()
    dealerScore = dealer.finalScore()

    if (dealerScore > playerScore and dealerScore <= 21) or playerScore > 21
     console.log("lost")
    else if dealerScore < playerScore or dealerScore > 21
     console.log("won")
    else if dealerScore is playerScore
     console.log("tie")
    undefined

  playDealer: ->
    console.log("playing dealer")
    dealer = @get 'dealerHand'
    firstCard = dealer.first()
    firstCard.flip() if not firstCard.get("revealed")
    dealerFinalScore = dealer.finalScore()
    
    if dealerFinalScore <= 16
      dealer.hit()
      @playDealer()
    else
      @compare(dealerFinalScore)
    undefined