const { db, bucket } = require("../config/db");
const express = require("express");
const router = express.Router();

const COLLECTION_NAME = "3dModel";

// Route to store tooth details in Firestore
router.put("/store", async (req, res) => {
  try {
    // Extract case data from the request body
    const { mainTypeName, complaintTypeName, caseId } = req.body;

    // Reference to the specific document in the Firestore collection
    const complaintTypeRef = db.collection(COLLECTION_NAME).doc("caseDetails");

    // Update the document with new details
    await complaintTypeRef.update({
      mainTypeName: mainTypeName,
      complaintTypeName: complaintTypeName,
      caseId: caseId,
    });

    res.status(200).send({ message: "Tooth details updated successfully." });
  } catch (error) {
    console.error("Error updating tooth details:", error);
    res.status(500).send({
      message: "Failed to update tooth details.",
      error: error.message,
    });
  }
});

// Route to get tooth details from Firestore
router.get("/get", async (req, res) => {
  try {
    // Reference to the specific document in the Firestore collection
    const complaintTypeRef = db.collection(COLLECTION_NAME).doc("caseDetails");

    // Retrieve the document
    const doc = await complaintTypeRef.get();

    if (!doc.exists) {
      return res.status(404).json({ error: "No such document!" });
    }

    // Send back the document data
    res.status(200).json({
      message: "Tooth details retrieved successfully.",
      data: doc.data(),
    });
  } catch (error) {
    console.error("Error getting tooth details:", error);
    res.status(500).send({
      message: "Failed to get tooth details.",
      error: error.message,
    });
  }
});

module.exports = router;
