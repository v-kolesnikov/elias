ROM::SQL.migration do
  up do
    run <<-SQL
      CREATE FUNCTION bookings_now() RETURNS timestamp with time zone
        LANGUAGE sql IMMUTABLE COST 0.00999999978
        AS $$SELECT '2016-10-13 17:00:00'::TIMESTAMP
        AT TIME ZONE 'Europe/Moscow';$$
    SQL
  end

  down do
    run 'DROP FUNCTION bookings_now()'
  end
end
