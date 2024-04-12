RSpec.shared_examples 'creates a new object' do |klass|
  it "increments the number of #{klass.name}s by 1" do
    expect { perform }.to change { klass.count }.by(1)
  end
end

RSpec.shared_examples 'does not create a new object' do |klass|
  it "increments the number of #{klass.name}s by 0" do
    # rubocop:disable Lint/AmbiguousBlockAssociation
    expect { perform }.not_to change { klass.count }
    # rubocop:enable Lint/AmbiguousBlockAssociation
  end
end
