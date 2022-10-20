# THINGS IN HERE

## GEMS

```
gem "sassc-rails"
gem 'devise'
gem 'will_paginate'
# gem 'paperclip'
# gem 'aws-sdk'
```
- no paperclip needed
- sass rails for .scss files
- image processing for storage
- devise set for turbo, rails 7
- from: https://dev.to/efocoder/how-to-use-devise-with-turbo-in-rails-7-9n9
- didnt use aws-sdk

## MODELS
- devise podcast: has many episodes, has an image
- added fields to the podcast
- updated the sign ups to include images etc.

```
  def configure_permitted_parameters
  	devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, :title, :thumbnail)}
  	devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:email, :password, :password_confirmation, :current_password, :title, :thumbnail, :description, :itunes, :stitcher, :podbay)}
  end
end
```

- episodes, has an image and mp3 file

```
  belongs_to :podcast
  has_one_attached :episode_thumbnail
  has_one_attached :mp3_file
end

```

## OTHER
- he did his own styling
- and master scss variables
- used normalize
- for audio tags: https://blog.saeloun.com/2022/06/15/rails-7-extends-audio_tag-and-video_tag-to-accept-active-storage-attachments.html
- for audio, video, image, downloads: https://github.com/corsego/20-active_storage/commit/a932b8e4ce861827da9cc4e86830b1e73ff55565
- the video: https://www.youtube.com/watch?v=Zc043m1YBNI
- added jplayer but couldnt get it to work
- figured out how to add different javascript files

```
in application.js
// import "controllers/test"
// import "./here"
// import "./jquery.jplayer.min"
$(document).on('turbo:load', function() {
	// alert('hi');
});
```

- added javascript cdn for jquery and jplayer

```
    <link href='http://fonts.googleapis.com/css?family=Lato:300,700,300italic,700italic' rel='stylesheet' type='text/css'>   
     <!-- <script src="https://code.jquery.com/jquery-3.6.1.min.js" integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ=" crossorigin="anonymous"></script> -->
    <script src="https://code.jquery.com/jquery-3.6.1.js" integrity="sha256-3zlB5s2uwoUzrXK3BT7AX3FyvojsraNFxCc2vC/7pNI=" crossorigin="anonymous"></script>     
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jplayer/2.9.2/jplayer/jquery.jplayer.min.js" integrity="sha512-g0etrk7svX8WYBp+ZDIqeenmkxQSXjRDTr08ie37rVFc99iXFGxmD0/SCt3kZ6sDNmr8sR0ISHkSAc/M8rQBqg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>   
```

- unless current page

```
  <% unless current_page?(root_path) %>
    <%= render 'layouts/header'; %>
  <% end %>
```

- unless blank

```
<% unless @podcast.itunes.blank? %>
```

- breadcrumbs

```
	<div id="breadcrumb">
		<%= link_to podcasts_path do %>
			All Podcasts
			<span>/</span>
			<%= link_to @podcast.title, podcast_path(@podcast) %>
			<span>/</span>
			<%= @episode.title %>
		<% end %>
	</div>
```

- added audio source

```
<audio controls>
  <source src="<%= rails_blob_url(@episode.mp3_file) %>" type="<%= @episode.mp3_file.content_type %>"/>
</audio>   
```

- added a route for once user is logged in

```
  authenticated :podcast do
    root 'podcasts#dashboard', as: "authenticated_root"
  end

  root 'welcome#index'
end

```

- in the episodes show page, showed other episodes linked with the podcast except the current episode

```
  def show
    @episodes = Episode.where(podcast_id: @podcast).order("created_at DESC").limit(6).reject { |e| e.id == @episode.id }
  end
```