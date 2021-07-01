/**
 * This class is automatically generated by mig. DO NOT EDIT THIS FILE.
 * This class implements a Java interface to the 'DemoAppMsgT'
 * message type.
 */

public class DemoAppMsgT extends net.tinyos.message.Message {

    /** The default size of this message type in bytes. */
    public static final int DEFAULT_MESSAGE_SIZE = 2;

    /** The Active Message type associated with this message. */
    public static final int AM_TYPE = 133;

    /** Create a new DemoAppMsgT of size 2. */
    public DemoAppMsgT() {
        super(DEFAULT_MESSAGE_SIZE);
        amTypeSet(AM_TYPE);
    }

    /** Create a new DemoAppMsgT of the given data_length. */
    public DemoAppMsgT(int data_length) {
        super(data_length);
        amTypeSet(AM_TYPE);
    }

    /**
     * Create a new DemoAppMsgT with the given data_length
     * and base offset.
     */
    public DemoAppMsgT(int data_length, int base_offset) {
        super(data_length, base_offset);
        amTypeSet(AM_TYPE);
    }

    /**
     * Create a new DemoAppMsgT using the given byte array
     * as backing store.
     */
    public DemoAppMsgT(byte[] data) {
        super(data);
        amTypeSet(AM_TYPE);
    }

    /**
     * Create a new DemoAppMsgT using the given byte array
     * as backing store, with the given base offset.
     */
    public DemoAppMsgT(byte[] data, int base_offset) {
        super(data, base_offset);
        amTypeSet(AM_TYPE);
    }

    /**
     * Create a new DemoAppMsgT using the given byte array
     * as backing store, with the given base offset and data length.
     */
    public DemoAppMsgT(byte[] data, int base_offset, int data_length) {
        super(data, base_offset, data_length);
        amTypeSet(AM_TYPE);
    }

    /**
     * Create a new DemoAppMsgT embedded in the given message
     * at the given base offset.
     */
    public DemoAppMsgT(net.tinyos.message.Message msg, int base_offset) {
        super(msg, base_offset, DEFAULT_MESSAGE_SIZE);
        amTypeSet(AM_TYPE);
    }

    /**
     * Create a new DemoAppMsgT embedded in the given message
     * at the given base offset and length.
     */
    public DemoAppMsgT(net.tinyos.message.Message msg, int base_offset, int data_length) {
        super(msg, base_offset, data_length);
        amTypeSet(AM_TYPE);
    }

    /**
    /* Return a String representation of this message. Includes the
     * message type name and the non-indexed field values.
     */
    public String toString() {
      String s = "Message <DemoAppMsgT> \n";
      try {
        s += "  [tReading=0x"+Long.toHexString(get_tReading())+"]\n";
      } catch (ArrayIndexOutOfBoundsException aioobe) { /* Skip field */ }
      return s;
    }

    // Message-type-specific access methods appear below.

    /////////////////////////////////////////////////////////
    // Accessor methods for field: tReading
    //   Field type: int, unsigned
    //   Offset (bits): 0
    //   Size (bits): 16
    /////////////////////////////////////////////////////////

    /**
     * Return whether the field 'tReading' is signed (false).
     */
    public static boolean isSigned_tReading() {
        return false;
    }

    /**
     * Return whether the field 'tReading' is an array (false).
     */
    public static boolean isArray_tReading() {
        return false;
    }

    /**
     * Return the offset (in bytes) of the field 'tReading'
     */
    public static int offset_tReading() {
        return (0 / 8);
    }

    /**
     * Return the offset (in bits) of the field 'tReading'
     */
    public static int offsetBits_tReading() {
        return 0;
    }

    /**
     * Return the value (as a int) of the field 'tReading'
     */
    public int get_tReading() {
        return (int)getUIntBEElement(offsetBits_tReading(), 16);
    }

    /**
     * Set the value of the field 'tReading'
     */
    public void set_tReading(int value) {
        setUIntBEElement(offsetBits_tReading(), 16, value);
    }

    /**
     * Return the size, in bytes, of the field 'tReading'
     */
    public static int size_tReading() {
        return (16 / 8);
    }

    /**
     * Return the size, in bits, of the field 'tReading'
     */
    public static int sizeBits_tReading() {
        return 16;
    }

}