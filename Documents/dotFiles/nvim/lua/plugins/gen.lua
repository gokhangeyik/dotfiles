return {
  "David-Kunz/gen.nvim",
  enabled = true,
  lazy = false,
  keys = {
    {
      "<leader>oc",
      "<cmd>Gen Chat<cr>",
      desc = "Ollama Prompt",
      mode = { "n", "v" },
    },
    {
      "<leader>og",
      "<cmd>Gen Generate<cr>",
      desc = "Ollama Generate",
      mode = { "n", "v" },
    },
    {
      "<leader>od",
      "<cmd>Gen Generate_Docstring<cr>",
      desc = "Ollama Generate Docstring",
      mode = { "n", "v" },
    },
    {
      "<leader>om",
      function()
        require("gen").select_model()
      end,
      desc = "Ollama Select Model",
      mode = { "n", "v" },
    },
  },
  opts = {
    model = "llama3.1:8b", -- The default model to use.
    host = "192.168.178.254", -- The host running the Ollama service.
    port = "11434", -- The port on which the Ollama service is listening.
    quit_map = "q", -- set keymap for close the response window
    retry_map = "<c-r>", -- set keymap to re-send the current prompt
    prompts = {
      ["Generate"] = {
        prompt = "$input",
        replace = true,
      },
      ["Chat"] = {
        prompt = "$input",
      },
      ["Review_Code"] = {
        prompt = "Act as a senior $filetype developer and review the following code and make concise suggestions :\n```$filetype\n$text\n```",
        replace = false,
        extract = "```$filetype\n(.-)```",
      },
      ["Explain_Code"] = {
        prompt = "Act as a senior $filetype developer and explain the following code :\n```$filetype\n$text\n```",
        replace = false,
        extract = "```$filetype\n(.-)```",
      },

      ["Fix_Code"] = {
        prompt = "Act as a senior $filetype developer and fix the bugs and issues in the code, only output the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```",
        replace = false,
        extract = "```$filetype\n(.-)```",
      },
      ["Enhance_Code"] = {
        -- prompt = "You are an expert software engineer proficient in multiple programming languages. Your task is to generate, complete, and refactor code snippets based on the given instructions. Provide clean, efficient, and well-commented code. For smaller changes (just a few lines) you should output the complete changed function/class/method along with the corresponding filename and line number and for larger changes output the entire changed file. Avoid explaining your solutions unless prompted to do so and be as concise as possible. Follow best practices, use the latest conventions and libraries and ensure the code is easy to understand and maintain.\n```$filetype\n$text\n```",
        prompt = "Act as a senior $filetype developer, consider all coding standards and enhance the code, do not output anything other than the code, only output the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```",
        replace = true,
        extract = "```$filetype\n(.-)```",
      },
      ["Generate_Docstring"] = {
        prompt = "Act as senior $filetype developer and generate docstring preferably in google style for the follwing code, only output the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```",
        replace = true,
        extract = "```$filetype\n(.-)```",
      },
    },
    init = function(options)
      pcall(io.popen, "ollama serve > /dev/null 2>&1 &")
    end,
    -- Function to initialize Ollama
    command = function(options)
      local body = { model = options.model, stream = true }
      return "curl --silent --no-buffer -X POST http://" .. options.host .. ":" .. options.port .. "/api/chat -d $body"
    end,
    -- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
    -- This can also be a command string.
    -- The executed command must return a JSON object with { response, context }
    -- (context property is optional).
    -- list_models = '<omitted lua function>', -- Retrieves a list of model names
    display_mode = "float", -- The display mode. Can be "float" or "split" or "horizontal-split".
    show_prompt = false, -- Shows the prompt submitted to Ollama.
    show_model = false, -- Displays which model you are using at the beginning of your chat session.
    no_auto_close = false, -- Never closes the window automatically.
    debug = false, -- Prints errors and the command which is run.
  },
}
