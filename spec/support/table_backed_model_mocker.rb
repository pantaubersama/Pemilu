# = TableBackedModelMocker
#
# Example:
#
#   require 'rails_helper'
#
#   describe 'MyModule' do
#     include TableBackedModelMocker
#
#     before { ActiveRecord::Base.connection.create_table model.table_name }
#     after { ActiveRecord::Base.connection.drop_table model.table_name }
#
#     let(:model) { build_mock_model }
#     let!(:record) { model.create! }
#
#     it { expect(model.first!).to eq(record) }
#   end
module TableBackedModelMocker
  # Creates model.
  #
  # Without arguments and block:
  #
  #   model = build_mock_model        # => #<Class:0x00007fa1580d2dd8>(Table doesn't exist)
  #   model.is_a?(ActiveRecord::Base) # => true
  #   model.table_name                # => "test_1e298e_records"
  #   model.new                       # => #<Record >
  #
  # With arguments and block:
  #
  #   model = build_mock_model name: 'Foo', base: ApplicationRecord do
  #     self.table_name = 'my_table'
  #   end
  #   # => #<Class:0x00007fa45f174db8>(id: integer, created_at: datetime, updated_at: datetime)
  #
  #   model.is_a?(ApplicationRecord) # => true
  #   model.table_name               # => "my_table"
  #   model.new                      # => #<Foo id: nil, created_at: nil, updated_at: nil>
  def build_mock_model(name: 'Record', base: ActiveRecord::Base, &block)
    Class.new base do
      self.table_name = "test_#{SecureRandom.hex(3)}_records" if respond_to?(:table_name=)

      define_method :inspect do
        super().sub(/#<Class:0x\w+>/, name)
      end

      instance_eval(&block) if block_given?
    end
  end
end
