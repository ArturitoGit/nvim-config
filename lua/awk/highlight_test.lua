local M = require('awk.highlight')

describe('find_all', function()

  it('should return all positions of given pattern in expression', function()
    local result = M.find_all('arthur', 'r')
    assert.are.equals(2, #result)
    assert.are.equals(2, result[1])
    assert.are.equals(6, result[2])
  end)

  it('should return empty when expression does not contain pattern', function()
    local result = M.find_all('arthur', 'x')
    assert.are.equals(0, #result)
  end)

end)

describe('find_column', function ()

  it('should return position of matched column', function()
    local col_start, col_end = M.find_column(1, 'one;two;three')
    assert.are.equals(1, col_start)
    assert.are.equals(4, col_end)
  end)

  it('should return position of any column', function()
    local col_start, col_end = M.find_column(2, 'one;two;three')
    assert.are.equals(5, col_start)
    assert.are.equals(8, col_end)
  end)

  it('should return position of last column', function()
    local col_start, col_end = M.find_column(3, 'one;two;three')
    assert.are.equals(9, col_start)
    assert.are.equals(14, col_end)
  end)

  it('should return (nil, nil) if there is not enough columns', function()
    local col_start, col_end = M.find_column(5, ';one;two;three')
    assert.are.equals(nil, col_start)
    assert.are.equals(nil, col_end)
  end)

  it('should return (nil, nil) if given column <= 0', function()
    local col_start, col_end = M.find_column(0, 'one;two;three')
    assert.are.equals(nil, col_start)
    assert.are.equals(nil, col_end)
  end)

  it('should use provided separator', function()
    local col_start, col_end = M.find_column(1, 'one:two:three', ':')
    assert.are.equals(1, col_start)
    assert.are.equals(4, col_end)
  end)

  it('should ; as default separator', function()
    local col_start, col_end = M.find_column(1, 'one;two;three')
    assert.are.equals(1, col_start)
    assert.are.equals(4, col_end)
  end)

end)
