# URL: /
exports.index = (req, res) ->
  res.render 'index', title: 'adc'

# URL: /about
exports.about = (req, res) ->
  res.render 'about', title: 'adc'