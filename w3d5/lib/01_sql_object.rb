require_relative 'db_connection'
require 'active_support/inflector'
require 'byebug'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    rows = DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        #{table_name}
    SQL

    rows.first.map(&:to_sym)
  end

  def self.finalize!
    columns.each do |column|
      define_method("#{column}") do
        attributes[column]
      end

      define_method("#{column}=") do |value|
        attributes[column] = value
      end
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name ||= "#{self}".tableize
  end

  def self.all
    rows = DBConnection.execute(<<-SQL)
      SELECT
        *
      FROM
        #{table_name}
    SQL
    objects = parse_all(rows)
  end

  def self.parse_all(results)
    # byebug
    results.map { |hash| self.new(hash) }

  end

  def self.find(id)
    rows = DBConnection.execute(<<-SQL, id)
      SELECT
        *
      FROM
        #{table_name}
      WHERE
        id = ?
    SQL

    self.parse_all(rows).first
  end

  def initialize(params = {})
    params.each do |attr_name, value|
      name = attr_name.to_sym
      unless self.class.columns.include?(name)
        raise "unknown attribute '#{name}'"
      end

      send("#{attr_name}=", value)
    end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    attributes.map { |attr| send(attr.first) }
  end

  def insert
    n = self.class.columns.count - 1
    col_names = self.class.columns[1..-1].join(", ")
    attr_values = self.attribute_values
    question_marks = (["?"] * n).join(", ")

    DBConnection.execute(<<-SQL, attr_values)
      INSERT INTO
        #{self.class.table_name} (#{col_names})
      VALUES
        (#{question_marks})
    SQL

    send("id=", DBConnection.last_insert_row_id)
  end

  def update
    n = self.class.columns.count - 1
    cols = self.class.columns.rotate
    options = attribute_values.rotate
    set_line = []
    cols.each do |attr_name|
      set_line << "#{attr_name} = ?"
    end
    set_line = set_line[0...-1].join(", ")
    DBConnection.execute(<<-SQL, options)
      UPDATE
        #{self.class.table_name}
      SET
        #{set_line}
      WHERE
        id = ?
    SQL
  end

  def save
    id.nil? ? insert : update
  end
end
