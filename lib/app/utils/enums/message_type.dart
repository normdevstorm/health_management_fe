enum MessageType {
  text('text'),
  image('image'),
  gif('gif'),
  video('video'),
  audio('audio'),
  location('location'),
  file('file');

  const MessageType(this.type);

  final String type;
}

extension ConvertMessage on String {
  MessageType toEnum() {
    switch (this) {
      case 'text':
        return MessageType.text;
      case 'image':
        return MessageType.image;
      case 'gif':
        return MessageType.gif;
      case 'video':
        return MessageType.video;
      case 'audio':
        return MessageType.audio;
      case 'location':
        return MessageType.location;
      case 'file':
        return MessageType.file;
      default:
        return MessageType.text;
    }
  }
}
