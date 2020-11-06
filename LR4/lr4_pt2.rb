=begin
Полþзователþ запускает программу и отвеùает на вопрос, с каким ресурсом он хоùет
взаимодействоватþ
- После ùего он может передатþ тип запроса GET/POST/PUT/DELETE
 - GET index - должен возвраûатþ все постý из памāти и их индекс в массиве (прим. 0.
Hello World \n 1. Hello (again))
 - GET show - должен запраúиватþ идентификатор поста и показýватþ пост по
переданному идентификатору (как в index толþко 1 пост)
 - POST create - должен запраúиватþ текст поста, добавлāтþ его в массив постов и
возвраûатþ в ответ идентификатор поста и сам пост
 - PUT update - должен запраúиватþ идентификатор поста, потом новýй текст поста и
заменитþ его. В резулþтате вýводитþ пост (как в ÿкúене index)
 - DELETE destroy - должен запраúиватþ идентификатор поста, затем удалāтþ его из
массива постов
Задание #2
SOFTWARE ENGINEERING
- Нужно реализоватþ логику длā PostsController
- Добавитþ CommentsController самостоāтелþно
В отùете по заданиĀ расписатþ, понимание работý класса Router, приùинý, по
которýм исполþзуетсā extend длā модулā Resource
В слуùае неправилþного ввода (командý), ваúа программа должна вýдатþ
соответствуĀûее сообûение об оúибке, которое говорит клиенту, как ее
исправитþ. Нелþзā просто вýводитþ "Error!" - ÿто не поможет.
=end

class Post
  attr_accessor :content, :comments
  def initialize(content)
    @content = content
    @comments = []
  end
end

module Resource
  def connection(routes)
    if routes.nil?
      puts "No route matches for #{self}"
      return
    end

    loop do
      print 'Choose verb to interact with resources (GET/POST/PUT/DELETE) / q to exit: '
      verb = gets.chomp.upcase!
      break if verb == 'q'

      if verb != "GET" and verb != "POST" and verb != "PUT" and verb != "DELETE" and verb != "q" then
        puts "Exception: wrong argument"
        next
      end

      action = nil

      if verb == 'GET'
        print 'Choose action (index/show) / q to exit: '
        action = gets.chomp.downcase!
        break if action == 'q'
      end

      action.nil? ? routes[verb].call : routes[verb][action].call
    end
  end
end

class PostsController
  extend Resource

  def initialize(posts)
    @posts = posts
  end

  def index
    (0..(@posts.size - 1)).each { |i|
      puts i.to_s + " " + @posts[i].content
    }
  end

  def show
    print 'Choose index of post: '
    index = gets.chomp
    puts @posts[index.to_i].content
  end

  def create
    puts "Enter your post's content:"
    content = gets.chomp
    @posts.push(Post.new(content))
  end

  def update
    print 'Choose index of post: '
    index = gets.chomp
    puts "Rewrite your post's content:"
    content = gets.chomp
    @posts[index.to_i].content = content
  end

  def destroy
    print 'Choose index of post: '
    index = gets.chomp
    @posts.delete_at(index.to_i)
  end

end

#Controller for comments
class CommentsController
  extend Resource

  def initialize(posts)
    @posts = posts
  end

  def index
    (0..(@posts.size - 1)).each { |i|
      puts "post index: #{i}"
      puts "post content:\n" + @posts[i].content
      puts "comments: "
      (0..(@posts[i].comments.size - 1)).each { |j|
        puts j.to_s + " " + @posts[i].comments[j]
      }
    }
  end

  def show
    print 'Choose index of post: '
    post_index = gets.chomp
    print 'Choose index of comment: '
    comment_index = gets.chomp
    puts @posts[post_index.to_i].comments[comment_index.to_i]

  end

  def create
    print "Choose index of the post for which you are writing a comment: "
    index = gets.chomp
    puts "Enter your comment:"
    comment = gets.chomp
    @posts[index.to_i].comments.push(comment)
  end

  def update
    print 'Choose index of post: '
    post_index = gets.chomp
    print 'Choose index of comment: '
    comment_index = gets.chomp
    puts "Rewrite comment:"
    comment = gets.chomp
    @posts[post_index.to_i].comments[comment_index.to_i] = comment

  end

  def destroy
    print 'Choose index of post: '
    post_index = gets.chomp
    print 'Choose index of comment: '
    comment_index = gets.chomp
    @posts[post_index.to_i].comments.delete_at(comment_index.to_i)
  end
end


class Router
  def initialize
    @routes = {}
  end

  def init

    posts = []

    resources(PostsController, 'posts', posts)
    resources(CommentsController,'comments', posts)

    loop do
      print 'Choose resource you want to interact (1 - Posts, 2 - Comments, q - Exit): '
      choise = gets.chomp

      PostsController.connection(@routes['posts']) if choise == '1'
      CommentsController.connection(@routes['comments']) if choise == '2'
      break if choise == 'q'
    end

    puts 'Good bye!'
  end

  def resources(klass, keyword, posts_arr)
    controller = klass.new(posts_arr)
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