class window.CardView extends Backbone.View
  className: 'card'

  tagName: 'img'

  template: _.template '<%= rankName %> of <%= suitName %>'

  srcTemplate: _.template 'img/cards/<%= rankName %>-<%= suitName %>.png'

  initialize: -> @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @model.attributes
    @$el.addClass 'covered' unless @model.get 'revealed'
    @$el.attr 'src', (@srcTemplate @model.attributes)
