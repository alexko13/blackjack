class window.Bank extends Backbone.Model

  initialize: ->
    @set "bankroll", 500

  getChipCounts: ->
    runningBankroll = @get "bankroll"
    chipTypes = [500,100,50,25,10,5,1]
    chipObj = {}

    for chip in [1,5,10,25,50,100,500]
      runningBankroll -= chip
      if runningBankroll > 0
        chipObj[chip] = 1

    func = (chip) ->
       num = Math.floor runningBankroll / chip
       runningBankroll -= num * chip
       chipObj[chip] += num

    for chip in chipTypes
    	func chip

    chipObj	

  bet: (bet) ->
    @set "bankroll", @get "bankroll" - bet
    @set "currentBet", bet

  win: ->
    @set "bankroll", @get "bankroll" + @get "currentBet" * 2
    @set "currentBet", 0

  winBlackJack: ->
    @set "bankroll", @get "bankroll" + @get "currentBet" * 2.5
    @set "currentBet", 0

 # 1 5 10 25 50 100 500 

 # goes through chiptyps adding one of each until runningbankroll is empty
 # if it gets to end and still has money in runningbankroll
 # distribute most efficiently


