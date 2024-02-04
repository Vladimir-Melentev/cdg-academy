module Resource
  def connection(routes)
    if routes.nil?
      puts "No route matches for #{self}"
      return
    end

    loop do
      print 'Choose verb to interact with resources (GET/POST/PUT/DELETE) / q to exit: '
      verb = gets.chomp.upcase
      break if verb == 'q'

      action = nil

      if verb == 'GET'
        print 'Choose action (index/show) / q to exit: '
        action = gets.chomp
        break if action == 'q'
      end


      action.nil? ? routes[verb].call : routes[verb][action].call
    end
  end
end

class PostsController
  extend Resource

  def initialize
    @posts = []
  end

  def index
    if @posts.empty?
      puts "No post available"
      return
    end

    post_list = @posts.each_with_index.map { |post, index| "#{index}: #{post[:text]}" }.join("\n")

    puts post_list
  end

  def show
    print "Enter the post index: "
    post_index = gets.chomp.to_i

    if post_index >= 0 && post_index < @posts.length
      puts "#{post_index}: #{@posts[post_index]}"
    else
      puts "Invalid post index"
    end
  end

  def create
    puts "Enter text for added"
    post_text = gets.chomp

    post_hash = { id: @posts.length, text: post_text }
    @posts << post_hash

    puts post_hash
  end

  def update
    puts "Enter id number the post to refactoring: "
    post_index = gets.chomp.to_i

    if post_index >= 0 && post_index < @posts.length
      print "Enter the new text for the post: "
      new_text = gets.chomp

      @posts[post_index][:text] = new_text

      puts "#{post_index}: #{@posts[post_index][:text]}"
    else
      puts "Invalid post index"
    end
  end

  def destroy
    puts "Enter id number the post to delete: "
    post_index = gets.chomp.to_i

    if post_index >= 0 && post_index < @posts.length
      delete_post = @posts.delete_at(post_index)
      puts "Post #{post_index} delete: #{delete_post[:text]}"
    else
      puts "Invalid post index"
    end
  end
end

class Router
  def initialize
    @routes = {}
  end

  def init
    resources(PostsController, 'posts')

    loop do
      print 'Choose resource you want to interact (1 - Posts, 2 - Comments, q - Exit): '
      choice = gets.chomp

      PostsController.connection(@routes['posts']) if choice == '1'
      break if choice == 'q'
    end

    puts 'Good bye!'
  end

  def resources(klass, keyword)
    controller = klass.new
    @routes[keyword] = {
      'GET' => {
        'index' => controller.method(:index),
        'show' => controller.method(:show)
      },
      'POST' => controller.method(:create),
      'PUT' => controller.method(:update),
      'DELETE' => controller.method(:destroy)
    }
  end
end

router = Router.new

router.init