Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 521FC439B9F
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Oct 2021 18:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233980AbhJYQgw (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 25 Oct 2021 12:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233960AbhJYQgw (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 25 Oct 2021 12:36:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A7BC061745;
        Mon, 25 Oct 2021 09:34:29 -0700 (PDT)
Date:   Mon, 25 Oct 2021 16:34:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635179667;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SyoqGRuQLiPSVy3O8/AD4i/1iCllFOsnHSJylbHakJo=;
        b=C33MwLQjIQqINyL8T5ZmnNTVmnz7NsBvIkaQpmv+l3GW7B4nDxzk5uuACuGEF63phcX0Ph
        H0nQm7TSI+eEykjRiJhoje1XI9sSVajxz4L1L+T8ZM+0JMb0FzA0/B9Q1+Mq7s76wdTOkU
        K4CFYNmqAtodD2dmZykVrCMvM1ORz+abADX0IhlZ91QDHMZM9rlTUyXLdjtCZlgxvJ6397
        r4/SfBzHv6yhOUpM+bpRhSDfsaGy2oP0nseUXiZ5LhOyM29YHvEQPUsSwyHLxKMOPA7O2k
        /p+2FAetkrfMOxXg4sjy3F2jhE8IJixVRmMuwfJ80aKB73hmtd4UhoAit33g/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635179667;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SyoqGRuQLiPSVy3O8/AD4i/1iCllFOsnHSJylbHakJo=;
        b=CQ1+nVQciRiF7BnCO9ANU+hlGaCQgNuU3BG5Kx5VyVN7K5AZ6eNkAGq0FqIIvJu8iGcDtW
        Xc+enJw7oVR6VjDQ==
From:   "tip-bot2 for Tianyu Lan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Expose sev_es_ghcb_hv_call() for use by HyperV
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Borislav Petkov <bp@suse.de>,
        Michael Kelley <mikelley@microsoft.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211025122116.264793-6-ltykernel@gmail.com>
References: <20211025122116.264793-6-ltykernel@gmail.com>
MIME-Version: 1.0
Message-ID: <163517966616.626.15035578353013624242.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     007faec014cb5d26983c1f86fd08c6539b41392e
Gitweb:        https://git.kernel.org/tip/007faec014cb5d26983c1f86fd08c6539b41392e
Author:        Tianyu Lan <Tianyu.Lan@microsoft.com>
AuthorDate:    Mon, 25 Oct 2021 08:21:10 -04:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 25 Oct 2021 18:11:42 +02:00

x86/sev: Expose sev_es_ghcb_hv_call() for use by HyperV

Hyper-V needs to issue the GHCB HV call in order to read/write MSRs in
Isolation VMs. For that, expose sev_es_ghcb_hv_call().

The Hyper-V Isolation VMs are unenlightened guests and run a paravisor
at VMPL0 for communicating. GHCB pages are being allocated and set up
by that paravisor. Linux gets the GHCB page's physical address via
MSR_AMD64_SEV_ES_GHCB from the paravisor and should not change it.

Add a @set_ghcb_msr parameter to sev_es_ghcb_hv_call() to control
whether the function should set the GHCB's address prior to the call or
not and export that function for use by HyperV.

  [ bp: - Massage commit message
        - add a struct ghcb forward declaration to fix randconfig builds. ]

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Link: https://lore.kernel.org/r/20211025122116.264793-6-ltykernel@gmail.com
---
 arch/x86/include/asm/sev.h   |  6 ++++++
 arch/x86/kernel/sev-shared.c | 25 ++++++++++++++++---------
 arch/x86/kernel/sev.c        | 13 +++++++------
 3 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index fa5cd05..ec060c4 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -53,6 +53,7 @@ static inline u64 lower_bits(u64 val, unsigned int bits)
 
 struct real_mode_header;
 enum stack_type;
+struct ghcb;
 
 /* Early IDT entry points for #VC handler */
 extern void vc_no_ghcb(void);
@@ -81,6 +82,11 @@ static __always_inline void sev_es_nmi_complete(void)
 		__sev_es_nmi_complete();
 }
 extern int __init sev_es_efi_map_ghcbs(pgd_t *pgd);
+extern enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
+					  bool set_ghcb_msr,
+					  struct es_em_ctxt *ctxt,
+					  u64 exit_code, u64 exit_info_1,
+					  u64 exit_info_2);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 4579c38..0aacd60 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -125,10 +125,9 @@ static enum es_result verify_exception_info(struct ghcb *ghcb, struct es_em_ctxt
 	return ES_VMM_ERROR;
 }
 
-static enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
-					  struct es_em_ctxt *ctxt,
-					  u64 exit_code, u64 exit_info_1,
-					  u64 exit_info_2)
+enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb, bool set_ghcb_msr,
+				   struct es_em_ctxt *ctxt, u64 exit_code,
+				   u64 exit_info_1, u64 exit_info_2)
 {
 	/* Fill in protocol and format specifiers */
 	ghcb->protocol_version = GHCB_PROTOCOL_MAX;
@@ -138,7 +137,14 @@ static enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
 	ghcb_set_sw_exit_info_1(ghcb, exit_info_1);
 	ghcb_set_sw_exit_info_2(ghcb, exit_info_2);
 
-	sev_es_wr_ghcb_msr(__pa(ghcb));
+	/*
+	 * Hyper-V unenlightened guests use a paravisor for communicating and
+	 * GHCB pages are being allocated and set up by that paravisor. Linux
+	 * should not change the GHCB page's physical address.
+	 */
+	if (set_ghcb_msr)
+		sev_es_wr_ghcb_msr(__pa(ghcb));
+
 	VMGEXIT();
 
 	return verify_exception_info(ghcb, ctxt);
@@ -418,7 +424,7 @@ static enum es_result vc_handle_ioio(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
 		 */
 		sw_scratch = __pa(ghcb) + offsetof(struct ghcb, shared_buffer);
 		ghcb_set_sw_scratch(ghcb, sw_scratch);
-		ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_IOIO,
+		ret = sev_es_ghcb_hv_call(ghcb, true, ctxt, SVM_EXIT_IOIO,
 					  exit_info_1, exit_info_2);
 		if (ret != ES_OK)
 			return ret;
@@ -460,7 +466,8 @@ static enum es_result vc_handle_ioio(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
 
 		ghcb_set_rax(ghcb, rax);
 
-		ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_IOIO, exit_info_1, 0);
+		ret = sev_es_ghcb_hv_call(ghcb, true, ctxt,
+					  SVM_EXIT_IOIO, exit_info_1, 0);
 		if (ret != ES_OK)
 			return ret;
 
@@ -491,7 +498,7 @@ static enum es_result vc_handle_cpuid(struct ghcb *ghcb,
 		/* xgetbv will cause #GP - use reset value for xcr0 */
 		ghcb_set_xcr0(ghcb, 1);
 
-	ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_CPUID, 0, 0);
+	ret = sev_es_ghcb_hv_call(ghcb, true, ctxt, SVM_EXIT_CPUID, 0, 0);
 	if (ret != ES_OK)
 		return ret;
 
@@ -516,7 +523,7 @@ static enum es_result vc_handle_rdtsc(struct ghcb *ghcb,
 	bool rdtscp = (exit_code == SVM_EXIT_RDTSCP);
 	enum es_result ret;
 
-	ret = sev_es_ghcb_hv_call(ghcb, ctxt, exit_code, 0, 0);
+	ret = sev_es_ghcb_hv_call(ghcb, true, ctxt, exit_code, 0, 0);
 	if (ret != ES_OK)
 		return ret;
 
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 2de1f36..113d3ae 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -648,7 +648,8 @@ static enum es_result vc_handle_msr(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
 		ghcb_set_rdx(ghcb, regs->dx);
 	}
 
-	ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_MSR, exit_info_1, 0);
+	ret = sev_es_ghcb_hv_call(ghcb, true, ctxt, SVM_EXIT_MSR,
+				  exit_info_1, 0);
 
 	if ((ret == ES_OK) && (!exit_info_1)) {
 		regs->ax = ghcb->save.rax;
@@ -867,7 +868,7 @@ static enum es_result vc_do_mmio(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
 
 	ghcb_set_sw_scratch(ghcb, ghcb_pa + offsetof(struct ghcb, shared_buffer));
 
-	return sev_es_ghcb_hv_call(ghcb, ctxt, exit_code, exit_info_1, exit_info_2);
+	return sev_es_ghcb_hv_call(ghcb, true, ctxt, exit_code, exit_info_1, exit_info_2);
 }
 
 static enum es_result vc_handle_mmio_twobyte_ops(struct ghcb *ghcb,
@@ -1117,7 +1118,7 @@ static enum es_result vc_handle_dr7_write(struct ghcb *ghcb,
 
 	/* Using a value of 0 for ExitInfo1 means RAX holds the value */
 	ghcb_set_rax(ghcb, val);
-	ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_WRITE_DR7, 0, 0);
+	ret = sev_es_ghcb_hv_call(ghcb, true, ctxt, SVM_EXIT_WRITE_DR7, 0, 0);
 	if (ret != ES_OK)
 		return ret;
 
@@ -1147,7 +1148,7 @@ static enum es_result vc_handle_dr7_read(struct ghcb *ghcb,
 static enum es_result vc_handle_wbinvd(struct ghcb *ghcb,
 				       struct es_em_ctxt *ctxt)
 {
-	return sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_WBINVD, 0, 0);
+	return sev_es_ghcb_hv_call(ghcb, true, ctxt, SVM_EXIT_WBINVD, 0, 0);
 }
 
 static enum es_result vc_handle_rdpmc(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
@@ -1156,7 +1157,7 @@ static enum es_result vc_handle_rdpmc(struct ghcb *ghcb, struct es_em_ctxt *ctxt
 
 	ghcb_set_rcx(ghcb, ctxt->regs->cx);
 
-	ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_RDPMC, 0, 0);
+	ret = sev_es_ghcb_hv_call(ghcb, true, ctxt, SVM_EXIT_RDPMC, 0, 0);
 	if (ret != ES_OK)
 		return ret;
 
@@ -1197,7 +1198,7 @@ static enum es_result vc_handle_vmmcall(struct ghcb *ghcb,
 	if (x86_platform.hyper.sev_es_hcall_prepare)
 		x86_platform.hyper.sev_es_hcall_prepare(ghcb, ctxt->regs);
 
-	ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_VMMCALL, 0, 0);
+	ret = sev_es_ghcb_hv_call(ghcb, true, ctxt, SVM_EXIT_VMMCALL, 0, 0);
 	if (ret != ES_OK)
 		return ret;
 
