require('pg')

class Movie
  attr_reader :id
  attr_accessor :title,:genre,:budget

  def initialize(options)
    @title = options['title']
    @genre = options['genre']
    @budget = options['budget']
    @id = options['id'].to_i if options['id']
  end

  def save()
    sql = '
      INSERT INTO movies
      (title,genre,budget)
      VALUES
      ($1,$2,$3)
      RETURNING id
    '

    result = SqlRunner.run(sql,[@title,@genre,@budget])
    @id = result[0]['id'].to_i
  end

  def self.delete_all()
    sql = 'DELETE FROM movies'
    SqlRunner.run(sql)
  end

  def self.all()
    sql = '
      SELECT * FROM movies ORDER BY title
    '

    SqlRunner.run(sql).map do |movie|
      Movie.new(movie)
    end
  end

  def update()
    sql = '
      UPDATE movies
      SET
      title = $1,
      genre = $2,
      budget = $3
      WHERE id = $4
    ;'
    SqlRunner.run(sql,[@title,@genre,@budget,@id])
  end

  def actors()
    sql='
      SELECT actors.first_name,actors.last_name
      FROM actors
      INNER JOIN roles
      ON actors.id = roles.actor_id
      INNER JOIN movies
      ON movies.id = roles.movie_id
      WHERE movies.id = $1
    '

    SqlRunner.run(sql,[@id]).to_a

  end

  def budget()
    sql='
      SELECT roles.fee,movies.budget
      FROM movies
      INNER JOIN roles
      ON movies.id = roles.movie_id
      INNER JOIN actors
      ON actors.id = roles.actor_id
      WHERE movies.id = $1
    '
    results = SqlRunner.run(sql,[@id]).to_a
    budget_amount = results[0]['budget'].to_i

    results.each do |result|
      fee = result['fee'].to_i
       budget_amount -= fee
    end
    # binding.pry
    return budget_amount
  end
end
