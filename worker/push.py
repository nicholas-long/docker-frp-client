import pusher

secret = open('/run/secrets/pusher_secret', 'r').read()

pusher_client = pusher.Pusher(
  app_id='1276400',
  key='948e8ac8cb97e719702d',
  secret=secret,
  cluster='us3',
  ssl=True
)

pusher_client.trigger('my-channel', 'my-event', {'message': 'updated'})
