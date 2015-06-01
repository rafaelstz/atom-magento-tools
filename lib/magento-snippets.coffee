MagentoSnippetsView = require './magento-snippets-view'
{CompositeDisposable} = require 'atom'

module.exports = MagentoSnippets =
  magentoSnippetsView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @magentoSnippetsView = new MagentoSnippetsView(state.magentoSnippetsViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @magentoSnippetsView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'magento-snippets:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @magentoSnippetsView.destroy()

  serialize: ->
    magentoSnippetsViewState: @magentoSnippetsView.serialize()

  toggle: ->
    console.log 'MagentoSnippets was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
