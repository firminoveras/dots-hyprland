local ok, sllm = pcall(require, 'sllm')
if not ok then return end

sllm.setup {
  llm_cmd = "llm",
  default_model = "gemini-2.5-flash",
  show_usage = false,
  on_start_new_chat = true,
  reset_ctx_each_prompt = true,
  window_type = "vertical",
  pick_func = vim.ui.select,
  notify_func = notify,
  input_func = vim.ui.input,
  keymaps = false,
}
