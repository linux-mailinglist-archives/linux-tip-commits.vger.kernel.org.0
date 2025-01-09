Return-Path: <linux-tip-commits+bounces-3192-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D09CA071D7
	for <lists+linux-tip-commits@lfdr.de>; Thu,  9 Jan 2025 10:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF2503A4EF9
	for <lists+linux-tip-commits@lfdr.de>; Thu,  9 Jan 2025 09:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922E921661C;
	Thu,  9 Jan 2025 09:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PWeQhnOi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BJesRmp6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5152163B5;
	Thu,  9 Jan 2025 09:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736415832; cv=none; b=HfW2lIUr9eAYIOaJ0qJywolxgqJv/3JLmZmJj4bmsNJYcs0D/q2sFng97Ylfwu+cAuaSiTB0fSAi0P4cn1IS6VKLnwwxidi34B0hp8PEeXDqkEeO8Q1gEvbkU1+kAOk3Vl7+WU3cXGhJJzaWTdyRl/CNBXm2YyvitfsC0+OD/fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736415832; c=relaxed/simple;
	bh=XNxlmg7BQ8is/6gNWxXrm/0zoqYQfdPtPUzoO9OCs5Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=H/2NTnd1Vzy3sNIZT2UswG3cAKAOsOaRxiwkeGIoafFSEuwRRAzRy5NYUZa2j9YQF54EUtWdNGIhwX/HB+YFIZ+tJRzeiJMkEZt9JATFuKVzp2G97R4DMH2jZCVAa/ULd6WxHE/NSPxeIzLDZ/hrtLZj7Bqvt+lBrS55iwF7fco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PWeQhnOi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BJesRmp6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 09 Jan 2025 09:43:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736415828;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EZfpMudtZxxqFglLHzVb++bKWvsxDBmCeYTcge+GxSk=;
	b=PWeQhnOiKkyd1F9vwjxLGXVFWgAK+Eacvc4tUkuzQuUfeIcTxLIB1K1Ln91P2qHetyfGhT
	ZRQ0Yed+oC/BofsoAXABrj5/ZtyyGVc+4PAX6xL5Jw2JBXYlrlZav6UlGRpbfhVQcIelsP
	WdFq4FwX1ciKTaGG7QQXO8fHl+nXMs9Cwfxn5JUH0ZXXnfx1sTmXF0tqEG8pQ6OVlElx+p
	D3KEAcWr2fhL2RNzzCqgl125sNP7dOH9cyDP9Yle/aUpqZ3gO/UdISmfMrg/MrjRwoqUfi
	gPvCGKH9as1Zu/bsqsCjIpUUWux2QTtYJCiHSgELrJdlEH43mEqE0GkiXVZh8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736415828;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EZfpMudtZxxqFglLHzVb++bKWvsxDBmCeYTcge+GxSk=;
	b=BJesRmp6dEbDlh+t1vgh2fHUE683A7n8+/NRFtp3i4/s8qY4JHDQIsN+xXvYwAGxW3XiNG
	+ThmcDiogpLIpuCg==
From: "tip-bot2 for Nikunj A Dadhania" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Add Secure TSC support for SNP guests
Cc: Nikunj A Dadhania <nikunj@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250106124633.1418972-6-nikunj@amd.com>
References: <20250106124633.1418972-6-nikunj@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173641582755.399.17736193882473055015.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     85b60ca9ad2c94661acf86a0c11278246cc5ea86
Gitweb:        https://git.kernel.org/tip/85b60ca9ad2c94661acf86a0c11278246cc5ea86
Author:        Nikunj A Dadhania <nikunj@amd.com>
AuthorDate:    Mon, 06 Jan 2025 18:16:25 +05:30
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 07 Jan 2025 20:27:23 +01:00

x86/sev: Add Secure TSC support for SNP guests

Add support for Secure TSC in SNP-enabled guests. Secure TSC allows guests
to securely use RDTSC/RDTSCP instructions, ensuring that the parameters used
cannot be altered by the hypervisor once the guest is launched.

Secure TSC-enabled guests need to query TSC information from the AMD Security
Processor. This communication channel is encrypted between the AMD Security
Processor and the guest, with the hypervisor acting merely as a conduit to
deliver the guest messages to the AMD Security Processor. Each message is
protected with AEAD (AES-256 GCM).

  [ bp: Zap a stray newline over amd_cc_platform_has() while at it,
    simplify CC_ATTR_GUEST_SNP_SECURE_TSC check ]

Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20250106124633.1418972-6-nikunj@amd.com
---
 arch/x86/coco/core.c              |   4 +-
 arch/x86/coco/sev/core.c          | 107 +++++++++++++++++++++++++++++-
 arch/x86/include/asm/sev-common.h |   1 +-
 arch/x86/include/asm/sev.h        |  21 ++++++-
 arch/x86/include/asm/svm.h        |   6 +-
 arch/x86/mm/mem_encrypt.c         |   2 +-
 include/linux/cc_platform.h       |   8 ++-
 7 files changed, 146 insertions(+), 3 deletions(-)

diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
index 0f81f70..9a0ddda 100644
--- a/arch/x86/coco/core.c
+++ b/arch/x86/coco/core.c
@@ -65,7 +65,6 @@ static __maybe_unused __always_inline bool amd_cc_platform_vtom(enum cc_attr att
  * up under SME the trampoline area cannot be encrypted, whereas under SEV
  * the trampoline area must be encrypted.
  */
-
 static bool noinstr amd_cc_platform_has(enum cc_attr attr)
 {
 #ifdef CONFIG_AMD_MEM_ENCRYPT
@@ -97,6 +96,9 @@ static bool noinstr amd_cc_platform_has(enum cc_attr attr)
 	case CC_ATTR_GUEST_SEV_SNP:
 		return sev_status & MSR_AMD64_SEV_SNP_ENABLED;
 
+	case CC_ATTR_GUEST_SNP_SECURE_TSC:
+		return sev_status & MSR_AMD64_SNP_SECURE_TSC;
+
 	case CC_ATTR_HOST_SEV_SNP:
 		return cc_flags.host_sev_snp;
 
diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index ad3a288..7458805 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -96,6 +96,14 @@ static u64 sev_hv_features __ro_after_init;
 /* Secrets page physical address from the CC blob */
 static u64 secrets_pa __ro_after_init;
 
+/*
+ * For Secure TSC guests, the BSP fetches TSC_INFO using SNP guest messaging and
+ * initializes snp_tsc_scale and snp_tsc_offset. These values are replicated
+ * across the APs VMSA fields (TSC_SCALE and TSC_OFFSET).
+ */
+static u64 snp_tsc_scale __ro_after_init;
+static u64 snp_tsc_offset __ro_after_init;
+
 /* #VC handler runtime per-CPU data */
 struct sev_es_runtime_data {
 	struct ghcb ghcb_page;
@@ -1277,6 +1285,12 @@ static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip)
 	vmsa->vmpl		= snp_vmpl;
 	vmsa->sev_features	= sev_status >> 2;
 
+	/* Populate AP's TSC scale/offset to get accurate TSC values. */
+	if (cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC)) {
+		vmsa->tsc_scale = snp_tsc_scale;
+		vmsa->tsc_offset = snp_tsc_offset;
+	}
+
 	/* Switch the page over to a VMSA page now that it is initialized */
 	ret = snp_set_vmsa(vmsa, caa, apic_id, true);
 	if (ret) {
@@ -3126,3 +3140,96 @@ int snp_send_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_req *req
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snp_send_guest_request);
+
+static int __init snp_get_tsc_info(void)
+{
+	struct snp_guest_request_ioctl *rio;
+	struct snp_tsc_info_resp *tsc_resp;
+	struct snp_tsc_info_req *tsc_req;
+	struct snp_msg_desc *mdesc;
+	struct snp_guest_req *req;
+	int rc = -ENOMEM;
+
+	tsc_req = kzalloc(sizeof(*tsc_req), GFP_KERNEL);
+	if (!tsc_req)
+		return rc;
+
+	/*
+	 * The intermediate response buffer is used while decrypting the
+	 * response payload. Make sure that it has enough space to cover
+	 * the authtag.
+	 */
+	tsc_resp = kzalloc(sizeof(*tsc_resp) + AUTHTAG_LEN, GFP_KERNEL);
+	if (!tsc_resp)
+		goto e_free_tsc_req;
+
+	req = kzalloc(sizeof(*req), GFP_KERNEL);
+	if (!req)
+		goto e_free_tsc_resp;
+
+	rio = kzalloc(sizeof(*rio), GFP_KERNEL);
+	if (!rio)
+		goto e_free_req;
+
+	mdesc = snp_msg_alloc();
+	if (IS_ERR_OR_NULL(mdesc))
+		goto e_free_rio;
+
+	rc = snp_msg_init(mdesc, snp_vmpl);
+	if (rc)
+		goto e_free_mdesc;
+
+	req->msg_version = MSG_HDR_VER;
+	req->msg_type = SNP_MSG_TSC_INFO_REQ;
+	req->vmpck_id = snp_vmpl;
+	req->req_buf = tsc_req;
+	req->req_sz = sizeof(*tsc_req);
+	req->resp_buf = (void *)tsc_resp;
+	req->resp_sz = sizeof(*tsc_resp) + AUTHTAG_LEN;
+	req->exit_code = SVM_VMGEXIT_GUEST_REQUEST;
+
+	rc = snp_send_guest_request(mdesc, req, rio);
+	if (rc)
+		goto e_request;
+
+	pr_debug("%s: response status 0x%x scale 0x%llx offset 0x%llx factor 0x%x\n",
+		 __func__, tsc_resp->status, tsc_resp->tsc_scale, tsc_resp->tsc_offset,
+		 tsc_resp->tsc_factor);
+
+	if (!tsc_resp->status) {
+		snp_tsc_scale = tsc_resp->tsc_scale;
+		snp_tsc_offset = tsc_resp->tsc_offset;
+	} else {
+		pr_err("Failed to get TSC info, response status 0x%x\n", tsc_resp->status);
+		rc = -EIO;
+	}
+
+e_request:
+	/* The response buffer contains sensitive data, explicitly clear it. */
+	memzero_explicit(tsc_resp, sizeof(*tsc_resp) + AUTHTAG_LEN);
+e_free_mdesc:
+	snp_msg_free(mdesc);
+e_free_rio:
+	kfree(rio);
+e_free_req:
+	kfree(req);
+ e_free_tsc_resp:
+	kfree(tsc_resp);
+e_free_tsc_req:
+	kfree(tsc_req);
+
+	return rc;
+}
+
+void __init snp_secure_tsc_prepare(void)
+{
+	if (!cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC))
+		return;
+
+	if (snp_get_tsc_info()) {
+		pr_alert("Unable to retrieve Secure TSC info from ASP\n");
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SECURE_TSC);
+	}
+
+	pr_debug("SecureTSC enabled");
+}
diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index 50f5666..6ef9243 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -206,6 +206,7 @@ struct snp_psc_desc {
 #define GHCB_TERM_NO_SVSM		7	/* SVSM is not advertised in the secrets page */
 #define GHCB_TERM_SVSM_VMPL0		8	/* SVSM is present but has set VMPL to 0 */
 #define GHCB_TERM_SVSM_CAA		9	/* SVSM is present but CAA is not page aligned */
+#define GHCB_TERM_SECURE_TSC		10	/* Secure TSC initialization failed */
 
 #define GHCB_RESP_CODE(v)		((v) & GHCB_MSR_INFO_MASK)
 
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 0937ac7..bdcdaac 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -146,6 +146,9 @@ enum msg_type {
 	SNP_MSG_VMRK_REQ,
 	SNP_MSG_VMRK_RSP,
 
+	SNP_MSG_TSC_INFO_REQ = 17,
+	SNP_MSG_TSC_INFO_RSP,
+
 	SNP_MSG_TYPE_MAX
 };
 
@@ -174,6 +177,21 @@ struct snp_guest_msg {
 	u8 payload[PAGE_SIZE - sizeof(struct snp_guest_msg_hdr)];
 } __packed;
 
+#define SNP_TSC_INFO_REQ_SZ	128
+
+struct snp_tsc_info_req {
+	u8 rsvd[SNP_TSC_INFO_REQ_SZ];
+} __packed;
+
+struct snp_tsc_info_resp {
+	u32 status;
+	u32 rsvd1;
+	u64 tsc_scale;
+	u64 tsc_offset;
+	u32 tsc_factor;
+	u8 rsvd2[100];
+} __packed;
+
 struct snp_guest_req {
 	void *req_buf;
 	size_t req_sz;
@@ -463,6 +481,8 @@ void snp_msg_free(struct snp_msg_desc *mdesc);
 int snp_send_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_req *req,
 			   struct snp_guest_request_ioctl *rio);
 
+void __init snp_secure_tsc_prepare(void);
+
 #else	/* !CONFIG_AMD_MEM_ENCRYPT */
 
 #define snp_vmpl 0
@@ -503,6 +523,7 @@ static inline struct snp_msg_desc *snp_msg_alloc(void) { return NULL; }
 static inline void snp_msg_free(struct snp_msg_desc *mdesc) { }
 static inline int snp_send_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_req *req,
 					 struct snp_guest_request_ioctl *rio) { return -ENODEV; }
+static inline void __init snp_secure_tsc_prepare(void) { }
 
 #endif	/* CONFIG_AMD_MEM_ENCRYPT */
 
diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index 2b59b99..92e1879 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -417,7 +417,9 @@ struct sev_es_save_area {
 	u8 reserved_0x298[80];
 	u32 pkru;
 	u32 tsc_aux;
-	u8 reserved_0x2f0[24];
+	u64 tsc_scale;
+	u64 tsc_offset;
+	u8 reserved_0x300[8];
 	u64 rcx;
 	u64 rdx;
 	u64 rbx;
@@ -564,7 +566,7 @@ static inline void __unused_size_checks(void)
 	BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0x1c0);
 	BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0x248);
 	BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0x298);
-	BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0x2f0);
+	BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0x300);
 	BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0x320);
 	BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0x380);
 	BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0x3f0);
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 0a120d8..95bae74 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -94,6 +94,8 @@ void __init mem_encrypt_init(void)
 	/* Call into SWIOTLB to update the SWIOTLB DMA buffers */
 	swiotlb_update_mem_attributes();
 
+	snp_secure_tsc_prepare();
+
 	print_mem_encrypt_feature_info();
 }
 
diff --git a/include/linux/cc_platform.h b/include/linux/cc_platform.h
index caa4b44..0bf7d33 100644
--- a/include/linux/cc_platform.h
+++ b/include/linux/cc_platform.h
@@ -82,6 +82,14 @@ enum cc_attr {
 	CC_ATTR_GUEST_SEV_SNP,
 
 	/**
+	 * @CC_ATTR_GUEST_SNP_SECURE_TSC: SNP Secure TSC is active.
+	 *
+	 * The platform/OS is running as a guest/virtual machine and actively
+	 * using AMD SEV-SNP Secure TSC feature.
+	 */
+	CC_ATTR_GUEST_SNP_SECURE_TSC,
+
+	/**
 	 * @CC_ATTR_HOST_SEV_SNP: AMD SNP enabled on the host.
 	 *
 	 * The host kernel is running with the necessary features

