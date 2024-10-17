Return-Path: <linux-tip-commits+bounces-2498-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E7F9A2190
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Oct 2024 13:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B907F1C225AF
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Oct 2024 11:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E569C1DD0C6;
	Thu, 17 Oct 2024 11:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0KAVvEW5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FsxNbcxo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B344D1DB956;
	Thu, 17 Oct 2024 11:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729166193; cv=none; b=TcaXjMPU1wlH/YB1JUk2RkTYk8QYB1pImObpRLXBMJklxitLyUA5R89hlnAPUm3xrLK1j+IutZXI1mEfQdH+G6ITEI54Er0fu8IbAOP3LJjfl3vlWOb3/SSCMktUqtR32lO1F6vBa58/+Bo8ujQX3lV2P06mo8rNObz/iTOhrUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729166193; c=relaxed/simple;
	bh=/IaUn3H+Ecw4fftUyvHGGzS1kFO0A/5qmkSaMMvqWdk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=oBKAl/M7hjhzP94xr3nftScWv7Ck0HDZgRZ0DgxwtcIoGua7KmZmVnO8bmninKucjhmuHb7v2JNHw1vX4AQ90/FSZ5HmWiZ0mn1i8HNI+rdv0lPt06w97DOfy3nM2XLT2rxm6H/4zCzmr6VhNktgGNFSFr99yoNmtdcj8idsXHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0KAVvEW5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FsxNbcxo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 17 Oct 2024 11:56:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729166188;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BB1yNVRq+OILqClKq+zVePQnu0ucXFVqt7WllvqPcc8=;
	b=0KAVvEW5+BvZ4EvGAf17+Mm2AkJxpvt34wpi7fMLb2bGlTaIlI47AqUrxgNrbvyOxXW/hD
	+gO3b26qUFnY5TEGycjSLY1S5Rn+OJiQK3ESSus3RCBE3r+IlyxwhWh6k/Cps53bnzhJ8j
	Sr0e8Cuqg2821GyLsYLaqpCVgIgp6tCVGPdUHCDXIOXOJK3ywSTvjQnWw01/Er9ub3dCAb
	qbpcD/7nXO2zKuInePm54mBnD+bwfhT88pnzYcMfhjaH/P2psZbAZu69ab04tLr2va+DPU
	54XbxaOvraZhaEYJRtyCad2gYmfbydoT29Sg/karUko5n+ewMN3cqr/AJltYEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729166188;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BB1yNVRq+OILqClKq+zVePQnu0ucXFVqt7WllvqPcc8=;
	b=FsxNbcxo2gtSxGu6bxOGUO9sFkqPURm5X9eLPX+8NFXDncrp7yV8rrX64woz7z7ZKBYR8X
	UDL0l3rrGEwPqsAQ==
From: "tip-bot2 for Nikunj A Dadhania" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] virt: sev-guest: Consolidate SNP guest messaging
 parameters to a struct
Cc: Nikunj A Dadhania <nikunj@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241009092850.197575-5-nikunj@amd.com>
References: <20241009092850.197575-5-nikunj@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172916618816.1442.3529444455693835816.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     999d73686ba1c0700aba4ac0fe86e26f759468a9
Gitweb:        https://git.kernel.org/tip/999d73686ba1c0700aba4ac0fe86e26f759468a9
Author:        Nikunj A Dadhania <nikunj@amd.com>
AuthorDate:    Wed, 09 Oct 2024 14:58:35 +05:30
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 16 Oct 2024 18:30:40 +02:00

virt: sev-guest: Consolidate SNP guest messaging parameters to a struct

Add a snp_guest_req structure to eliminate the need to pass a long list of
parameters. This structure will be used to call the SNP Guest message
request API, simplifying the function arguments.

Update the snp_issue_guest_request() prototype to include the new guest
request structure.

Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/r/20241009092850.197575-5-nikunj@amd.com
---
 arch/x86/coco/sev/core.c                |  9 +--
 arch/x86/include/asm/sev.h              | 19 ++++-
 drivers/virt/coco/sev-guest/sev-guest.c | 84 +++++++++++++++---------
 3 files changed, 76 insertions(+), 36 deletions(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index af50a38..c7b4270 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -2373,7 +2373,8 @@ int snp_issue_svsm_attest_req(u64 call_id, struct svsm_call *call,
 }
 EXPORT_SYMBOL_GPL(snp_issue_svsm_attest_req);
 
-int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct snp_guest_request_ioctl *rio)
+int snp_issue_guest_request(struct snp_guest_req *req, struct snp_req_data *input,
+			    struct snp_guest_request_ioctl *rio)
 {
 	struct ghcb_state state;
 	struct es_em_ctxt ctxt;
@@ -2397,12 +2398,12 @@ int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct sn
 
 	vc_ghcb_invalidate(ghcb);
 
-	if (exit_code == SVM_VMGEXIT_EXT_GUEST_REQUEST) {
+	if (req->exit_code == SVM_VMGEXIT_EXT_GUEST_REQUEST) {
 		ghcb_set_rax(ghcb, input->data_gpa);
 		ghcb_set_rbx(ghcb, input->data_npages);
 	}
 
-	ret = sev_es_ghcb_hv_call(ghcb, &ctxt, exit_code, input->req_gpa, input->resp_gpa);
+	ret = sev_es_ghcb_hv_call(ghcb, &ctxt, req->exit_code, input->req_gpa, input->resp_gpa);
 	if (ret)
 		goto e_put;
 
@@ -2417,7 +2418,7 @@ int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct sn
 
 	case SNP_GUEST_VMM_ERR(SNP_GUEST_VMM_ERR_INVALID_LEN):
 		/* Number of expected pages are returned in RBX */
-		if (exit_code == SVM_VMGEXIT_EXT_GUEST_REQUEST) {
+		if (req->exit_code == SVM_VMGEXIT_EXT_GUEST_REQUEST) {
 			input->data_npages = ghcb_get_rbx(ghcb);
 			ret = -ENOSPC;
 			break;
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index e7977f7..27fa1c9 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -174,6 +174,19 @@ struct sev_guest_platform_data {
 	u64 secrets_gpa;
 };
 
+struct snp_guest_req {
+	void *req_buf;
+	size_t req_sz;
+
+	void *resp_buf;
+	size_t resp_sz;
+
+	u64 exit_code;
+	unsigned int vmpck_id;
+	u8 msg_version;
+	u8 msg_type;
+};
+
 /*
  * The secrets page contains 96-bytes of reserved field that can be used by
  * the guest OS. The guest OS uses the area to save the message sequence
@@ -395,7 +408,8 @@ void snp_set_wakeup_secondary_cpu(void);
 bool snp_init(struct boot_params *bp);
 void __noreturn snp_abort(void);
 void snp_dmi_setup(void);
-int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct snp_guest_request_ioctl *rio);
+int snp_issue_guest_request(struct snp_guest_req *req, struct snp_req_data *input,
+			    struct snp_guest_request_ioctl *rio);
 int snp_issue_svsm_attest_req(u64 call_id, struct svsm_call *call, struct svsm_attest_call *input);
 void snp_accept_memory(phys_addr_t start, phys_addr_t end);
 u64 snp_get_unsupported_features(u64 status);
@@ -425,7 +439,8 @@ static inline void snp_set_wakeup_secondary_cpu(void) { }
 static inline bool snp_init(struct boot_params *bp) { return false; }
 static inline void snp_abort(void) { }
 static inline void snp_dmi_setup(void) { }
-static inline int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct snp_guest_request_ioctl *rio)
+static inline int snp_issue_guest_request(struct snp_guest_req *req, struct snp_req_data *input,
+					  struct snp_guest_request_ioctl *rio)
 {
 	return -ENOTTY;
 }
diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index a33daff..2a1b542 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -177,7 +177,7 @@ static struct aesgcm_ctx *snp_init_crypto(u8 *key, size_t keylen)
 	return ctx;
 }
 
-static int verify_and_dec_payload(struct snp_guest_dev *snp_dev, void *payload, u32 sz)
+static int verify_and_dec_payload(struct snp_guest_dev *snp_dev, struct snp_guest_req *req)
 {
 	struct snp_guest_msg *resp_msg = &snp_dev->secret_response;
 	struct snp_guest_msg *req_msg = &snp_dev->secret_request;
@@ -206,20 +206,19 @@ static int verify_and_dec_payload(struct snp_guest_dev *snp_dev, void *payload, 
 	 * If the message size is greater than our buffer length then return
 	 * an error.
 	 */
-	if (unlikely((resp_msg_hdr->msg_sz + ctx->authsize) > sz))
+	if (unlikely((resp_msg_hdr->msg_sz + ctx->authsize) > req->resp_sz))
 		return -EBADMSG;
 
 	/* Decrypt the payload */
 	memcpy(iv, &resp_msg_hdr->msg_seqno, min(sizeof(iv), sizeof(resp_msg_hdr->msg_seqno)));
-	if (!aesgcm_decrypt(ctx, payload, resp_msg->payload, resp_msg_hdr->msg_sz,
+	if (!aesgcm_decrypt(ctx, req->resp_buf, resp_msg->payload, resp_msg_hdr->msg_sz,
 			    &resp_msg_hdr->algo, AAD_LEN, iv, resp_msg_hdr->authtag))
 		return -EBADMSG;
 
 	return 0;
 }
 
-static int enc_payload(struct snp_guest_dev *snp_dev, u64 seqno, int version, u8 type,
-			void *payload, size_t sz)
+static int enc_payload(struct snp_guest_dev *snp_dev, u64 seqno, struct snp_guest_req *req)
 {
 	struct snp_guest_msg *msg = &snp_dev->secret_request;
 	struct snp_guest_msg_hdr *hdr = &msg->hdr;
@@ -231,11 +230,11 @@ static int enc_payload(struct snp_guest_dev *snp_dev, u64 seqno, int version, u8
 	hdr->algo = SNP_AEAD_AES_256_GCM;
 	hdr->hdr_version = MSG_HDR_VER;
 	hdr->hdr_sz = sizeof(*hdr);
-	hdr->msg_type = type;
-	hdr->msg_version = version;
+	hdr->msg_type = req->msg_type;
+	hdr->msg_version = req->msg_version;
 	hdr->msg_seqno = seqno;
-	hdr->msg_vmpck = vmpck_id;
-	hdr->msg_sz = sz;
+	hdr->msg_vmpck = req->vmpck_id;
+	hdr->msg_sz = req->req_sz;
 
 	/* Verify the sequence number is non-zero */
 	if (!hdr->msg_seqno)
@@ -244,17 +243,17 @@ static int enc_payload(struct snp_guest_dev *snp_dev, u64 seqno, int version, u8
 	pr_debug("request [seqno %lld type %d version %d sz %d]\n",
 		 hdr->msg_seqno, hdr->msg_type, hdr->msg_version, hdr->msg_sz);
 
-	if (WARN_ON((sz + ctx->authsize) > sizeof(msg->payload)))
+	if (WARN_ON((req->req_sz + ctx->authsize) > sizeof(msg->payload)))
 		return -EBADMSG;
 
 	memcpy(iv, &hdr->msg_seqno, min(sizeof(iv), sizeof(hdr->msg_seqno)));
-	aesgcm_encrypt(ctx, msg->payload, payload, sz, &hdr->algo, AAD_LEN,
-		       iv, hdr->authtag);
+	aesgcm_encrypt(ctx, msg->payload, req->req_buf, req->req_sz, &hdr->algo,
+		       AAD_LEN, iv, hdr->authtag);
 
 	return 0;
 }
 
-static int __handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
+static int __handle_guest_request(struct snp_guest_dev *snp_dev, struct snp_guest_req *req,
 				  struct snp_guest_request_ioctl *rio)
 {
 	unsigned long req_start = jiffies;
@@ -269,7 +268,7 @@ retry_request:
 	 * sequence number must be incremented or the VMPCK must be deleted to
 	 * prevent reuse of the IV.
 	 */
-	rc = snp_issue_guest_request(exit_code, &snp_dev->input, rio);
+	rc = snp_issue_guest_request(req, &snp_dev->input, rio);
 	switch (rc) {
 	case -ENOSPC:
 		/*
@@ -280,7 +279,7 @@ retry_request:
 		 * IV reuse.
 		 */
 		override_npages = snp_dev->input.data_npages;
-		exit_code	= SVM_VMGEXIT_GUEST_REQUEST;
+		req->exit_code	= SVM_VMGEXIT_GUEST_REQUEST;
 
 		/*
 		 * Override the error to inform callers the given extended
@@ -340,10 +339,8 @@ retry_request:
 	return rc;
 }
 
-static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
-				struct snp_guest_request_ioctl *rio, u8 type,
-				void *req_buf, size_t req_sz, void *resp_buf,
-				u32 resp_sz)
+static int snp_send_guest_request(struct snp_guest_dev *snp_dev, struct snp_guest_req *req,
+				  struct snp_guest_request_ioctl *rio)
 {
 	u64 seqno;
 	int rc;
@@ -357,7 +354,7 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
 	memset(snp_dev->response, 0, sizeof(struct snp_guest_msg));
 
 	/* Encrypt the userspace provided payload in snp_dev->secret_request. */
-	rc = enc_payload(snp_dev, seqno, rio->msg_version, type, req_buf, req_sz);
+	rc = enc_payload(snp_dev, seqno, req);
 	if (rc)
 		return rc;
 
@@ -368,7 +365,7 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
 	memcpy(snp_dev->request, &snp_dev->secret_request,
 	       sizeof(snp_dev->secret_request));
 
-	rc = __handle_guest_request(snp_dev, exit_code, rio);
+	rc = __handle_guest_request(snp_dev, req, rio);
 	if (rc) {
 		if (rc == -EIO &&
 		    rio->exitinfo2 == SNP_GUEST_VMM_ERR(SNP_GUEST_VMM_ERR_INVALID_LEN))
@@ -382,7 +379,7 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
 		return rc;
 	}
 
-	rc = verify_and_dec_payload(snp_dev, resp_buf, resp_sz);
+	rc = verify_and_dec_payload(snp_dev, req);
 	if (rc) {
 		dev_alert(snp_dev->dev, "Detected unexpected decode failure from ASP. rc: %d\n", rc);
 		snp_disable_vmpck(snp_dev);
@@ -401,6 +398,7 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
 {
 	struct snp_report_req *report_req = &snp_dev->req.report;
 	struct snp_report_resp *report_resp;
+	struct snp_guest_req req = {};
 	int rc, resp_len;
 
 	lockdep_assert_held(&snp_cmd_mutex);
@@ -421,8 +419,16 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
 	if (!report_resp)
 		return -ENOMEM;
 
-	rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, arg, SNP_MSG_REPORT_REQ,
-				  report_req, sizeof(*report_req), report_resp->data, resp_len);
+	req.msg_version = arg->msg_version;
+	req.msg_type = SNP_MSG_REPORT_REQ;
+	req.vmpck_id = vmpck_id;
+	req.req_buf = report_req;
+	req.req_sz = sizeof(*report_req);
+	req.resp_buf = report_resp->data;
+	req.resp_sz = resp_len;
+	req.exit_code = SVM_VMGEXIT_GUEST_REQUEST;
+
+	rc = snp_send_guest_request(snp_dev, &req, arg);
 	if (rc)
 		goto e_free;
 
@@ -438,6 +444,7 @@ static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_reque
 {
 	struct snp_derived_key_req *derived_key_req = &snp_dev->req.derived_key;
 	struct snp_derived_key_resp derived_key_resp = {0};
+	struct snp_guest_req req = {};
 	int rc, resp_len;
 	/* Response data is 64 bytes and max authsize for GCM is 16 bytes. */
 	u8 buf[64 + 16];
@@ -460,8 +467,16 @@ static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_reque
 			   sizeof(*derived_key_req)))
 		return -EFAULT;
 
-	rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, arg, SNP_MSG_KEY_REQ,
-				  derived_key_req, sizeof(*derived_key_req), buf, resp_len);
+	req.msg_version = arg->msg_version;
+	req.msg_type = SNP_MSG_KEY_REQ;
+	req.vmpck_id = vmpck_id;
+	req.req_buf = derived_key_req;
+	req.req_sz = sizeof(*derived_key_req);
+	req.resp_buf = buf;
+	req.resp_sz = resp_len;
+	req.exit_code = SVM_VMGEXIT_GUEST_REQUEST;
+
+	rc = snp_send_guest_request(snp_dev, &req, arg);
 	if (rc)
 		return rc;
 
@@ -482,6 +497,7 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
 {
 	struct snp_ext_report_req *report_req = &snp_dev->req.ext_report;
 	struct snp_report_resp *report_resp;
+	struct snp_guest_req req = {};
 	int ret, npages = 0, resp_len;
 	sockptr_t certs_address;
 
@@ -529,9 +545,17 @@ cmd:
 		return -ENOMEM;
 
 	snp_dev->input.data_npages = npages;
-	ret = handle_guest_request(snp_dev, SVM_VMGEXIT_EXT_GUEST_REQUEST, arg, SNP_MSG_REPORT_REQ,
-				   &report_req->data, sizeof(report_req->data),
-				   report_resp->data, resp_len);
+
+	req.msg_version = arg->msg_version;
+	req.msg_type = SNP_MSG_REPORT_REQ;
+	req.vmpck_id = vmpck_id;
+	req.req_buf = &report_req->data;
+	req.req_sz = sizeof(report_req->data);
+	req.resp_buf = report_resp->data;
+	req.resp_sz = resp_len;
+	req.exit_code = SVM_VMGEXIT_EXT_GUEST_REQUEST;
+
+	ret = snp_send_guest_request(snp_dev, &req, arg);
 
 	/* If certs length is invalid then copy the returned length */
 	if (arg->vmm_error == SNP_GUEST_VMM_ERR_INVALID_LEN) {
@@ -1057,7 +1081,7 @@ static int __init sev_guest_probe(struct platform_device *pdev)
 	misc->name = DEVICE_NAME;
 	misc->fops = &snp_guest_fops;
 
-	/* initial the input address for guest request */
+	/* Initialize the input addresses for guest request */
 	snp_dev->input.req_gpa = __pa(snp_dev->request);
 	snp_dev->input.resp_gpa = __pa(snp_dev->response);
 	snp_dev->input.data_gpa = __pa(snp_dev->certs_data);

