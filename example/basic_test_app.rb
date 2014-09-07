#!/usr/bin/env ruby
require 'semantria'

print 'Semantria service demo ...', "\r\n"

# the consumer key and secret
$consumer_key, $consumer_secret = "9d205eae-9c7f-4442-92b0-c9aaef1f20e1","325d0014-6995-4e66-a3d5-fd39159138d2"

$initial_texts = [
  # 'Lisa - there\'s 2 Skinny cow coupons available $5 skinny cow ice cream coupons on special k boxes
  #  and Printable FPC from facebook - a teeny tiny cup of ice cream. I printed off 2
  #  (1 from my account and 1 from dh\'s). I couldn\'t find them instore and i\'m not going to walmart
  #  before the 19th. Oh well sounds like i\'m not missing much ...lol',

  # "In Lake Louise - a guided walk for the family with Great Divide Nature Tours  rent a canoe
  #  on Lake Louise or Moraine Lake  go for a hike to the Lake Agnes Tea House. In between Lake Louise
  #  and Banff - visit Marble Canyon or Johnson Canyon or both for family friendly short walks. In Banff
  #  a picnic at Johnson Lake  rent a boat at Lake Minnewanka  hike up Tunnel Mountain  walk to the Bow Falls
  #  and the Fairmont Banff Springs Hotel  visit the Banff Park Museum. The \"must-do\" in Banff is a visit
  #  to the Banff Gondola and some time spent on Banff Avenue - think candy shops and ice cream.",

  # 'On this day in 1786 - In New York City commercial ice cream was manufactured for the first time.'
  "Easily the best pub in Angel. I have lived in the area for a long time, so I've tried quite a few other places, just for the reference and comparison. But 'The Pig and Butcher' is head and shoulders above all other places. Great atmosphere, fantastic beer selection, absolutely delicious food (freshly cooked meat, not the usual pub 'oven heat-ups'). Staff and Jack are always fantastic to share a quick chat with if you're on your own, and Jack will always find a couple of fresh jokes to keep any company amused. Great, fantastic! If I could add one thing to this place, it would be a dozen of comfy sofas somewhere or something of that sort...",
  "Great pub with great food hidden on the back streets of Angel. Please go in search of this place! Staff are great, and the service even better. Sunday Lunch is a must!",
  "Popped in for a late dinner and grabbed three excellent starters. Two stars were the goose rillettes which came with some delicious toasted bread and cornichons and the mackerel was covered in a fantastic peri-peri sauce. Huge selection of beers and very friendly staff. A quality local that clearly cares about ingredients and delivering taste good value food. Will return....",
  "Extensive & Expensive! Visited after food service last night so can't comment on the very meaty menu, which looked good if rather pricey. Pub & dining room in standard Islington stripped wood. Large selection of common and guest beers on draught & bottle, but again, prices struck me as high. Staff very welcoming & helpful, obligingly seating us in restaurant as bar was full. Would recommend as somewhere for a special, but informal, night out, but I couldn't afford this place as my local.",
  "Lovely meat dishes. Great wine and good service. Nice gastro-pub / Islington ambience.",
  "This place has a great selection of beers and I would recommend highly as a pub. I ate here though and was not that impressed with the food. The menu is very meat heavy and I opted for the sole. It was a large portion but was extremely bony and the low light levels meant that deboning was difficult. I was also not impressed with the sides, the oils that were delivered with the bread were tasteless and the corn on the cob was burnt. This place has an above average price tag and I do not think it delivers at this level. Definitely worth a visit though if you fancy a decent beer!",
  "We have been going to the Pig and Butcher since it opened last year and we can never fault it. Jack and the team not only provide the friendliest and BEST service, but the food is absolutely outstanding. We visit about once a week whether it's for food or their huge range of beers (and the house red wine is a favourite of mine). Actually visited last night and it seems the food is improving which we thought was impossible. LOVE this place!",
  "Had a chance to visit this place with my friends and colleagues. Awesome food and really friendly staff, there's also a great selection of beers!",
  "Great food, always interesting and well-made. Owner is friendly and helpful. Always book ahead to avoid disappointment.",
  "Best roast I've ever had. Ever.",
  "good food, nice interior, a short walk from Angel tube",
  "Love this place since the redo. Friendly staff (especially love the Torontonese waitress, she rocks) good selection of beers and really well thought out dishes. Menu sometimes comes across as a little intimidating but food is always delicious.",
  "The first time was a great roast experience with family and friends. the second time was even better. The menu changes daily im led to believe and the rustic look and feel adds its unique position on liverpool road which is always a good hide away from the busy upper street at angel. Ill be going again.",
  "I am an aspiring vegetarian, after a couple of weeks of keeping to this i went for a family meal to the pig. This broke me. The meat was so well prepared and delicious that I have zero regrets about breaking my commitment to veg. An attentive assistant manager, ask for James, was great entertainment. The pig is an absolute must wherever you have to come from. x",
  "i thought that the service and atmosphere was great as well as the food. We went to sunday roast and it was awesome!",
  "I very much enjoyed the atmosphere from the start, though it was quite crowded. We put our name down for a table at the right time because the crowd grew as did the wait. The scotch eggs were killer - must have mustard with them. The winter roots were delicate/fresh and paired well with the nice crisp lettuces & goat curd. The steak tartare and the soup were also fantastic. I enjoyed the bratwurst as a main, but found my taste of the pork chops to be dry. Our waitress was great & as attentive as she could be given the crowd that she had to navigate through & the number of tables she was serving. I highly recommend.",
  "English Gastro-pub food at it's best!",
  "Great atmosphere, lovely staff a hive of activity with cracking Sunday lunches."
]

class SessionCallbackHandler < CallbackHandler
  def onRequest(sender, args)
    #print "Request: ", args, "\n"
  end

  def onResponse(sender, args)
    #print "Response: ", args, "\n"
  end

  def onError(sender, args)
    print 'Error: ', args, "\n"
  end

  def onDocsAutoResponse(sender, args)
    #print "DocsAutoResponse: ", args.length, args, "\n"
  end

  def onCollsAutoResponse(sender, args)
    #print "CollsAutoResponse: ", args.length, args, "\n"
  end
end

# Initializes new session with the keys and app name.
# We also will use compression.
session = Session.new($consumer_key, $consumer_secret, 'TestApp', true)
# Initialize session callback handlers
callback = SessionCallbackHandler.new()
session.setCallbackHandler(callback)

$initial_texts.each do |text|
  # Creates a sample document which need to be processed on Semantria
  # Unique document ID
  # Source text which need to be processed
  doc = {'id' => rand(10 ** 10).to_s.rjust(10, '0'), 'text' => text}
  # Queues document for processing on Semantria service
  status = session.queueDocument(doc)
  # Check status from Semantria service
  if status == 202
    # print 'Document ', doc['id'], ' queued successfully.', "\r\n"
  end
end

# # Count of the sample documents which need to be processed on Semantria
# length = $initial_texts.length
# results = []

# while results.length < length
#   print 'Please wait 10 sec for documents ...', "\r\n"
#   # As Semantria isn't real-time solution you need to wait some time before getting of the processed results
#   # In real application here can be implemented two separate jobs, one for queuing of source data another one for retreiving
#   # Wait ten seconds while Semantria process queued document
#   sleep(10)
#   # Requests processed results from Semantria service
#   status = session.getProcessedDocuments()
#   # Check status from Semantria service
#   status.is_a? Array and status.each do |object|
#     results.push(object)
#   end
#   print status.length, ' documents received successfully.', "\r\n"
# end

# # results.each do |data|
# #   # Printing of document sentiment score
# #   print 'Document ', data['id'], ' Sentiment score: ', data['sentiment_score'], "\r\n"

# #   # Printing of document themes
# #   print 'Document themes:', "\r\n"
# #   data['themes'].nil? or data['themes'].each do |theme|
# #     print '  ', theme['title'], ' (sentiment: ', theme['sentiment_score'], ")", "\r\n"
# #   end

# #   # Printing of document entities
# #   print 'Entities:', "\r\n"
# #   data['entities'].nil? or data['entities'].each do |entity|
# #     print '  ', entity['title'], ' : ', entity['entity_type'], ' (sentiment: ', entity['sentiment_score'], ')', "\r\n"
# #   end

# #   # Printing of document phrases
# #   print 'Phrases:', "\r\n"
# #   data['phrases'].nil? or data['phrases'].each do |phrase|
# #     print '  ', phrase['title']
# #     print '     ', 'Sentiment: ' , phrase['sentiment_score'], "\r\n"
# #     print '     ', 'Polarity: ' , phrase['sentiment_polarity'], "\r\n"
# #     print '     ', 'Negating phrase: ', phrase['negating_phrase'], "\r\n"
# #     print '     ', 'Intensifying phrase: ', phrase['intensifying_phrase'], "\r\n"
# #   end

# #   puts 'Average sentinment: '
# #   # puts data['phrases'].inject(0) {|res, phrase| res + phrase['sentiment_score']} / data['phrases'].size
# #   puts data['sentiment_score']
# #   print "\r\n"
# # end
# puts 'Combined sentiment score:'
# puts results.inject(0) {|memo, result| memo + result['sentiment_score']} / results.size
# puts 'Percentage positive'
# puts results.select {|document| document["sentiment_score"] > 0 }.size * 100.0 / results.size
