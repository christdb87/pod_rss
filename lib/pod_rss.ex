defmodule PodRss do

  import SweetXml
  import HTTPoison

  def parse_pod(url) do

  case HTTPoison.get url do
  {:error, _response} ->
    IO.puts("there was an error")
  {:ok, response} ->
    %HTTPoison.Response{body: body} = response
    body |>
    parse_xml() |>
    write_html()
  end
end

def parse_xml(body) do
body |>
xpath(
~x"//item"l,
title: ~x"./title/text()",
pubdate: ~x"./pubDate/text()",
description: ~x"./description/text()"s,
link: ~x"./link/text()",
image: ~x"./itunes:image/@href"s,
episode: ~x"./itunes:episode/text()"oi
)
end

def write_html(content) do
html = Enum.map(content, fn(x) ->
  "<h1>#{x.title}</h2>
   <h2>#{x.episode}</h2>
   <h3>#{x.pubdate}</h3>
   <p>#{x.description}</p>
   <a href=#{x.link}>Episode Link</a>
   <img src=#{x.image} height=\"42\" width=\"42\">" end)

header =
  "<head> <link rel=\"stylesheet\" href=\"https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css\" integrity=\"sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u\" crossorigin=\"anonymous\">
   <style> body {text-align: center; margin: 25px 150px 75px 150px;} </style> </head>"

html = [header | html]

File.write("new.html", html)
end

end
