Return-Path: <linux-tip-commits+bounces-1435-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B5090C846
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Jun 2024 13:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A74FE1F2460E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Jun 2024 11:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525911741DE;
	Tue, 18 Jun 2024 09:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U4wKfIaW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YrtuTEX6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C07621C181;
	Tue, 18 Jun 2024 09:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718703904; cv=none; b=X/NJ8CfBpida5bydaxHG2bhbkYlz2NXJ8wlggN9jMwKThOK3/KpGBozKrLFOcgClnHrdcL1WZp1FSmg4pOtPAt19MECd1tM1IzavJ/dRWRLUMKXlMsQBWZbVOLpKIyobGTNAKIk/LBlUGsQCWC1bOYBL2KWNeYbFeE+4op8tsaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718703904; c=relaxed/simple;
	bh=yrQbMc3j6GmeGrsd2j1UZt1aqUKl4GOXlilozTvPrEA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=g60qxxou5hTHjx/x3M2MAZGr0in0bNZJGxV9XxOBeeVhOBcz/7cA4JGhXXv2UzBvuL+J3kruAjksnsoH3RTubRZW5zy1LqLouWLbIwiL4us+w9RhroRfljWV2DMh9wLgo0pY2AHDkswpXLb+TUhSvV4CBnYJy9FE7M2f+CfMCGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U4wKfIaW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YrtuTEX6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Jun 2024 09:44:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718703898;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bT754/JFW3XlWiDeaplFa7vMWT8Vdf+NdF0JpRgIw28=;
	b=U4wKfIaW4dJ3mv/qe403fm5tIE1AhyUjdYGTw6uJyUqa72x7IoQwxJEnBMRqxy+lz+4jNc
	yTOI/07ftwknscB0V/9mj5BheQtZQOZPj6Gd1vs1pevSJNsLOlrpCCOIfkoOej/cNonsLD
	BOCCnKLv1ABTEyD7P+UbT1dEBC8WJKgZgKAHtwYu2L5aevM9LDiEpvGetqawxVwAG1k2Dn
	CVPuN23rif/Y3ozwE/V6rSzda0IvFXSFtdtcs5fytLDpL30gWVaLpisey0DB5StaCqFgwp
	5+mMR8rh+zD8aOZowrQJ0R9YFu9jwjqUXAq0k9jFxN+Nine3EbFx1LOd3dNZNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718703898;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bT754/JFW3XlWiDeaplFa7vMWT8Vdf+NdF0JpRgIw28=;
	b=YrtuTEX6EVuk6dmd0ReB1oQDHGlBFx59i8WwT1cR6FOds65nq2AYJLp/uO3pV74lljVkt2
	QFb36hxBqCfVRlDw==
From: "tip-bot2 for Tom Lendacky" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/sev] x86/sev: Extend the config-fs attestation support for an SVSM
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C965015dce3c76bb8724839d50c5dea4e4b5d598f=2E17176?=
 =?utf-8?q?00736=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
References: =?utf-8?q?=3C965015dce3c76bb8724839d50c5dea4e4b5d598f=2E171760?=
 =?utf-8?q?0736=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171870389805.10875.6775069497832795268.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     627dc671518b7f004ce04c45e8711f8dca94a57c
Gitweb:        https://git.kernel.org/tip/627dc671518b7f004ce04c45e8711f8dca94a57c
Author:        Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate:    Wed, 05 Jun 2024 10:18:55 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 17 Jun 2024 20:42:57 +02:00

x86/sev: Extend the config-fs attestation support for an SVSM

When an SVSM is present, the guest can also request attestation reports
from it. These SVSM attestation reports can be used to attest the SVSM
and any services running within the SVSM.

Extend the config-fs attestation support to provide such. This involves
creating four new config-fs attributes:

  - 'service-provider' (input)
    This attribute is used to determine whether the attestation request
    should be sent to the specified service provider or to the SEV
    firmware. The SVSM service provider is represented by the value
    'svsm'.

  - 'service_guid' (input)
    Used for requesting the attestation of a single service within the
    service provider. A null GUID implies that the SVSM_ATTEST_SERVICES
    call should be used to request the attestation report. A non-null
    GUID implies that the SVSM_ATTEST_SINGLE_SERVICE call should be used.

  - 'service_manifest_version' (input)
    Used with the SVSM_ATTEST_SINGLE_SERVICE call, the service version
    represents a specific service manifest version be used for the
    attestation report.

  - 'manifestblob' (output)
    Used to return the service manifest associated with the attestation
    report.

Only display these new attributes when running under an SVSM.

  [ bp: Massage.
   - s/svsm_attestation_call/svsm_attest_call/g ]

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/965015dce3c76bb8724839d50c5dea4e4b5d598f.1717600736.git.thomas.lendacky@amd.com
---
 Documentation/ABI/testing/configfs-tsm  |  64 ++++++++-
 arch/x86/include/asm/sev.h              |  31 +++-
 arch/x86/kernel/sev.c                   |  50 ++++++-
 drivers/virt/coco/sev-guest/sev-guest.c | 179 +++++++++++++++++++++++-
 drivers/virt/coco/tsm.c                 |  93 +++++++++++-
 include/linux/tsm.h                     |  19 ++-
 6 files changed, 433 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/configfs-tsm b/Documentation/ABI/testing/configfs-tsm
index dd24202..1db2008 100644
--- a/Documentation/ABI/testing/configfs-tsm
+++ b/Documentation/ABI/testing/configfs-tsm
@@ -31,6 +31,18 @@ Description:
 		Standardization v2.03 Section 4.1.8.1 MSG_REPORT_REQ.
 		https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/56421.pdf
 
+What:		/sys/kernel/config/tsm/report/$name/manifestblob
+Date:		January, 2024
+KernelVersion:	v6.10
+Contact:	linux-coco@lists.linux.dev
+Description:
+		(RO) Optional supplemental data that a TSM may emit, visibility
+		of this attribute depends on TSM, and may be empty if no
+		manifest data is available.
+
+		See 'service_provider' for information on the format of the
+		manifest blob.
+
 What:		/sys/kernel/config/tsm/report/$name/provider
 Date:		September, 2023
 KernelVersion:	v6.7
@@ -80,3 +92,55 @@ Contact:	linux-coco@lists.linux.dev
 Description:
 		(RO) Indicates the minimum permissible value that can be written
 		to @privlevel.
+
+What:		/sys/kernel/config/tsm/report/$name/service_provider
+Date:		January, 2024
+KernelVersion:	v6.10
+Contact:	linux-coco@lists.linux.dev
+Description:
+		(WO) Attribute is visible if a TSM implementation provider
+		supports the concept of attestation reports from a service
+		provider for TVMs, like SEV-SNP running under an SVSM.
+		Specifying the service provider via this attribute will create
+		an attestation report as specified by the service provider.
+		Currently supported service-providers are:
+			svsm
+
+		For the "svsm" service provider, see the Secure VM Service Module
+		for SEV-SNP Guests v1.00 Section 7. For the doc, search for
+		"site:amd.com "Secure VM Service Module for SEV-SNP
+		Guests", docID: 58019"
+
+What:		/sys/kernel/config/tsm/report/$name/service_guid
+Date:		January, 2024
+KernelVersion:	v6.10
+Contact:	linux-coco@lists.linux.dev
+Description:
+		(WO) Attribute is visible if a TSM implementation provider
+		supports the concept of attestation reports from a service
+		provider for TVMs, like SEV-SNP running under an SVSM.
+		Specifying an empty/null GUID (00000000-0000-0000-0000-000000)
+		requests all active services within the service provider be
+		part of the attestation report. Specifying a GUID request
+		an attestation report of just the specified service using the
+		manifest form specified by the service_manifest_version
+		attribute.
+
+		See 'service_provider' for information on the format of the
+		service guid.
+
+What:		/sys/kernel/config/tsm/report/$name/service_manifest_version
+Date:		January, 2024
+KernelVersion:	v6.10
+Contact:	linux-coco@lists.linux.dev
+Description:
+		(WO) Attribute is visible if a TSM implementation provider
+		supports the concept of attestation reports from a service
+		provider for TVMs, like SEV-SNP running under an SVSM.
+		Indicates the service manifest version requested for the
+		attestation report (default 0). If this field is not set by
+		the user, the default manifest version of the service (the
+		service's initial/first manifest version) is returned.
+
+		See 'service_provider' for information on the format of the
+		service manifest version.
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 9c6f269..ac5886c 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -214,6 +214,27 @@ struct svsm_pvalidate_call {
 					 sizeof(struct svsm_pvalidate_entry))
 
 /*
+ * The SVSM Attestation related structures
+ */
+struct svsm_loc_entry {
+	u64 pa;
+	u32 len;
+	u8 rsvd[4];
+};
+
+struct svsm_attest_call {
+	struct svsm_loc_entry report_buf;
+	struct svsm_loc_entry nonce;
+	struct svsm_loc_entry manifest_buf;
+	struct svsm_loc_entry certificates_buf;
+
+	/* For attesting a single service */
+	u8 service_guid[16];
+	u32 service_manifest_ver;
+	u8 rsvd[4];
+};
+
+/*
  * SVSM protocol structure
  */
 struct svsm_call {
@@ -236,6 +257,10 @@ struct svsm_call {
 #define SVSM_CORE_CREATE_VCPU		2
 #define SVSM_CORE_DELETE_VCPU		3
 
+#define SVSM_ATTEST_CALL(x)		((1ULL << 32) | (x))
+#define SVSM_ATTEST_SERVICES		0
+#define SVSM_ATTEST_SINGLE_SERVICE	1
+
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 
 extern u8 snp_vmpl;
@@ -317,6 +342,7 @@ bool snp_init(struct boot_params *bp);
 void __noreturn snp_abort(void);
 void snp_dmi_setup(void);
 int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct snp_guest_request_ioctl *rio);
+int snp_issue_svsm_attest_req(u64 call_id, struct svsm_call *call, struct svsm_attest_call *input);
 void snp_accept_memory(phys_addr_t start, phys_addr_t end);
 u64 snp_get_unsupported_features(u64 status);
 u64 sev_get_status(void);
@@ -349,7 +375,10 @@ static inline int snp_issue_guest_request(u64 exit_code, struct snp_req_data *in
 {
 	return -ENOTTY;
 }
-
+static inline int snp_issue_svsm_attest_req(u64 call_id, struct svsm_call *call, struct svsm_attest_call *input)
+{
+	return -ENOTTY;
+}
 static inline void snp_accept_memory(phys_addr_t start, phys_addr_t end) { }
 static inline u64 snp_get_unsupported_features(u64 status) { return 0; }
 static inline u64 sev_get_status(void) { return 0; }
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 4dc7ae3..53ac3e0 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -2387,6 +2387,56 @@ static int __init init_sev_config(char *str)
 }
 __setup("sev=", init_sev_config);
 
+static void update_attest_input(struct svsm_call *call, struct svsm_attest_call *input)
+{
+	/* If (new) lengths have been returned, propagate them up */
+	if (call->rcx_out != call->rcx)
+		input->manifest_buf.len = call->rcx_out;
+
+	if (call->rdx_out != call->rdx)
+		input->certificates_buf.len = call->rdx_out;
+
+	if (call->r8_out != call->r8)
+		input->report_buf.len = call->r8_out;
+}
+
+int snp_issue_svsm_attest_req(u64 call_id, struct svsm_call *call,
+			      struct svsm_attest_call *input)
+{
+	struct svsm_attest_call *ac;
+	unsigned long flags;
+	u64 attest_call_pa;
+	int ret;
+
+	if (!snp_vmpl)
+		return -EINVAL;
+
+	local_irq_save(flags);
+
+	call->caa = svsm_get_caa();
+
+	ac = (struct svsm_attest_call *)call->caa->svsm_buffer;
+	attest_call_pa = svsm_get_caa_pa() + offsetof(struct svsm_ca, svsm_buffer);
+
+	*ac = *input;
+
+	/*
+	 * Set input registers for the request and set RDX and R8 to known
+	 * values in order to detect length values being returned in them.
+	 */
+	call->rax = call_id;
+	call->rcx = attest_call_pa;
+	call->rdx = -1;
+	call->r8 = -1;
+	ret = svsm_perform_call_protocol(call);
+	update_attest_input(call, input);
+
+	local_irq_restore(flags);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snp_issue_svsm_attest_req);
+
 int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct snp_guest_request_ioctl *rio)
 {
 	struct ghcb_state state;
diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 0c70a38..3752288 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -39,6 +39,8 @@
 #define SNP_REQ_MAX_RETRY_DURATION	(60*HZ)
 #define SNP_REQ_RETRY_DELAY		(2*HZ)
 
+#define SVSM_MAX_RETRIES		3
+
 struct snp_guest_crypto {
 	struct crypto_aead *tfm;
 	u8 *iv, *authtag;
@@ -791,6 +793,143 @@ struct snp_msg_cert_entry {
 	u32 length;
 };
 
+static int sev_svsm_report_new(struct tsm_report *report, void *data)
+{
+	unsigned int rep_len, man_len, certs_len;
+	struct tsm_desc *desc = &report->desc;
+	struct svsm_attest_call ac = {};
+	unsigned int retry_count;
+	void *rep, *man, *certs;
+	struct svsm_call call;
+	unsigned int size;
+	bool try_again;
+	void *buffer;
+	u64 call_id;
+	int ret;
+
+	/*
+	 * Allocate pages for the request:
+	 * - Report blob (4K)
+	 * - Manifest blob (4K)
+	 * - Certificate blob (16K)
+	 *
+	 * Above addresses must be 4K aligned
+	 */
+	rep_len = SZ_4K;
+	man_len = SZ_4K;
+	certs_len = SEV_FW_BLOB_MAX_SIZE;
+
+	guard(mutex)(&snp_cmd_mutex);
+
+	if (guid_is_null(&desc->service_guid)) {
+		call_id = SVSM_ATTEST_CALL(SVSM_ATTEST_SERVICES);
+	} else {
+		export_guid(ac.service_guid, &desc->service_guid);
+		ac.service_manifest_ver = desc->service_manifest_version;
+
+		call_id = SVSM_ATTEST_CALL(SVSM_ATTEST_SINGLE_SERVICE);
+	}
+
+	retry_count = 0;
+
+retry:
+	memset(&call, 0, sizeof(call));
+
+	size = rep_len + man_len + certs_len;
+	buffer = alloc_pages_exact(size, __GFP_ZERO);
+	if (!buffer)
+		return -ENOMEM;
+
+	rep = buffer;
+	ac.report_buf.pa = __pa(rep);
+	ac.report_buf.len = rep_len;
+
+	man = rep + rep_len;
+	ac.manifest_buf.pa = __pa(man);
+	ac.manifest_buf.len = man_len;
+
+	certs = man + man_len;
+	ac.certificates_buf.pa = __pa(certs);
+	ac.certificates_buf.len = certs_len;
+
+	ac.nonce.pa = __pa(desc->inblob);
+	ac.nonce.len = desc->inblob_len;
+
+	ret = snp_issue_svsm_attest_req(call_id, &call, &ac);
+	if (ret) {
+		free_pages_exact(buffer, size);
+
+		switch (call.rax_out) {
+		case SVSM_ERR_INVALID_PARAMETER:
+			try_again = false;
+
+			if (ac.report_buf.len > rep_len) {
+				rep_len = PAGE_ALIGN(ac.report_buf.len);
+				try_again = true;
+			}
+
+			if (ac.manifest_buf.len > man_len) {
+				man_len = PAGE_ALIGN(ac.manifest_buf.len);
+				try_again = true;
+			}
+
+			if (ac.certificates_buf.len > certs_len) {
+				certs_len = PAGE_ALIGN(ac.certificates_buf.len);
+				try_again = true;
+			}
+
+			/* If one of the buffers wasn't large enough, retry the request */
+			if (try_again && retry_count < SVSM_MAX_RETRIES) {
+				retry_count++;
+				goto retry;
+			}
+
+			return -EINVAL;
+		default:
+			pr_err_ratelimited("SVSM attestation request failed (%d / 0x%llx)\n",
+					   ret, call.rax_out);
+			return -EINVAL;
+		}
+	}
+
+	/*
+	 * Allocate all the blob memory buffers at once so that the cleanup is
+	 * done for errors that occur after the first allocation (i.e. before
+	 * using no_free_ptr()).
+	 */
+	rep_len = ac.report_buf.len;
+	void *rbuf __free(kvfree) = kvzalloc(rep_len, GFP_KERNEL);
+
+	man_len = ac.manifest_buf.len;
+	void *mbuf __free(kvfree) = kvzalloc(man_len, GFP_KERNEL);
+
+	certs_len = ac.certificates_buf.len;
+	void *cbuf __free(kvfree) = certs_len ? kvzalloc(certs_len, GFP_KERNEL) : NULL;
+
+	if (!rbuf || !mbuf || (certs_len && !cbuf)) {
+		free_pages_exact(buffer, size);
+		return -ENOMEM;
+	}
+
+	memcpy(rbuf, rep, rep_len);
+	report->outblob = no_free_ptr(rbuf);
+	report->outblob_len = rep_len;
+
+	memcpy(mbuf, man, man_len);
+	report->manifestblob = no_free_ptr(mbuf);
+	report->manifestblob_len = man_len;
+
+	if (certs_len) {
+		memcpy(cbuf, certs, certs_len);
+		report->auxblob = no_free_ptr(cbuf);
+		report->auxblob_len = certs_len;
+	}
+
+	free_pages_exact(buffer, size);
+
+	return 0;
+}
+
 static int sev_report_new(struct tsm_report *report, void *data)
 {
 	struct snp_msg_cert_entry *cert_table;
@@ -805,6 +944,13 @@ static int sev_report_new(struct tsm_report *report, void *data)
 	if (desc->inblob_len != SNP_REPORT_USER_DATA_SIZE)
 		return -EINVAL;
 
+	if (desc->service_provider) {
+		if (strcmp(desc->service_provider, "svsm"))
+			return -EINVAL;
+
+		return sev_svsm_report_new(report, data);
+	}
+
 	void *buf __free(kvfree) = kvzalloc(size, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
@@ -893,9 +1039,42 @@ static int sev_report_new(struct tsm_report *report, void *data)
 	return 0;
 }
 
+static bool sev_report_attr_visible(int n)
+{
+	switch (n) {
+	case TSM_REPORT_GENERATION:
+	case TSM_REPORT_PROVIDER:
+	case TSM_REPORT_PRIVLEVEL:
+	case TSM_REPORT_PRIVLEVEL_FLOOR:
+		return true;
+	case TSM_REPORT_SERVICE_PROVIDER:
+	case TSM_REPORT_SERVICE_GUID:
+	case TSM_REPORT_SERVICE_MANIFEST_VER:
+		return snp_vmpl;
+	}
+
+	return false;
+}
+
+static bool sev_report_bin_attr_visible(int n)
+{
+	switch (n) {
+	case TSM_REPORT_INBLOB:
+	case TSM_REPORT_OUTBLOB:
+	case TSM_REPORT_AUXBLOB:
+		return true;
+	case TSM_REPORT_MANIFESTBLOB:
+		return snp_vmpl;
+	}
+
+	return false;
+}
+
 static struct tsm_ops sev_tsm_ops = {
 	.name = KBUILD_MODNAME,
 	.report_new = sev_report_new,
+	.report_attr_visible = sev_report_attr_visible,
+	.report_bin_attr_visible = sev_report_bin_attr_visible,
 };
 
 static void unregister_sev_tsm(void *data)
diff --git a/drivers/virt/coco/tsm.c b/drivers/virt/coco/tsm.c
index 7db534b..9432d4e 100644
--- a/drivers/virt/coco/tsm.c
+++ b/drivers/virt/coco/tsm.c
@@ -34,7 +34,7 @@ static DECLARE_RWSEM(tsm_rwsem);
  * The attestation report format is TSM provider specific, when / if a standard
  * materializes that can be published instead of the vendor layout. Until then
  * the 'provider' attribute indicates the format of 'outblob', and optionally
- * 'auxblob'.
+ * 'auxblob' and 'manifestblob'.
  */
 
 struct tsm_report_state {
@@ -47,6 +47,7 @@ struct tsm_report_state {
 enum tsm_data_select {
 	TSM_REPORT,
 	TSM_CERTS,
+	TSM_MANIFEST,
 };
 
 static struct tsm_report *to_tsm_report(struct config_item *cfg)
@@ -118,6 +119,74 @@ static ssize_t tsm_report_privlevel_floor_show(struct config_item *cfg,
 }
 CONFIGFS_ATTR_RO(tsm_report_, privlevel_floor);
 
+static ssize_t tsm_report_service_provider_store(struct config_item *cfg,
+						 const char *buf, size_t len)
+{
+	struct tsm_report *report = to_tsm_report(cfg);
+	size_t sp_len;
+	char *sp;
+	int rc;
+
+	guard(rwsem_write)(&tsm_rwsem);
+	rc = try_advance_write_generation(report);
+	if (rc)
+		return rc;
+
+	sp_len = (buf[len - 1] != '\n') ? len : len - 1;
+
+	sp = kstrndup(buf, sp_len, GFP_KERNEL);
+	if (!sp)
+		return -ENOMEM;
+	kfree(report->desc.service_provider);
+
+	report->desc.service_provider = sp;
+
+	return len;
+}
+CONFIGFS_ATTR_WO(tsm_report_, service_provider);
+
+static ssize_t tsm_report_service_guid_store(struct config_item *cfg,
+					     const char *buf, size_t len)
+{
+	struct tsm_report *report = to_tsm_report(cfg);
+	int rc;
+
+	guard(rwsem_write)(&tsm_rwsem);
+	rc = try_advance_write_generation(report);
+	if (rc)
+		return rc;
+
+	report->desc.service_guid = guid_null;
+
+	rc = guid_parse(buf, &report->desc.service_guid);
+	if (rc)
+		return rc;
+
+	return len;
+}
+CONFIGFS_ATTR_WO(tsm_report_, service_guid);
+
+static ssize_t tsm_report_service_manifest_version_store(struct config_item *cfg,
+							 const char *buf, size_t len)
+{
+	struct tsm_report *report = to_tsm_report(cfg);
+	unsigned int val;
+	int rc;
+
+	rc = kstrtouint(buf, 0, &val);
+	if (rc)
+		return rc;
+
+	guard(rwsem_write)(&tsm_rwsem);
+	rc = try_advance_write_generation(report);
+	if (rc)
+		return rc;
+	report->desc.service_manifest_version = val;
+
+	return len;
+}
+CONFIGFS_ATTR_WO(tsm_report_, service_manifest_version);
+
 static ssize_t tsm_report_inblob_write(struct config_item *cfg,
 				       const void *buf, size_t count)
 {
@@ -162,6 +231,9 @@ static ssize_t __read_report(struct tsm_report *report, void *buf, size_t count,
 	if (select == TSM_REPORT) {
 		out = report->outblob;
 		len = report->outblob_len;
+	} else if (select == TSM_MANIFEST) {
+		out = report->manifestblob;
+		len = report->manifestblob_len;
 	} else {
 		out = report->auxblob;
 		len = report->auxblob_len;
@@ -187,7 +259,7 @@ static ssize_t read_cached_report(struct tsm_report *report, void *buf,
 
 	/*
 	 * A given TSM backend always fills in ->outblob regardless of
-	 * whether the report includes an auxblob or not.
+	 * whether the report includes an auxblob/manifestblob or not.
 	 */
 	if (!report->outblob ||
 	    state->read_generation != state->write_generation)
@@ -223,8 +295,10 @@ static ssize_t tsm_report_read(struct tsm_report *report, void *buf,
 
 	kvfree(report->outblob);
 	kvfree(report->auxblob);
+	kvfree(report->manifestblob);
 	report->outblob = NULL;
 	report->auxblob = NULL;
+	report->manifestblob = NULL;
 	rc = ops->report_new(report, provider.data);
 	if (rc < 0)
 		return rc;
@@ -251,11 +325,23 @@ static ssize_t tsm_report_auxblob_read(struct config_item *cfg, void *buf,
 }
 CONFIGFS_BIN_ATTR_RO(tsm_report_, auxblob, NULL, TSM_OUTBLOB_MAX);
 
+static ssize_t tsm_report_manifestblob_read(struct config_item *cfg, void *buf,
+					    size_t count)
+{
+	struct tsm_report *report = to_tsm_report(cfg);
+
+	return tsm_report_read(report, buf, count, TSM_MANIFEST);
+}
+CONFIGFS_BIN_ATTR_RO(tsm_report_, manifestblob, NULL, TSM_OUTBLOB_MAX);
+
 static struct configfs_attribute *tsm_report_attrs[] = {
 	[TSM_REPORT_GENERATION] = &tsm_report_attr_generation,
 	[TSM_REPORT_PROVIDER] = &tsm_report_attr_provider,
 	[TSM_REPORT_PRIVLEVEL] = &tsm_report_attr_privlevel,
 	[TSM_REPORT_PRIVLEVEL_FLOOR] = &tsm_report_attr_privlevel_floor,
+	[TSM_REPORT_SERVICE_PROVIDER] = &tsm_report_attr_service_provider,
+	[TSM_REPORT_SERVICE_GUID] = &tsm_report_attr_service_guid,
+	[TSM_REPORT_SERVICE_MANIFEST_VER] = &tsm_report_attr_service_manifest_version,
 	NULL,
 };
 
@@ -263,6 +349,7 @@ static struct configfs_bin_attribute *tsm_report_bin_attrs[] = {
 	[TSM_REPORT_INBLOB] = &tsm_report_attr_inblob,
 	[TSM_REPORT_OUTBLOB] = &tsm_report_attr_outblob,
 	[TSM_REPORT_AUXBLOB] = &tsm_report_attr_auxblob,
+	[TSM_REPORT_MANIFESTBLOB] = &tsm_report_attr_manifestblob,
 	NULL,
 };
 
@@ -271,8 +358,10 @@ static void tsm_report_item_release(struct config_item *cfg)
 	struct tsm_report *report = to_tsm_report(cfg);
 	struct tsm_report_state *state = to_state(report);
 
+	kvfree(report->manifestblob);
 	kvfree(report->auxblob);
 	kvfree(report->outblob);
+	kfree(report->desc.service_provider);
 	kfree(state);
 }
 
diff --git a/include/linux/tsm.h b/include/linux/tsm.h
index 30d9d27..11b0c52 100644
--- a/include/linux/tsm.h
+++ b/include/linux/tsm.h
@@ -4,6 +4,7 @@
 
 #include <linux/sizes.h>
 #include <linux/types.h>
+#include <linux/uuid.h>
 
 #define TSM_INBLOB_MAX 64
 #define TSM_OUTBLOB_MAX SZ_32K
@@ -19,11 +20,17 @@
  * @privlevel: optional privilege level to associate with @outblob
  * @inblob_len: sizeof @inblob
  * @inblob: arbitrary input data
+ * @service_provider: optional name of where to obtain the tsm report blob
+ * @service_guid: optional service-provider service guid to attest
+ * @service_manifest_version: optional service-provider service manifest version requested
  */
 struct tsm_desc {
 	unsigned int privlevel;
 	size_t inblob_len;
 	u8 inblob[TSM_INBLOB_MAX];
+	char *service_provider;
+	guid_t service_guid;
+	unsigned int service_manifest_version;
 };
 
 /**
@@ -33,6 +40,8 @@ struct tsm_desc {
  * @outblob: generated evidence to provider to the attestation agent
  * @auxblob_len: sizeof(@auxblob)
  * @auxblob: (optional) auxiliary data to the report (e.g. certificate data)
+ * @manifestblob_len: sizeof(@manifestblob)
+ * @manifestblob: (optional) manifest data associated with the report
  */
 struct tsm_report {
 	struct tsm_desc desc;
@@ -40,6 +49,8 @@ struct tsm_report {
 	u8 *outblob;
 	size_t auxblob_len;
 	u8 *auxblob;
+	size_t manifestblob_len;
+	u8 *manifestblob;
 };
 
 /**
@@ -48,12 +59,18 @@ struct tsm_report {
  * @TSM_REPORT_PROVIDER: index of the provider name attribute
  * @TSM_REPORT_PRIVLEVEL: index of the desired privilege level attribute
  * @TSM_REPORT_PRIVLEVEL_FLOOR: index of the minimum allowed privileg level attribute
+ * @TSM_REPORT_SERVICE_PROVIDER: index of the service provider identifier attribute
+ * @TSM_REPORT_SERVICE_GUID: index of the service GUID attribute
+ * @TSM_REPORT_SERVICE_MANIFEST_VER: index of the service manifest version attribute
  */
 enum tsm_attr_index {
 	TSM_REPORT_GENERATION,
 	TSM_REPORT_PROVIDER,
 	TSM_REPORT_PRIVLEVEL,
 	TSM_REPORT_PRIVLEVEL_FLOOR,
+	TSM_REPORT_SERVICE_PROVIDER,
+	TSM_REPORT_SERVICE_GUID,
+	TSM_REPORT_SERVICE_MANIFEST_VER,
 };
 
 /**
@@ -61,11 +78,13 @@ enum tsm_attr_index {
  * @TSM_REPORT_INBLOB: index of the binary report input attribute
  * @TSM_REPORT_OUTBLOB: index of the binary report output attribute
  * @TSM_REPORT_AUXBLOB: index of the binary auxiliary data attribute
+ * @TSM_REPORT_MANIFESTBLOB: index of the binary manifest data attribute
  */
 enum tsm_bin_attr_index {
 	TSM_REPORT_INBLOB,
 	TSM_REPORT_OUTBLOB,
 	TSM_REPORT_AUXBLOB,
+	TSM_REPORT_MANIFESTBLOB,
 };
 
 /**

