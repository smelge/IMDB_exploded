require('pg')

class Movie
  attr_reader :id
  attr_accessor :title,:genre

  def initialize(options)
    @title = options['title']
    @genre = options['genre']
    @id = options['id'].to_i if options['id']
  end

  def save()
    sql = '
      INSERT INTO movies
      (title,genre)
      VALUES
      ($1,$2)
      RETURNING id
    '

    result = SqlRunner.run(sql,[@title,@genre])
    @id = result[0]['id'].to_i
  end

  def self.delete_all()
    sql = 'DELETE FROM movies'
    SqlRunner.run(sql)
  end
end
