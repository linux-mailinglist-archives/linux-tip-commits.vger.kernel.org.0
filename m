Return-Path: <linux-tip-commits+bounces-6289-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21884B2D90B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Aug 2025 11:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1A6E5C5FEB
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Aug 2025 09:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DDC2EA75F;
	Wed, 20 Aug 2025 09:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1Mp5h5iB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RGlucxcb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C282E9ED1;
	Wed, 20 Aug 2025 09:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755682753; cv=none; b=JbnW6ySij+4oZ1zqVbFUQ9Lh4ZH8xILXXmBOrqBNmrZ+/13UmGw/p8Y/sdGT1H/sEFrxTUuflgCy1AHTsXi4egbUtXQh3XRcj491nX30rsv03USAKJGyYGcn6CCy/XyGsCcE9SQzFeConTl+maBpKm4lY2XRx0Zrpir8VGtSXDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755682753; c=relaxed/simple;
	bh=3GjWSwZgifC/bG0jP+Sb/1O+qQz3y3fCKgk2bWRVga8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WlKmHQi1+/4fccWFsMlI/X4Qg5Cam1M4HmBybkpZZ1shQ1/ezMeyvyMEBqJqlWOkqQfgERaJaPN2C/Y/Z+HMkbhHm7oTCSuhkTYX0IM9qebXZ7Sw07diHz/UTiF8NSQK4btBS2ZKKFZFx+9l18VLg7BBrtV9GEld52xHuofnjMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1Mp5h5iB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RGlucxcb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 20 Aug 2025 09:39:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755682750;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Y1s3fSZarr/lQpu476vtHcciRfQixtuVy0iqhKe/AM=;
	b=1Mp5h5iBnjepdW2v/MJNC7+3axSLw88lLsyAlpWCzzGnrzY7aSgcml/JLSQ0jxQ5bboS7m
	MH4U4R9typsjrsw9B53ZDS4qI7E69lRDki64NJ//7FzmMeUg6g4wVYVbgoKf4db+LrVfrV
	LAGQ97tZKU2EDFueh/lHYr90ZG11f/XfYoo7nMI5/NUQ8O63HCP2USivTjFf8eVljd6gr7
	nf6uXVCIXua8S8aBcYn9br2ffE4g3wbXeCU6hrNbcIpSszJY7hAlEN2Hl1qcy/+RrXEQ6S
	ecb1g7sFDu2QUl4ZYahaTodCQOUEjyt1TmlOF5cDYPVdV5WIBjXHDhjOkOm1rQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755682750;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Y1s3fSZarr/lQpu476vtHcciRfQixtuVy0iqhKe/AM=;
	b=RGlucxcb7UCmhfUq3NVyXFmjZ6+9nkmS7lYiFP+LOmiiCk2CrTaqU1ZYTMNIEYZU4vdcjE
	9EiPHhORHgHInjAQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/hyperv: Use direct call to hypercall-page
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Michael Kelley <mhklinux@outlook.com>,
 Sean Christopherson <seanjc@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250714103441.011387946@infradead.org>
References: <20250714103441.011387946@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175568274935.1420.12939640357922910856.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     c8ed0812646e1335c80a8f204c1b92b2f9d76119
Gitweb:        https://git.kernel.org/tip/c8ed0812646e1335c80a8f204c1b92b2f9d=
76119
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Sat, 12 Apr 2025 13:55:55 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 18 Aug 2025 14:23:07 +02:00

x86/hyperv: Use direct call to hypercall-page

Instead of using an indirect call to the hypercall page, use a direct
call instead. This avoids all CFI problems, including the one where
the hypercall page doesn't have IBT on.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Acked-by: Sean Christopherson <seanjc@google.com>
Link: https://lkml.kernel.org/r/20250714103441.011387946@infradead.org
---
 arch/x86/hyperv/hv_init.c | 61 ++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 31 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 5ef1e64..e890fd3 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -17,7 +17,6 @@
 #include <asm/desc.h>
 #include <asm/e820/api.h>
 #include <asm/sev.h>
-#include <asm/ibt.h>
 #include <asm/hypervisor.h>
 #include <hyperv/hvhdk.h>
 #include <asm/mshyperv.h>
@@ -39,23 +38,41 @@
 void *hv_hypercall_pg;
=20
 #ifdef CONFIG_X86_64
+static u64 __hv_hyperfail(u64 control, u64 param1, u64 param2)
+{
+	return U64_MAX;
+}
+
+DEFINE_STATIC_CALL(__hv_hypercall, __hv_hyperfail);
+
 u64 hv_std_hypercall(u64 control, u64 param1, u64 param2)
 {
 	u64 hv_status;
=20
-	if (!hv_hypercall_pg)
-		return U64_MAX;
-
 	register u64 __r8 asm("r8") =3D param2;
-	asm volatile (CALL_NOSPEC
+	asm volatile ("call " STATIC_CALL_TRAMP_STR(__hv_hypercall)
 		      : "=3Da" (hv_status), ASM_CALL_CONSTRAINT,
 		        "+c" (control), "+d" (param1), "+r" (__r8)
-		      : THUNK_TARGET(hv_hypercall_pg)
-		      : "cc", "memory", "r9", "r10", "r11");
+		      : : "cc", "memory", "r9", "r10", "r11");
=20
 	return hv_status;
 }
+
+typedef u64 (*hv_hypercall_f)(u64 control, u64 param1, u64 param2);
+
+static inline void hv_set_hypercall_pg(void *ptr)
+{
+	hv_hypercall_pg =3D ptr;
+
+	if (!ptr)
+		ptr =3D &__hv_hyperfail;
+	static_call_update(__hv_hypercall, (hv_hypercall_f)ptr);
+}
 #else
+static inline void hv_set_hypercall_pg(void *ptr)
+{
+	hv_hypercall_pg =3D ptr;
+}
 EXPORT_SYMBOL_GPL(hv_hypercall_pg);
 #endif
=20
@@ -350,7 +367,7 @@ static int hv_suspend(void)
 	 * pointer is restored on resume.
 	 */
 	hv_hypercall_pg_saved =3D hv_hypercall_pg;
-	hv_hypercall_pg =3D NULL;
+	hv_set_hypercall_pg(NULL);
=20
 	/* Disable the hypercall page in the hypervisor */
 	rdmsrq(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
@@ -376,7 +393,7 @@ static void hv_resume(void)
 		vmalloc_to_pfn(hv_hypercall_pg_saved);
 	wrmsrq(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
=20
-	hv_hypercall_pg =3D hv_hypercall_pg_saved;
+	hv_set_hypercall_pg(hv_hypercall_pg_saved);
 	hv_hypercall_pg_saved =3D NULL;
=20
 	/*
@@ -496,8 +513,8 @@ void __init hyperv_init(void)
 	if (hv_isolation_type_tdx() && !ms_hyperv.paravisor_present)
 		goto skip_hypercall_pg_init;
=20
-	hv_hypercall_pg =3D __vmalloc_node_range(PAGE_SIZE, 1, VMALLOC_START,
-			VMALLOC_END, GFP_KERNEL, PAGE_KERNEL_ROX,
+	hv_hypercall_pg =3D __vmalloc_node_range(PAGE_SIZE, 1, MODULES_VADDR,
+			MODULES_END, GFP_KERNEL, PAGE_KERNEL_ROX,
 			VM_FLUSH_RESET_PERMS, NUMA_NO_NODE,
 			__builtin_return_address(0));
 	if (hv_hypercall_pg =3D=3D NULL)
@@ -535,27 +552,9 @@ void __init hyperv_init(void)
 		wrmsrq(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
 	}
=20
-skip_hypercall_pg_init:
-	/*
-	 * Some versions of Hyper-V that provide IBT in guest VMs have a bug
-	 * in that there's no ENDBR64 instruction at the entry to the
-	 * hypercall page. Because hypercalls are invoked via an indirect call
-	 * to the hypercall page, all hypercall attempts fail when IBT is
-	 * enabled, and Linux panics. For such buggy versions, disable IBT.
-	 *
-	 * Fixed versions of Hyper-V always provide ENDBR64 on the hypercall
-	 * page, so if future Linux kernel versions enable IBT for 32-bit
-	 * builds, additional hypercall page hackery will be required here
-	 * to provide an ENDBR32.
-	 */
-#ifdef CONFIG_X86_KERNEL_IBT
-	if (cpu_feature_enabled(X86_FEATURE_IBT) &&
-	    *(u32 *)hv_hypercall_pg !=3D gen_endbr()) {
-		setup_clear_cpu_cap(X86_FEATURE_IBT);
-		pr_warn("Disabling IBT because of Hyper-V bug\n");
-	}
-#endif
+	hv_set_hypercall_pg(hv_hypercall_pg);
=20
+skip_hypercall_pg_init:
 	/*
 	 * hyperv_init() is called before LAPIC is initialized: see
 	 * apic_intr_mode_init() -> x86_platform.apic_post_init() and

