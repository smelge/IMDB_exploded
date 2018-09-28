require('pg')

class Role
  attr_reader :id
  attr_accessor :movie_id,:actor_id,:fee

  def initialize(options)
    @movie_id = options['movie_id']
    @actor_id = options['actor_id']
    @fee = options['fee']
    @id = options['id'].to_i if options['id']
  end

  def save()
    sql = '
      INSERT INTO roles
      (movie_id,actor_id,fee)
      VALUES
      ($1,$2,$3)
      RETURNING id
    '

    result = SqlRunner.run(sql,[@movie_id,@actor_id,@fee])
    @id = result[0]['id'].to_i
  end

  def self.delete_all()
    sql = 'DELETE FROM roles'
    SqlRunner.run(sql)
  end

  def self.all()
    sql = '
      SELECT * FROM roles
    '

    SqlRunner.run(sql).map do |role|
      Role.new(role)
    end
  end

  def update()
    sql = '
      UPDATE roles
      SET
      movie_id = $1,
      actor_id = $2,
      fee = $3
      WHERE id = $4
    ;'
    SqlRunner.run(sql,[@movie_id,@actor_id,@fee,@id])
  end
end
