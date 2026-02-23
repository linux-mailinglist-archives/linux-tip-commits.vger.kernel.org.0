Return-Path: <linux-tip-commits+bounces-8229-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNjuJdYrnGmcAQQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8229-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Feb 2026 11:28:38 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C78A174E0D
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Feb 2026 11:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EAE13302BBE6
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Feb 2026 10:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4455E362153;
	Mon, 23 Feb 2026 10:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LVXWIdgC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4+6O5KL1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DCC3624A7;
	Mon, 23 Feb 2026 10:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771842331; cv=none; b=ckOj7UTxz4ILtCtZeqjP+tTcCGPd7ljueJu0J7NDpvuxaQQphmW7pfRun1A1YkK6ye6OLOvjIL7pVITrGRA37yDyKka1x3dwnI8A7GyZF4OBrBNbNm7KT5VV0RFjdzvi724Zx0v4Bjg7PzZfvzKdWlcW3MzjGA4ONS/pb47m7xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771842331; c=relaxed/simple;
	bh=6qPIo2KyLYTarwh6JORif6gHsvIYoQoU/8x8I27qFSA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BYRtfr5NbW3E/93thxyz5o35qN0kIapMv1uGkP0m++1UhLbRBzl6jwJdesHQIG7RD3pku1c379YwBR1D3EvZjx29wJKX0m40eWsiF0tDFHfb+VF9NTATYdThBIc8LzUT/QzJU1XhjH8dAUCZ+hlQ2Bcvm0sRLhtFvbrU/xA1QMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LVXWIdgC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4+6O5KL1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 23 Feb 2026 10:25:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771842328;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iDOFvxYRL8UA/KYh7PuX/WfFe85btC3lYDMHSzVUzRg=;
	b=LVXWIdgCzKgD8Ud0Rmq7Ez2TJJ3PqZBeOgwn/P43X0i4PAPQC8UuvlzfKK4MsrC2cN05PC
	vY1KnZhzUKlnIEIr5j6do51SKeaQgldVVk1A+mz58oaSQZ8md8PQErCelD0kZl9flHieYr
	eDZDYgZ+OKGMonhW2cYWSZRK4P61xoW7hKLJOUDMGyYpXEGJi9FuYNwLGutOd2NgnmPcww
	v6TgW4JOQOEf355E+k221yvRx3bfyaGmmY3kGAd11W6epJlOMHL3jeowOPVnpy2KJKNbuc
	8KycOl8z8y3wX1A1pPntv7EQ2Khnuvz3L77FsuWDsgQFD94oHqkSxgyT4ddbiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771842328;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iDOFvxYRL8UA/KYh7PuX/WfFe85btC3lYDMHSzVUzRg=;
	b=4+6O5KL1Ft/zhNQe7F86W44oFUcFNyl2Th8i6/wFU/vJ7Ni5KMQFhoNqns5q1y1RTDM++j
	xF436h5DzoKkF1CQ==
From: "tip-bot2 for Thomas Huth" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/headers: Replace __ASSEMBLY__ stragglers with
 __ASSEMBLER__
Cc: Thomas Huth <thuth@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251218182029.166993-1-thuth@redhat.com>
References: <20251218182029.166993-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177184232725.1647592.7601187609397681941.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8229-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linutronix.de:dkim,infradead.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:replyto];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 3C78A174E0D
X-Rspamd-Action: no action

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     237dc6a054f6787c2a8f61c59086030267e5e1c5
Gitweb:        https://git.kernel.org/tip/237dc6a054f6787c2a8f61c59086030267e=
5e1c5
Author:        Thomas Huth <thuth@redhat.com>
AuthorDate:    Thu, 18 Dec 2025 19:20:29 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 23 Feb 2026 11:19:12 +01:00

x86/headers: Replace __ASSEMBLY__ stragglers with __ASSEMBLER__

After converting the __ASSEMBLY__ statements to __ASSEMBLER__ in
commit 24a295e4ef1ca ("x86/headers: Replace __ASSEMBLY__ with
__ASSEMBLER__ in non-UAPI headers"), some new code has been
added that uses __ASSEMBLY__ again. Convert these stragglers, too.

This is a mechanical patch, done with a simple "sed -i" command.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251218182029.166993-1-thuth@redhat.com
---
 arch/x86/include/asm/bug.h           | 6 +++---
 arch/x86/include/asm/irqflags.h      | 4 ++--
 arch/x86/include/asm/percpu.h        | 2 +-
 arch/x86/include/asm/runtime-const.h | 6 +++---
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
index 9b4e046..80c1696 100644
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -7,7 +7,7 @@
 #include <linux/objtool.h>
 #include <asm/asm.h>
=20
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 struct bug_entry;
 extern void __WARN_trap(struct bug_entry *bug, ...);
 #endif
@@ -137,7 +137,7 @@ do {									\
=20
 #ifdef HAVE_ARCH_BUG_FORMAT_ARGS
=20
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/static_call_types.h>
 DECLARE_STATIC_CALL(WARN_trap, __WARN_trap);
=20
@@ -153,7 +153,7 @@ struct arch_va_list {
 	struct sysv_va_list args;
 };
 extern void *__warn_args(struct arch_va_list *args, struct pt_regs *regs);
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
=20
 #define __WARN_bug_entry(flags, format) ({				\
 	struct bug_entry *bug;						\
diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index a1193e9..462754b 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -77,7 +77,7 @@ static __always_inline void native_local_irq_restore(unsign=
ed long flags)
 #endif
=20
 #ifndef CONFIG_PARAVIRT
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 /*
  * Used in the idle loop; sti takes one instruction cycle
  * to complete:
@@ -95,7 +95,7 @@ static __always_inline void halt(void)
 {
 	native_halt();
 }
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* CONFIG_PARAVIRT */
=20
 #ifdef CONFIG_PARAVIRT_XXL
diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index c55058f..4099814 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -20,7 +20,7 @@
=20
 #define PER_CPU_VAR(var)	__percpu(var)__percpu_rel
=20
-#else /* !__ASSEMBLY__: */
+#else /* !__ASSEMBLER__: */
=20
 #include <linux/args.h>
 #include <linux/bits.h>
diff --git a/arch/x86/include/asm/runtime-const.h b/arch/x86/include/asm/runt=
ime-const.h
index e5a13dc..4cd94fd 100644
--- a/arch/x86/include/asm/runtime-const.h
+++ b/arch/x86/include/asm/runtime-const.h
@@ -6,7 +6,7 @@
   #error "Cannot use runtime-const infrastructure from modules"
 #endif
=20
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
=20
 .macro RUNTIME_CONST_PTR sym reg
 	movq	$0x0123456789abcdef, %\reg
@@ -16,7 +16,7 @@
 	.popsection
 .endm
=20
-#else /* __ASSEMBLY__ */
+#else /* __ASSEMBLER__ */
=20
 #define runtime_const_ptr(sym) ({				\
 	typeof(sym) __ret;					\
@@ -74,5 +74,5 @@ static inline void runtime_const_fixup(void (*fn)(void *, u=
nsigned long),
 	}
 }
=20
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif

