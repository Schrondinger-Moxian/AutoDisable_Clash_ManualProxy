# 检查名为 'Clash for Windows' 的进程是否在运行
$processName = "Clash for Windows"
if (Get-Process -Name $processName -ErrorAction SilentlyContinue) {
    # 如果 'Clash for Windows' 在运行，则重置系统代理设置
    netsh winhttp reset proxy
}
