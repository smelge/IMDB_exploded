require('pg')
require_relative('../db/runner_sql.rb')

class Actor
  attr_reader :id
  attr_accessor :first_name,:last_name

  def initialize(options)
    @first_name = options['first_name']
    @last_name = options['last_name']
    @id = options['id'].to_i if options['id']
  end

  def save()
    sql = '
      INSERT INTO actors
      (first_name,last_name)
      VALUES
      ($1,$2)
      RETURNING id
    '

    result = SqlRunner.run(sql,[@first_name,@last_name])
    @id = result[0]['id'].to_i
  end

  def self.delete_all()
    sql = 'DELETE FROM actors'
    SqlRunner.run(sql)
  end

  def self.all()
    sql = '
      SELECT * FROM actors ORDER BY last_name
    '

    SqlRunner.run(sql).map do |actor|
      Actor.new(actor)
    end
  end

  def update()
    sql = '
      UPDATE actors
      SET
      first_name = $1,
      last_name = $2
      WHERE id = $3
    ;'
    SqlRunner.run(sql,[@first_name,@last_name,@id])
  end

  def movies()
    sql='
      SELECT movies.title
      FROM movies
      INNER JOIN roles
      ON movies.id = roles.movie_id
      INNER JOIN actors
      ON actors.id = roles.actor_id
      WHERE actors.id = $1
    '

    SqlRunner.run(sql,[@id]).to_a
  end
end
