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
end
