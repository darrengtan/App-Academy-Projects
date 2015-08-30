require_relative 'db_connection'
require_relative '01_sql_object'
require 'byebug'

module Searchable
  def where(params)
    where_line = params.map { |k, v| "#{k} = ?"}.join(" AND ")
    where_rows = DBConnection.execute(<<-SQL, params.values)
      SELECT
        *
      FROM
        #{table_name}
      WHERE
        #{where_line}
    SQL

    where_rows.map { |object| self.new(object) }
  end
end

class SQLObject
  extend Searchable
end
