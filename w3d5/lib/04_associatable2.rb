require_relative '03_associatable'

# Phase IV
module Associatable
  # Remember to go back to 04_associatable to write ::assoc_options

  def has_one_through(name, through_name, source_name)
    through_options = assoc_options[through_name]
    define_method("#{name}") do
      source_options = through_options.model_class.assoc_options[source_name]

      through_table = through_options.table_name
      source_table = source_options.table_name

      through_pk = through_options.primary_key
      source_pk = source_options.primary_key

      through_fk = through_options.foreign_key
      source_fk = source_options.foreign_key

      start_fk_value = self.send(through_fk)
      
      list = DBConnection.execute(<<-SQL, start_fk_value)
        SELECT
          #{source_table}.*
        FROM
          #{source_table}
        JOIN
          #{through_table} ON #{through_table}.#{source_fk} = #{source_table}.#{source_pk}
        WHERE
          #{through_table}.#{through_pk} = ?
      SQL

      source_options.model_class.new(list.first)
    end
  end
end
