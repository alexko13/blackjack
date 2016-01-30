# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('playerHand').on('hit', @checkBust, @)
    @get('playerHand').on('stand', @playDealer, @)
    undefined

    #@get('playerHand').onStand ->
      # dealer checks if he should hit or not (<16)

      # dealer over 16 trigger stand
        #check who won

  #hit listener for busts on playerHand
  checkBust: (hand) ->
    scores = hand.scores()
    if scores[0] > 21
      alert 'bust'

  compare: (dealerScore)->
    player = @get 'playerHand'
    playerScores = player.scores()
    playerScore = if playerScores[1] < 21 then playerScores[1] else playerScores[0]
    if dealerScore > playerScore
     console.log("lost")
    if dealerScore < playerScore
     console.log("won")
    if dealerScore == playerScore
     console.log("tie")
    undefined




  playDealer: ->
    dealer = @get 'dealerHand'
    firstCard = dealer.first()
    firstCard.flip() if firstCard.revealed
    dealerScore = dealer.scores()
    if 16 < dealerScore[0] < 21 
      @compare(dealerScore[0])
    else if dealerScore[1] and 16 < dealerScore[1] < 21
      @compare(dealerScore[1])
    else if dealerScore[0] < 16
      dealer.hit()
      @playDealer()
    undefined