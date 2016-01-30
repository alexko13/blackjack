class window.CardView extends Backbone.View
  className: 'card'

  tagName: 'img'

  template: _.template '<%= rankName %> of <%= suitName %>'

  srcTemplate: _.template 'img/cards/<%= rankName %>-<%= suitName %>.png'

  initialize: -> @render()

  render: ->
    @$el.children().detach()
    @$el.attr 'src', if @model.get 'revealed' then (@srcTemplate @model.attributes) else 'img/card-back.png'