require_relative('../db/sql_runner')

class Ticket

  attr_reader :id, :customer_id, :film_id

  def initialize(options)
    @id = options['id'].to_i
    @customer_id = options.fetch('customer_id').to_i
    @film_id = options.fetch('film_id').to_i
  end

  def save()
    sql = "INSERT INTO tickets
      (customer_id, film_id)
      VALUES (#{@customer_id}, #{@film_id})
      RETURNING *"
    ticket = SqlRunner.run(sql).first
    @customer_id = ticket['customer_id'].to_i
    @film_id = ticket['film_id'].to_i
    @id = ticket['id'].to_i
  end

  # def sell_ticket
  #   sql = ""
  # end

  def self.all
    sql = "SELECT * FROM tickets"
    tickets = SqlRunner.run(sql)
    result = tickets.map { |ticket| Ticket.new(ticket) }
    return result
  end

  def self.delete_all
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
    return nil
  end

end