// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
// import "controllers/test"
// import "./here"
// import "./jquery.jplayer.min"


$(document).on('turbo:load', function() {
	// alert('hi');
});