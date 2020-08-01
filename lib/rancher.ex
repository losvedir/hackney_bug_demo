defmodule HackneyBugDemo.Rancher do
  def start_link do
    :ranch.start_listener(__MODULE__, :ranch_tcp, [port: 8081], HackneyBugDemo.Acceptor, [])
  end
end
