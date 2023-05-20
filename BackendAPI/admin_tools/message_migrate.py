from enum import Enum

from api.config import *

db = firestore.client()


# migrate task
# i have a collection named 'users' and i want to get all documents in it

# Define the Attachment class
class Attachment:
    def __init__(self, fileName, url, fileSize, type):
        self.fileName = fileName
        self.url = url
        self.fileSize = fileSize
        self.type = type


# Retrieve the channels collection
channels_ref = db.collection(u'channels')
channels = channels_ref.stream()


# Iterate over the channels and update the messages collection
# for channel in channels:
#     messages_ref = channels_ref.document(channel.id).collection(u'messages')
#     messages = messages_ref.get()
#     for message in messages:
#         if u'attachments' not in message.to_dict():
#             continue
#         attachments_list = message.get(u'attachments')
#         updated_attachments = []
#         for attachment in attachments_list:
#             # Create an Attachment object for each attachment in the list
#             updated_attachment = Attachment("", attachment, "", "image")
#             updated_attachments.append(updated_attachment.__dict__)
#         # Update the attachments field in Firestore with the updated list of attachments
#         message.reference.update({u'attachments': updated_attachments})


# Define the MessageType enum
class MessageType(Enum):
    normal = 1
    pending = 2
    system = 3
    call = 4

    def constValue(self):
        return {
            MessageType.normal: 'normal',
            MessageType.pending: 'pending',
            MessageType.system: 'system',
            MessageType.call: 'call'
        }[self]


def migrateMessageType():
    for channel in channels:
        messages_ref = channels_ref.document(channel.id).collection(u'messages')
        messages = messages_ref.get()
        for message in messages:
            message_type_id = message.get(u'message_type')
            if message_type_id == MessageType.normal.name \
                    or message_type_id == MessageType.pending.name \
                    or message_type_id == MessageType.system.name \
                    or message_type_id == MessageType.call.name:
                continue
            message_type_enum = MessageType.normal if message_type_id is None else MessageType(message_type_id).name
            message.reference.update({u'message_type': message_type_enum.name})


migrateMessageType()


def migrateLastMessage():
    for channel in channels:
        last_message_dict = channel.get(u'last_message')
        if last_message_dict:
            # Convert message_type field
            message_type_id = last_message_dict.get(u'message_type')
            if type(message_type_id) is not str:
                message_type_enum = MessageType(message_type_id)
                last_message_dict[u'message_type'] = message_type_enum.name

            # Convert attachments list
            attachments_list = last_message_dict.get(u'attachments')
            if attachments_list:
                new_attachments_list = []
                for attachment in attachments_list:
                    if type(attachment) is str:
                        new_attachment = Attachment(
                            url=attachment,
                            type="image",
                            fileName="",
                            fileSize=""
                        )
                        new_attachments_list.append(new_attachment.__dict__)
                        last_message_dict[u'attachments'] = new_attachments_list

            # Update the last_message field in Firestore
            channel.reference.update({u'last_message': last_message_dict})

migrateLastMessage()
# Iterate over the channels and update the messages collection
# migrateMessageType()
#
# Iterate over the channels and update the last_message field
# migrateLastMessage()


exit(0)

