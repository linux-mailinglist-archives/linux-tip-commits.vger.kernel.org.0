Return-Path: <linux-tip-commits+bounces-8339-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALv7DEOlpWngCwAAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8339-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Mon, 02 Mar 2026 15:57:07 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5561DB406
	for <lists+linux-tip-commits@lfdr.de>; Mon, 02 Mar 2026 15:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BDAB33056B7E
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Mar 2026 14:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7321401494;
	Mon,  2 Mar 2026 14:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qadrBk/b";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="azh6ZAoL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CFE3E0C71;
	Mon,  2 Mar 2026 14:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772463034; cv=none; b=CRTa7csjfNgWmQZULRq9kF4YUEH0PxHfncrHKaHohtuNLldY2r4QwNOnoui3N2DrSRcuxxqrA+q+wy0eJkxmKzmlmn8+HnBPX3gNNpcnTbLJWpNWL9mpvNfljIqoVlAexDoY+MLMHDO2pkJr7tAky7alUprXzs4PQoePngzML/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772463034; c=relaxed/simple;
	bh=bKRdIPUZ3ingacR2OY8x3Am8wBajj9LrQs9AXSezhCY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BY2cMV6sWa/3cH7rCDx9bhdIElnGJ2+u5VCxSGr2tdTNWi8an3fOqHI10yRJaYnGtKrd01LO5HWFKYvIwNLqjUp+L2xSC1IkkLDOJizIe/2PLoKWzvaeltg7O0Z1+nNHC/OJCVTgvvWmLcYTRuVMAlL8sKdI01jawH1fvs6BU2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qadrBk/b; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=azh6ZAoL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 02 Mar 2026 14:50:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772463031;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=icpyxltmlWpN7g8Ub6usJhfmbcs1KMheyUQZKBziS2s=;
	b=qadrBk/bclqufG2jp6RZL6oQxELABkS5ufsokq2F2mQbZVBBAQDf9heMxgTy8mscqzN7wm
	cQEGngJ7oLdLYgaNi30LyQHawh4EcRFKkNRkJps7CSdDPd5jbnIPEYuxuOe1aVhesb8+dh
	r9OM5gMbESvbV03FQbhQvvMXWKHa9WY90P/WOaHSQqbLbpncw5FfcX9U4R6+hKesN53Pfk
	CkoldZ9pm+tpKePYnCtrdbuE1HW2lfKV3WpEKq0pygrww5NhzRZ2atolb88l2JgTu32Z08
	co+6tXNloXmDkuPENud0nEUymc+F1lZwfYGQbqWJW1aKxd6LvJvQpUakBDiDuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772463031;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=icpyxltmlWpN7g8Ub6usJhfmbcs1KMheyUQZKBziS2s=;
	b=azh6ZAoLdPil3jT1mayFq3xf1rNhg4Jg/6LMjE0h5ixWn/0tfHIK7LrnmiYg8Yq6cucNmT
	vGoeRsadMQmKASBQ==
From: "tip-bot2 for Xie Yuanbin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] x86/mm/tlb: Make enter_lazy_tlb() always inline on x86
Cc: Dave Hansen <dave.hansen@intel.com>, Xie Yuanbin <qq570070308@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260216164950.147617-2-qq570070308@gmail.com>
References: <20260216164950.147617-2-qq570070308@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177246303057.1647592.6635187614393170714.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 9A5561DB406
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8339-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,intel.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linutronix.de:dkim,vger.kernel.org:replyto,infradead.org:email];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[intel.com,gmail.com,infradead.org,kernel.org,vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Action: no action

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     0a902967b342c744fa85099fce4d3106a39e1337
Gitweb:        https://git.kernel.org/tip/0a902967b342c744fa85099fce4d3106a39=
e1337
Author:        Xie Yuanbin <qq570070308@gmail.com>
AuthorDate:    Tue, 17 Feb 2026 00:49:48 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 02 Mar 2026 15:41:01 +01:00

x86/mm/tlb: Make enter_lazy_tlb() always inline on x86

enter_lazy_tlb() on x86 is short enough, and is called in context
switching, which is the hot code path.

Make enter_lazy_tlb() always inline on x86 to optimize performance.

Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Xie Yuanbin <qq570070308@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260216164950.147617-2-qq570070308@gmail.com
---
 arch/x86/include/asm/mmu_context.h |  3 ---
 arch/x86/include/asm/tlbflush.h    | 26 ++++++++++++++++++++++++++
 arch/x86/mm/tlb.c                  | 21 ---------------------
 3 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_co=
ntext.h
index 1acafb1..ef5b507 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -136,9 +136,6 @@ static inline void mm_reset_untag_mask(struct mm_struct *=
mm)
 }
 #endif
=20
-#define enter_lazy_tlb enter_lazy_tlb
-extern void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk);
-
 extern void mm_init_global_asid(struct mm_struct *mm);
 extern void mm_free_global_asid(struct mm_struct *mm);
=20
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 5a3cdc4..0545fe7 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -172,6 +172,28 @@ struct tlb_state_shared {
 };
 DECLARE_PER_CPU_SHARED_ALIGNED(struct tlb_state_shared, cpu_tlbstate_shared);
=20
+/*
+ * Please ignore the name of this function.  It should be called
+ * switch_to_kernel_thread().
+ *
+ * enter_lazy_tlb() is a hint from the scheduler that we are entering a
+ * kernel thread or other context without an mm.  Acceptable implementations
+ * include doing nothing whatsoever, switching to init_mm, or various clever
+ * lazy tricks to try to minimize TLB flushes.
+ *
+ * The scheduler reserves the right to call enter_lazy_tlb() several times
+ * in a row.  It will notify us that we're going back to a real mm by
+ * calling switch_mm_irqs_off().
+ */
+#define enter_lazy_tlb enter_lazy_tlb
+static __always_inline void enter_lazy_tlb(struct mm_struct *mm, struct task=
_struct *tsk)
+{
+	if (this_cpu_read(cpu_tlbstate.loaded_mm) =3D=3D &init_mm)
+		return;
+
+	this_cpu_write(cpu_tlbstate_shared.is_lazy, true);
+}
+
 bool nmi_uaccess_okay(void);
 #define nmi_uaccess_okay nmi_uaccess_okay
=20
@@ -480,6 +502,10 @@ static inline void cpu_tlbstate_update_lam(unsigned long=
 lam, u64 untag_mask)
 {
 }
 #endif
+#else /* !MODULE */
+#define enter_lazy_tlb enter_lazy_tlb
+extern void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
+	__compiletime_error("enter_lazy_tlb() should not be used in modules");
 #endif /* !MODULE */
=20
 static inline void __native_tlb_flush_global(unsigned long cr4)
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 621e09d..af43d17 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -972,27 +972,6 @@ reload_tlb:
 }
=20
 /*
- * Please ignore the name of this function.  It should be called
- * switch_to_kernel_thread().
- *
- * enter_lazy_tlb() is a hint from the scheduler that we are entering a
- * kernel thread or other context without an mm.  Acceptable implementations
- * include doing nothing whatsoever, switching to init_mm, or various clever
- * lazy tricks to try to minimize TLB flushes.
- *
- * The scheduler reserves the right to call enter_lazy_tlb() several times
- * in a row.  It will notify us that we're going back to a real mm by
- * calling switch_mm_irqs_off().
- */
-void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
-{
-	if (this_cpu_read(cpu_tlbstate.loaded_mm) =3D=3D &init_mm)
-		return;
-
-	this_cpu_write(cpu_tlbstate_shared.is_lazy, true);
-}
-
-/*
  * Using a temporary mm allows to set temporary mappings that are not access=
ible
  * by other CPUs. Such mappings are needed to perform sensitive memory writes
  * that override the kernel memory protections (e.g., W^X), without exposing=
 the

