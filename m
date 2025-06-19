Return-Path: <linux-tip-commits+bounces-5872-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC50AE02D8
	for <lists+linux-tip-commits@lfdr.de>; Thu, 19 Jun 2025 12:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C941177E66
	for <lists+linux-tip-commits@lfdr.de>; Thu, 19 Jun 2025 10:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E6F22A4E3;
	Thu, 19 Jun 2025 10:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x1Bnezjy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OnuHvKUC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555F62264BC;
	Thu, 19 Jun 2025 10:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750329611; cv=none; b=UjfkPbOoEB+IoH6Jdgi7slQqpcY/vydTVoi278FUzTu+y6fgTtc+DC7aggZPL0aILmVkcxlNl/Sjb3IrsgsOlVUpuh/gF8ACjyPCvMmJQsfjf2nzqU6WQ/Ojw67G0I3czZ+KsyP/ttCDy5QvyxQUDYGOf8CDx8CW3PEwtIoYOYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750329611; c=relaxed/simple;
	bh=ugDRN2x10YRUu7yJ3Xv0tcTzCM9pNqJCt+mp//K4NQM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BatXeakCUKSkNnAVo2VOYFGbcTRd9j9E+Pae5VFkQYWX/X4n107ejE/VdT2yyy0PqyfjgMvoCLFrpzOpviKcCdXgTCpfhgsUD8b0Bj6CMykLSyeVJql+DloM3ZKS/hyfImKD+OewFsVCeSLpfPSlikt7iJA8OruAUMVBoGCBfoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x1Bnezjy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OnuHvKUC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 19 Jun 2025 10:40:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750329601;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wO6lkOqXYmlkMYZiigBKuVzVL6Q4+sfc0E72XkHdKU0=;
	b=x1Bnezjy8M9U/JJq3NU8YHbiK7kWzBhf2K604fTX9vw7l/7x1YYeMWn5tBHNSxDXYf8mqu
	gq5OAliyUbL9kBqMICjsSNFFyologgvbXnrFeLbWhfCu8ZmaiktZjzgjLXk8D6eOU6Vcfc
	epIVVygwZcrHezIeAMdlWsF7GnkV3ylyWrAwP+07djNUa4jWhrj3kSv6q6bVU724fSs/vV
	v/vlWE+UniJZZwqBM7fJ+Afsp1ypfMc5J4x78jSlkeMfkUuA5+j/USHqafZH3EqEQJur5i
	icGEF7eIltyPuSiCeOoNc8RTOnQk19D2BdFEdALE/QeA9jeEcauAw29N7Jf1AA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750329601;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wO6lkOqXYmlkMYZiigBKuVzVL6Q4+sfc0E72XkHdKU0=;
	b=OnuHvKUCCVyOzYEm4Y8ONgNhR3dNnqbNt/mPZt0m1trV6lAIcmVhvLdmfCFHiVI03xLA2S
	bSZ95errohkum9BQ==
From: "tip-bot2 for Alexey Kardashevskiy" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/sev] virt: sev-guest: Contain snp_guest_request_ioctl in sev-guest
Cc: Alexey Kardashevskiy <aik@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Tom Lendacky <thomas.lendacky@amd.com>, Dionna Glaze <dionnaglaze@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250611040842.2667262-2-aik@amd.com>
References: <20250611040842.2667262-2-aik@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175032960001.406.17045623951297790051.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     3f83ab6f9f1db9e8f0141c0c6b974f40b4aa0dcf
Gitweb:        https://git.kernel.org/tip/3f83ab6f9f1db9e8f0141c0c6b974f40b4aa0dcf
Author:        Alexey Kardashevskiy <aik@amd.com>
AuthorDate:    Wed, 11 Jun 2025 14:08:39 +10:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 18 Jun 2025 22:55:30 +02:00

virt: sev-guest: Contain snp_guest_request_ioctl in sev-guest

SNP Guest Request uses only exitinfo2 which is a return value from GHCB, has
meaning beyond ioctl and therefore belongs to struct snp_guest_req.

Move exitinfo2 there and remove snp_guest_request_ioctl from the SEV platform
code.

No functional change intended.

Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Dionna Glaze <dionnaglaze@google.com>
Link: https://lore.kernel.org/20250611040842.2667262-2-aik@amd.com
---
 arch/x86/coco/sev/core.c                | 36 ++++++++----------------
 arch/x86/include/asm/sev.h              | 10 ++-----
 drivers/virt/coco/sev-guest/sev-guest.c |  9 ++++--
 3 files changed, 23 insertions(+), 32 deletions(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index b6db4e0..cf91cb4 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -1389,8 +1389,7 @@ int snp_issue_svsm_attest_req(u64 call_id, struct svsm_call *call,
 }
 EXPORT_SYMBOL_GPL(snp_issue_svsm_attest_req);
 
-static int snp_issue_guest_request(struct snp_guest_req *req, struct snp_req_data *input,
-				   struct snp_guest_request_ioctl *rio)
+static int snp_issue_guest_request(struct snp_guest_req *req, struct snp_req_data *input)
 {
 	struct ghcb_state state;
 	struct es_em_ctxt ctxt;
@@ -1398,7 +1397,7 @@ static int snp_issue_guest_request(struct snp_guest_req *req, struct snp_req_dat
 	struct ghcb *ghcb;
 	int ret;
 
-	rio->exitinfo2 = SEV_RET_NO_FW_CALL;
+	req->exitinfo2 = SEV_RET_NO_FW_CALL;
 
 	/*
 	 * __sev_get_ghcb() needs to run with IRQs disabled because it is using
@@ -1423,8 +1422,8 @@ static int snp_issue_guest_request(struct snp_guest_req *req, struct snp_req_dat
 	if (ret)
 		goto e_put;
 
-	rio->exitinfo2 = ghcb->save.sw_exit_info_2;
-	switch (rio->exitinfo2) {
+	req->exitinfo2 = ghcb->save.sw_exit_info_2;
+	switch (req->exitinfo2) {
 	case 0:
 		break;
 
@@ -1919,8 +1918,7 @@ static int enc_payload(struct snp_msg_desc *mdesc, u64 seqno, struct snp_guest_r
 	return 0;
 }
 
-static int __handle_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_req *req,
-				  struct snp_guest_request_ioctl *rio)
+static int __handle_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_req *req)
 {
 	unsigned long req_start = jiffies;
 	unsigned int override_npages = 0;
@@ -1934,7 +1932,7 @@ retry_request:
 	 * sequence number must be incremented or the VMPCK must be deleted to
 	 * prevent reuse of the IV.
 	 */
-	rc = snp_issue_guest_request(req, &req->input, rio);
+	rc = snp_issue_guest_request(req, &req->input);
 	switch (rc) {
 	case -ENOSPC:
 		/*
@@ -1987,7 +1985,7 @@ retry_request:
 	snp_inc_msg_seqno(mdesc);
 
 	if (override_err) {
-		rio->exitinfo2 = override_err;
+		req->exitinfo2 = override_err;
 
 		/*
 		 * If an extended guest request was issued and the supplied certificate
@@ -2005,8 +2003,7 @@ retry_request:
 	return rc;
 }
 
-int snp_send_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_req *req,
-			   struct snp_guest_request_ioctl *rio)
+int snp_send_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_req *req)
 {
 	u64 seqno;
 	int rc;
@@ -2043,14 +2040,14 @@ int snp_send_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_req *req
 	req->input.resp_gpa = __pa(mdesc->response);
 	req->input.data_gpa = req->certs_data ? __pa(req->certs_data) : 0;
 
-	rc = __handle_guest_request(mdesc, req, rio);
+	rc = __handle_guest_request(mdesc, req);
 	if (rc) {
 		if (rc == -EIO &&
-		    rio->exitinfo2 == SNP_GUEST_VMM_ERR(SNP_GUEST_VMM_ERR_INVALID_LEN))
+		    req->exitinfo2 == SNP_GUEST_VMM_ERR(SNP_GUEST_VMM_ERR_INVALID_LEN))
 			return rc;
 
 		pr_alert("Detected error from ASP request. rc: %d, exitinfo2: 0x%llx\n",
-			 rc, rio->exitinfo2);
+			 rc, req->exitinfo2);
 
 		snp_disable_vmpck(mdesc);
 		return rc;
@@ -2069,7 +2066,6 @@ EXPORT_SYMBOL_GPL(snp_send_guest_request);
 
 static int __init snp_get_tsc_info(void)
 {
-	struct snp_guest_request_ioctl *rio;
 	struct snp_tsc_info_resp *tsc_resp;
 	struct snp_tsc_info_req *tsc_req;
 	struct snp_msg_desc *mdesc;
@@ -2093,13 +2089,9 @@ static int __init snp_get_tsc_info(void)
 	if (!req)
 		goto e_free_tsc_resp;
 
-	rio = kzalloc(sizeof(*rio), GFP_KERNEL);
-	if (!rio)
-		goto e_free_req;
-
 	mdesc = snp_msg_alloc();
 	if (IS_ERR_OR_NULL(mdesc))
-		goto e_free_rio;
+		goto e_free_req;
 
 	rc = snp_msg_init(mdesc, snp_vmpl);
 	if (rc)
@@ -2114,7 +2106,7 @@ static int __init snp_get_tsc_info(void)
 	req->resp_sz = sizeof(*tsc_resp) + AUTHTAG_LEN;
 	req->exit_code = SVM_VMGEXIT_GUEST_REQUEST;
 
-	rc = snp_send_guest_request(mdesc, req, rio);
+	rc = snp_send_guest_request(mdesc, req);
 	if (rc)
 		goto e_request;
 
@@ -2135,8 +2127,6 @@ e_request:
 	memzero_explicit(tsc_resp, sizeof(*tsc_resp) + AUTHTAG_LEN);
 e_free_mdesc:
 	snp_msg_free(mdesc);
-e_free_rio:
-	kfree(rio);
 e_free_req:
 	kfree(req);
  e_free_tsc_resp:
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 58e028d..fbb616f 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -231,6 +231,7 @@ struct snp_guest_req {
 	size_t resp_sz;
 
 	u64 exit_code;
+	u64 exitinfo2;
 	unsigned int vmpck_id;
 	u8 msg_version;
 	u8 msg_type;
@@ -486,8 +487,6 @@ static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool validate)
 	return rc;
 }
 
-struct snp_guest_request_ioctl;
-
 void setup_ghcb(void);
 void early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr,
 				  unsigned long npages);
@@ -513,8 +512,7 @@ void snp_kexec_begin(void);
 int snp_msg_init(struct snp_msg_desc *mdesc, int vmpck_id);
 struct snp_msg_desc *snp_msg_alloc(void);
 void snp_msg_free(struct snp_msg_desc *mdesc);
-int snp_send_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_req *req,
-			   struct snp_guest_request_ioctl *rio);
+int snp_send_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_req *req);
 
 int snp_svsm_vtpm_send_command(u8 *buffer);
 
@@ -587,8 +585,8 @@ static inline void snp_kexec_begin(void) { }
 static inline int snp_msg_init(struct snp_msg_desc *mdesc, int vmpck_id) { return -1; }
 static inline struct snp_msg_desc *snp_msg_alloc(void) { return NULL; }
 static inline void snp_msg_free(struct snp_msg_desc *mdesc) { }
-static inline int snp_send_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_req *req,
-					 struct snp_guest_request_ioctl *rio) { return -ENODEV; }
+static inline int snp_send_guest_request(struct snp_msg_desc *mdesc,
+					 struct snp_guest_req *req) { return -ENODEV; }
 static inline int snp_svsm_vtpm_send_command(u8 *buffer) { return -ENODEV; }
 static inline void __init snp_secure_tsc_prepare(void) { }
 static inline void __init snp_secure_tsc_init(void) { }
diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 7a4e218..d2b3ae7 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -101,7 +101,8 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
 	req.resp_sz = resp_len;
 	req.exit_code = SVM_VMGEXIT_GUEST_REQUEST;
 
-	rc = snp_send_guest_request(mdesc, &req, arg);
+	rc = snp_send_guest_request(mdesc, &req);
+	arg->exitinfo2 = req.exitinfo2;
 	if (rc)
 		goto e_free;
 
@@ -152,7 +153,8 @@ static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_reque
 	req.resp_sz = resp_len;
 	req.exit_code = SVM_VMGEXIT_GUEST_REQUEST;
 
-	rc = snp_send_guest_request(mdesc, &req, arg);
+	rc = snp_send_guest_request(mdesc, &req);
+	arg->exitinfo2 = req.exitinfo2;
 	if (rc)
 		return rc;
 
@@ -249,7 +251,8 @@ cmd:
 	req.resp_sz = resp_len;
 	req.exit_code = SVM_VMGEXIT_EXT_GUEST_REQUEST;
 
-	ret = snp_send_guest_request(mdesc, &req, arg);
+	ret = snp_send_guest_request(mdesc, &req);
+	arg->exitinfo2 = req.exitinfo2;
 
 	/* If certs length is invalid then copy the returned length */
 	if (arg->vmm_error == SNP_GUEST_VMM_ERR_INVALID_LEN) {

