###
  @author Curtis M. Humphrey, Ph.D.
  
  The files adds a KO binding for iScroll 4
      
  Dependence (from global namespace):
    ko - knockoutjs
    iScroll 4 - from http://cubiq.org/iscroll-4
      
  Public API, Fired Events, or Exports
    export on ko as a new binding e.g., data-bind="iscroll4: value"
      where value = update_on: ko observableArray, parameters.. from iscroll documentation


  Notes:
    element that this binding is on needs to have a specified height
    first child of element needs to have the height that contains all its children as it is the scroller
      - often this means float:left;    
###




has_iscroll = '__ko_has_iscroll'
ko.bindingHandlers.iscroll4 =   
  # This will be called when the binding is first applied to an element
  # Set up any initial state, event handlers, etc. here
  init: (element, valueAccessor, allBindingsAccessor, viewModel, bindingContext) ->      
    #create the refresh function
    Refresh = ->
      setTimeout ->
        element[has_iscroll].refresh()
        #console.log "iScroll Refresh"
      , 0
      
    #get values and peel out the update_on
    values = ko.utils.unwrapObservable valueAccessor()
    update_on = values.update_on ? false
    delete values.update_on
    
    element[has_iscroll] = new iScroll element, values
    
    if update_on isnt false
      update_on.subscribe (newValue) ->
        Refresh()
    
    Refresh()
    

   
    
