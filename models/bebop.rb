require('pg')

class Bounty
  attr_accessor :name, :bounty, :danger, :fav_weapon
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @bounty = options['bounty'].to_i
    @danger = options['danger']
    @fav_weapon = options['fav_weapon']
  end

  def save()
    db = PG.connect({dbname: 'bebop', host: 'localhost'})
    sql = "INSERT INTO bounties
    (name, bounty, danger, fav_weapon)
    VALUES
    ($1, $2, $3, $4) RETURNING *
    "
    values = [@name, @bounty, @danger, @fav_weapon]
    db.prepare("save", sql)
    @id = db.exec_prepared("save", values) [0]['id'].to_i
    db.close()
  end

  def delete()
    db = PG.connect({dbname: 'bebop', host: 'localhost'})
    sql = "DELETE FROM bounties WHERE id = $1"
    values = [@id]
    db.prepare("delete_one", sql)
    db.exec_prepared("delete_one", values)
    db.close()
  end

  def update()
    db = PG.connect({dbname: 'bebop', host: 'localhost'})
    sql = "UPDATE bounties
    SET(
      name, bounty, danger, fav_weapon
      ) = (
        $1, $2, $3, $4
      )
      WHERE id = $5"
      values = [@name, @bounty, @danger, @fav_weapon, @id]
      db.prepare("update", sql)
      orders = db.exec_prepared("update", values)
      db.close()
    end

    def Bounty.all()
      db = PG.connect({dbname: 'bebop', host: 'localhost'})
      sql = "SELECT * FROM bounties"
      db.prepare("all", sql)
      bounties = db.exec_prepared("all")
      db.close()
      return bounties.map { |b| Bounty.new(b)}
    end

    def Bounty.delete_all()
      db = PG.connect({dbname: 'bebop', host: 'localhost'})
      sql = "DELETE FROM bounties"
      db.prepare("delete_all", sql)
      db.exec_prepared("delete_all")
      db.close()
    end

    def Bounty.find_by_name(name)
      db = PG.connect({dbname: 'bebop', host: 'localhost'})
      sql = "SELECT * FROM bounties WHERE name = $1"
      values = [name]
      db.prepare("find_by_name", sql)
      result = db.exec_prepared("find_by_name", values)
      db.close()
      # return result
      check = result.map { |b| Bounty.new(b)}
      if check == []
        return nil
      else
        return check
      end
    end

    def Bounty.find_by_id(id)
      db = PG.connect({dbname: 'bebop', host: 'localhost'})
      sql = "SELECT * FROM bounties WHERE id = $1"
      values = [id]
      db.prepare("find_by_id", sql)
      result = db.exec_prepared("find_by_id", values)
      db.close()
      # return result
      check = result.map { |b| Bounty.new(b)}
      if check == []
        return nil
      else
        return check
      end
    end

  end
