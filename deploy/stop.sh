#!/usr/bin/env bash

# 查找 gunicorn 主进程 PID
# shellcheck disable=SC2009
gunicorn_pid=$(ps aux | grep 'gunicorn' | grep -v 'grep' | awk '{print $2}')

# 如果找到了主进程 PID
if [ -n "$gunicorn_pid" ]; then
  echo "Found gunicorn process: $gunicorn_pid"

  # 给主进程发 SIGINT 信号，请求正常停止进程
  kill -INT "$gunicorn_pid"

  # 睡眠 5 秒等待主进程结束
  sleep 5

  # 查找所有 gunicorn 子进程 PID
  gunicorn_child_pids=$(pstree -p "$gunicorn_pid" | grep -oP '([0-9]+)(?=\))')

  # 如果找到了子进程 PID
  if [ -n "$gunicorn_child_pids" ]; then
    echo "Found gunicorn child processes: $gunicorn_child_pids"

    # 杀死所有子进程
    for pid in $gunicorn_child_pids; do
      kill -9 "$pid"
    done
  fi

  echo "Stopped gunicorn process and child processes"

else
  echo "No running gunicorn process found"
fi