require 'rubygems'
require 'ramaze'
require 'feedzirra'

class MainController < Ramaze::Controller
  layout :master
  
  def master
    %{
		<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
      	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
		<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
		<head>
			<meta http-equiv="Content-type" content="text/html; charset=utf-8" />
			<style  type="text/css">
			  body {
			    font-family: Geneva;
			  }
  			#wrapper {
           border: 1px solid #ccc;
           width: 600px;
           padding: 5px;
           margin: 0 auto;
         }
         
         .entry {
           border: 1px solid #ccc;
           margin-bottom: 5px;
         }

         .info {
           word-wrap: break-word;
           overflow: auto;
           background: #ccc;
           padding: 5px;
         }
         
         .user, .date {
            font-size: 10px;
            padding-top: 5px;
         }
         
         h5, p, fieldset {
           padding: 0;
           margin: 0;
           border: none;
         } 

         .left {
           float: left;
         }

         .right {
           float: right;
         }

         .content {
           clear: both;
           padding: 5px;
           font-size: 0.8em;
         }
         
        input {
          border: 1px solid #ccc;
          font-size: 120%;
        }
        
        .text {
          width: 512px;
        }
        
        .form {
          margin-bottom: 10px;
        }
			</style>
			<title>Twitter Search</title>
			
		</head>
		<body>
		  <div id="wrapper">
  		  <div class="form">
           <form method="post" action="/">
             <fieldset>
              <input class="text" type="text" name="query" value="" />
              <input type="submit" value="Search" />
             </fieldset>
           </form>
        </div>
  			#{@content}
  		  </div>
		</body>
		</html>
    }
  end

  def index
    if request.post?
      entries = Array.new
      feed = Feedzirra::Feed.fetch_and_parse("http://search.twitter.com/search.atom?q=#{request[:query]}")
      feed.entries.each do |entry|
        entries.push(%{
          <div class="entry">
            <div class="info">
              <h5>#{entry.title}</h5>
              <span class="left user">#{entry.author}</span><span class="right date">#{entry.published.gmtime}</span>
            </div>
            <div class="content">
              <p>#{entry.content}</p>
            </div>
          </div>
          })
        end
      end
      entries.to_s
    end
end

Ramaze.start