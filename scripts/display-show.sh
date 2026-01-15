#!/bin/bash

# 获取DisplayPort显示器状态
get_dp_status() {
    local dp_status=$(xrandr | grep -E "DP-[12] ")
    echo "$dp_status"
}

# 主程序
get_detailed_status() {
    # 检查DP-1 (虚拟)
    local dp1=$(xrandr | grep "^DP-1 " | awk '{print $2}')
    if [[ "$dp1" == "connected" ]]; then
        local dp1_res=$(xrandr | grep "^DP-1 " | grep -oP '\d+x\d+' | head -1)
        DP1="✅ $dp1_res"
    else
        DP1="❌ 未连接"
    fi
    
    # 检查DP-2 (真实)
    local dp2=$(xrandr | grep "^DP-2 " | awk '{print $2}')
    if [[ "$dp2" == "connected" ]]; then
        local dp2_res=$(xrandr | grep "^DP-2 " | grep -oP '\d+x\d+' | head -1)
        DP2="✅ $dp2_res"
    else
        DP2="❌ 未连接"
    fi
}

# 使用kdialog显示信息
show_dialog() {
    get_detailed_status
    kdialog --passivepopup "🖥 显示器状态\n虚拟 DP-1: $DP1\n真实 DP-2: $DP2" 3
}

# 主程序
show_dialog
