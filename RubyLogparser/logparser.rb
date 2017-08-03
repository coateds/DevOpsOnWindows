require './model.rb'
require './view.rb'
require './controller.rb'

require 'io/console'

@controller = LogParserController.new
@controller.run

# My Playing around

# view = BasicView.new
# view.clear_display
# view.center("Goober")