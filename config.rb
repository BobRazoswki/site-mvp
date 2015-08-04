activate :dotenv
# This is the website version registered in Mixpanel
# It should match the minor version (e.g. 2.1) of the website
set :website_version, 2.2

Dir["lib/*.rb"].each { |file| require file }

###
# Compass
###

activate :directory_indexes
activate :meta_tags

set :url_root, 'http://www.makersacademy.com'
activate :search_engine_sitemap

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", layout: false
#
# With alternative layout
# page "/path/to/file.html", layout: :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Methods defined in the helpers block are available in templates
helpers CurrentPageHelper, PartnerLogosHelper, MarkdownHelper, PossessiveHelper, SlugHelper, ImageHelper, GraduateHelper

# Proxy pages (https://middlemanapp.com/advanced/dynamic_pages/)
data.graduates.each do | grad |
  if grad[:case_study]
    full_name = "#{grad[:first_name]} #{grad[:last_name]}"
    url_slug = slug(full_name)
    proxy "/case-studies/#{url_slug}.html", "/case-studies/template.html", locals: { grad: grad }, ignore: true
  end
end

set :css_dir, 'sass'
set :js_dir, 'javascripts'
set :partials_dir, 'partials'
set :images_dir, 'images'

sprockets.append_path File.join root, 'bower_components'

set :apply_form_url, "https://apply.makersacademy.com"

# Redirects from old site urls
redirect "payments/new.html", to: "#{config.apply_form_url}/payments/new"
redirect "apply.html", to: config.apply_form_url
redirect "apply-for-ronin.html", to: "#{config.apply_form_url}/ronin/application"
redirect "fellowship.html", to: "http://techcityfellowship.org/"

configure :development do
  activate :livereload
  set :mixpanel_token, 'f3e503bb7803dd7089f5b4124baa03a4'

  # custom setting for switching off analytics in development
  set :run_analytics, false

  # turn on to view a baseline grid for setting vertical rhythm
  set :show_baseline_grid, false
end

# Build-specific configuration
configure :build do

  activate :imageoptim do |options|
    options.pngout    = false
    options.svgo      = false
  end

  # For example, change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  # Enable cache buster
  activate :asset_hash

  # Use relative URLs
  # activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"

  set :run_analytics, true

  set :mixpanel_token, 'b839b30fbe0796d650ae20e7eae6d0d1'

  set :show_baseline_grid, false

  ignore 'elements.html.haml'
  ignore 'typography.html.haml'
  ignore 'form-styles.html.haml'
end
