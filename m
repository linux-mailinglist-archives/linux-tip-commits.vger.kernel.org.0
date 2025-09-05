Return-Path: <linux-tip-commits+bounces-6498-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 676E7B463AE
	for <lists+linux-tip-commits@lfdr.de>; Fri,  5 Sep 2025 21:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C403CA66E35
	for <lists+linux-tip-commits@lfdr.de>; Fri,  5 Sep 2025 19:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DE328AB0B;
	Fri,  5 Sep 2025 19:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pSoBXtVf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xzo2lF/u"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B24283121;
	Fri,  5 Sep 2025 19:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757100794; cv=none; b=T+By8o48iNjaiD56f6sBhncMLtqIpaA565iSEAb2elIXdK/X2OoJLOfVEgV2PdWZ/TUB017JBD60splmlutjWmiEbbwoSu/uJTtpbE69Mt/ulPTWWpdMyhH1i4J/qV8n1QU3lQBNIO4JYMxBR+ma6DjfjaABtAsioA/5IwGmPVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757100794; c=relaxed/simple;
	bh=ev2KC7ZZK+f3qP9BD5zXcfrdWRFOKWPbHzXrYxU/Cbc=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=jUXzXw752LrnX97YDQ6LGGdzhvFhmKnbaKwWOz96Z9lFY34z4yxJQr3xPblCUIMP2jYo/TMBop20rAeB5vhmZLfYLSyHVsHYQJby9fOJ+MGmyy+ZB5obA+wdwdPkoaYvd7Zr37PcVlq0Om07FJtBTvoMj9OKOWen5+eyoYzanO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pSoBXtVf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xzo2lF/u; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 05 Sep 2025 19:33:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757100790;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=lplGP9C938IELlEBa/Z7ptlveSnKAjjCsC6m1X1drqo=;
	b=pSoBXtVfaJkt5RgxPLgDhoJLhxAdf+QvAQxpHjXvP0sCyCxS7ov6HbzJxG9V5wYjHfbXiX
	S1aW3X9V/BUXc/fhX90SaK7UR1iGkTvIKzHmLX8Wsmh5y1Nljv3rII+SjuqyHGwfDo4M2X
	dHrxalidnxcudOAv4lL2Xio5xwdbsz4oNcoIH6cWDsfvQ8fZ8BgXiOcJnx/TEZF0PIVK7R
	koNjvx+5LW0M3PXXFHlX9uGsMleh8iSwACCTkTATctEPM1KDwWH20yaBzNVoJzKxrcmNp3
	/uydzuZp6oozudI/aK9N1CyXkl9xmAmFSGesdkfpndB/tAVb9zUF4THcIn/dDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757100790;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=lplGP9C938IELlEBa/Z7ptlveSnKAjjCsC6m1X1drqo=;
	b=xzo2lF/u9hVLmHJJRRqybdS4NxNY+912aJnR8BkNEPPdZIFUI2aqAj6Jds/q865JIrYfkT
	lYSmGMNyXiAWGBDg==
From: "tip-bot2 for Kai Huang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/virt/tdx: Mark memory cache state incoherent when
 making SEAMCALL
Cc: Kai Huang <kai.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Chao Gao <chao.gao@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Farrah Chen <farrah.chen@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175710078939.1920.2435501533692486043.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     10df8607bf1a22249d21859f56eeb61e9a033313
Gitweb:        https://git.kernel.org/tip/10df8607bf1a22249d21859f56eeb61e9a0=
33313
Author:        Kai Huang <kai.huang@intel.com>
AuthorDate:    Mon, 01 Sep 2025 18:09:26 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 05 Sep 2025 10:40:40 -07:00

x86/virt/tdx: Mark memory cache state incoherent when making SEAMCALL

On TDX platforms, dirty cacheline aliases with and without encryption
bits can coexist, and the cpu can flush them back to memory in random
order.  During kexec, the caches must be flushed before jumping to the
new kernel otherwise the dirty cachelines could silently corrupt the
memory used by the new kernel due to different encryption property.

A percpu boolean is used to mark whether the cache of a given CPU may be
in an incoherent state, and the kexec performs WBINVD on the CPUs with
that boolean turned on.

For TDX, only the TDX module or the TDX guests can generate dirty
cachelines of TDX private memory, i.e., they are only generated when the
kernel does a SEAMCALL.

Set that boolean when the kernel does SEAMCALL so that kexec can flush
the cache correctly.

The kernel provides both the __seamcall*() assembly functions and the
seamcall*() wrapper ones which additionally handle running out of
entropy error in a loop.  Most of the SEAMCALLs are called using the
seamcall*(), except TDH.VP.ENTER and TDH.PHYMEM.PAGE.RDMD which are
called using __seamcall*() variant directly.

To cover the two special cases, add a new __seamcall_dirty_cache()
helper which only sets the percpu boolean and calls the __seamcall*(),
and change the special cases to use the new helper.  To cover all other
SEAMCALLs, change seamcall*() to call the new helper.

For the SEAMCALLs invoked via seamcall*(), they can be made from both
task context and IRQ disabled context.  Given SEAMCALL is just a lengthy
instruction (e.g., thousands of cycles) from kernel's point of view and
preempt_{disable|enable}() is cheap compared to it, just unconditionally
disable preemption during setting the boolean and making SEAMCALL.

Signed-off-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Tested-by: Farrah Chen <farrah.chen@intel.com>
Link: https://lore.kernel.org/all/20250901160930.1785244-4-pbonzini%40redhat.=
com
---
 arch/x86/include/asm/tdx.h  | 25 ++++++++++++++++++++++++-
 arch/x86/virt/vmx/tdx/tdx.c |  4 ++--
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 57b46f0..c178360 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -102,10 +102,31 @@ u64 __seamcall_ret(u64 fn, struct tdx_module_args *args=
);
 u64 __seamcall_saved_ret(u64 fn, struct tdx_module_args *args);
 void tdx_init(void);
=20
+#include <linux/preempt.h>
 #include <asm/archrandom.h>
+#include <asm/processor.h>
=20
 typedef u64 (*sc_func_t)(u64 fn, struct tdx_module_args *args);
=20
+static __always_inline u64 __seamcall_dirty_cache(sc_func_t func, u64 fn,
+						  struct tdx_module_args *args)
+{
+	lockdep_assert_preemption_disabled();
+
+	/*
+	 * SEAMCALLs are made to the TDX module and can generate dirty
+	 * cachelines of TDX private memory.  Mark cache state incoherent
+	 * so that the cache can be flushed during kexec.
+	 *
+	 * This needs to be done before actually making the SEAMCALL,
+	 * because kexec-ing CPU could send NMI to stop remote CPUs,
+	 * in which case even disabling IRQ won't help here.
+	 */
+	this_cpu_write(cache_state_incoherent, true);
+
+	return func(fn, args);
+}
+
 static __always_inline u64 sc_retry(sc_func_t func, u64 fn,
 			   struct tdx_module_args *args)
 {
@@ -113,7 +134,9 @@ static __always_inline u64 sc_retry(sc_func_t func, u64 f=
n,
 	u64 ret;
=20
 	do {
-		ret =3D func(fn, args);
+		preempt_disable();
+		ret =3D __seamcall_dirty_cache(func, fn, args);
+		preempt_enable();
 	} while (ret =3D=3D TDX_RND_NO_ENTROPY && --retry);
=20
 	return ret;
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 8238503..2abf53e 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1268,7 +1268,7 @@ static bool paddr_is_tdx_private(unsigned long phys)
 		return false;
=20
 	/* Get page type from the TDX module */
-	sret =3D __seamcall_ret(TDH_PHYMEM_PAGE_RDMD, &args);
+	sret =3D __seamcall_dirty_cache(__seamcall_ret, TDH_PHYMEM_PAGE_RDMD, &args=
);
=20
 	/*
 	 * The SEAMCALL will not return success unless there is a
@@ -1524,7 +1524,7 @@ noinstr __flatten u64 tdh_vp_enter(struct tdx_vp *td, s=
truct tdx_module_args *ar
 {
 	args->rcx =3D tdx_tdvpr_pa(td);
=20
-	return __seamcall_saved_ret(TDH_VP_ENTER, args);
+	return __seamcall_dirty_cache(__seamcall_saved_ret, TDH_VP_ENTER, args);
 }
 EXPORT_SYMBOL_GPL(tdh_vp_enter);
=20

