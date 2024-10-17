Return-Path: <linux-tip-commits+bounces-2501-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 361E79A2196
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Oct 2024 13:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59C3F1C21256
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Oct 2024 11:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2198D1DDC01;
	Thu, 17 Oct 2024 11:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y/N6rryF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Xt5pbIw3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9CB1DD539;
	Thu, 17 Oct 2024 11:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729166198; cv=none; b=B2vFZNy6H3ryUmXfwUr7Q0gu+wq30+039P9MKkY/KwT0PA3DCAOdqLl9z+YpKLQjamdPHGMpDUrc2uf1vmwAz6iDTChEL+iKDTSmumWEXxGcczs/6rJxa2y3axZ2R+qAcnxu4RA2rRea3S/tUORT6e8dA4JHpzn2qN2HL1DG8Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729166198; c=relaxed/simple;
	bh=1K9o3Qdl20Zocd/YodMResPLob95OvPV7PkpUZQeVjc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ePONp6h88fatWBCfyW13grf6lf/hwTmslUn57Q1pEiyFHKlsAHZu/K5Oyuolzok4KtbxWLqO4KOPoLIOaOm5kHJlp73uwfyB8lNvxI2aVKiyCJCv0uT967LQy3CVTEfaE3iG4+XFOyIwt/2UMEnfq+MwqlYRlmTWSlsZm+p7zLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y/N6rryF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Xt5pbIw3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 17 Oct 2024 11:56:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729166190;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FWtHcsOxLfV6qOpWBe8yZdzrpLXm96SrD3Q0iTK9UI8=;
	b=Y/N6rryFuVDRBdNi65BPKYEBqUb4r4eRbdmIY+wavH4uz8qk3RG+sdlWAIiTETBCYCGVyH
	tEMM4GYsI8jdjhpTyAsyLjPRz5T3hNUZhE8jJmwWI+4xx8/QvXhkn8vO+QEXPzL+Ez3lFP
	TqEyXriBpKvTqkYgtJVB7SAzUFZHUMdcOSd3Baz1XH9p5vyhhHzZ0TmR2FYP4jM26tV9jo
	DJ0B1MTJi9bMZ9d+yKz+kqqsQ1HwPiuZw1a8zlKTK5cwjDocGitGVIpHLGlMse2NmWfgns
	iTd33LhVCaMxTjPUSl4RWlaw4h+cA0/o29aD2uc+BPtFxU+HNjcybLVUDZWPBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729166190;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FWtHcsOxLfV6qOpWBe8yZdzrpLXm96SrD3Q0iTK9UI8=;
	b=Xt5pbIw36BcIsvXNSFzd40by4WHeLJkpkdqbQm6KdmGWcg71CGRepIc0Gw/MBZtLUUbHMx
	RKQeo48zxuN5BbBw==
From: "tip-bot2 for Nikunj A Dadhania" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] virt: sev-guest: Use AES GCM crypto library
Cc: Nikunj A Dadhania <nikunj@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Tom Lendacky <thomas.lendacky@amd.com>, Peter Gonda <pgonda@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241009092850.197575-2-nikunj@amd.com>
References: <20241009092850.197575-2-nikunj@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172916619008.1442.12963262033418483715.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     f3476bc77057db0adf90c0a141a3599dd11c56a0
Gitweb:        https://git.kernel.org/tip/f3476bc77057db0adf90c0a141a3599dd11c56a0
Author:        Nikunj A Dadhania <nikunj@amd.com>
AuthorDate:    Wed, 09 Oct 2024 14:58:32 +05:30
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 16 Oct 2024 18:08:17 +02:00

virt: sev-guest: Use AES GCM crypto library

The sev-guest driver encryption code uses the crypto API for SNP guest
messaging with the AMD Security processor. In order to enable secure TSC,
SEV-SNP guests need to send such a TSC_INFO message before the APs are
booted. Details from the TSC_INFO response will then be used to program the
VMSA before the APs are brought up.

However, the crypto API is not available this early in the boot process.

In preparation for moving the encryption code out of sev-guest to support
secure TSC and to ease review, switch to using the AES GCM library
implementation instead.

Drop __enc_payload() and dec_payload() helpers as both are small and can be
moved to the respective callers.

Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Peter Gonda <pgonda@google.com>
Link: https://lore.kernel.org/r/20241009092850.197575-2-nikunj@amd.com
---
 arch/x86/include/asm/sev.h              |   3 +-
 drivers/virt/coco/sev-guest/Kconfig     |   4 +-
 drivers/virt/coco/sev-guest/sev-guest.c | 175 +++++------------------
 3 files changed, 43 insertions(+), 139 deletions(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index ee34ab0..e7977f7 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -120,6 +120,9 @@ struct snp_req_data {
 };
 
 #define MAX_AUTHTAG_LEN		32
+#define AUTHTAG_LEN		16
+#define AAD_LEN			48
+#define MSG_HDR_VER		1
 
 /* See SNP spec SNP_GUEST_REQUEST section for the structure */
 enum msg_type {
diff --git a/drivers/virt/coco/sev-guest/Kconfig b/drivers/virt/coco/sev-guest/Kconfig
index 1cffc72..0b772bd 100644
--- a/drivers/virt/coco/sev-guest/Kconfig
+++ b/drivers/virt/coco/sev-guest/Kconfig
@@ -2,9 +2,7 @@ config SEV_GUEST
 	tristate "AMD SEV Guest driver"
 	default m
 	depends on AMD_MEM_ENCRYPT
-	select CRYPTO
-	select CRYPTO_AEAD2
-	select CRYPTO_GCM
+	select CRYPTO_LIB_AESGCM
 	select TSM_REPORTS
 	help
 	  SEV-SNP firmware provides the guest a mechanism to communicate with
diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 89754b0..a33daff 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -17,8 +17,7 @@
 #include <linux/set_memory.h>
 #include <linux/fs.h>
 #include <linux/tsm.h>
-#include <crypto/aead.h>
-#include <linux/scatterlist.h>
+#include <crypto/gcm.h>
 #include <linux/psp-sev.h>
 #include <linux/sockptr.h>
 #include <linux/cleanup.h>
@@ -31,26 +30,18 @@
 #include <asm/sev.h>
 
 #define DEVICE_NAME	"sev-guest"
-#define AAD_LEN		48
-#define MSG_HDR_VER	1
 
 #define SNP_REQ_MAX_RETRY_DURATION	(60*HZ)
 #define SNP_REQ_RETRY_DELAY		(2*HZ)
 
 #define SVSM_MAX_RETRIES		3
 
-struct snp_guest_crypto {
-	struct crypto_aead *tfm;
-	u8 *iv, *authtag;
-	int iv_len, a_len;
-};
-
 struct snp_guest_dev {
 	struct device *dev;
 	struct miscdevice misc;
 
 	void *certs_data;
-	struct snp_guest_crypto *crypto;
+	struct aesgcm_ctx *ctx;
 	/* request and response are in unencrypted memory */
 	struct snp_guest_msg *request, *response;
 
@@ -169,132 +160,31 @@ static inline struct snp_guest_dev *to_snp_dev(struct file *file)
 	return container_of(dev, struct snp_guest_dev, misc);
 }
 
-static struct snp_guest_crypto *init_crypto(struct snp_guest_dev *snp_dev, u8 *key, size_t keylen)
+static struct aesgcm_ctx *snp_init_crypto(u8 *key, size_t keylen)
 {
-	struct snp_guest_crypto *crypto;
+	struct aesgcm_ctx *ctx;
 
-	crypto = kzalloc(sizeof(*crypto), GFP_KERNEL_ACCOUNT);
-	if (!crypto)
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL_ACCOUNT);
+	if (!ctx)
 		return NULL;
 
-	crypto->tfm = crypto_alloc_aead("gcm(aes)", 0, 0);
-	if (IS_ERR(crypto->tfm))
-		goto e_free;
-
-	if (crypto_aead_setkey(crypto->tfm, key, keylen))
-		goto e_free_crypto;
-
-	crypto->iv_len = crypto_aead_ivsize(crypto->tfm);
-	crypto->iv = kmalloc(crypto->iv_len, GFP_KERNEL_ACCOUNT);
-	if (!crypto->iv)
-		goto e_free_crypto;
-
-	if (crypto_aead_authsize(crypto->tfm) > MAX_AUTHTAG_LEN) {
-		if (crypto_aead_setauthsize(crypto->tfm, MAX_AUTHTAG_LEN)) {
-			dev_err(snp_dev->dev, "failed to set authsize to %d\n", MAX_AUTHTAG_LEN);
-			goto e_free_iv;
-		}
+	if (aesgcm_expandkey(ctx, key, keylen, AUTHTAG_LEN)) {
+		pr_err("Crypto context initialization failed\n");
+		kfree(ctx);
+		return NULL;
 	}
 
-	crypto->a_len = crypto_aead_authsize(crypto->tfm);
-	crypto->authtag = kmalloc(crypto->a_len, GFP_KERNEL_ACCOUNT);
-	if (!crypto->authtag)
-		goto e_free_iv;
-
-	return crypto;
-
-e_free_iv:
-	kfree(crypto->iv);
-e_free_crypto:
-	crypto_free_aead(crypto->tfm);
-e_free:
-	kfree(crypto);
-
-	return NULL;
-}
-
-static void deinit_crypto(struct snp_guest_crypto *crypto)
-{
-	crypto_free_aead(crypto->tfm);
-	kfree(crypto->iv);
-	kfree(crypto->authtag);
-	kfree(crypto);
-}
-
-static int enc_dec_message(struct snp_guest_crypto *crypto, struct snp_guest_msg *msg,
-			   u8 *src_buf, u8 *dst_buf, size_t len, bool enc)
-{
-	struct snp_guest_msg_hdr *hdr = &msg->hdr;
-	struct scatterlist src[3], dst[3];
-	DECLARE_CRYPTO_WAIT(wait);
-	struct aead_request *req;
-	int ret;
-
-	req = aead_request_alloc(crypto->tfm, GFP_KERNEL);
-	if (!req)
-		return -ENOMEM;
-
-	/*
-	 * AEAD memory operations:
-	 * +------ AAD -------+------- DATA -----+---- AUTHTAG----+
-	 * |  msg header      |  plaintext       |  hdr->authtag  |
-	 * | bytes 30h - 5Fh  |    or            |                |
-	 * |                  |   cipher         |                |
-	 * +------------------+------------------+----------------+
-	 */
-	sg_init_table(src, 3);
-	sg_set_buf(&src[0], &hdr->algo, AAD_LEN);
-	sg_set_buf(&src[1], src_buf, hdr->msg_sz);
-	sg_set_buf(&src[2], hdr->authtag, crypto->a_len);
-
-	sg_init_table(dst, 3);
-	sg_set_buf(&dst[0], &hdr->algo, AAD_LEN);
-	sg_set_buf(&dst[1], dst_buf, hdr->msg_sz);
-	sg_set_buf(&dst[2], hdr->authtag, crypto->a_len);
-
-	aead_request_set_ad(req, AAD_LEN);
-	aead_request_set_tfm(req, crypto->tfm);
-	aead_request_set_callback(req, 0, crypto_req_done, &wait);
-
-	aead_request_set_crypt(req, src, dst, len, crypto->iv);
-	ret = crypto_wait_req(enc ? crypto_aead_encrypt(req) : crypto_aead_decrypt(req), &wait);
-
-	aead_request_free(req);
-	return ret;
-}
-
-static int __enc_payload(struct snp_guest_dev *snp_dev, struct snp_guest_msg *msg,
-			 void *plaintext, size_t len)
-{
-	struct snp_guest_crypto *crypto = snp_dev->crypto;
-	struct snp_guest_msg_hdr *hdr = &msg->hdr;
-
-	memset(crypto->iv, 0, crypto->iv_len);
-	memcpy(crypto->iv, &hdr->msg_seqno, sizeof(hdr->msg_seqno));
-
-	return enc_dec_message(crypto, msg, plaintext, msg->payload, len, true);
-}
-
-static int dec_payload(struct snp_guest_dev *snp_dev, struct snp_guest_msg *msg,
-		       void *plaintext, size_t len)
-{
-	struct snp_guest_crypto *crypto = snp_dev->crypto;
-	struct snp_guest_msg_hdr *hdr = &msg->hdr;
-
-	/* Build IV with response buffer sequence number */
-	memset(crypto->iv, 0, crypto->iv_len);
-	memcpy(crypto->iv, &hdr->msg_seqno, sizeof(hdr->msg_seqno));
-
-	return enc_dec_message(crypto, msg, msg->payload, plaintext, len, false);
+	return ctx;
 }
 
 static int verify_and_dec_payload(struct snp_guest_dev *snp_dev, void *payload, u32 sz)
 {
-	struct snp_guest_crypto *crypto = snp_dev->crypto;
 	struct snp_guest_msg *resp_msg = &snp_dev->secret_response;
 	struct snp_guest_msg *req_msg = &snp_dev->secret_request;
 	struct snp_guest_msg_hdr *req_msg_hdr = &req_msg->hdr;
 	struct snp_guest_msg_hdr *resp_msg_hdr = &resp_msg->hdr;
+	struct aesgcm_ctx *ctx = snp_dev->ctx;
+	u8 iv[GCM_AES_IV_SIZE] = {};
 
 	pr_debug("response [seqno %lld type %d version %d sz %d]\n",
 		 resp_msg_hdr->msg_seqno, resp_msg_hdr->msg_type, resp_msg_hdr->msg_version,
@@ -316,11 +206,16 @@ static int verify_and_dec_payload(struct snp_guest_dev *snp_dev, void *payload, 
 	 * If the message size is greater than our buffer length then return
 	 * an error.
 	 */
-	if (unlikely((resp_msg_hdr->msg_sz + crypto->a_len) > sz))
+	if (unlikely((resp_msg_hdr->msg_sz + ctx->authsize) > sz))
 		return -EBADMSG;
 
 	/* Decrypt the payload */
-	return dec_payload(snp_dev, resp_msg, payload, resp_msg_hdr->msg_sz + crypto->a_len);
+	memcpy(iv, &resp_msg_hdr->msg_seqno, min(sizeof(iv), sizeof(resp_msg_hdr->msg_seqno)));
+	if (!aesgcm_decrypt(ctx, payload, resp_msg->payload, resp_msg_hdr->msg_sz,
+			    &resp_msg_hdr->algo, AAD_LEN, iv, resp_msg_hdr->authtag))
+		return -EBADMSG;
+
+	return 0;
 }
 
 static int enc_payload(struct snp_guest_dev *snp_dev, u64 seqno, int version, u8 type,
@@ -328,6 +223,8 @@ static int enc_payload(struct snp_guest_dev *snp_dev, u64 seqno, int version, u8
 {
 	struct snp_guest_msg *msg = &snp_dev->secret_request;
 	struct snp_guest_msg_hdr *hdr = &msg->hdr;
+	struct aesgcm_ctx *ctx = snp_dev->ctx;
+	u8 iv[GCM_AES_IV_SIZE] = {};
 
 	memset(msg, 0, sizeof(*msg));
 
@@ -347,7 +244,14 @@ static int enc_payload(struct snp_guest_dev *snp_dev, u64 seqno, int version, u8
 	pr_debug("request [seqno %lld type %d version %d sz %d]\n",
 		 hdr->msg_seqno, hdr->msg_type, hdr->msg_version, hdr->msg_sz);
 
-	return __enc_payload(snp_dev, msg, payload, sz);
+	if (WARN_ON((sz + ctx->authsize) > sizeof(msg->payload)))
+		return -EBADMSG;
+
+	memcpy(iv, &hdr->msg_seqno, min(sizeof(iv), sizeof(hdr->msg_seqno)));
+	aesgcm_encrypt(ctx, msg->payload, payload, sz, &hdr->algo, AAD_LEN,
+		       iv, hdr->authtag);
+
+	return 0;
 }
 
 static int __handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
@@ -495,7 +399,6 @@ struct snp_req_resp {
 
 static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
 {
-	struct snp_guest_crypto *crypto = snp_dev->crypto;
 	struct snp_report_req *report_req = &snp_dev->req.report;
 	struct snp_report_resp *report_resp;
 	int rc, resp_len;
@@ -513,7 +416,7 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
 	 * response payload. Make sure that it has enough space to cover the
 	 * authtag.
 	 */
-	resp_len = sizeof(report_resp->data) + crypto->a_len;
+	resp_len = sizeof(report_resp->data) + snp_dev->ctx->authsize;
 	report_resp = kzalloc(resp_len, GFP_KERNEL_ACCOUNT);
 	if (!report_resp)
 		return -ENOMEM;
@@ -534,7 +437,6 @@ e_free:
 static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
 {
 	struct snp_derived_key_req *derived_key_req = &snp_dev->req.derived_key;
-	struct snp_guest_crypto *crypto = snp_dev->crypto;
 	struct snp_derived_key_resp derived_key_resp = {0};
 	int rc, resp_len;
 	/* Response data is 64 bytes and max authsize for GCM is 16 bytes. */
@@ -550,7 +452,7 @@ static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_reque
 	 * response payload. Make sure that it has enough space to cover the
 	 * authtag.
 	 */
-	resp_len = sizeof(derived_key_resp.data) + crypto->a_len;
+	resp_len = sizeof(derived_key_resp.data) + snp_dev->ctx->authsize;
 	if (sizeof(buf) < resp_len)
 		return -ENOMEM;
 
@@ -579,7 +481,6 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
 
 {
 	struct snp_ext_report_req *report_req = &snp_dev->req.ext_report;
-	struct snp_guest_crypto *crypto = snp_dev->crypto;
 	struct snp_report_resp *report_resp;
 	int ret, npages = 0, resp_len;
 	sockptr_t certs_address;
@@ -622,7 +523,7 @@ cmd:
 	 * response payload. Make sure that it has enough space to cover the
 	 * authtag.
 	 */
-	resp_len = sizeof(report_resp->data) + crypto->a_len;
+	resp_len = sizeof(report_resp->data) + snp_dev->ctx->authsize;
 	report_resp = kzalloc(resp_len, GFP_KERNEL_ACCOUNT);
 	if (!report_resp)
 		return -ENOMEM;
@@ -1147,8 +1048,8 @@ static int __init sev_guest_probe(struct platform_device *pdev)
 		goto e_free_response;
 
 	ret = -EIO;
-	snp_dev->crypto = init_crypto(snp_dev, snp_dev->vmpck, VMPCK_KEY_LEN);
-	if (!snp_dev->crypto)
+	snp_dev->ctx = snp_init_crypto(snp_dev->vmpck, VMPCK_KEY_LEN);
+	if (!snp_dev->ctx)
 		goto e_free_cert_data;
 
 	misc = &snp_dev->misc;
@@ -1174,11 +1075,13 @@ static int __init sev_guest_probe(struct platform_device *pdev)
 
 	ret =  misc_register(misc);
 	if (ret)
-		goto e_free_cert_data;
+		goto e_free_ctx;
 
 	dev_info(dev, "Initialized SEV guest driver (using VMPCK%d communication key)\n", vmpck_id);
 	return 0;
 
+e_free_ctx:
+	kfree(snp_dev->ctx);
 e_free_cert_data:
 	free_shared_pages(snp_dev->certs_data, SEV_FW_BLOB_MAX_SIZE);
 e_free_response:
@@ -1197,7 +1100,7 @@ static void __exit sev_guest_remove(struct platform_device *pdev)
 	free_shared_pages(snp_dev->certs_data, SEV_FW_BLOB_MAX_SIZE);
 	free_shared_pages(snp_dev->response, sizeof(struct snp_guest_msg));
 	free_shared_pages(snp_dev->request, sizeof(struct snp_guest_msg));
-	deinit_crypto(snp_dev->crypto);
+	kfree(snp_dev->ctx);
 	misc_deregister(&snp_dev->misc);
 }
 

