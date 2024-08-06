# 使用 PowerShell 关闭手动设置的代理服务器
function Disable-ManualProxy {
    # 获取当前代理设置
    $proxy = Get-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings"

    # 只在代理服务器设置开启时进行修改
    if ($proxy.ProxyEnable -eq 1) {
        # 禁用代理服务器
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings" -Name ProxyEnable -Value 0

        # 清空代理服务器地址
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings" -Name ProxyServer -Value ""

        Write-Output "Manual proxy settings have been disabled."
    } else {
        Write-Output "Proxy server is not enabled."
    }
}

# 调用函数来禁用手动代理设置
Disable-ManualProxy
