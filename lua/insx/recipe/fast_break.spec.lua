local insx = require('insx')
local spec = require('insx.spec')

describe('insx.recipe.fast_break', function()
  it('should work', function()
    insx.add(
      '<CR>',
      require('insx.recipe.fast_break')({
        open_pat = insx.helper.regex.esc('('),
        close_pat = insx.helper.regex.esc(')'),
        split = true,
      })
    )
    spec.assert(
      {
        'foo(',
        '  bar(|)',
        ')',
      },
      '<CR>',
      {
        'foo(',
        '  bar(',
        '    |',
        '  )',
        ')',
      }
    )
    spec.assert(
      {
        'foo(',
        '  bar(|baz)',
        ')',
      },
      '<CR>',
      {
        'foo(',
        '  bar(',
        '    |baz',
        '  )',
        ')',
      }
    )
    spec.assert(
      {
        '\t\t{',
        '\t\t\tfoo::bar(|$foo, { $bar, 1 }, $baz)',
        '\t\t}',
      },
      '<CR>',
      {
        '\t\t{',
        '\t\t\tfoo::bar(',
        '\t\t\t\t|$foo,',
        '\t\t\t\t{ $bar, 1 },',
        '\t\t\t\t$baz',
        '\t\t\t)',
        '\t\t}',
      },
      {
        filetype = 'php',
        noexpandtab = true,
        shiftwidth = 4,
        tabstop = 4,
      }
    )

    insx.clear()
    insx.add(
      '<CR>',
      require('insx.recipe.fast_break')({
        open_pat = insx.helper.regex.esc('('),
        close_pat = insx.helper.regex.esc(')'),
        split = false,
      })
    )
    spec.assert(
      {
        'foo(',
        '  bar(|)',
        ')',
      },
      '<CR>',
      {
        'foo(',
        '  bar(',
        '    |',
        '  )',
        ')',
      }
    )
    spec.assert(
      {
        'foo(',
        '  bar(|baz)',
        ')',
      },
      '<CR>',
      {
        'foo(',
        '  bar(',
        '  |baz)',
        ')',
      }
    )
    spec.assert(
      {
        '\t\t{',
        '\t\t\tfoo::bar(|$foo, { $bar, 1 }, $baz)',
        '\t\t}',
      },
      '<CR>',
      {
        '\t\t{',
        '\t\t\tfoo::bar(',
        '\t\t\t|$foo, { $bar, 1 }, $baz)',
        '\t\t}',
      },
      {
        filetype = 'php',
        noexpandtab = true,
        shiftwidth = 4,
        tabstop = 4,
      }
    )
  end)
end)
