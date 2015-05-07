require 'rspec'
require_relative 'tictactoe'

describe Game do
  it 'exists' do
    expect(Game.new).to be_a_kind_of(Game)
  end

  it 'disallows choosing the same position twice' do
    game = Game.new
    game.select(0,0)
    expect { game.select(0,0) }.to raise_error(Game::InvalidSelectionError)
  end
end

describe Grid do
  it 'exists' do
    expect(Grid.new).to be_a_kind_of(Grid)
  end

  it 'allows selection' do
    expect { grid = Grid.new.select('o', at: { x: 0, y: 0 }) }.to_not raise_error
    expect(grid.representation).to eq "|o| | |\n| | | |\n| | | |"
  end

  it 'knows if it is valid?' do
    expect(
      Grid.new.select('o', at: { x: 0, y: 0 })
    ).to be_valid

    grid = Grid.new
    grid.select('o', at: { x: 0, y: 0 })
    grid.select('o', at: { x: 0, y: 0 })
    expect(grid).to_not be_valid
  end
end
