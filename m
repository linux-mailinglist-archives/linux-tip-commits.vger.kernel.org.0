Return-Path: <linux-tip-commits+bounces-3193-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 863D1A071DA
	for <lists+linux-tip-commits@lfdr.de>; Thu,  9 Jan 2025 10:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D98F3A1E88
	for <lists+linux-tip-commits@lfdr.de>; Thu,  9 Jan 2025 09:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22781216E07;
	Thu,  9 Jan 2025 09:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dMW8GOob";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+Om0w7bU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C222163AC;
	Thu,  9 Jan 2025 09:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736415833; cv=none; b=d3YSFj/pBjG4VGIaEZCTzybkwoT+k96sQoj+ejsefDfKbRtqjHMuhLQmIi/l7FDThgylFU5QhT/XwNEVWaMFfa62ogWXnBoiDL/WBmPfTYwlaSZ206H9YSplv4+bbNsutaHJ9rLjM0lbpa/f9wH6B9a3xmnUb0DJDID3rfH2o58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736415833; c=relaxed/simple;
	bh=8iINVAaaUDbcmuUrehzAwZGw7PLuKjTAWjUM5Z2QPUk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SrKkqG9bRpYwcSjdl6+Z5nMFHDV/RkKLoZpDeQ8jhzaVuAqw/CHSbzAQVimFoqNPpuv13pKd7mdatBAyETyGlIlt8xHlywvRKsNgNrM+xB6oW+du5E58lM+DcQpNR2dNhq3uDcc8KKavFSmXNV/Q/NKZl6qIM0JV4bgGPEwDvz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dMW8GOob; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+Om0w7bU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 09 Jan 2025 09:43:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736415828;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=10Tb+hvg8zRGI3GL78AYiWakvB5HkcxNzgimDn1P6NI=;
	b=dMW8GOobCq+tPw22FcVjo9k4kadIdkHY9miDiwCnHnRZUcNjx27UhWZuYyrspnRMlx0x8s
	Ax5AJDQxQTtoY6z7jFWVJ45A9cbDYk/yKp9MvKRcm1sW2qakKdSktkYhTOl+r4xghoI9PA
	kOvRz/tAFdSaWUrRsr+Om1UwErddQ6StPKL5Gh92B55Nn+REubhPbGRWhgngjzwztYFq+c
	5Q0cl0gIJ4qT3rVXM09j31PVN1MHpW7a7oX09Fgt33nHgUI+bKL/lyWU5TLBZL4DF8auFf
	TMs/T26ynJnPQEvJPN4YC+K3T8yPbhhPc8okMTf4zLFxru/wtp0ksryCZZ8yBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736415828;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=10Tb+hvg8zRGI3GL78AYiWakvB5HkcxNzgimDn1P6NI=;
	b=+Om0w7bU56Jaarke8kEy/sOE9FA7habFSwSx7o3NNAwclfEeeJfFWpSHs3NlxEcd5DauHb
	SWLKhlrcePCI8KDg==
From: "tip-bot2 for Nikunj A Dadhania" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/sev] x86/sev: Relocate SNP guest messaging routines to common code
Cc: Nikunj A Dadhania <nikunj@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250106124633.1418972-5-nikunj@amd.com>
References: <20250106124633.1418972-5-nikunj@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173641582808.399.7706386508134971018.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     1e0b23b5d2d18b2bd2c66d8214072d700a8c350d
Gitweb:        https://git.kernel.org/tip/1e0b23b5d2d18b2bd2c66d8214072d700a8c350d
Author:        Nikunj A Dadhania <nikunj@amd.com>
AuthorDate:    Mon, 06 Jan 2025 18:16:24 +05:30
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 07 Jan 2025 11:16:46 +01:00

x86/sev: Relocate SNP guest messaging routines to common code

At present, the SEV guest driver exclusively handles SNP guest messaging. All
routines for sending guest messages are embedded within it.

To support Secure TSC, SEV-SNP guests must communicate with the AMD Security
Processor during early boot. However, these guest messaging functions are not
accessible during early boot since they are currently part of the guest
driver.

Hence, relocate the core SNP guest messaging functions to SEV common code and
provide an API for sending SNP guest messages.

No functional change, but just an export symbol added for
snp_send_guest_request() and dropped the export symbol on
snp_issue_guest_request() and made it static.

Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/r/20250106124633.1418972-5-nikunj@amd.com
---
 arch/x86/coco/sev/core.c                | 294 ++++++++++++++++++++++-
 arch/x86/include/asm/sev.h              |  14 +-
 drivers/virt/coco/sev-guest/sev-guest.c | 292 +-----------------------
 3 files changed, 298 insertions(+), 302 deletions(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 30ce563..ad3a288 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -2509,8 +2509,8 @@ int snp_issue_svsm_attest_req(u64 call_id, struct svsm_call *call,
 }
 EXPORT_SYMBOL_GPL(snp_issue_svsm_attest_req);
 
-int snp_issue_guest_request(struct snp_guest_req *req, struct snp_req_data *input,
-			    struct snp_guest_request_ioctl *rio)
+static int snp_issue_guest_request(struct snp_guest_req *req, struct snp_req_data *input,
+				   struct snp_guest_request_ioctl *rio)
 {
 	struct ghcb_state state;
 	struct es_em_ctxt ctxt;
@@ -2572,7 +2572,6 @@ e_restore_irq:
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(snp_issue_guest_request);
 
 static struct platform_device sev_guest_device = {
 	.name		= "sev-guest",
@@ -2838,3 +2837,292 @@ void snp_msg_free(struct snp_msg_desc *mdesc)
 	kfree(mdesc);
 }
 EXPORT_SYMBOL_GPL(snp_msg_free);
+
+/* Mutex to serialize the shared buffer access and command handling. */
+static DEFINE_MUTEX(snp_cmd_mutex);
+
+/*
+ * If an error is received from the host or AMD Secure Processor (ASP) there
+ * are two options. Either retry the exact same encrypted request or discontinue
+ * using the VMPCK.
+ *
+ * This is because in the current encryption scheme GHCB v2 uses AES-GCM to
+ * encrypt the requests. The IV for this scheme is the sequence number. GCM
+ * cannot tolerate IV reuse.
+ *
+ * The ASP FW v1.51 only increments the sequence numbers on a successful
+ * guest<->ASP back and forth and only accepts messages at its exact sequence
+ * number.
+ *
+ * So if the sequence number were to be reused the encryption scheme is
+ * vulnerable. If the sequence number were incremented for a fresh IV the ASP
+ * will reject the request.
+ */
+static void snp_disable_vmpck(struct snp_msg_desc *mdesc)
+{
+	pr_alert("Disabling VMPCK%d communication key to prevent IV reuse.\n",
+		  mdesc->vmpck_id);
+	memzero_explicit(mdesc->vmpck, VMPCK_KEY_LEN);
+	mdesc->vmpck = NULL;
+}
+
+static inline u64 __snp_get_msg_seqno(struct snp_msg_desc *mdesc)
+{
+	u64 count;
+
+	lockdep_assert_held(&snp_cmd_mutex);
+
+	/* Read the current message sequence counter from secrets pages */
+	count = *mdesc->os_area_msg_seqno;
+
+	return count + 1;
+}
+
+/* Return a non-zero on success */
+static u64 snp_get_msg_seqno(struct snp_msg_desc *mdesc)
+{
+	u64 count = __snp_get_msg_seqno(mdesc);
+
+	/*
+	 * The message sequence counter for the SNP guest request is a  64-bit
+	 * value but the version 2 of GHCB specification defines a 32-bit storage
+	 * for it. If the counter exceeds the 32-bit value then return zero.
+	 * The caller should check the return value, but if the caller happens to
+	 * not check the value and use it, then the firmware treats zero as an
+	 * invalid number and will fail the  message request.
+	 */
+	if (count >= UINT_MAX) {
+		pr_err("request message sequence counter overflow\n");
+		return 0;
+	}
+
+	return count;
+}
+
+static void snp_inc_msg_seqno(struct snp_msg_desc *mdesc)
+{
+	/*
+	 * The counter is also incremented by the PSP, so increment it by 2
+	 * and save in secrets page.
+	 */
+	*mdesc->os_area_msg_seqno += 2;
+}
+
+static int verify_and_dec_payload(struct snp_msg_desc *mdesc, struct snp_guest_req *req)
+{
+	struct snp_guest_msg *resp_msg = &mdesc->secret_response;
+	struct snp_guest_msg *req_msg = &mdesc->secret_request;
+	struct snp_guest_msg_hdr *req_msg_hdr = &req_msg->hdr;
+	struct snp_guest_msg_hdr *resp_msg_hdr = &resp_msg->hdr;
+	struct aesgcm_ctx *ctx = mdesc->ctx;
+	u8 iv[GCM_AES_IV_SIZE] = {};
+
+	pr_debug("response [seqno %lld type %d version %d sz %d]\n",
+		 resp_msg_hdr->msg_seqno, resp_msg_hdr->msg_type, resp_msg_hdr->msg_version,
+		 resp_msg_hdr->msg_sz);
+
+	/* Copy response from shared memory to encrypted memory. */
+	memcpy(resp_msg, mdesc->response, sizeof(*resp_msg));
+
+	/* Verify that the sequence counter is incremented by 1 */
+	if (unlikely(resp_msg_hdr->msg_seqno != (req_msg_hdr->msg_seqno + 1)))
+		return -EBADMSG;
+
+	/* Verify response message type and version number. */
+	if (resp_msg_hdr->msg_type != (req_msg_hdr->msg_type + 1) ||
+	    resp_msg_hdr->msg_version != req_msg_hdr->msg_version)
+		return -EBADMSG;
+
+	/*
+	 * If the message size is greater than our buffer length then return
+	 * an error.
+	 */
+	if (unlikely((resp_msg_hdr->msg_sz + ctx->authsize) > req->resp_sz))
+		return -EBADMSG;
+
+	/* Decrypt the payload */
+	memcpy(iv, &resp_msg_hdr->msg_seqno, min(sizeof(iv), sizeof(resp_msg_hdr->msg_seqno)));
+	if (!aesgcm_decrypt(ctx, req->resp_buf, resp_msg->payload, resp_msg_hdr->msg_sz,
+			    &resp_msg_hdr->algo, AAD_LEN, iv, resp_msg_hdr->authtag))
+		return -EBADMSG;
+
+	return 0;
+}
+
+static int enc_payload(struct snp_msg_desc *mdesc, u64 seqno, struct snp_guest_req *req)
+{
+	struct snp_guest_msg *msg = &mdesc->secret_request;
+	struct snp_guest_msg_hdr *hdr = &msg->hdr;
+	struct aesgcm_ctx *ctx = mdesc->ctx;
+	u8 iv[GCM_AES_IV_SIZE] = {};
+
+	memset(msg, 0, sizeof(*msg));
+
+	hdr->algo = SNP_AEAD_AES_256_GCM;
+	hdr->hdr_version = MSG_HDR_VER;
+	hdr->hdr_sz = sizeof(*hdr);
+	hdr->msg_type = req->msg_type;
+	hdr->msg_version = req->msg_version;
+	hdr->msg_seqno = seqno;
+	hdr->msg_vmpck = req->vmpck_id;
+	hdr->msg_sz = req->req_sz;
+
+	/* Verify the sequence number is non-zero */
+	if (!hdr->msg_seqno)
+		return -ENOSR;
+
+	pr_debug("request [seqno %lld type %d version %d sz %d]\n",
+		 hdr->msg_seqno, hdr->msg_type, hdr->msg_version, hdr->msg_sz);
+
+	if (WARN_ON((req->req_sz + ctx->authsize) > sizeof(msg->payload)))
+		return -EBADMSG;
+
+	memcpy(iv, &hdr->msg_seqno, min(sizeof(iv), sizeof(hdr->msg_seqno)));
+	aesgcm_encrypt(ctx, msg->payload, req->req_buf, req->req_sz, &hdr->algo,
+		       AAD_LEN, iv, hdr->authtag);
+
+	return 0;
+}
+
+static int __handle_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_req *req,
+				  struct snp_guest_request_ioctl *rio)
+{
+	unsigned long req_start = jiffies;
+	unsigned int override_npages = 0;
+	u64 override_err = 0;
+	int rc;
+
+retry_request:
+	/*
+	 * Call firmware to process the request. In this function the encrypted
+	 * message enters shared memory with the host. So after this call the
+	 * sequence number must be incremented or the VMPCK must be deleted to
+	 * prevent reuse of the IV.
+	 */
+	rc = snp_issue_guest_request(req, &mdesc->input, rio);
+	switch (rc) {
+	case -ENOSPC:
+		/*
+		 * If the extended guest request fails due to having too
+		 * small of a certificate data buffer, retry the same
+		 * guest request without the extended data request in
+		 * order to increment the sequence number and thus avoid
+		 * IV reuse.
+		 */
+		override_npages = mdesc->input.data_npages;
+		req->exit_code	= SVM_VMGEXIT_GUEST_REQUEST;
+
+		/*
+		 * Override the error to inform callers the given extended
+		 * request buffer size was too small and give the caller the
+		 * required buffer size.
+		 */
+		override_err = SNP_GUEST_VMM_ERR(SNP_GUEST_VMM_ERR_INVALID_LEN);
+
+		/*
+		 * If this call to the firmware succeeds, the sequence number can
+		 * be incremented allowing for continued use of the VMPCK. If
+		 * there is an error reflected in the return value, this value
+		 * is checked further down and the result will be the deletion
+		 * of the VMPCK and the error code being propagated back to the
+		 * user as an ioctl() return code.
+		 */
+		goto retry_request;
+
+	/*
+	 * The host may return SNP_GUEST_VMM_ERR_BUSY if the request has been
+	 * throttled. Retry in the driver to avoid returning and reusing the
+	 * message sequence number on a different message.
+	 */
+	case -EAGAIN:
+		if (jiffies - req_start > SNP_REQ_MAX_RETRY_DURATION) {
+			rc = -ETIMEDOUT;
+			break;
+		}
+		schedule_timeout_killable(SNP_REQ_RETRY_DELAY);
+		goto retry_request;
+	}
+
+	/*
+	 * Increment the message sequence number. There is no harm in doing
+	 * this now because decryption uses the value stored in the response
+	 * structure and any failure will wipe the VMPCK, preventing further
+	 * use anyway.
+	 */
+	snp_inc_msg_seqno(mdesc);
+
+	if (override_err) {
+		rio->exitinfo2 = override_err;
+
+		/*
+		 * If an extended guest request was issued and the supplied certificate
+		 * buffer was not large enough, a standard guest request was issued to
+		 * prevent IV reuse. If the standard request was successful, return -EIO
+		 * back to the caller as would have originally been returned.
+		 */
+		if (!rc && override_err == SNP_GUEST_VMM_ERR(SNP_GUEST_VMM_ERR_INVALID_LEN))
+			rc = -EIO;
+	}
+
+	if (override_npages)
+		mdesc->input.data_npages = override_npages;
+
+	return rc;
+}
+
+int snp_send_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_req *req,
+			   struct snp_guest_request_ioctl *rio)
+{
+	u64 seqno;
+	int rc;
+
+	guard(mutex)(&snp_cmd_mutex);
+
+	/* Check if the VMPCK is not empty */
+	if (!mdesc->vmpck || !memchr_inv(mdesc->vmpck, 0, VMPCK_KEY_LEN)) {
+		pr_err_ratelimited("VMPCK is disabled\n");
+		return -ENOTTY;
+	}
+
+	/* Get message sequence and verify that its a non-zero */
+	seqno = snp_get_msg_seqno(mdesc);
+	if (!seqno)
+		return -EIO;
+
+	/* Clear shared memory's response for the host to populate. */
+	memset(mdesc->response, 0, sizeof(struct snp_guest_msg));
+
+	/* Encrypt the userspace provided payload in mdesc->secret_request. */
+	rc = enc_payload(mdesc, seqno, req);
+	if (rc)
+		return rc;
+
+	/*
+	 * Write the fully encrypted request to the shared unencrypted
+	 * request page.
+	 */
+	memcpy(mdesc->request, &mdesc->secret_request, sizeof(mdesc->secret_request));
+
+	rc = __handle_guest_request(mdesc, req, rio);
+	if (rc) {
+		if (rc == -EIO &&
+		    rio->exitinfo2 == SNP_GUEST_VMM_ERR(SNP_GUEST_VMM_ERR_INVALID_LEN))
+			return rc;
+
+		pr_alert("Detected error from ASP request. rc: %d, exitinfo2: 0x%llx\n",
+			 rc, rio->exitinfo2);
+
+		snp_disable_vmpck(mdesc);
+		return rc;
+	}
+
+	rc = verify_and_dec_payload(mdesc, req);
+	if (rc) {
+		pr_alert("Detected unexpected decode failure from ASP. rc: %d\n", rc);
+		snp_disable_vmpck(mdesc);
+		return rc;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snp_send_guest_request);
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index db08d0a..0937ac7 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -125,6 +125,9 @@ struct snp_req_data {
 #define AAD_LEN			48
 #define MSG_HDR_VER		1
 
+#define SNP_REQ_MAX_RETRY_DURATION      (60*HZ)
+#define SNP_REQ_RETRY_DELAY             (2*HZ)
+
 /* See SNP spec SNP_GUEST_REQUEST section for the structure */
 enum msg_type {
 	SNP_MSG_TYPE_INVALID = 0,
@@ -443,8 +446,6 @@ void snp_set_wakeup_secondary_cpu(void);
 bool snp_init(struct boot_params *bp);
 void __noreturn snp_abort(void);
 void snp_dmi_setup(void);
-int snp_issue_guest_request(struct snp_guest_req *req, struct snp_req_data *input,
-			    struct snp_guest_request_ioctl *rio);
 int snp_issue_svsm_attest_req(u64 call_id, struct svsm_call *call, struct svsm_attest_call *input);
 void snp_accept_memory(phys_addr_t start, phys_addr_t end);
 u64 snp_get_unsupported_features(u64 status);
@@ -459,6 +460,8 @@ void snp_kexec_begin(void);
 int snp_msg_init(struct snp_msg_desc *mdesc, int vmpck_id);
 struct snp_msg_desc *snp_msg_alloc(void);
 void snp_msg_free(struct snp_msg_desc *mdesc);
+int snp_send_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_req *req,
+			   struct snp_guest_request_ioctl *rio);
 
 #else	/* !CONFIG_AMD_MEM_ENCRYPT */
 
@@ -482,11 +485,6 @@ static inline void snp_set_wakeup_secondary_cpu(void) { }
 static inline bool snp_init(struct boot_params *bp) { return false; }
 static inline void snp_abort(void) { }
 static inline void snp_dmi_setup(void) { }
-static inline int snp_issue_guest_request(struct snp_guest_req *req, struct snp_req_data *input,
-					  struct snp_guest_request_ioctl *rio)
-{
-	return -ENOTTY;
-}
 static inline int snp_issue_svsm_attest_req(u64 call_id, struct svsm_call *call, struct svsm_attest_call *input)
 {
 	return -ENOTTY;
@@ -503,6 +501,8 @@ static inline void snp_kexec_begin(void) { }
 static inline int snp_msg_init(struct snp_msg_desc *mdesc, int vmpck_id) { return -1; }
 static inline struct snp_msg_desc *snp_msg_alloc(void) { return NULL; }
 static inline void snp_msg_free(struct snp_msg_desc *mdesc) { }
+static inline int snp_send_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_req *req,
+					 struct snp_guest_request_ioctl *rio) { return -ENODEV; }
 
 #endif	/* CONFIG_AMD_MEM_ENCRYPT */
 
diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index d0f7233..264b652 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -31,9 +31,6 @@
 
 #define DEVICE_NAME	"sev-guest"
 
-#define SNP_REQ_MAX_RETRY_DURATION	(60*HZ)
-#define SNP_REQ_RETRY_DELAY		(2*HZ)
-
 #define SVSM_MAX_RETRIES		3
 
 struct snp_guest_dev {
@@ -60,76 +57,6 @@ static int vmpck_id = -1;
 module_param(vmpck_id, int, 0444);
 MODULE_PARM_DESC(vmpck_id, "The VMPCK ID to use when communicating with the PSP.");
 
-/* Mutex to serialize the shared buffer access and command handling. */
-static DEFINE_MUTEX(snp_cmd_mutex);
-
-/*
- * If an error is received from the host or AMD Secure Processor (ASP) there
- * are two options. Either retry the exact same encrypted request or discontinue
- * using the VMPCK.
- *
- * This is because in the current encryption scheme GHCB v2 uses AES-GCM to
- * encrypt the requests. The IV for this scheme is the sequence number. GCM
- * cannot tolerate IV reuse.
- *
- * The ASP FW v1.51 only increments the sequence numbers on a successful
- * guest<->ASP back and forth and only accepts messages at its exact sequence
- * number.
- *
- * So if the sequence number were to be reused the encryption scheme is
- * vulnerable. If the sequence number were incremented for a fresh IV the ASP
- * will reject the request.
- */
-static void snp_disable_vmpck(struct snp_msg_desc *mdesc)
-{
-	pr_alert("Disabling VMPCK%d communication key to prevent IV reuse.\n",
-		  mdesc->vmpck_id);
-	memzero_explicit(mdesc->vmpck, VMPCK_KEY_LEN);
-	mdesc->vmpck = NULL;
-}
-
-static inline u64 __snp_get_msg_seqno(struct snp_msg_desc *mdesc)
-{
-	u64 count;
-
-	lockdep_assert_held(&snp_cmd_mutex);
-
-	/* Read the current message sequence counter from secrets pages */
-	count = *mdesc->os_area_msg_seqno;
-
-	return count + 1;
-}
-
-/* Return a non-zero on success */
-static u64 snp_get_msg_seqno(struct snp_msg_desc *mdesc)
-{
-	u64 count = __snp_get_msg_seqno(mdesc);
-
-	/*
-	 * The message sequence counter for the SNP guest request is a  64-bit
-	 * value but the version 2 of GHCB specification defines a 32-bit storage
-	 * for it. If the counter exceeds the 32-bit value then return zero.
-	 * The caller should check the return value, but if the caller happens to
-	 * not check the value and use it, then the firmware treats zero as an
-	 * invalid number and will fail the  message request.
-	 */
-	if (count >= UINT_MAX) {
-		pr_err("request message sequence counter overflow\n");
-		return 0;
-	}
-
-	return count;
-}
-
-static void snp_inc_msg_seqno(struct snp_msg_desc *mdesc)
-{
-	/*
-	 * The counter is also incremented by the PSP, so increment it by 2
-	 * and save in secrets page.
-	 */
-	*mdesc->os_area_msg_seqno += 2;
-}
-
 static inline struct snp_guest_dev *to_snp_dev(struct file *file)
 {
 	struct miscdevice *dev = file->private_data;
@@ -137,225 +64,6 @@ static inline struct snp_guest_dev *to_snp_dev(struct file *file)
 	return container_of(dev, struct snp_guest_dev, misc);
 }
 
-static int verify_and_dec_payload(struct snp_msg_desc *mdesc, struct snp_guest_req *req)
-{
-	struct snp_guest_msg *resp_msg = &mdesc->secret_response;
-	struct snp_guest_msg *req_msg = &mdesc->secret_request;
-	struct snp_guest_msg_hdr *req_msg_hdr = &req_msg->hdr;
-	struct snp_guest_msg_hdr *resp_msg_hdr = &resp_msg->hdr;
-	struct aesgcm_ctx *ctx = mdesc->ctx;
-	u8 iv[GCM_AES_IV_SIZE] = {};
-
-	pr_debug("response [seqno %lld type %d version %d sz %d]\n",
-		 resp_msg_hdr->msg_seqno, resp_msg_hdr->msg_type, resp_msg_hdr->msg_version,
-		 resp_msg_hdr->msg_sz);
-
-	/* Copy response from shared memory to encrypted memory. */
-	memcpy(resp_msg, mdesc->response, sizeof(*resp_msg));
-
-	/* Verify that the sequence counter is incremented by 1 */
-	if (unlikely(resp_msg_hdr->msg_seqno != (req_msg_hdr->msg_seqno + 1)))
-		return -EBADMSG;
-
-	/* Verify response message type and version number. */
-	if (resp_msg_hdr->msg_type != (req_msg_hdr->msg_type + 1) ||
-	    resp_msg_hdr->msg_version != req_msg_hdr->msg_version)
-		return -EBADMSG;
-
-	/*
-	 * If the message size is greater than our buffer length then return
-	 * an error.
-	 */
-	if (unlikely((resp_msg_hdr->msg_sz + ctx->authsize) > req->resp_sz))
-		return -EBADMSG;
-
-	/* Decrypt the payload */
-	memcpy(iv, &resp_msg_hdr->msg_seqno, min(sizeof(iv), sizeof(resp_msg_hdr->msg_seqno)));
-	if (!aesgcm_decrypt(ctx, req->resp_buf, resp_msg->payload, resp_msg_hdr->msg_sz,
-			    &resp_msg_hdr->algo, AAD_LEN, iv, resp_msg_hdr->authtag))
-		return -EBADMSG;
-
-	return 0;
-}
-
-static int enc_payload(struct snp_msg_desc *mdesc, u64 seqno, struct snp_guest_req *req)
-{
-	struct snp_guest_msg *msg = &mdesc->secret_request;
-	struct snp_guest_msg_hdr *hdr = &msg->hdr;
-	struct aesgcm_ctx *ctx = mdesc->ctx;
-	u8 iv[GCM_AES_IV_SIZE] = {};
-
-	memset(msg, 0, sizeof(*msg));
-
-	hdr->algo = SNP_AEAD_AES_256_GCM;
-	hdr->hdr_version = MSG_HDR_VER;
-	hdr->hdr_sz = sizeof(*hdr);
-	hdr->msg_type = req->msg_type;
-	hdr->msg_version = req->msg_version;
-	hdr->msg_seqno = seqno;
-	hdr->msg_vmpck = req->vmpck_id;
-	hdr->msg_sz = req->req_sz;
-
-	/* Verify the sequence number is non-zero */
-	if (!hdr->msg_seqno)
-		return -ENOSR;
-
-	pr_debug("request [seqno %lld type %d version %d sz %d]\n",
-		 hdr->msg_seqno, hdr->msg_type, hdr->msg_version, hdr->msg_sz);
-
-	if (WARN_ON((req->req_sz + ctx->authsize) > sizeof(msg->payload)))
-		return -EBADMSG;
-
-	memcpy(iv, &hdr->msg_seqno, min(sizeof(iv), sizeof(hdr->msg_seqno)));
-	aesgcm_encrypt(ctx, msg->payload, req->req_buf, req->req_sz, &hdr->algo,
-		       AAD_LEN, iv, hdr->authtag);
-
-	return 0;
-}
-
-static int __handle_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_req *req,
-				  struct snp_guest_request_ioctl *rio)
-{
-	unsigned long req_start = jiffies;
-	unsigned int override_npages = 0;
-	u64 override_err = 0;
-	int rc;
-
-retry_request:
-	/*
-	 * Call firmware to process the request. In this function the encrypted
-	 * message enters shared memory with the host. So after this call the
-	 * sequence number must be incremented or the VMPCK must be deleted to
-	 * prevent reuse of the IV.
-	 */
-	rc = snp_issue_guest_request(req, &mdesc->input, rio);
-	switch (rc) {
-	case -ENOSPC:
-		/*
-		 * If the extended guest request fails due to having too
-		 * small of a certificate data buffer, retry the same
-		 * guest request without the extended data request in
-		 * order to increment the sequence number and thus avoid
-		 * IV reuse.
-		 */
-		override_npages = mdesc->input.data_npages;
-		req->exit_code	= SVM_VMGEXIT_GUEST_REQUEST;
-
-		/*
-		 * Override the error to inform callers the given extended
-		 * request buffer size was too small and give the caller the
-		 * required buffer size.
-		 */
-		override_err = SNP_GUEST_VMM_ERR(SNP_GUEST_VMM_ERR_INVALID_LEN);
-
-		/*
-		 * If this call to the firmware succeeds, the sequence number can
-		 * be incremented allowing for continued use of the VMPCK. If
-		 * there is an error reflected in the return value, this value
-		 * is checked further down and the result will be the deletion
-		 * of the VMPCK and the error code being propagated back to the
-		 * user as an ioctl() return code.
-		 */
-		goto retry_request;
-
-	/*
-	 * The host may return SNP_GUEST_VMM_ERR_BUSY if the request has been
-	 * throttled. Retry in the driver to avoid returning and reusing the
-	 * message sequence number on a different message.
-	 */
-	case -EAGAIN:
-		if (jiffies - req_start > SNP_REQ_MAX_RETRY_DURATION) {
-			rc = -ETIMEDOUT;
-			break;
-		}
-		schedule_timeout_killable(SNP_REQ_RETRY_DELAY);
-		goto retry_request;
-	}
-
-	/*
-	 * Increment the message sequence number. There is no harm in doing
-	 * this now because decryption uses the value stored in the response
-	 * structure and any failure will wipe the VMPCK, preventing further
-	 * use anyway.
-	 */
-	snp_inc_msg_seqno(mdesc);
-
-	if (override_err) {
-		rio->exitinfo2 = override_err;
-
-		/*
-		 * If an extended guest request was issued and the supplied certificate
-		 * buffer was not large enough, a standard guest request was issued to
-		 * prevent IV reuse. If the standard request was successful, return -EIO
-		 * back to the caller as would have originally been returned.
-		 */
-		if (!rc && override_err == SNP_GUEST_VMM_ERR(SNP_GUEST_VMM_ERR_INVALID_LEN))
-			rc = -EIO;
-	}
-
-	if (override_npages)
-		mdesc->input.data_npages = override_npages;
-
-	return rc;
-}
-
-static int snp_send_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_req *req,
-				  struct snp_guest_request_ioctl *rio)
-{
-	u64 seqno;
-	int rc;
-
-	guard(mutex)(&snp_cmd_mutex);
-
-	/* Check if the VMPCK is not empty */
-	if (!mdesc->vmpck || !memchr_inv(mdesc->vmpck, 0, VMPCK_KEY_LEN)) {
-		pr_err_ratelimited("VMPCK is disabled\n");
-		return -ENOTTY;
-	}
-
-	/* Get message sequence and verify that its a non-zero */
-	seqno = snp_get_msg_seqno(mdesc);
-	if (!seqno)
-		return -EIO;
-
-	/* Clear shared memory's response for the host to populate. */
-	memset(mdesc->response, 0, sizeof(struct snp_guest_msg));
-
-	/* Encrypt the userspace provided payload in mdesc->secret_request. */
-	rc = enc_payload(mdesc, seqno, req);
-	if (rc)
-		return rc;
-
-	/*
-	 * Write the fully encrypted request to the shared unencrypted
-	 * request page.
-	 */
-	memcpy(mdesc->request, &mdesc->secret_request,
-	       sizeof(mdesc->secret_request));
-
-	rc = __handle_guest_request(mdesc, req, rio);
-	if (rc) {
-		if (rc == -EIO &&
-		    rio->exitinfo2 == SNP_GUEST_VMM_ERR(SNP_GUEST_VMM_ERR_INVALID_LEN))
-			return rc;
-
-		pr_alert("Detected error from ASP request. rc: %d, exitinfo2: 0x%llx\n",
-			 rc, rio->exitinfo2);
-
-		snp_disable_vmpck(mdesc);
-		return rc;
-	}
-
-	rc = verify_and_dec_payload(mdesc, req);
-	if (rc) {
-		pr_alert("Detected unexpected decode failure from ASP. rc: %d\n", rc);
-		snp_disable_vmpck(mdesc);
-		return rc;
-	}
-
-	return 0;
-}
-
 struct snp_req_resp {
 	sockptr_t req_data;
 	sockptr_t resp_data;

