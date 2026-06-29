import * as admin from 'firebase-admin';
import { onCall, HttpsError } from 'firebase-functions/v2/https';

admin.initializeApp();

export const issueCertificate = onCall(async (request) => {
  if (!request.auth) throw new HttpsError('unauthenticated', 'Login required.');
  const { stageName, score } = request.data || {};
  if (!stageName || typeof score !== 'number') throw new HttpsError('invalid-argument', 'stageName and score are required.');
  if (score < 80) throw new HttpsError('failed-precondition', 'Certificate requires 80% or higher.');

  const userId = request.auth.uid;
  const certRef = admin.firestore().collection('users').doc(userId).collection('certificates').doc();
  const verifyCode = `TM-${Date.now()}-${certRef.id.substring(0, 6).toUpperCase()}`;
  await certRef.set({ stageName, score, verifyCode, issuedAt: admin.firestore.FieldValue.serverTimestamp() });
  return { id: certRef.id, verifyCode };
});

export const verifyCertificate = onCall(async (request) => {
  const { code } = request.data || {};
  if (!code) throw new HttpsError('invalid-argument', 'Verification code is required.');
  const users = await admin.firestore().collectionGroup('certificates').where('verifyCode', '==', code).limit(1).get();
  if (users.empty) return { valid: false };
  const cert = users.docs[0].data();
  return { valid: true, certificate: cert };
});

export const analyzeRecitationPlaceholder = onCall(async (request) => {
  if (!request.auth) throw new HttpsError('unauthenticated', 'Login required.');
  const { recordingPath, surah, ayah } = request.data || {};
  if (!recordingPath) throw new HttpsError('invalid-argument', 'recordingPath is required.');

  // Connect this to an ASR + Tajweed rule engine later.
  // Return structured time spans so the Flutter app can highlight mistakes.
  return {
    accuracy: 0,
    surah,
    ayah,
    status: 'pipeline_ready',
    mistakes: [
      { type: 'needs_ai_engine', message: 'تم تجهيز المسار. اربط خدمة الذكاء الاصطناعي لإرجاع أخطاء الإخفاء والمدود والغنة.' }
    ]
  };
});
