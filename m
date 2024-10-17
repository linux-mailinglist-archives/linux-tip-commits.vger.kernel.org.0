Return-Path: <linux-tip-commits+bounces-2500-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1919A2192
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Oct 2024 13:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25FF6281E20
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Oct 2024 11:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E371DD525;
	Thu, 17 Oct 2024 11:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b7vcyYwG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ia47uyzw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3E41DB534;
	Thu, 17 Oct 2024 11:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729166194; cv=none; b=SOCCZzIJjbpES1KCAgM3i+1YNVezqG89EwOG/I49NuWA0ISXpF04u9ZBVoQPNoKfLbvz6x8Es4pMY4t/7kH6paMfvEaAGLQ3uY/4yDB/mV8bEvQeGulKhlckyJkGM68+LVp1AASMFU4ag3S8vdqyYJ92pe6ilnx/muvLLP1cLXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729166194; c=relaxed/simple;
	bh=nas7BScfj5ZHBbAL4SFmYHoxvhBWreXBlibIWYlTejY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MV4J7twzpHWMN+XWqtftAHxRvt7641TdocjLD2Ot8Reg7/9UmRwnb60Y36havAEUpJIN0chgMqEzmAhzToRDFiyELKJebmBh8nrVqwc4UDQzrjTuEL9Xe8C9k5a9cKHrvqoHTqaOmEVO8eBx56WYAFDBzT1eHvqE9YbsutHGII4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b7vcyYwG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ia47uyzw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 17 Oct 2024 11:56:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729166187;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=86gHrE5OOfxReUlZttInfVoMGnq6/yrPTD1iA5QtJUs=;
	b=b7vcyYwGyK9mbDul+2Akq789zh0klad7E6wT76ev2b/Rovmqyz2ZpM2GF74+YIXRxq7mhG
	DZiUPksK+0EQAsmdL00fn3zA9AN9BEMlDRX2/jcWTjtDlzA3Uw3x/zi2+P8LLHI86xPiOO
	ZMf+tEV1i6VGFqEJOYxh65nht5n/aAuzyHWDzB+r+GNyi5hVUBzukfoM0GYNUiXhnhs8eL
	wEkTx8I6OsIy0n0mP/Es5VvI5B20in+nuANTV0Fk7N1l5YadhkZbKx9HWrtBlfy9jv4kea
	kglMfXVYUhmO3CAD6OVPn5DMAcT3vUO7aYqq1Vmea/iV7u7tTgV7iT4UiuPAnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729166187;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=86gHrE5OOfxReUlZttInfVoMGnq6/yrPTD1iA5QtJUs=;
	b=Ia47uyzwy84ZZVLfcBpXe+9S0oxi3aaSHeMy09eRkaIt1mlP4Yu1SOEXTdjY+s7goplrbQ
	Nvke5arAS/0l7mCg==
From: "tip-bot2 for Nikunj A Dadhania" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/sev] virt: sev-guest: Carve out SNP message context structure
Cc: Nikunj A Dadhania <nikunj@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241009092850.197575-7-nikunj@amd.com>
References: <20241009092850.197575-7-nikunj@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172916618679.1442.5671372574992974574.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     0a895c0d9b73d934de95aa0dd4e631c394bdd25d
Gitweb:        https://git.kernel.org/tip/0a895c0d9b73d934de95aa0dd4e631c394bdd25d
Author:        Nikunj A Dadhania <nikunj@amd.com>
AuthorDate:    Wed, 09 Oct 2024 14:58:37 +05:30
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 16 Oct 2024 18:41:40 +02:00

virt: sev-guest: Carve out SNP message context structure

Currently, the sev-guest driver is the only user of SNP guest messaging.
The snp_guest_dev structure holds all the allocated buffers, secrets page
and VMPCK details. In preparation for adding messaging allocation and
initialization APIs, decouple snp_guest_dev from messaging-related
information by carving out the guest message context
structure(snp_msg_desc).

Incorporate this newly added context into snp_send_guest_request() and all
related functions, replacing the use of the snp_guest_dev.

No functional change.

Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/r/20241009092850.197575-7-nikunj@amd.com
---
 arch/x86/include/asm/sev.h              |  21 +++-
 drivers/virt/coco/sev-guest/sev-guest.c | 178 +++++++++++------------
 2 files changed, 108 insertions(+), 91 deletions(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 27fa1c9..2e49c4a 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -234,6 +234,27 @@ struct snp_secrets_page {
 	u8 rsvd4[3744];
 } __packed;
 
+struct snp_msg_desc {
+	/* request and response are in unencrypted memory */
+	struct snp_guest_msg *request, *response;
+
+	/*
+	 * Avoid information leakage by double-buffering shared messages
+	 * in fields that are in regular encrypted memory.
+	 */
+	struct snp_guest_msg secret_request, secret_response;
+
+	struct snp_secrets_page *secrets;
+	struct snp_req_data input;
+
+	void *certs_data;
+
+	struct aesgcm_ctx *ctx;
+
+	u32 *os_area_msg_seqno;
+	u8 *vmpck;
+};
+
 /*
  * The SVSM Calling Area (CA) related structures.
  */
diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 1bddef8..fca5c45 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -40,26 +40,13 @@ struct snp_guest_dev {
 	struct device *dev;
 	struct miscdevice misc;
 
-	void *certs_data;
-	struct aesgcm_ctx *ctx;
-	/* request and response are in unencrypted memory */
-	struct snp_guest_msg *request, *response;
-
-	/*
-	 * Avoid information leakage by double-buffering shared messages
-	 * in fields that are in regular encrypted memory.
-	 */
-	struct snp_guest_msg secret_request, secret_response;
+	struct snp_msg_desc *msg_desc;
 
-	struct snp_secrets_page *secrets;
-	struct snp_req_data input;
 	union {
 		struct snp_report_req report;
 		struct snp_derived_key_req derived_key;
 		struct snp_ext_report_req ext_report;
 	} req;
-	u32 *os_area_msg_seqno;
-	u8 *vmpck;
 };
 
 /*
@@ -76,12 +63,12 @@ MODULE_PARM_DESC(vmpck_id, "The VMPCK ID to use when communicating with the PSP.
 /* Mutex to serialize the shared buffer access and command handling. */
 static DEFINE_MUTEX(snp_cmd_mutex);
 
-static bool is_vmpck_empty(struct snp_guest_dev *snp_dev)
+static bool is_vmpck_empty(struct snp_msg_desc *mdesc)
 {
 	char zero_key[VMPCK_KEY_LEN] = {0};
 
-	if (snp_dev->vmpck)
-		return !memcmp(snp_dev->vmpck, zero_key, VMPCK_KEY_LEN);
+	if (mdesc->vmpck)
+		return !memcmp(mdesc->vmpck, zero_key, VMPCK_KEY_LEN);
 
 	return true;
 }
@@ -103,30 +90,30 @@ static bool is_vmpck_empty(struct snp_guest_dev *snp_dev)
  * vulnerable. If the sequence number were incremented for a fresh IV the ASP
  * will reject the request.
  */
-static void snp_disable_vmpck(struct snp_guest_dev *snp_dev)
+static void snp_disable_vmpck(struct snp_msg_desc *mdesc)
 {
-	dev_alert(snp_dev->dev, "Disabling VMPCK%d communication key to prevent IV reuse.\n",
+	pr_alert("Disabling VMPCK%d communication key to prevent IV reuse.\n",
 		  vmpck_id);
-	memzero_explicit(snp_dev->vmpck, VMPCK_KEY_LEN);
-	snp_dev->vmpck = NULL;
+	memzero_explicit(mdesc->vmpck, VMPCK_KEY_LEN);
+	mdesc->vmpck = NULL;
 }
 
-static inline u64 __snp_get_msg_seqno(struct snp_guest_dev *snp_dev)
+static inline u64 __snp_get_msg_seqno(struct snp_msg_desc *mdesc)
 {
 	u64 count;
 
 	lockdep_assert_held(&snp_cmd_mutex);
 
 	/* Read the current message sequence counter from secrets pages */
-	count = *snp_dev->os_area_msg_seqno;
+	count = *mdesc->os_area_msg_seqno;
 
 	return count + 1;
 }
 
 /* Return a non-zero on success */
-static u64 snp_get_msg_seqno(struct snp_guest_dev *snp_dev)
+static u64 snp_get_msg_seqno(struct snp_msg_desc *mdesc)
 {
-	u64 count = __snp_get_msg_seqno(snp_dev);
+	u64 count = __snp_get_msg_seqno(mdesc);
 
 	/*
 	 * The message sequence counter for the SNP guest request is a  64-bit
@@ -137,20 +124,20 @@ static u64 snp_get_msg_seqno(struct snp_guest_dev *snp_dev)
 	 * invalid number and will fail the  message request.
 	 */
 	if (count >= UINT_MAX) {
-		dev_err(snp_dev->dev, "request message sequence counter overflow\n");
+		pr_err("request message sequence counter overflow\n");
 		return 0;
 	}
 
 	return count;
 }
 
-static void snp_inc_msg_seqno(struct snp_guest_dev *snp_dev)
+static void snp_inc_msg_seqno(struct snp_msg_desc *mdesc)
 {
 	/*
 	 * The counter is also incremented by the PSP, so increment it by 2
 	 * and save in secrets page.
 	 */
-	*snp_dev->os_area_msg_seqno += 2;
+	*mdesc->os_area_msg_seqno += 2;
 }
 
 static inline struct snp_guest_dev *to_snp_dev(struct file *file)
@@ -177,13 +164,13 @@ static struct aesgcm_ctx *snp_init_crypto(u8 *key, size_t keylen)
 	return ctx;
 }
 
-static int verify_and_dec_payload(struct snp_guest_dev *snp_dev, struct snp_guest_req *req)
+static int verify_and_dec_payload(struct snp_msg_desc *mdesc, struct snp_guest_req *req)
 {
-	struct snp_guest_msg *resp_msg = &snp_dev->secret_response;
-	struct snp_guest_msg *req_msg = &snp_dev->secret_request;
+	struct snp_guest_msg *resp_msg = &mdesc->secret_response;
+	struct snp_guest_msg *req_msg = &mdesc->secret_request;
 	struct snp_guest_msg_hdr *req_msg_hdr = &req_msg->hdr;
 	struct snp_guest_msg_hdr *resp_msg_hdr = &resp_msg->hdr;
-	struct aesgcm_ctx *ctx = snp_dev->ctx;
+	struct aesgcm_ctx *ctx = mdesc->ctx;
 	u8 iv[GCM_AES_IV_SIZE] = {};
 
 	pr_debug("response [seqno %lld type %d version %d sz %d]\n",
@@ -191,7 +178,7 @@ static int verify_and_dec_payload(struct snp_guest_dev *snp_dev, struct snp_gues
 		 resp_msg_hdr->msg_sz);
 
 	/* Copy response from shared memory to encrypted memory. */
-	memcpy(resp_msg, snp_dev->response, sizeof(*resp_msg));
+	memcpy(resp_msg, mdesc->response, sizeof(*resp_msg));
 
 	/* Verify that the sequence counter is incremented by 1 */
 	if (unlikely(resp_msg_hdr->msg_seqno != (req_msg_hdr->msg_seqno + 1)))
@@ -218,11 +205,11 @@ static int verify_and_dec_payload(struct snp_guest_dev *snp_dev, struct snp_gues
 	return 0;
 }
 
-static int enc_payload(struct snp_guest_dev *snp_dev, u64 seqno, struct snp_guest_req *req)
+static int enc_payload(struct snp_msg_desc *mdesc, u64 seqno, struct snp_guest_req *req)
 {
-	struct snp_guest_msg *msg = &snp_dev->secret_request;
+	struct snp_guest_msg *msg = &mdesc->secret_request;
 	struct snp_guest_msg_hdr *hdr = &msg->hdr;
-	struct aesgcm_ctx *ctx = snp_dev->ctx;
+	struct aesgcm_ctx *ctx = mdesc->ctx;
 	u8 iv[GCM_AES_IV_SIZE] = {};
 
 	memset(msg, 0, sizeof(*msg));
@@ -253,7 +240,7 @@ static int enc_payload(struct snp_guest_dev *snp_dev, u64 seqno, struct snp_gues
 	return 0;
 }
 
-static int __handle_guest_request(struct snp_guest_dev *snp_dev, struct snp_guest_req *req,
+static int __handle_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_req *req,
 				  struct snp_guest_request_ioctl *rio)
 {
 	unsigned long req_start = jiffies;
@@ -268,7 +255,7 @@ retry_request:
 	 * sequence number must be incremented or the VMPCK must be deleted to
 	 * prevent reuse of the IV.
 	 */
-	rc = snp_issue_guest_request(req, &snp_dev->input, rio);
+	rc = snp_issue_guest_request(req, &mdesc->input, rio);
 	switch (rc) {
 	case -ENOSPC:
 		/*
@@ -278,7 +265,7 @@ retry_request:
 		 * order to increment the sequence number and thus avoid
 		 * IV reuse.
 		 */
-		override_npages = snp_dev->input.data_npages;
+		override_npages = mdesc->input.data_npages;
 		req->exit_code	= SVM_VMGEXIT_GUEST_REQUEST;
 
 		/*
@@ -318,7 +305,7 @@ retry_request:
 	 * structure and any failure will wipe the VMPCK, preventing further
 	 * use anyway.
 	 */
-	snp_inc_msg_seqno(snp_dev);
+	snp_inc_msg_seqno(mdesc);
 
 	if (override_err) {
 		rio->exitinfo2 = override_err;
@@ -334,12 +321,12 @@ retry_request:
 	}
 
 	if (override_npages)
-		snp_dev->input.data_npages = override_npages;
+		mdesc->input.data_npages = override_npages;
 
 	return rc;
 }
 
-static int snp_send_guest_request(struct snp_guest_dev *snp_dev, struct snp_guest_req *req,
+static int snp_send_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_req *req,
 				  struct snp_guest_request_ioctl *rio)
 {
 	u64 seqno;
@@ -348,21 +335,21 @@ static int snp_send_guest_request(struct snp_guest_dev *snp_dev, struct snp_gues
 	guard(mutex)(&snp_cmd_mutex);
 
 	/* Check if the VMPCK is not empty */
-	if (is_vmpck_empty(snp_dev)) {
-		dev_err_ratelimited(snp_dev->dev, "VMPCK is disabled\n");
+	if (is_vmpck_empty(mdesc)) {
+		pr_err_ratelimited("VMPCK is disabled\n");
 		return -ENOTTY;
 	}
 
 	/* Get message sequence and verify that its a non-zero */
-	seqno = snp_get_msg_seqno(snp_dev);
+	seqno = snp_get_msg_seqno(mdesc);
 	if (!seqno)
 		return -EIO;
 
 	/* Clear shared memory's response for the host to populate. */
-	memset(snp_dev->response, 0, sizeof(struct snp_guest_msg));
+	memset(mdesc->response, 0, sizeof(struct snp_guest_msg));
 
-	/* Encrypt the userspace provided payload in snp_dev->secret_request. */
-	rc = enc_payload(snp_dev, seqno, req);
+	/* Encrypt the userspace provided payload in mdesc->secret_request. */
+	rc = enc_payload(mdesc, seqno, req);
 	if (rc)
 		return rc;
 
@@ -370,27 +357,26 @@ static int snp_send_guest_request(struct snp_guest_dev *snp_dev, struct snp_gues
 	 * Write the fully encrypted request to the shared unencrypted
 	 * request page.
 	 */
-	memcpy(snp_dev->request, &snp_dev->secret_request,
-	       sizeof(snp_dev->secret_request));
+	memcpy(mdesc->request, &mdesc->secret_request,
+	       sizeof(mdesc->secret_request));
 
-	rc = __handle_guest_request(snp_dev, req, rio);
+	rc = __handle_guest_request(mdesc, req, rio);
 	if (rc) {
 		if (rc == -EIO &&
 		    rio->exitinfo2 == SNP_GUEST_VMM_ERR(SNP_GUEST_VMM_ERR_INVALID_LEN))
 			return rc;
 
-		dev_alert(snp_dev->dev,
-			  "Detected error from ASP request. rc: %d, exitinfo2: 0x%llx\n",
-			  rc, rio->exitinfo2);
+		pr_alert("Detected error from ASP request. rc: %d, exitinfo2: 0x%llx\n",
+			 rc, rio->exitinfo2);
 
-		snp_disable_vmpck(snp_dev);
+		snp_disable_vmpck(mdesc);
 		return rc;
 	}
 
-	rc = verify_and_dec_payload(snp_dev, req);
+	rc = verify_and_dec_payload(mdesc, req);
 	if (rc) {
-		dev_alert(snp_dev->dev, "Detected unexpected decode failure from ASP. rc: %d\n", rc);
-		snp_disable_vmpck(snp_dev);
+		pr_alert("Detected unexpected decode failure from ASP. rc: %d\n", rc);
+		snp_disable_vmpck(mdesc);
 		return rc;
 	}
 
@@ -405,6 +391,7 @@ struct snp_req_resp {
 static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
 {
 	struct snp_report_req *report_req = &snp_dev->req.report;
+	struct snp_msg_desc *mdesc = snp_dev->msg_desc;
 	struct snp_report_resp *report_resp;
 	struct snp_guest_req req = {};
 	int rc, resp_len;
@@ -420,7 +407,7 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
 	 * response payload. Make sure that it has enough space to cover the
 	 * authtag.
 	 */
-	resp_len = sizeof(report_resp->data) + snp_dev->ctx->authsize;
+	resp_len = sizeof(report_resp->data) + mdesc->ctx->authsize;
 	report_resp = kzalloc(resp_len, GFP_KERNEL_ACCOUNT);
 	if (!report_resp)
 		return -ENOMEM;
@@ -434,7 +421,7 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
 	req.resp_sz = resp_len;
 	req.exit_code = SVM_VMGEXIT_GUEST_REQUEST;
 
-	rc = snp_send_guest_request(snp_dev, &req, arg);
+	rc = snp_send_guest_request(mdesc, &req, arg);
 	if (rc)
 		goto e_free;
 
@@ -450,6 +437,7 @@ static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_reque
 {
 	struct snp_derived_key_req *derived_key_req = &snp_dev->req.derived_key;
 	struct snp_derived_key_resp derived_key_resp = {0};
+	struct snp_msg_desc *mdesc = snp_dev->msg_desc;
 	struct snp_guest_req req = {};
 	int rc, resp_len;
 	/* Response data is 64 bytes and max authsize for GCM is 16 bytes. */
@@ -463,7 +451,7 @@ static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_reque
 	 * response payload. Make sure that it has enough space to cover the
 	 * authtag.
 	 */
-	resp_len = sizeof(derived_key_resp.data) + snp_dev->ctx->authsize;
+	resp_len = sizeof(derived_key_resp.data) + mdesc->ctx->authsize;
 	if (sizeof(buf) < resp_len)
 		return -ENOMEM;
 
@@ -480,7 +468,7 @@ static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_reque
 	req.resp_sz = resp_len;
 	req.exit_code = SVM_VMGEXIT_GUEST_REQUEST;
 
-	rc = snp_send_guest_request(snp_dev, &req, arg);
+	rc = snp_send_guest_request(mdesc, &req, arg);
 	if (rc)
 		return rc;
 
@@ -500,6 +488,7 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
 
 {
 	struct snp_ext_report_req *report_req = &snp_dev->req.ext_report;
+	struct snp_msg_desc *mdesc = snp_dev->msg_desc;
 	struct snp_report_resp *report_resp;
 	struct snp_guest_req req = {};
 	int ret, npages = 0, resp_len;
@@ -533,7 +522,7 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
 	 * the host. If host does not supply any certs in it, then copy
 	 * zeros to indicate that certificate data was not provided.
 	 */
-	memset(snp_dev->certs_data, 0, report_req->certs_len);
+	memset(mdesc->certs_data, 0, report_req->certs_len);
 	npages = report_req->certs_len >> PAGE_SHIFT;
 cmd:
 	/*
@@ -541,12 +530,12 @@ cmd:
 	 * response payload. Make sure that it has enough space to cover the
 	 * authtag.
 	 */
-	resp_len = sizeof(report_resp->data) + snp_dev->ctx->authsize;
+	resp_len = sizeof(report_resp->data) + mdesc->ctx->authsize;
 	report_resp = kzalloc(resp_len, GFP_KERNEL_ACCOUNT);
 	if (!report_resp)
 		return -ENOMEM;
 
-	snp_dev->input.data_npages = npages;
+	mdesc->input.data_npages = npages;
 
 	req.msg_version = arg->msg_version;
 	req.msg_type = SNP_MSG_REPORT_REQ;
@@ -557,11 +546,11 @@ cmd:
 	req.resp_sz = resp_len;
 	req.exit_code = SVM_VMGEXIT_EXT_GUEST_REQUEST;
 
-	ret = snp_send_guest_request(snp_dev, &req, arg);
+	ret = snp_send_guest_request(mdesc, &req, arg);
 
 	/* If certs length is invalid then copy the returned length */
 	if (arg->vmm_error == SNP_GUEST_VMM_ERR_INVALID_LEN) {
-		report_req->certs_len = snp_dev->input.data_npages << PAGE_SHIFT;
+		report_req->certs_len = mdesc->input.data_npages << PAGE_SHIFT;
 
 		if (copy_to_sockptr(io->req_data, report_req, sizeof(*report_req)))
 			ret = -EFAULT;
@@ -570,7 +559,7 @@ cmd:
 	if (ret)
 		goto e_free;
 
-	if (npages && copy_to_sockptr(certs_address, snp_dev->certs_data, report_req->certs_len)) {
+	if (npages && copy_to_sockptr(certs_address, mdesc->certs_data, report_req->certs_len)) {
 		ret = -EFAULT;
 		goto e_free;
 	}
@@ -994,6 +983,7 @@ static int __init sev_guest_probe(struct platform_device *pdev)
 	struct snp_secrets_page *secrets;
 	struct device *dev = &pdev->dev;
 	struct snp_guest_dev *snp_dev;
+	struct snp_msg_desc *mdesc;
 	struct miscdevice *misc;
 	void __iomem *mapping;
 	int ret;
@@ -1018,43 +1008,47 @@ static int __init sev_guest_probe(struct platform_device *pdev)
 	if (!snp_dev)
 		goto e_unmap;
 
+	mdesc = devm_kzalloc(&pdev->dev, sizeof(struct snp_msg_desc), GFP_KERNEL);
+	if (!mdesc)
+		goto e_unmap;
+
 	/* Adjust the default VMPCK key based on the executing VMPL level */
 	if (vmpck_id == -1)
 		vmpck_id = snp_vmpl;
 
 	ret = -EINVAL;
-	snp_dev->vmpck = get_vmpck(vmpck_id, secrets, &snp_dev->os_area_msg_seqno);
-	if (!snp_dev->vmpck) {
+	mdesc->vmpck = get_vmpck(vmpck_id, secrets, &mdesc->os_area_msg_seqno);
+	if (!mdesc->vmpck) {
 		dev_err(dev, "Invalid VMPCK%d communication key\n", vmpck_id);
 		goto e_unmap;
 	}
 
 	/* Verify that VMPCK is not zero. */
-	if (is_vmpck_empty(snp_dev)) {
+	if (is_vmpck_empty(mdesc)) {
 		dev_err(dev, "Empty VMPCK%d communication key\n", vmpck_id);
 		goto e_unmap;
 	}
 
 	platform_set_drvdata(pdev, snp_dev);
 	snp_dev->dev = dev;
-	snp_dev->secrets = secrets;
+	mdesc->secrets = secrets;
 
 	/* Allocate the shared page used for the request and response message. */
-	snp_dev->request = alloc_shared_pages(dev, sizeof(struct snp_guest_msg));
-	if (!snp_dev->request)
+	mdesc->request = alloc_shared_pages(dev, sizeof(struct snp_guest_msg));
+	if (!mdesc->request)
 		goto e_unmap;
 
-	snp_dev->response = alloc_shared_pages(dev, sizeof(struct snp_guest_msg));
-	if (!snp_dev->response)
+	mdesc->response = alloc_shared_pages(dev, sizeof(struct snp_guest_msg));
+	if (!mdesc->response)
 		goto e_free_request;
 
-	snp_dev->certs_data = alloc_shared_pages(dev, SEV_FW_BLOB_MAX_SIZE);
-	if (!snp_dev->certs_data)
+	mdesc->certs_data = alloc_shared_pages(dev, SEV_FW_BLOB_MAX_SIZE);
+	if (!mdesc->certs_data)
 		goto e_free_response;
 
 	ret = -EIO;
-	snp_dev->ctx = snp_init_crypto(snp_dev->vmpck, VMPCK_KEY_LEN);
-	if (!snp_dev->ctx)
+	mdesc->ctx = snp_init_crypto(mdesc->vmpck, VMPCK_KEY_LEN);
+	if (!mdesc->ctx)
 		goto e_free_cert_data;
 
 	misc = &snp_dev->misc;
@@ -1063,9 +1057,9 @@ static int __init sev_guest_probe(struct platform_device *pdev)
 	misc->fops = &snp_guest_fops;
 
 	/* Initialize the input addresses for guest request */
-	snp_dev->input.req_gpa = __pa(snp_dev->request);
-	snp_dev->input.resp_gpa = __pa(snp_dev->response);
-	snp_dev->input.data_gpa = __pa(snp_dev->certs_data);
+	mdesc->input.req_gpa = __pa(mdesc->request);
+	mdesc->input.resp_gpa = __pa(mdesc->response);
+	mdesc->input.data_gpa = __pa(mdesc->certs_data);
 
 	/* Set the privlevel_floor attribute based on the vmpck_id */
 	sev_tsm_ops.privlevel_floor = vmpck_id;
@@ -1082,17 +1076,18 @@ static int __init sev_guest_probe(struct platform_device *pdev)
 	if (ret)
 		goto e_free_ctx;
 
+	snp_dev->msg_desc = mdesc;
 	dev_info(dev, "Initialized SEV guest driver (using VMPCK%d communication key)\n", vmpck_id);
 	return 0;
 
 e_free_ctx:
-	kfree(snp_dev->ctx);
+	kfree(mdesc->ctx);
 e_free_cert_data:
-	free_shared_pages(snp_dev->certs_data, SEV_FW_BLOB_MAX_SIZE);
+	free_shared_pages(mdesc->certs_data, SEV_FW_BLOB_MAX_SIZE);
 e_free_response:
-	free_shared_pages(snp_dev->response, sizeof(struct snp_guest_msg));
+	free_shared_pages(mdesc->response, sizeof(struct snp_guest_msg));
 e_free_request:
-	free_shared_pages(snp_dev->request, sizeof(struct snp_guest_msg));
+	free_shared_pages(mdesc->request, sizeof(struct snp_guest_msg));
 e_unmap:
 	iounmap(mapping);
 	return ret;
@@ -1101,11 +1096,12 @@ e_unmap:
 static void __exit sev_guest_remove(struct platform_device *pdev)
 {
 	struct snp_guest_dev *snp_dev = platform_get_drvdata(pdev);
+	struct snp_msg_desc *mdesc = snp_dev->msg_desc;
 
-	free_shared_pages(snp_dev->certs_data, SEV_FW_BLOB_MAX_SIZE);
-	free_shared_pages(snp_dev->response, sizeof(struct snp_guest_msg));
-	free_shared_pages(snp_dev->request, sizeof(struct snp_guest_msg));
-	kfree(snp_dev->ctx);
+	free_shared_pages(mdesc->certs_data, SEV_FW_BLOB_MAX_SIZE);
+	free_shared_pages(mdesc->response, sizeof(struct snp_guest_msg));
+	free_shared_pages(mdesc->request, sizeof(struct snp_guest_msg));
+	kfree(mdesc->ctx);
 	misc_deregister(&snp_dev->misc);
 }
 

