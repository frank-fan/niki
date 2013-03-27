# URL: /
exports.index = (req, res) ->
  res.render 'index', title: 'adc'

# URL: /edit
exports.edit = (req, res) ->
  res.render 'edit', title: 'adc'