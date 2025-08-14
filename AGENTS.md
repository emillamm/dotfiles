# Agent Instructions for dotfiles Repository

## Build/Test Commands
- **Build**: `./.make` (if present in project root) or use vim keybinding `ui` (saves & runs make via AsyncRun)
- **Lint/Format**: For Go files, gopls with gofumpt is configured in nvim. No global lint command.
- **Test**: Use project-specific test commands (check for `.make` script first)

## Code Style Guidelines
- **Language**: Primarily Lua (Neovim config), Vim script, and shell scripts
- **Lua Style**: 
  - Use `vim.keymap.set()` for keybindings with descriptive `desc` fields
  - Prefer `require()` for module imports
  - Use single quotes for strings unless interpolation needed
- **Shell Scripts**: Use bash with proper quoting, error checking (`set -e` implied)
- **File Organization**: Config files in `dotfiles/` subdirectory, symlinked via `setup.sh`
- **Indentation**: 2 spaces for Lua/Vim files
- **Comments**: Minimal, only when necessary for complex logic
- **Git**: Never commit swap files or vim plugin directories (see .gitignore)

## Environment Notes
- Neovim config uses mini.nvim ecosystem with lazy loading
- LSP configured for Go (gopls with gofumpt) and Lua
- AsyncRun.vim for async command execution