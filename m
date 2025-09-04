Return-Path: <linux-tip-commits+bounces-6475-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2DAB439F2
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 13:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 468BE7C6134
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 11:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C0D3054CA;
	Thu,  4 Sep 2025 11:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gk4z7zYw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AQ3OVTUd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDD22FD1BA;
	Thu,  4 Sep 2025 11:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756984870; cv=none; b=e7GD2oAM+VbphCEX61bxpan80L6QDWpnBwAPoS5iglBzorydwkR/J4jHye4Ok0lKZ5kd1ueynC3xM4ah/B6PK52XP3pCIPsCfPmQ5qPzvxomqPzRbtVBJdAFkRIpNTT05+rjnyNyz4N/qfZ4rcJa+Tr+PyXDgNtsFxGPn38vxb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756984870; c=relaxed/simple;
	bh=y8Lf8twUBak1X8NvT4KeP53gKe6YTAGjiItx6pbGceU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Mp0Hj/K2fNR3C8q+5yz0kI2sIAOn+3xZYC7Bd6TbT1blbL5XxkOayOrIKswJy//J8+RGtqou/yaiBHwgB6uUCZKjQx3Yk17OOCu1jkoObpAvlxkR03v7YYizHQ0zxfHkPENSXbty/YwJo9thGFLKWD0BtdKqjUj3Q7/8rpXuc2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gk4z7zYw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AQ3OVTUd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 04 Sep 2025 11:21:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756984866;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eyUhjI0dH/jRwuGemrdj0foTVYpWgSxME60BijTxAWo=;
	b=gk4z7zYwzeFOFriWV2lUrW13KfCDrTjHRlP2+yilRSgTXg9spB/tHJsHHWbrxbM8h3+fLW
	S7r++pSGXBw2oFnSaWelXgII/pzwntlWYTT5NiSONhwdThK3ZjIrrgW6O4Tv01NDApfnfu
	lpZautnKksZX8RX5KNcVwGhjxEzV7hO++5YCwH9XgOv10QeLFe6OdKooASrAxKBGgb+tSW
	ST91ntSsZFZtxLCQi7dST2IMxs5PjytwdDqbx/YVLrVavuYgJr1GJ414m3AsudPoyFBEa+
	EQa0idf3KDSrogkPshOebCxjtntEJhcoStEApy7oB+fwqJtUyhCQNF1fmRbtNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756984866;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eyUhjI0dH/jRwuGemrdj0foTVYpWgSxME60BijTxAWo=;
	b=AQ3OVTUdF+oy3eydsrUoYWhDgD2ckgsZ9bfEi/PO2mHD5U3BR7qEwCRtGTVf8+pfHN7ZyW
	5OY2vcOM4x8FgBBA==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Move GHCB page based HV communication out of
 startup code
Cc: Ard Biesheuvel <ardb@kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250828102202.1849035-29-ardb+git@google.com>
References: <20250828102202.1849035-29-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175698486547.1920.5335430230437685059.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     37dbd78f98a80e89b5413f4649d0fbd023d99b2f
Gitweb:        https://git.kernel.org/tip/37dbd78f98a80e89b5413f4649d0fbd023d=
99b2f
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Thu, 28 Aug 2025 12:22:08 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 03 Sep 2025 17:55:25 +02:00

x86/sev: Move GHCB page based HV communication out of startup code

Both the decompressor and the core kernel implement an early #VC handler,
which only deals with CPUID instructions, and full featured one, which can
handle any #VC exception.

The former communicates with the hypervisor using the MSR based protocol,
whereas the latter uses a shared GHCB page, which is configured a bit later
during the boot, when the kernel runs from its ordinary virtual mapping,
rather than the 1:1 mapping that the startup code uses.

Accessing this shared GHCB page from the core kernel's startup code is
problematic, because it involves converting the GHCB address provided by the
caller to a physical address. In the startup code, virtual to physical address
translations are problematic, given that the virtual address might be a 1:1
mapped address, and such translations should therefore be avoided.

This means that exposing startup code dealing with the GHCB to callers that
execute from the ordinary kernel virtual mapping should be avoided too. So
move all GHCB page based communication out of the startup code, now that all
communication occurring before the kernel virtual mapping is up relies on the
MSR protocol only.

As an exception, add a flag representing the need to apply the coherency
fix in order to avoid exporting CPUID* helpers because of the code
running too early for the *cpu_has* infrastructure.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250828102202.1849035-29-ardb+git@google.com
---
 arch/x86/boot/compressed/sev-handle-vc.c |   3 +-
 arch/x86/boot/compressed/sev.c           |   2 +-
 arch/x86/boot/cpuflags.c                 |  13 +--
 arch/x86/boot/startup/sev-shared.c       | 145 +----------------------
 arch/x86/boot/startup/sev-startup.c      |  42 +------
 arch/x86/boot/startup/sme.c              |   1 +-
 arch/x86/coco/sev/core.c                 |  76 ++++++++++++-
 arch/x86/coco/sev/vc-handle.c            |   2 +-
 arch/x86/coco/sev/vc-shared.c            |  94 ++++++++++++++-
 arch/x86/include/asm/sev-internal.h      |   7 +-
 arch/x86/include/asm/sev.h               |  12 +-
 11 files changed, 196 insertions(+), 201 deletions(-)

diff --git a/arch/x86/boot/compressed/sev-handle-vc.c b/arch/x86/boot/compres=
sed/sev-handle-vc.c
index 89dd02d..7530ad8 100644
--- a/arch/x86/boot/compressed/sev-handle-vc.c
+++ b/arch/x86/boot/compressed/sev-handle-vc.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
=20
 #include "misc.h"
+#include "error.h"
 #include "sev.h"
=20
 #include <linux/kernel.h>
@@ -14,6 +15,8 @@
 #include <asm/fpu/xcr.h>
=20
 #define __BOOT_COMPRESSED
+#undef __init
+#define __init
=20
 /* Basic instruction decoding support needed */
 #include "../../lib/inat.c"
diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 3628e9b..f197173 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -371,6 +371,8 @@ static int sev_check_cpu_support(void)
 	if (!(eax & BIT(1)))
 		return -ENODEV;
=20
+	sev_snp_needs_sfw =3D !(ebx & BIT(31));
+
 	return ebx & 0x3f;
 }
=20
diff --git a/arch/x86/boot/cpuflags.c b/arch/x86/boot/cpuflags.c
index 63e037e..916bac0 100644
--- a/arch/x86/boot/cpuflags.c
+++ b/arch/x86/boot/cpuflags.c
@@ -106,18 +106,5 @@ void get_cpuflags(void)
 			cpuid(0x80000001, &ignored, &ignored, &cpu.flags[6],
 			      &cpu.flags[1]);
 		}
-
-		if (max_amd_level >=3D 0x8000001f) {
-			u32 ebx;
-
-			/*
-			 * The X86_FEATURE_COHERENCY_SFW_NO feature bit is in
-			 * the virtualization flags entry (word 8) and set by
-			 * scattered.c, so the bit needs to be explicitly set.
-			 */
-			cpuid(0x8000001f, &ignored, &ebx, &ignored, &ignored);
-			if (ebx & BIT(31))
-				set_bit(X86_FEATURE_COHERENCY_SFW_NO, cpu.flags);
-		}
 	}
 }
diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-s=
hared.c
index 83c222a..348811a 100644
--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -13,12 +13,9 @@
=20
 #ifndef __BOOT_COMPRESSED
 #define error(v)			pr_err(v)
-#define has_cpuflag(f)			boot_cpu_has(f)
 #else
 #undef WARN
 #define WARN(condition, format...) (!!(condition))
-#undef vc_forward_exception
-#define vc_forward_exception(c)		panic("SNP: Hypervisor requested exception\=
n")
 #endif
=20
 /*
@@ -39,7 +36,7 @@ u64 boot_svsm_caa_pa __ro_after_init;
  *
  * GHCB protocol version negotiated with the hypervisor.
  */
-static u16 ghcb_version __ro_after_init;
+u16 ghcb_version __ro_after_init;
=20
 /* Copy of the SNP firmware's CPUID page. */
 static struct snp_cpuid_table cpuid_table_copy __ro_after_init;
@@ -54,15 +51,7 @@ static u32 cpuid_std_range_max __ro_after_init;
 static u32 cpuid_hyp_range_max __ro_after_init;
 static u32 cpuid_ext_range_max __ro_after_init;
=20
-bool __init sev_es_check_cpu_features(void)
-{
-	if (!has_cpuflag(X86_FEATURE_RDRAND)) {
-		error("RDRAND instruction not supported - no trusted source of randomness =
available\n");
-		return false;
-	}
-
-	return true;
-}
+bool sev_snp_needs_sfw;
=20
 void __head __noreturn
 sev_es_terminate(unsigned int set, unsigned int reason)
@@ -100,72 +89,7 @@ u64 get_hv_features(void)
 	return GHCB_MSR_HV_FT_RESP_VAL(val);
 }
=20
-void snp_register_ghcb_early(unsigned long paddr)
-{
-	unsigned long pfn =3D paddr >> PAGE_SHIFT;
-	u64 val;
-
-	sev_es_wr_ghcb_msr(GHCB_MSR_REG_GPA_REQ_VAL(pfn));
-	VMGEXIT();
-
-	val =3D sev_es_rd_ghcb_msr();
-
-	/* If the response GPA is not ours then abort the guest */
-	if ((GHCB_RESP_CODE(val) !=3D GHCB_MSR_REG_GPA_RESP) ||
-	    (GHCB_MSR_REG_GPA_RESP_VAL(val) !=3D pfn))
-		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_REGISTER);
-}
-
-bool sev_es_negotiate_protocol(void)
-{
-	u64 val;
-
-	/* Do the GHCB protocol version negotiation */
-	sev_es_wr_ghcb_msr(GHCB_MSR_SEV_INFO_REQ);
-	VMGEXIT();
-	val =3D sev_es_rd_ghcb_msr();
-
-	if (GHCB_MSR_INFO(val) !=3D GHCB_MSR_SEV_INFO_RESP)
-		return false;
-
-	if (GHCB_MSR_PROTO_MAX(val) < GHCB_PROTOCOL_MIN ||
-	    GHCB_MSR_PROTO_MIN(val) > GHCB_PROTOCOL_MAX)
-		return false;
-
-	ghcb_version =3D min_t(size_t, GHCB_MSR_PROTO_MAX(val), GHCB_PROTOCOL_MAX);
-
-	return true;
-}
-
-static enum es_result verify_exception_info(struct ghcb *ghcb, struct es_em_=
ctxt *ctxt)
-{
-	u32 ret;
-
-	ret =3D ghcb->save.sw_exit_info_1 & GENMASK_ULL(31, 0);
-	if (!ret)
-		return ES_OK;
-
-	if (ret =3D=3D 1) {
-		u64 info =3D ghcb->save.sw_exit_info_2;
-		unsigned long v =3D info & SVM_EVTINJ_VEC_MASK;
-
-		/* Check if exception information from hypervisor is sane. */
-		if ((info & SVM_EVTINJ_VALID) &&
-		    ((v =3D=3D X86_TRAP_GP) || (v =3D=3D X86_TRAP_UD)) &&
-		    ((info & SVM_EVTINJ_TYPE_MASK) =3D=3D SVM_EVTINJ_TYPE_EXEPT)) {
-			ctxt->fi.vector =3D v;
-
-			if (info & SVM_EVTINJ_VALID_ERR)
-				ctxt->fi.error_code =3D info >> 32;
-
-			return ES_EXCEPTION;
-		}
-	}
-
-	return ES_VMM_ERROR;
-}
-
-static inline int svsm_process_result_codes(struct svsm_call *call)
+int svsm_process_result_codes(struct svsm_call *call)
 {
 	switch (call->rax_out) {
 	case SVSM_SUCCESS:
@@ -193,7 +117,7 @@ static inline int svsm_process_result_codes(struct svsm_c=
all *call)
  *     - RAX specifies the SVSM protocol/callid as input and the return code
  *       as output.
  */
-static __always_inline void svsm_issue_call(struct svsm_call *call, u8 *pend=
ing)
+void svsm_issue_call(struct svsm_call *call, u8 *pending)
 {
 	register unsigned long rax asm("rax") =3D call->rax;
 	register unsigned long rcx asm("rcx") =3D call->rcx;
@@ -216,7 +140,7 @@ static __always_inline void svsm_issue_call(struct svsm_c=
all *call, u8 *pending)
 	call->r9_out  =3D r9;
 }
=20
-static int svsm_perform_msr_protocol(struct svsm_call *call)
+int svsm_perform_msr_protocol(struct svsm_call *call)
 {
 	u8 pending =3D 0;
 	u64 val, resp;
@@ -247,63 +171,6 @@ static int svsm_perform_msr_protocol(struct svsm_call *c=
all)
 	return svsm_process_result_codes(call);
 }
=20
-static int svsm_perform_ghcb_protocol(struct ghcb *ghcb, struct svsm_call *c=
all)
-{
-	struct es_em_ctxt ctxt;
-	u8 pending =3D 0;
-
-	vc_ghcb_invalidate(ghcb);
-
-	/*
-	 * Fill in protocol and format specifiers. This can be called very early
-	 * in the boot, so use rip-relative references as needed.
-	 */
-	ghcb->protocol_version =3D ghcb_version;
-	ghcb->ghcb_usage       =3D GHCB_DEFAULT_USAGE;
-
-	ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_SNP_RUN_VMPL);
-	ghcb_set_sw_exit_info_1(ghcb, 0);
-	ghcb_set_sw_exit_info_2(ghcb, 0);
-
-	sev_es_wr_ghcb_msr(__pa(ghcb));
-
-	svsm_issue_call(call, &pending);
-
-	if (pending)
-		return -EINVAL;
-
-	switch (verify_exception_info(ghcb, &ctxt)) {
-	case ES_OK:
-		break;
-	case ES_EXCEPTION:
-		vc_forward_exception(&ctxt);
-		fallthrough;
-	default:
-		return -EINVAL;
-	}
-
-	return svsm_process_result_codes(call);
-}
-
-enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
-				   struct es_em_ctxt *ctxt,
-				   u64 exit_code, u64 exit_info_1,
-				   u64 exit_info_2)
-{
-	/* Fill in protocol and format specifiers */
-	ghcb->protocol_version =3D ghcb_version;
-	ghcb->ghcb_usage       =3D GHCB_DEFAULT_USAGE;
-
-	ghcb_set_sw_exit_code(ghcb, exit_code);
-	ghcb_set_sw_exit_info_1(ghcb, exit_info_1);
-	ghcb_set_sw_exit_info_2(ghcb, exit_info_2);
-
-	sev_es_wr_ghcb_msr(__pa(ghcb));
-	VMGEXIT();
-
-	return verify_exception_info(ghcb, ctxt);
-}
-
 static int __sev_cpuid_hv(u32 fn, int reg_idx, u32 *reg)
 {
 	u64 val;
@@ -793,7 +660,7 @@ static void __head pvalidate_4k_page(unsigned long vaddr,=
 unsigned long paddr,
 	 * If validating memory (making it private) and affected by the
 	 * cache-coherency vulnerability, perform the cache eviction mitigation.
 	 */
-	if (validate && !has_cpuflag(X86_FEATURE_COHERENCY_SFW_NO))
+	if (validate && sev_snp_needs_sfw)
 		sev_evict_cache((void *)vaddr, 1);
 }
=20
diff --git a/arch/x86/boot/startup/sev-startup.c b/arch/x86/boot/startup/sev-=
startup.c
index 3da04a7..fd18a00 100644
--- a/arch/x86/boot/startup/sev-startup.c
+++ b/arch/x86/boot/startup/sev-startup.c
@@ -41,15 +41,6 @@
 #include <asm/cpuid/api.h>
 #include <asm/cmdline.h>
=20
-/* For early boot hypervisor communication in SEV-ES enabled guests */
-struct ghcb boot_ghcb_page __bss_decrypted __aligned(PAGE_SIZE);
-
-/*
- * Needs to be in the .data section because we need it NULL before bss is
- * cleared
- */
-struct ghcb *boot_ghcb __section(".data");
-
 /* Bitmap of SEV features supported by the hypervisor */
 u64 sev_hv_features __ro_after_init;
=20
@@ -139,39 +130,6 @@ noinstr void __sev_put_ghcb(struct ghcb_state *state)
 	}
 }
=20
-int svsm_perform_call_protocol(struct svsm_call *call)
-{
-	struct ghcb_state state;
-	unsigned long flags;
-	struct ghcb *ghcb;
-	int ret;
-
-	/*
-	 * This can be called very early in the boot, use native functions in
-	 * order to avoid paravirt issues.
-	 */
-	flags =3D native_local_irq_save();
-
-	if (sev_cfg.ghcbs_initialized)
-		ghcb =3D __sev_get_ghcb(&state);
-	else if (boot_ghcb)
-		ghcb =3D boot_ghcb;
-	else
-		ghcb =3D NULL;
-
-	do {
-		ret =3D ghcb ? svsm_perform_ghcb_protocol(ghcb, call)
-			   : svsm_perform_msr_protocol(call);
-	} while (ret =3D=3D -EAGAIN);
-
-	if (sev_cfg.ghcbs_initialized)
-		__sev_put_ghcb(&state);
-
-	native_local_irq_restore(flags);
-
-	return ret;
-}
-
 void __head
 early_set_pages_state(unsigned long vaddr, unsigned long paddr,
 		      unsigned long npages, enum psc_op op)
diff --git a/arch/x86/boot/startup/sme.c b/arch/x86/boot/startup/sme.c
index 70ea174..bf9153b 100644
--- a/arch/x86/boot/startup/sme.c
+++ b/arch/x86/boot/startup/sme.c
@@ -521,6 +521,7 @@ void __head sme_enable(struct boot_params *bp)
 		return;
=20
 	me_mask =3D 1UL << (ebx & 0x3f);
+	sev_snp_needs_sfw =3D !(ebx & BIT(31));
=20
 	/* Check the SEV MSR whether SEV or SME is enabled */
 	sev_status =3D msr =3D native_rdmsrq(MSR_AMD64_SEV);
diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 14ef590..2a28d14 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -101,6 +101,15 @@ DEFINE_PER_CPU(struct sev_es_save_area *, sev_vmsa);
 u8 snp_vmpl __ro_after_init;
 EXPORT_SYMBOL_GPL(snp_vmpl);
=20
+/* For early boot hypervisor communication in SEV-ES enabled guests */
+static struct ghcb boot_ghcb_page __bss_decrypted __aligned(PAGE_SIZE);
+
+/*
+ * Needs to be in the .data section because we need it NULL before bss is
+ * cleared
+ */
+struct ghcb *boot_ghcb __section(".data");
+
 static u64 __init get_snp_jump_table_addr(void)
 {
 	struct snp_secrets_page *secrets;
@@ -154,6 +163,73 @@ static u64 __init get_jump_table_addr(void)
 	return ret;
 }
=20
+static int svsm_perform_ghcb_protocol(struct ghcb *ghcb, struct svsm_call *c=
all)
+{
+	struct es_em_ctxt ctxt;
+	u8 pending =3D 0;
+
+	vc_ghcb_invalidate(ghcb);
+
+	/*
+	 * Fill in protocol and format specifiers. This can be called very early
+	 * in the boot, so use rip-relative references as needed.
+	 */
+	ghcb->protocol_version =3D ghcb_version;
+	ghcb->ghcb_usage       =3D GHCB_DEFAULT_USAGE;
+
+	ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_SNP_RUN_VMPL);
+	ghcb_set_sw_exit_info_1(ghcb, 0);
+	ghcb_set_sw_exit_info_2(ghcb, 0);
+
+	sev_es_wr_ghcb_msr(__pa(ghcb));
+
+	svsm_issue_call(call, &pending);
+
+	if (pending)
+		return -EINVAL;
+
+	switch (verify_exception_info(ghcb, &ctxt)) {
+	case ES_OK:
+		break;
+	case ES_EXCEPTION:
+		vc_forward_exception(&ctxt);
+		fallthrough;
+	default:
+		return -EINVAL;
+	}
+
+	return svsm_process_result_codes(call);
+}
+
+static int svsm_perform_call_protocol(struct svsm_call *call)
+{
+	struct ghcb_state state;
+	unsigned long flags;
+	struct ghcb *ghcb;
+	int ret;
+
+	flags =3D native_local_irq_save();
+
+	if (sev_cfg.ghcbs_initialized)
+		ghcb =3D __sev_get_ghcb(&state);
+	else if (boot_ghcb)
+		ghcb =3D boot_ghcb;
+	else
+		ghcb =3D NULL;
+
+	do {
+		ret =3D ghcb ? svsm_perform_ghcb_protocol(ghcb, call)
+			   : svsm_perform_msr_protocol(call);
+	} while (ret =3D=3D -EAGAIN);
+
+	if (sev_cfg.ghcbs_initialized)
+		__sev_put_ghcb(&state);
+
+	native_local_irq_restore(flags);
+
+	return ret;
+}
+
 static inline void __pval_terminate(u64 pfn, bool action, unsigned int page_=
size,
 				    int ret, u64 svsm_ret)
 {
diff --git a/arch/x86/coco/sev/vc-handle.c b/arch/x86/coco/sev/vc-handle.c
index c3b4acb..3573894 100644
--- a/arch/x86/coco/sev/vc-handle.c
+++ b/arch/x86/coco/sev/vc-handle.c
@@ -351,6 +351,8 @@ fault:
 }
=20
 #define sev_printk(fmt, ...)		printk(fmt, ##__VA_ARGS__)
+#define error(v)
+#define has_cpuflag(f)			boot_cpu_has(f)
=20
 #include "vc-shared.c"
=20
diff --git a/arch/x86/coco/sev/vc-shared.c b/arch/x86/coco/sev/vc-shared.c
index b4688f6..9b01c9a 100644
--- a/arch/x86/coco/sev/vc-shared.c
+++ b/arch/x86/coco/sev/vc-shared.c
@@ -409,6 +409,53 @@ static enum es_result vc_handle_ioio(struct ghcb *ghcb, =
struct es_em_ctxt *ctxt)
 	return ret;
 }
=20
+enum es_result verify_exception_info(struct ghcb *ghcb, struct es_em_ctxt *c=
txt)
+{
+	u32 ret;
+
+	ret =3D ghcb->save.sw_exit_info_1 & GENMASK_ULL(31, 0);
+	if (!ret)
+		return ES_OK;
+
+	if (ret =3D=3D 1) {
+		u64 info =3D ghcb->save.sw_exit_info_2;
+		unsigned long v =3D info & SVM_EVTINJ_VEC_MASK;
+
+		/* Check if exception information from hypervisor is sane. */
+		if ((info & SVM_EVTINJ_VALID) &&
+		    ((v =3D=3D X86_TRAP_GP) || (v =3D=3D X86_TRAP_UD)) &&
+		    ((info & SVM_EVTINJ_TYPE_MASK) =3D=3D SVM_EVTINJ_TYPE_EXEPT)) {
+			ctxt->fi.vector =3D v;
+
+			if (info & SVM_EVTINJ_VALID_ERR)
+				ctxt->fi.error_code =3D info >> 32;
+
+			return ES_EXCEPTION;
+		}
+	}
+
+	return ES_VMM_ERROR;
+}
+
+enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
+				   struct es_em_ctxt *ctxt,
+				   u64 exit_code, u64 exit_info_1,
+				   u64 exit_info_2)
+{
+	/* Fill in protocol and format specifiers */
+	ghcb->protocol_version =3D ghcb_version;
+	ghcb->ghcb_usage       =3D GHCB_DEFAULT_USAGE;
+
+	ghcb_set_sw_exit_code(ghcb, exit_code);
+	ghcb_set_sw_exit_info_1(ghcb, exit_info_1);
+	ghcb_set_sw_exit_info_2(ghcb, exit_info_2);
+
+	sev_es_wr_ghcb_msr(__pa(ghcb));
+	VMGEXIT();
+
+	return verify_exception_info(ghcb, ctxt);
+}
+
 static int __sev_cpuid_hv_ghcb(struct ghcb *ghcb, struct es_em_ctxt *ctxt, s=
truct cpuid_leaf *leaf)
 {
 	u32 cr4 =3D native_read_cr4();
@@ -549,3 +596,50 @@ static enum es_result vc_handle_rdtsc(struct ghcb *ghcb,
=20
 	return ES_OK;
 }
+
+void snp_register_ghcb_early(unsigned long paddr)
+{
+	unsigned long pfn =3D paddr >> PAGE_SHIFT;
+	u64 val;
+
+	sev_es_wr_ghcb_msr(GHCB_MSR_REG_GPA_REQ_VAL(pfn));
+	VMGEXIT();
+
+	val =3D sev_es_rd_ghcb_msr();
+
+	/* If the response GPA is not ours then abort the guest */
+	if ((GHCB_RESP_CODE(val) !=3D GHCB_MSR_REG_GPA_RESP) ||
+	    (GHCB_MSR_REG_GPA_RESP_VAL(val) !=3D pfn))
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_REGISTER);
+}
+
+bool __init sev_es_check_cpu_features(void)
+{
+	if (!has_cpuflag(X86_FEATURE_RDRAND)) {
+		error("RDRAND instruction not supported - no trusted source of randomness =
available\n");
+		return false;
+	}
+
+	return true;
+}
+
+bool sev_es_negotiate_protocol(void)
+{
+	u64 val;
+
+	/* Do the GHCB protocol version negotiation */
+	sev_es_wr_ghcb_msr(GHCB_MSR_SEV_INFO_REQ);
+	VMGEXIT();
+	val =3D sev_es_rd_ghcb_msr();
+
+	if (GHCB_MSR_INFO(val) !=3D GHCB_MSR_SEV_INFO_RESP)
+		return false;
+
+	if (GHCB_MSR_PROTO_MAX(val) < GHCB_PROTOCOL_MIN ||
+	    GHCB_MSR_PROTO_MIN(val) > GHCB_PROTOCOL_MAX)
+		return false;
+
+	ghcb_version =3D min_t(size_t, GHCB_MSR_PROTO_MAX(val), GHCB_PROTOCOL_MAX);
+
+	return true;
+}
diff --git a/arch/x86/include/asm/sev-internal.h b/arch/x86/include/asm/sev-i=
nternal.h
index 3dfd306..6199b35 100644
--- a/arch/x86/include/asm/sev-internal.h
+++ b/arch/x86/include/asm/sev-internal.h
@@ -2,7 +2,6 @@
=20
 #define DR7_RESET_VALUE        0x400
=20
-extern struct ghcb boot_ghcb_page;
 extern u64 sev_hv_features;
 extern u64 sev_secrets_pa;
=20
@@ -80,7 +79,8 @@ static __always_inline u64 svsm_get_caa_pa(void)
 		return boot_svsm_caa_pa;
 }
=20
-int svsm_perform_call_protocol(struct svsm_call *call);
+enum es_result verify_exception_info(struct ghcb *ghcb, struct es_em_ctxt *c=
txt);
+void vc_forward_exception(struct es_em_ctxt *ctxt);
=20
 static inline u64 sev_es_rd_ghcb_msr(void)
 {
@@ -97,9 +97,6 @@ static __always_inline void sev_es_wr_ghcb_msr(u64 val)
 	native_wrmsr(MSR_AMD64_SEV_ES_GHCB, low, high);
 }
=20
-void snp_register_ghcb_early(unsigned long paddr);
-bool sev_es_negotiate_protocol(void);
-bool sev_es_check_cpu_features(void);
 u64 get_hv_features(void);
=20
 const struct snp_cpuid_table *snp_cpuid_get_table(void);
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index e4622e4..be9d7cb 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -503,6 +503,7 @@ static inline int pvalidate(unsigned long vaddr, bool rmp=
_psize, bool validate)
 }
=20
 void setup_ghcb(void);
+void snp_register_ghcb_early(unsigned long paddr);
 void early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr,
 				  unsigned long npages);
 void early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
@@ -540,8 +541,6 @@ static __always_inline void vc_ghcb_invalidate(struct ghc=
b *ghcb)
 	__builtin_memset(ghcb->save.valid_bitmap, 0, sizeof(ghcb->save.valid_bitmap=
));
 }
=20
-void vc_forward_exception(struct es_em_ctxt *ctxt);
-
 /* I/O parameters for CPUID-related helpers */
 struct cpuid_leaf {
 	u32 fn;
@@ -552,16 +551,25 @@ struct cpuid_leaf {
 	u32 edx;
 };
=20
+int svsm_perform_msr_protocol(struct svsm_call *call);
 int snp_cpuid(void (*cpuid_fn)(void *ctx, struct cpuid_leaf *leaf),
 	      void *ctx, struct cpuid_leaf *leaf);
=20
+void svsm_issue_call(struct svsm_call *call, u8 *pending);
+int svsm_process_result_codes(struct svsm_call *call);
+
 void __noreturn sev_es_terminate(unsigned int set, unsigned int reason);
 enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
 				   struct es_em_ctxt *ctxt,
 				   u64 exit_code, u64 exit_info_1,
 				   u64 exit_info_2);
=20
+bool sev_es_negotiate_protocol(void);
+bool sev_es_check_cpu_features(void);
+
+extern u16 ghcb_version;
 extern struct ghcb *boot_ghcb;
+extern bool sev_snp_needs_sfw;
=20
 #else	/* !CONFIG_AMD_MEM_ENCRYPT */
=20

