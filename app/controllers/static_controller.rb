class StaticController < ApplicationController
  layout "standard"
    NO_CACHE = [

    ]
    layout "standard"
    def index
       if template_exists? path = 'static/' + params[:path].join('/')
          render_cached path
       else
         if template_exists? path += 'index.rhtml'
           render_cached path
         else
            redirect_to :path => '404.html'
            #raise ::ActionController::RoutingError,
            #      "Recognition failed for #{request.path.inspect}"
         end
       end
    end

    private

    def render_cached(path)
      # if NO_CACHE.include? path
          render :template => path
     #  else
     #     key = path.gsub('/', '-')
     #     unless content = read_fragment(key)
     #        content = render_to_string :template => path, :layout => false
     #        write_fragment(key, content)
     #     end
     #     render :text => content, :layout => true
     #  end
    end
end
