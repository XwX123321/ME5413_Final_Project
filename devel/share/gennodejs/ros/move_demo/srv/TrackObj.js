// Auto-generated. Do not edit!

// (in-package move_demo.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------


//-----------------------------------------------------------

class TrackObjRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.obj = null;
    }
    else {
      if (initObj.hasOwnProperty('obj')) {
        this.obj = initObj.obj
      }
      else {
        this.obj = '';
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type TrackObjRequest
    // Serialize message field [obj]
    bufferOffset = _serializer.string(obj.obj, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type TrackObjRequest
    let len;
    let data = new TrackObjRequest(null);
    // Deserialize message field [obj]
    data.obj = _deserializer.string(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += _getByteLength(object.obj);
    return length + 4;
  }

  static datatype() {
    // Returns string type for a service object
    return 'move_demo/TrackObjRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'd8fd46ff9e0d150d043714f673d35559';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    string obj
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new TrackObjRequest(null);
    if (msg.obj !== undefined) {
      resolved.obj = msg.obj;
    }
    else {
      resolved.obj = ''
    }

    return resolved;
    }
};

class TrackObjResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.result = null;
    }
    else {
      if (initObj.hasOwnProperty('result')) {
        this.result = initObj.result
      }
      else {
        this.result = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type TrackObjResponse
    // Serialize message field [result]
    bufferOffset = _serializer.bool(obj.result, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type TrackObjResponse
    let len;
    let data = new TrackObjResponse(null);
    // Deserialize message field [result]
    data.result = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 1;
  }

  static datatype() {
    // Returns string type for a service object
    return 'move_demo/TrackObjResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'eb13ac1f1354ccecb7941ee8fa2192e8';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    bool result
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new TrackObjResponse(null);
    if (msg.result !== undefined) {
      resolved.result = msg.result;
    }
    else {
      resolved.result = false
    }

    return resolved;
    }
};

module.exports = {
  Request: TrackObjRequest,
  Response: TrackObjResponse,
  md5sum() { return 'd6d04e8b2c20037b11fd9c862b657664'; },
  datatype() { return 'move_demo/TrackObj'; }
};
