Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 835DB377E6C
	for <lists+linux-tip-commits@lfdr.de>; Mon, 10 May 2021 10:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbhEJIoP (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 10 May 2021 04:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbhEJIoN (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 10 May 2021 04:44:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F59C061573;
        Mon, 10 May 2021 01:43:05 -0700 (PDT)
Date:   Mon, 10 May 2021 08:43:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620636183;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nX77JefN6pjusDrvzlaQMocUYj2poaB49FmqK1uMjNk=;
        b=ASqC3DofhhYQZRQxMoHvCKNTgViNR3V1R9D0L9UU1hVa97NdLKvVbCvvqypekfvnvYHqzi
        Q5xYUp00GJSthW9SETyK+sWooP6Uf3uSTJjqQp/NRNxnwZz5KC28HqDUI2UXJyFWuBchSl
        WzilKfqmGXFMohh4rn2jq3iebSc/TRXAuqDdBaxHPIkGLvm5k1b+TLDYt07+9mgHHT8051
        aSql6n6/dIJDoq8nW4RRv9GUWmUfirNCMuX/2fIi0d20ExJlWbFC+zSJQ2k4V6flIshngf
        56Pm8/fb3o1bsh8IkrK3Cv2FBadoo1/M3461v3J5p3rkVkcOTsap16qUlUsYuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620636183;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nX77JefN6pjusDrvzlaQMocUYj2poaB49FmqK1uMjNk=;
        b=O8kyuGT3pqZjX/mv3dmzoPiwu2MFnaHLCTBTuS11GwkALkFEfxo0pMd9bKyEJTvkr5e4t9
        duCnqwTzVcYCKBCQ==
From:   "tip-bot2 for Brijesh Singh" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/sev: Move GHCB MSR protocol and NAE definitions
 in a common header
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Borislav Petkov <bp@suse.de>, Joerg Roedel <jroedel@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210427111636.1207-3-brijesh.singh@amd.com>
References: <20210427111636.1207-3-brijesh.singh@amd.com>
MIME-Version: 1.0
Message-ID: <162063618241.29796.10058735199294707708.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     b81fc74d53d1248de6db3136dd6b29e5d5528021
Gitweb:        https://git.kernel.org/tip/b81fc74d53d1248de6db3136dd6b29e5d5528021
Author:        Brijesh Singh <brijesh.singh@amd.com>
AuthorDate:    Tue, 27 Apr 2021 06:16:35 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 10 May 2021 07:46:39 +02:00

x86/sev: Move GHCB MSR protocol and NAE definitions in a common header

The guest and the hypervisor contain separate macros to get and set
the GHCB MSR protocol and NAE event fields. Consolidate the GHCB
protocol definitions and helper macros in one place.

Leave the supported protocol version define in separate files to keep
the guest and hypervisor flexibility to support different GHCB version
in the same release.

There is no functional change intended.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Joerg Roedel <jroedel@suse.de>
Link: https://lkml.kernel.org/r/20210427111636.1207-3-brijesh.singh@amd.com
---
 arch/x86/include/asm/sev-common.h | 62 ++++++++++++++++++++++++++++++-
 arch/x86/include/asm/sev.h        | 30 ++-------------
 arch/x86/kernel/sev-shared.c      | 20 +++++-----
 arch/x86/kvm/svm/svm.h            | 38 +-----------------
 4 files changed, 80 insertions(+), 70 deletions(-)
 create mode 100644 arch/x86/include/asm/sev-common.h

diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
new file mode 100644
index 0000000..629c3df
--- /dev/null
+++ b/arch/x86/include/asm/sev-common.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * AMD SEV header common between the guest and the hypervisor.
+ *
+ * Author: Brijesh Singh <brijesh.singh@amd.com>
+ */
+
+#ifndef __ASM_X86_SEV_COMMON_H
+#define __ASM_X86_SEV_COMMON_H
+
+#define GHCB_MSR_INFO_POS		0
+#define GHCB_MSR_INFO_MASK		(BIT_ULL(12) - 1)
+
+#define GHCB_MSR_SEV_INFO_RESP		0x001
+#define GHCB_MSR_SEV_INFO_REQ		0x002
+#define GHCB_MSR_VER_MAX_POS		48
+#define GHCB_MSR_VER_MAX_MASK		0xffff
+#define GHCB_MSR_VER_MIN_POS		32
+#define GHCB_MSR_VER_MIN_MASK		0xffff
+#define GHCB_MSR_CBIT_POS		24
+#define GHCB_MSR_CBIT_MASK		0xff
+#define GHCB_MSR_SEV_INFO(_max, _min, _cbit)				\
+	((((_max) & GHCB_MSR_VER_MAX_MASK) << GHCB_MSR_VER_MAX_POS) |	\
+	 (((_min) & GHCB_MSR_VER_MIN_MASK) << GHCB_MSR_VER_MIN_POS) |	\
+	 (((_cbit) & GHCB_MSR_CBIT_MASK) << GHCB_MSR_CBIT_POS) |	\
+	 GHCB_MSR_SEV_INFO_RESP)
+#define GHCB_MSR_INFO(v)		((v) & 0xfffUL)
+#define GHCB_MSR_PROTO_MAX(v)		(((v) >> GHCB_MSR_VER_MAX_POS) & GHCB_MSR_VER_MAX_MASK)
+#define GHCB_MSR_PROTO_MIN(v)		(((v) >> GHCB_MSR_VER_MIN_POS) & GHCB_MSR_VER_MIN_MASK)
+
+#define GHCB_MSR_CPUID_REQ		0x004
+#define GHCB_MSR_CPUID_RESP		0x005
+#define GHCB_MSR_CPUID_FUNC_POS		32
+#define GHCB_MSR_CPUID_FUNC_MASK	0xffffffff
+#define GHCB_MSR_CPUID_VALUE_POS	32
+#define GHCB_MSR_CPUID_VALUE_MASK	0xffffffff
+#define GHCB_MSR_CPUID_REG_POS		30
+#define GHCB_MSR_CPUID_REG_MASK		0x3
+#define GHCB_CPUID_REQ_EAX		0
+#define GHCB_CPUID_REQ_EBX		1
+#define GHCB_CPUID_REQ_ECX		2
+#define GHCB_CPUID_REQ_EDX		3
+#define GHCB_CPUID_REQ(fn, reg)		\
+		(GHCB_MSR_CPUID_REQ | \
+		(((unsigned long)reg & GHCB_MSR_CPUID_REG_MASK) << GHCB_MSR_CPUID_REG_POS) | \
+		(((unsigned long)fn) << GHCB_MSR_CPUID_FUNC_POS))
+
+#define GHCB_MSR_TERM_REQ		0x100
+#define GHCB_MSR_TERM_REASON_SET_POS	12
+#define GHCB_MSR_TERM_REASON_SET_MASK	0xf
+#define GHCB_MSR_TERM_REASON_POS	16
+#define GHCB_MSR_TERM_REASON_MASK	0xff
+#define GHCB_SEV_TERM_REASON(reason_set, reason_val)						  \
+	(((((u64)reason_set) &  GHCB_MSR_TERM_REASON_SET_MASK) << GHCB_MSR_TERM_REASON_SET_POS) | \
+	((((u64)reason_val) & GHCB_MSR_TERM_REASON_MASK) << GHCB_MSR_TERM_REASON_POS))
+
+#define GHCB_SEV_ES_REASON_GENERAL_REQUEST	0
+#define GHCB_SEV_ES_REASON_PROTOCOL_UNSUPPORTED	1
+
+#define GHCB_RESP_CODE(v)		((v) & GHCB_MSR_INFO_MASK)
+
+#endif
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index cf1d957..fa5cd05 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -10,34 +10,12 @@
 
 #include <linux/types.h>
 #include <asm/insn.h>
+#include <asm/sev-common.h>
 
-#define GHCB_SEV_INFO		0x001UL
-#define GHCB_SEV_INFO_REQ	0x002UL
-#define		GHCB_INFO(v)		((v) & 0xfffUL)
-#define		GHCB_PROTO_MAX(v)	(((v) >> 48) & 0xffffUL)
-#define		GHCB_PROTO_MIN(v)	(((v) >> 32) & 0xffffUL)
-#define		GHCB_PROTO_OUR		0x0001UL
-#define GHCB_SEV_CPUID_REQ	0x004UL
-#define		GHCB_CPUID_REQ_EAX	0
-#define		GHCB_CPUID_REQ_EBX	1
-#define		GHCB_CPUID_REQ_ECX	2
-#define		GHCB_CPUID_REQ_EDX	3
-#define		GHCB_CPUID_REQ(fn, reg) (GHCB_SEV_CPUID_REQ | \
-					(((unsigned long)reg & 3) << 30) | \
-					(((unsigned long)fn) << 32))
+#define GHCB_PROTO_OUR		0x0001UL
+#define GHCB_PROTOCOL_MAX	1ULL
+#define GHCB_DEFAULT_USAGE	0ULL
 
-#define	GHCB_PROTOCOL_MAX	0x0001UL
-#define GHCB_DEFAULT_USAGE	0x0000UL
-
-#define GHCB_SEV_CPUID_RESP	0x005UL
-#define GHCB_SEV_TERMINATE	0x100UL
-#define		GHCB_SEV_TERMINATE_REASON(reason_set, reason_val)	\
-			(((((u64)reason_set) &  0x7) << 12) |		\
-			 ((((u64)reason_val) & 0xff) << 16))
-#define		GHCB_SEV_ES_REASON_GENERAL_REQUEST	0
-#define		GHCB_SEV_ES_REASON_PROTOCOL_UNSUPPORTED	1
-
-#define	GHCB_SEV_GHCB_RESP_CODE(v)	((v) & 0xfff)
 #define	VMGEXIT()			{ asm volatile("rep; vmmcall\n\r"); }
 
 enum es_result {
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 0aa9f13..6ec8b3b 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -26,13 +26,13 @@ static bool __init sev_es_check_cpu_features(void)
 
 static void __noreturn sev_es_terminate(unsigned int reason)
 {
-	u64 val = GHCB_SEV_TERMINATE;
+	u64 val = GHCB_MSR_TERM_REQ;
 
 	/*
 	 * Tell the hypervisor what went wrong - only reason-set 0 is
 	 * currently supported.
 	 */
-	val |= GHCB_SEV_TERMINATE_REASON(0, reason);
+	val |= GHCB_SEV_TERM_REASON(0, reason);
 
 	/* Request Guest Termination from Hypvervisor */
 	sev_es_wr_ghcb_msr(val);
@@ -47,15 +47,15 @@ static bool sev_es_negotiate_protocol(void)
 	u64 val;
 
 	/* Do the GHCB protocol version negotiation */
-	sev_es_wr_ghcb_msr(GHCB_SEV_INFO_REQ);
+	sev_es_wr_ghcb_msr(GHCB_MSR_SEV_INFO_REQ);
 	VMGEXIT();
 	val = sev_es_rd_ghcb_msr();
 
-	if (GHCB_INFO(val) != GHCB_SEV_INFO)
+	if (GHCB_MSR_INFO(val) != GHCB_MSR_SEV_INFO_RESP)
 		return false;
 
-	if (GHCB_PROTO_MAX(val) < GHCB_PROTO_OUR ||
-	    GHCB_PROTO_MIN(val) > GHCB_PROTO_OUR)
+	if (GHCB_MSR_PROTO_MAX(val) < GHCB_PROTO_OUR ||
+	    GHCB_MSR_PROTO_MIN(val) > GHCB_PROTO_OUR)
 		return false;
 
 	return true;
@@ -153,28 +153,28 @@ void __init do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
 	sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(fn, GHCB_CPUID_REQ_EAX));
 	VMGEXIT();
 	val = sev_es_rd_ghcb_msr();
-	if (GHCB_SEV_GHCB_RESP_CODE(val) != GHCB_SEV_CPUID_RESP)
+	if (GHCB_RESP_CODE(val) != GHCB_MSR_CPUID_RESP)
 		goto fail;
 	regs->ax = val >> 32;
 
 	sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(fn, GHCB_CPUID_REQ_EBX));
 	VMGEXIT();
 	val = sev_es_rd_ghcb_msr();
-	if (GHCB_SEV_GHCB_RESP_CODE(val) != GHCB_SEV_CPUID_RESP)
+	if (GHCB_RESP_CODE(val) != GHCB_MSR_CPUID_RESP)
 		goto fail;
 	regs->bx = val >> 32;
 
 	sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(fn, GHCB_CPUID_REQ_ECX));
 	VMGEXIT();
 	val = sev_es_rd_ghcb_msr();
-	if (GHCB_SEV_GHCB_RESP_CODE(val) != GHCB_SEV_CPUID_RESP)
+	if (GHCB_RESP_CODE(val) != GHCB_MSR_CPUID_RESP)
 		goto fail;
 	regs->cx = val >> 32;
 
 	sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(fn, GHCB_CPUID_REQ_EDX));
 	VMGEXIT();
 	val = sev_es_rd_ghcb_msr();
-	if (GHCB_SEV_GHCB_RESP_CODE(val) != GHCB_SEV_CPUID_RESP)
+	if (GHCB_RESP_CODE(val) != GHCB_MSR_CPUID_RESP)
 		goto fail;
 	regs->dx = val >> 32;
 
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 84b3133..42f8a7b 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -20,6 +20,7 @@
 #include <linux/bits.h>
 
 #include <asm/svm.h>
+#include <asm/sev-common.h>
 
 #define __sme_page_pa(x) __sme_set(page_to_pfn(x) << PAGE_SHIFT)
 
@@ -525,40 +526,9 @@ void svm_vcpu_unblocking(struct kvm_vcpu *vcpu);
 
 /* sev.c */
 
-#define GHCB_VERSION_MAX		1ULL
-#define GHCB_VERSION_MIN		1ULL
-
-#define GHCB_MSR_INFO_POS		0
-#define GHCB_MSR_INFO_MASK		(BIT_ULL(12) - 1)
-
-#define GHCB_MSR_SEV_INFO_RESP		0x001
-#define GHCB_MSR_SEV_INFO_REQ		0x002
-#define GHCB_MSR_VER_MAX_POS		48
-#define GHCB_MSR_VER_MAX_MASK		0xffff
-#define GHCB_MSR_VER_MIN_POS		32
-#define GHCB_MSR_VER_MIN_MASK		0xffff
-#define GHCB_MSR_CBIT_POS		24
-#define GHCB_MSR_CBIT_MASK		0xff
-#define GHCB_MSR_SEV_INFO(_max, _min, _cbit)				\
-	((((_max) & GHCB_MSR_VER_MAX_MASK) << GHCB_MSR_VER_MAX_POS) |	\
-	 (((_min) & GHCB_MSR_VER_MIN_MASK) << GHCB_MSR_VER_MIN_POS) |	\
-	 (((_cbit) & GHCB_MSR_CBIT_MASK) << GHCB_MSR_CBIT_POS) |	\
-	 GHCB_MSR_SEV_INFO_RESP)
-
-#define GHCB_MSR_CPUID_REQ		0x004
-#define GHCB_MSR_CPUID_RESP		0x005
-#define GHCB_MSR_CPUID_FUNC_POS		32
-#define GHCB_MSR_CPUID_FUNC_MASK	0xffffffff
-#define GHCB_MSR_CPUID_VALUE_POS	32
-#define GHCB_MSR_CPUID_VALUE_MASK	0xffffffff
-#define GHCB_MSR_CPUID_REG_POS		30
-#define GHCB_MSR_CPUID_REG_MASK		0x3
-
-#define GHCB_MSR_TERM_REQ		0x100
-#define GHCB_MSR_TERM_REASON_SET_POS	12
-#define GHCB_MSR_TERM_REASON_SET_MASK	0xf
-#define GHCB_MSR_TERM_REASON_POS	16
-#define GHCB_MSR_TERM_REASON_MASK	0xff
+#define GHCB_VERSION_MAX	1ULL
+#define GHCB_VERSION_MIN	1ULL
+
 
 extern unsigned int max_sev_asid;
 
