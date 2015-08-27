require 'sinatra'
require 'json'
require 'json'

class Session
  @@current_index = 0

  def self.current_index=(index)
    @@current_index = index
  end

  def self.current_index
    @@current_index
  end
end

get '/highlights.json' do
  content_type :json

  books = JSON.parse(File.read('/Users/gaurav/Desktop/highlights.json'))

  book = if params[:index]
    Session.current_index = params[:index].to_i
    books[params[:index].to_i]
  else
    Session.current_index = 0
    books.first
  end

  next_index = if Session.current_index == books.length - 1
    nil
  else
    Session.current_index + 1
  end

  { book: book, next_book_index: next_index }.to_json
end
