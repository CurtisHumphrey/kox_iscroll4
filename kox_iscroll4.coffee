###
  @author Curtis M. Humphrey, Ph.D.
  
  The files adds a KO binding for iScroll 4
      
  Dependence (from global namespace):
    ko - knockoutjs
    iScroll 4 - from http://cubiq.org/iscroll-4
      
  Public API, Fired Events, or Exports
    export on ko as a new binding e.g., data-bind="iscroll4: value"
      where value = 
        update_on: ko observableArray, 
        enable_when: ko observable (true / false)
        parameters.. from iscroll documentation


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
    org = ko.utils.unwrapObservable valueAccessor()
    
    #make copy
    values = []
    values[k] = org[k] for k, v of org
    
    #peel out update_on
    update_on = values.update_on ? false
    delete values.update_on
    
    #peel out enable_when
    enable_when = values.enable_when ? false
    delete values.enable_when
    
    element[has_iscroll] = new iScroll element, values
    
    #setup subscribes
    if update_on isnt false
      update_on.subscribe (newValue) ->
        Refresh()
    
    if enable_when isnt false
      enable_when.subscribe (newValue) ->
        console.log "scroll state:" + newValue
        if newValue
          element[has_iscroll].enable()
        else
          element[has_iscroll].disable()
    
    Refresh()
    

   
    
