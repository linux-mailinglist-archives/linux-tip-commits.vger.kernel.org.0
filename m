Return-Path: <linux-tip-commits+bounces-2128-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 451DF9604D3
	for <lists+linux-tip-commits@lfdr.de>; Tue, 27 Aug 2024 10:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1666281EF9
	for <lists+linux-tip-commits@lfdr.de>; Tue, 27 Aug 2024 08:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101D71993B0;
	Tue, 27 Aug 2024 08:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xwb8EgPs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NSU+Anj6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8074198A19;
	Tue, 27 Aug 2024 08:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724748493; cv=none; b=OLi7ls1UGOLmABCfdg/JpLBBVgfXYkV23KBvtlmSHgOKmC0vm9jGlqoWTIsva0vaM7yF1Ty+qNnrNfx5ViyU0werzMRBgVHXoeDGlJL33nOV7TNCkzk1TU22/zFNdIbX3VN12sq84AvdEBT+k+LGUHvWtRI7RU5avlLoJ/PnmlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724748493; c=relaxed/simple;
	bh=OQt3l3HSNEhkzerObWrTrvl+xtVMXlAM6oqG9sTvi2k=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=K7bDsRzjTCJQNNfJD2juMSx+0ZgJwM9qgqN8uJ4Kxnml1eYUXBT2tdDFqyY83jBNkNqSKJ5g6zD55klnU5Q/2KgUqFZfiTCBlFeEa3PJbtRYelzqrBfyq8TSjbFyK82EbpCvlK2RzuIR5QBw0tOjdDMdxIpr5pMxxxQCt81HIZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xwb8EgPs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NSU+Anj6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 27 Aug 2024 08:48:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724748487;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z5+AodQvcTFgRHSwvGq3SbBE0HF8l9wqhEXbjBZRIA4=;
	b=xwb8EgPsBc/io4uORR+dsMBK21/FWL4PqlRvJzXavuahpj8PGQzunmkPHQty/xYdp2412S
	R/vm5XSIXpklJ6ErSFFggSH4xvzpnhYnXUC4jaJpS5RTS2OlfStSykKaZctr7oT/73BLZ1
	gFlAi1poj1ZIAfdPMp9N/dHlEnLMJDBOqj5yVCM2GFyQ6zdmrWJuoGs+Yvy2cr6xoR9wXW
	kOBNskO2lUFGA5BP6L54paVYEp9qFwuYcDPPFPSpDlyNsd1XuU1RlDhBxS5mvdXQ7ZfSfG
	dIJ1IdiHQ0VOl2UTeYXg3g8fetQGE7g0h40KXHK+l9Y/CUF97G9V04wSy03syA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724748487;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z5+AodQvcTFgRHSwvGq3SbBE0HF8l9wqhEXbjBZRIA4=;
	b=NSU+Anj6wU1MOhL3f7S03jTT6w5f+6jXAWEbMzsXEx+Uq28QjlrTI8mMSTdsNQMhIRqhQC
	fstYtK9IBSmK+FAw==
From: "tip-bot2 for Nikunj A Dadhania" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] virt: sev-guest: Rename local guest message variables
Cc: Nikunj A Dadhania <nikunj@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240731150811.156771-3-nikunj@amd.com>
References: <20240731150811.156771-3-nikunj@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172474848691.2215.233187575965682163.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     a1bbb2236bb97c0afee4cdf8fd732ff5f9cd60ac
Gitweb:        https://git.kernel.org/tip/a1bbb2236bb97c0afee4cdf8fd732ff5f9cd60ac
Author:        Nikunj A Dadhania <nikunj@amd.com>
AuthorDate:    Wed, 31 Jul 2024 20:37:53 +05:30
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 27 Aug 2024 10:34:41 +02:00

virt: sev-guest: Rename local guest message variables

Rename local guest message variables for more clarity.

No functional change.

Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240731150811.156771-3-nikunj@amd.com
---
 drivers/virt/coco/sev-guest/sev-guest.c | 117 +++++++++++------------
 1 file changed, 59 insertions(+), 58 deletions(-)

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 7d343f2..a72fe1e 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -291,45 +291,45 @@ static int dec_payload(struct snp_guest_dev *snp_dev, struct snp_guest_msg *msg,
 static int verify_and_dec_payload(struct snp_guest_dev *snp_dev, void *payload, u32 sz)
 {
 	struct snp_guest_crypto *crypto = snp_dev->crypto;
-	struct snp_guest_msg *resp = &snp_dev->secret_response;
-	struct snp_guest_msg *req = &snp_dev->secret_request;
-	struct snp_guest_msg_hdr *req_hdr = &req->hdr;
-	struct snp_guest_msg_hdr *resp_hdr = &resp->hdr;
+	struct snp_guest_msg *resp_msg = &snp_dev->secret_response;
+	struct snp_guest_msg *req_msg = &snp_dev->secret_request;
+	struct snp_guest_msg_hdr *req_msg_hdr = &req_msg->hdr;
+	struct snp_guest_msg_hdr *resp_msg_hdr = &resp_msg->hdr;
 
 	pr_debug("response [seqno %lld type %d version %d sz %d]\n",
-		 resp_hdr->msg_seqno, resp_hdr->msg_type, resp_hdr->msg_version,
-		 resp_hdr->msg_sz);
+		 resp_msg_hdr->msg_seqno, resp_msg_hdr->msg_type, resp_msg_hdr->msg_version,
+		 resp_msg_hdr->msg_sz);
 
 	/* Copy response from shared memory to encrypted memory. */
-	memcpy(resp, snp_dev->response, sizeof(*resp));
+	memcpy(resp_msg, snp_dev->response, sizeof(*resp_msg));
 
 	/* Verify that the sequence counter is incremented by 1 */
-	if (unlikely(resp_hdr->msg_seqno != (req_hdr->msg_seqno + 1)))
+	if (unlikely(resp_msg_hdr->msg_seqno != (req_msg_hdr->msg_seqno + 1)))
 		return -EBADMSG;
 
 	/* Verify response message type and version number. */
-	if (resp_hdr->msg_type != (req_hdr->msg_type + 1) ||
-	    resp_hdr->msg_version != req_hdr->msg_version)
+	if (resp_msg_hdr->msg_type != (req_msg_hdr->msg_type + 1) ||
+	    resp_msg_hdr->msg_version != req_msg_hdr->msg_version)
 		return -EBADMSG;
 
 	/*
 	 * If the message size is greater than our buffer length then return
 	 * an error.
 	 */
-	if (unlikely((resp_hdr->msg_sz + crypto->a_len) > sz))
+	if (unlikely((resp_msg_hdr->msg_sz + crypto->a_len) > sz))
 		return -EBADMSG;
 
 	/* Decrypt the payload */
-	return dec_payload(snp_dev, resp, payload, resp_hdr->msg_sz + crypto->a_len);
+	return dec_payload(snp_dev, resp_msg, payload, resp_msg_hdr->msg_sz + crypto->a_len);
 }
 
 static int enc_payload(struct snp_guest_dev *snp_dev, u64 seqno, int version, u8 type,
 			void *payload, size_t sz)
 {
-	struct snp_guest_msg *req = &snp_dev->secret_request;
-	struct snp_guest_msg_hdr *hdr = &req->hdr;
+	struct snp_guest_msg *msg = &snp_dev->secret_request;
+	struct snp_guest_msg_hdr *hdr = &msg->hdr;
 
-	memset(req, 0, sizeof(*req));
+	memset(msg, 0, sizeof(*msg));
 
 	hdr->algo = SNP_AEAD_AES_256_GCM;
 	hdr->hdr_version = MSG_HDR_VER;
@@ -347,7 +347,7 @@ static int enc_payload(struct snp_guest_dev *snp_dev, u64 seqno, int version, u8
 	pr_debug("request [seqno %lld type %d version %d sz %d]\n",
 		 hdr->msg_seqno, hdr->msg_type, hdr->msg_version, hdr->msg_sz);
 
-	return __enc_payload(snp_dev, req, payload, sz);
+	return __enc_payload(snp_dev, msg, payload, sz);
 }
 
 static int __handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
@@ -496,8 +496,8 @@ struct snp_req_resp {
 static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
 {
 	struct snp_guest_crypto *crypto = snp_dev->crypto;
-	struct snp_report_req *req = &snp_dev->req.report;
-	struct snp_report_resp *resp;
+	struct snp_report_req *report_req = &snp_dev->req.report;
+	struct snp_report_resp *report_resp;
 	int rc, resp_len;
 
 	lockdep_assert_held(&snp_cmd_mutex);
@@ -505,7 +505,7 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
 	if (!arg->req_data || !arg->resp_data)
 		return -EINVAL;
 
-	if (copy_from_user(req, (void __user *)arg->req_data, sizeof(*req)))
+	if (copy_from_user(report_req, (void __user *)arg->req_data, sizeof(*report_req)))
 		return -EFAULT;
 
 	/*
@@ -513,30 +513,29 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
 	 * response payload. Make sure that it has enough space to cover the
 	 * authtag.
 	 */
-	resp_len = sizeof(resp->data) + crypto->a_len;
-	resp = kzalloc(resp_len, GFP_KERNEL_ACCOUNT);
-	if (!resp)
+	resp_len = sizeof(report_resp->data) + crypto->a_len;
+	report_resp = kzalloc(resp_len, GFP_KERNEL_ACCOUNT);
+	if (!report_resp)
 		return -ENOMEM;
 
-	rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, arg,
-				  SNP_MSG_REPORT_REQ, req, sizeof(*req), resp->data,
-				  resp_len);
+	rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, arg, SNP_MSG_REPORT_REQ,
+				  report_req, sizeof(*report_req), report_resp->data, resp_len);
 	if (rc)
 		goto e_free;
 
-	if (copy_to_user((void __user *)arg->resp_data, resp, sizeof(*resp)))
+	if (copy_to_user((void __user *)arg->resp_data, report_resp, sizeof(*report_resp)))
 		rc = -EFAULT;
 
 e_free:
-	kfree(resp);
+	kfree(report_resp);
 	return rc;
 }
 
 static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
 {
-	struct snp_derived_key_req *req = &snp_dev->req.derived_key;
+	struct snp_derived_key_req *derived_key_req = &snp_dev->req.derived_key;
 	struct snp_guest_crypto *crypto = snp_dev->crypto;
-	struct snp_derived_key_resp resp = {0};
+	struct snp_derived_key_resp derived_key_resp = {0};
 	int rc, resp_len;
 	/* Response data is 64 bytes and max authsize for GCM is 16 bytes. */
 	u8 buf[64 + 16];
@@ -551,25 +550,27 @@ static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_reque
 	 * response payload. Make sure that it has enough space to cover the
 	 * authtag.
 	 */
-	resp_len = sizeof(resp.data) + crypto->a_len;
+	resp_len = sizeof(derived_key_resp.data) + crypto->a_len;
 	if (sizeof(buf) < resp_len)
 		return -ENOMEM;
 
-	if (copy_from_user(req, (void __user *)arg->req_data, sizeof(*req)))
+	if (copy_from_user(derived_key_req, (void __user *)arg->req_data,
+			   sizeof(*derived_key_req)))
 		return -EFAULT;
 
-	rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, arg,
-				  SNP_MSG_KEY_REQ, req, sizeof(*req), buf, resp_len);
+	rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, arg, SNP_MSG_KEY_REQ,
+				  derived_key_req, sizeof(*derived_key_req), buf, resp_len);
 	if (rc)
 		return rc;
 
-	memcpy(resp.data, buf, sizeof(resp.data));
-	if (copy_to_user((void __user *)arg->resp_data, &resp, sizeof(resp)))
+	memcpy(derived_key_resp.data, buf, sizeof(derived_key_resp.data));
+	if (copy_to_user((void __user *)arg->resp_data, &derived_key_resp,
+			 sizeof(derived_key_resp)))
 		rc = -EFAULT;
 
 	/* The response buffer contains the sensitive data, explicitly clear it. */
 	memzero_explicit(buf, sizeof(buf));
-	memzero_explicit(&resp, sizeof(resp));
+	memzero_explicit(&derived_key_resp, sizeof(derived_key_resp));
 	return rc;
 }
 
@@ -577,9 +578,9 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
 			  struct snp_req_resp *io)
 
 {
-	struct snp_ext_report_req *req = &snp_dev->req.ext_report;
+	struct snp_ext_report_req *report_req = &snp_dev->req.ext_report;
 	struct snp_guest_crypto *crypto = snp_dev->crypto;
-	struct snp_report_resp *resp;
+	struct snp_report_resp *report_resp;
 	int ret, npages = 0, resp_len;
 	sockptr_t certs_address;
 
@@ -588,22 +589,22 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
 	if (sockptr_is_null(io->req_data) || sockptr_is_null(io->resp_data))
 		return -EINVAL;
 
-	if (copy_from_sockptr(req, io->req_data, sizeof(*req)))
+	if (copy_from_sockptr(report_req, io->req_data, sizeof(*report_req)))
 		return -EFAULT;
 
 	/* caller does not want certificate data */
-	if (!req->certs_len || !req->certs_address)
+	if (!report_req->certs_len || !report_req->certs_address)
 		goto cmd;
 
-	if (req->certs_len > SEV_FW_BLOB_MAX_SIZE ||
-	    !IS_ALIGNED(req->certs_len, PAGE_SIZE))
+	if (report_req->certs_len > SEV_FW_BLOB_MAX_SIZE ||
+	    !IS_ALIGNED(report_req->certs_len, PAGE_SIZE))
 		return -EINVAL;
 
 	if (sockptr_is_kernel(io->resp_data)) {
-		certs_address = KERNEL_SOCKPTR((void *)req->certs_address);
+		certs_address = KERNEL_SOCKPTR((void *)report_req->certs_address);
 	} else {
-		certs_address = USER_SOCKPTR((void __user *)req->certs_address);
-		if (!access_ok(certs_address.user, req->certs_len))
+		certs_address = USER_SOCKPTR((void __user *)report_req->certs_address);
+		if (!access_ok(certs_address.user, report_req->certs_len))
 			return -EFAULT;
 	}
 
@@ -613,45 +614,45 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
 	 * the host. If host does not supply any certs in it, then copy
 	 * zeros to indicate that certificate data was not provided.
 	 */
-	memset(snp_dev->certs_data, 0, req->certs_len);
-	npages = req->certs_len >> PAGE_SHIFT;
+	memset(snp_dev->certs_data, 0, report_req->certs_len);
+	npages = report_req->certs_len >> PAGE_SHIFT;
 cmd:
 	/*
 	 * The intermediate response buffer is used while decrypting the
 	 * response payload. Make sure that it has enough space to cover the
 	 * authtag.
 	 */
-	resp_len = sizeof(resp->data) + crypto->a_len;
-	resp = kzalloc(resp_len, GFP_KERNEL_ACCOUNT);
-	if (!resp)
+	resp_len = sizeof(report_resp->data) + crypto->a_len;
+	report_resp = kzalloc(resp_len, GFP_KERNEL_ACCOUNT);
+	if (!report_resp)
 		return -ENOMEM;
 
 	snp_dev->input.data_npages = npages;
-	ret = handle_guest_request(snp_dev, SVM_VMGEXIT_EXT_GUEST_REQUEST, arg,
-				   SNP_MSG_REPORT_REQ, &req->data,
-				   sizeof(req->data), resp->data, resp_len);
+	ret = handle_guest_request(snp_dev, SVM_VMGEXIT_EXT_GUEST_REQUEST, arg, SNP_MSG_REPORT_REQ,
+				   &report_req->data, sizeof(report_req->data),
+				   report_resp->data, resp_len);
 
 	/* If certs length is invalid then copy the returned length */
 	if (arg->vmm_error == SNP_GUEST_VMM_ERR_INVALID_LEN) {
-		req->certs_len = snp_dev->input.data_npages << PAGE_SHIFT;
+		report_req->certs_len = snp_dev->input.data_npages << PAGE_SHIFT;
 
-		if (copy_to_sockptr(io->req_data, req, sizeof(*req)))
+		if (copy_to_sockptr(io->req_data, report_req, sizeof(*report_req)))
 			ret = -EFAULT;
 	}
 
 	if (ret)
 		goto e_free;
 
-	if (npages && copy_to_sockptr(certs_address, snp_dev->certs_data, req->certs_len)) {
+	if (npages && copy_to_sockptr(certs_address, snp_dev->certs_data, report_req->certs_len)) {
 		ret = -EFAULT;
 		goto e_free;
 	}
 
-	if (copy_to_sockptr(io->resp_data, resp, sizeof(*resp)))
+	if (copy_to_sockptr(io->resp_data, report_resp, sizeof(*report_resp)))
 		ret = -EFAULT;
 
 e_free:
-	kfree(resp);
+	kfree(report_resp);
 	return ret;
 }
 

