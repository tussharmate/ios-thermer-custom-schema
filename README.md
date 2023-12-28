**BluetoothPrint Integration Guide**

Introduction

The BluetoothPrint app allows you to print text, images, barcodes, and QR codes by sending a request from your Swift application. This guide explains how to use the provided Swift code to structure and pass data to the BluetoothPrint app.

**Print Entry Types**
**Text Entry:**

**Type:** 0

**Content:** Any string

**Bold:** 0 if no, 1 if yes

**Align:** 0 if left, 1 if center, 2 if right

**Format:** 0 if normal, 1 if double Height, 2 if double Height + Width, 3 if double Width, 4 if small

**Image Entry:**

**Type: 1**

**Path:** Complete filepath on your web server; ensure it is not a large size

**Align:** 0 if left, 1 if center, 2 if right; set left align for big size images

**Barcode Entry:**

**Type:** 2

**Value:** Valid barcode value

**Height:** Valid barcode height (10 to 80)

**Align:** 0 if left, 1 if center, 2 if right

**QR Entry:**

**Type:** 3

**Value:** Valid QR code value

**Size:** Valid QR code size in mm (Min 40)

**Align:** 0 if left, 1 if center, 2 if right

**Empty Line:**

**Type:** 0

**Content:** " " (empty line)

**Bold:** 0

**Align:** 0

**Multi-lines Text:**

**Type:** 0

**Content:** 'This text has<br />two lines' (multiple lines text)

**Bold:** 0

**Align:** 0

**Integration Steps**


Set up your Xcode project:

Copy the provided Swift code into your Xcode project.

Create Print Entries:

Use the PrintEntry struct to create print entries with different types.
Assign values to the properties based on the type of entry.
Encode and Open URL:

Use the JSONEncoder to encode the print entries into JSON format.
Add percent encoding to the JSON string.
Construct a URL with the encoded JSON string and the custom scheme (e.g., "bprintapp://").
Open the URL using UIApplication.shared.open(url!).

**Note**

Ensure that the sequence of entries matches the desired printing content.
For non-English entries, the app will automatically convert them to text special if the corresponding setting is enabled in the app under Settings -> Special Characters.
