require 'sequel'
DB = Sequel.connect('postgres://postgres:postgres@localhost:5432/db_notify') # requires pg

DB.drop_table?(:items)

DB.create_table :items do
  primary_key :id
  String :name
  Float :price
end

DB.execute("
CREATE OR REPLACE FUNCTION notify_event() RETURNS TRIGGER AS $$
  DECLARE
    record RECORD;
    payload JSON;
  BEGIN
    IF (TG_OP = 'DELETE') THEN
      record = OLD;
    ELSE
      record = NEW;
    END IF;

    payload = json_build_object('table', TG_TABLE_NAME,
                                'action', TG_OP,
                                'data', row_to_json(record));

    PERFORM pg_notify('events', payload::text);

    RETURN NULL;
  END;
$$ LANGUAGE plpgsql;
")

DB.execute("
CREATE TRIGGER notify_order_event
AFTER INSERT OR UPDATE OR DELETE ON items
  FOR EACH ROW EXECUTE PROCEDURE notify_event();
")

DB.listen(:events, loop: true) do |_channel, _pid, payload|
  puts payload
end
