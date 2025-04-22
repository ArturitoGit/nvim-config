local find_column_under_cursor = require('awk.cursor_column').find_column_under_cursor

describe('find_column_under_cursor', function()

  it('should return column at line end', function()
    assert.are.equals(4, find_column_under_cursor('print $4', 8))
  end)

  it('should return column before line end', function()
    assert.are.equals(4, find_column_under_cursor('print $4; return 0', 8))
  end)

  it('should not return column that is not a number', function()
    assert.are.equals(nil, find_column_under_cursor('print $t', 8))
  end)

  it('should return multi-digit column', function()
    assert.are.equals(18, find_column_under_cursor('print $18', 9))
  end)

  it('should not return column if cursor is not on it', function()
    assert.are.equals(nil, find_column_under_cursor('print $18', 3))
  end)

  it('should return nil on empty line', function()
    assert.are.equals(nil, find_column_under_cursor('', 0))
  end)

  it('should return complete number', function()
    assert.are.equals(112, find_column_under_cursor('print $112; return 1', 9))
  end)

  it('should return last column if cursor is greater than line size', function()
    assert.are.equals(112, find_column_under_cursor('print $112', 20))
  end)

  it('should return first column if cursor is fewer than 0', function()
    assert.are.equals(115, find_column_under_cursor('$115 > 3', -1))
  end)

  it('should return nil on nil line', function()
    assert.are.equals(nil, find_column_under_cursor(nil, 5))
  end)

end)
