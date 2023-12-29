local get_args = function()
  -- 获取输入命令行参数
  local cmd_args = vim.fn.input('Args:')
  local params = {}
  -- 定义分隔符(%s在lua内表示任何空白符号)
  local sep = "%s"
  for param in string.gmatch(cmd_args, "[^%s]+") do
    table.insert(params, param)
  end
  return params
end;

return {
  'mfussenegger/nvim-dap-python',
  dependencies = {
    { 'mfussenegger/nvim-dap' },
    { 'rcarriga/nvim-dap-ui' },
  },
  config = function ()
    local dap = require('dap')
    dap.configurations.python = {
      {
	type = 'python';
	request = 'launch';
	name = "Launch file";
	program = "${file}";
	args = get_args;
	pythonPath = 'python'
      },
    }
    dap.adapters.python = {
      type = 'executable';
      command = os.getenv('HOME') .. '/.local/share/nvim/mason/packages/debugpy/bin/python';
      args = { '-m', 'debugpy.adapter' };
    }
    local dapui = require("dapui")
    dapui.setup(
      {
	layouts = {{
	  elements = {{
	      id = "scopes",
	      size = 0.3
	    },
	    {
	      id = "watches",
	      size = 0.7
	    }
	  },
	  position = "bottom",
	  size = 10
	},{
	  elements = {{
	      id = "repl",
	      size = 0.75
	    },
	    {
	      id = "breakpoints",
	      size = 0.25
	    }},
	  position = "left",
	  size = 40
	}},
      }
    )
    dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open({})
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close({})
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close({})
    end
  end
}
