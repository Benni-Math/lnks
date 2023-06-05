#!/usr/bin/env pwsh

try
{
  # try executing a dummy command to test if we have fzf installed, surpressing any output
  fzf --version 2>&1 | out-null
}
Catch [System.Management.Automation.CommandNotFoundException]
{
  Write-Output "fzf is not installed"
  Exit 1
}

$lnksDirectory = Split-Path -Path $PSCommandPath -Parent

Get-Content "$lnksDirectory\*.txt" | fzf `
  --border=rounded --margin=5% `
  --prompt="Search Bookmarks > " `
  --with-nth='1..-2' `
  --bind="enter:execute-silent(explorer.exe {-1})" `
  --preview='echo {-1}' --preview-window='up,1'



