Return-Path: <linux-tip-commits+bounces-8006-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 941E2D241A8
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 Jan 2026 12:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0F3530274FD
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 Jan 2026 11:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB3A374178;
	Thu, 15 Jan 2026 11:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WD3AcYCQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TaWnetM7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77362773CA;
	Thu, 15 Jan 2026 11:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768475495; cv=none; b=r4yWDp6b15XGULgLFl2kEKFNjbF3xNmRdMMkgdVEV1vTCj9OyS2Ou6cAwtmSS6jZdU5ChEjNN2xcpIOCQRqlwV+WuS8vvGS5+MgoR0ytkVUuNMgP24BUMJSL6cS7VM/UwqWcLNwtE/5/ZG2XGOb3wqm3Mx+8b4juzdZT7gwFTyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768475495; c=relaxed/simple;
	bh=U2H7Os0xz9WqwpnLH6w6pti+yBTLMTbPg8WKAhWaSR0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iQ177UyrqJlpp57yDWrpIQyOOl+gDBbIc55GvU2loG335XpGRRcNIzeWfyBg/uWri2sOCwGNDtxeXXokK5yPyaeMxEn7emwXzI/7WuIlGA7IdkpcxB1A+W7+TwOC7K7kcmKMHp9JPiI5Hu14GWxNJvERU3zVrQ16+AM6kXmc4d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WD3AcYCQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TaWnetM7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 15 Jan 2026 11:11:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768475492;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lxAtwFBumwfmknJOqM1NcKj/prBmq8DnAiKCp2eqMeQ=;
	b=WD3AcYCQ7gMQ7YhyYpl9mIvWPd07h4Qvtn7oLIAsQF56eavHiMdKblbP3dhTZoHkmso/sd
	dnTOTZUy0W0KmTKyDg4oD7oS7UGR7PQrgirfyGN+LpT2AOfQGL2srMPRGSIellZVJy+kxA
	+NikoUf/H3uv6iXtbscCObMKQvYLgKtL9QVL7ceCY02StuIPErzC6e2pL3xfZq915IKyZT
	4CExgW9DdKUir/U+Y7bG7NXhgHo32eNsH6QY5FRgWvd1yXp3VIDFx3s8hql7+2RD/MeQtg
	uPwckGSS2BStE1PBc4GY6nEX/9c/ovLFuAnc6tKiOUBQO88JMXmPzC+sJmNaIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768475492;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lxAtwFBumwfmknJOqM1NcKj/prBmq8DnAiKCp2eqMeQ=;
	b=TaWnetM7FfApY04tah050JOL7Pvp/I50GlItl872k6z9AF8PG+yWZYIDKiA2VSEtkSYhxX
	zrAd2Bf308lBBmBg==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/paravirt] x86/paravirt: Remove trailing semicolons from
 alternative asm templates
Cc: Uros Bizjak <ubizjak@gmail.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Juergen Gross <jgross@suse.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260114211948.74774-1-ubizjak@gmail.com>
References: <20260114211948.74774-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176847549068.510.16372498803989927090.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/paravirt branch of tip:

Commit-ID:     baea32b242be8ff857cc27b910c6c325c24a7247
Gitweb:        https://git.kernel.org/tip/baea32b242be8ff857cc27b910c6c325c24=
a7247
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Wed, 14 Jan 2026 22:18:14 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 15 Jan 2026 11:14:47 +01:00

x86/paravirt: Remove trailing semicolons from alternative asm templates

GCC inline asm treats semicolons as instruction separators, so a
semicolon after the last instruction is not required.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Juergen Gross <jgross@suse.com>
Acked-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
Link: https://patch.msgid.link/20260114211948.74774-1-ubizjak@gmail.com
---
 arch/x86/include/asm/paravirt-spinlock.h |  4 ++--
 arch/x86/include/asm/paravirt.h          | 16 ++++++++--------
 arch/x86/include/asm/paravirt_types.h    |  2 +-
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/paravirt-spinlock.h b/arch/x86/include/asm/=
paravirt-spinlock.h
index a5011ef..458b888 100644
--- a/arch/x86/include/asm/paravirt-spinlock.h
+++ b/arch/x86/include/asm/paravirt-spinlock.h
@@ -38,14 +38,14 @@ static __always_inline void pv_queued_spin_lock_slowpath(=
struct qspinlock *lock,
 static __always_inline void pv_queued_spin_unlock(struct qspinlock *lock)
 {
 	PVOP_ALT_VCALLEE1(pv_ops_lock, queued_spin_unlock, lock,
-			  "movb $0, (%%" _ASM_ARG1 ");",
+			  "movb $0, (%%" _ASM_ARG1 ")",
 			  ALT_NOT(X86_FEATURE_PVUNLOCK));
 }
=20
 static __always_inline bool pv_vcpu_is_preempted(long cpu)
 {
 	return PVOP_ALT_CALLEE1(bool, pv_ops_lock, vcpu_is_preempted, cpu,
-				"xor %%" _ASM_AX ", %%" _ASM_AX ";",
+				"xor %%" _ASM_AX ", %%" _ASM_AX,
 				ALT_NOT(X86_FEATURE_VCPUPREEMPT));
 }
=20
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index b21072a..3d0b92a 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -117,7 +117,7 @@ static inline void write_cr0(unsigned long x)
 static __always_inline unsigned long read_cr2(void)
 {
 	return PVOP_ALT_CALLEE0(unsigned long, pv_ops, mmu.read_cr2,
-				"mov %%cr2, %%rax;", ALT_NOT_XEN);
+				"mov %%cr2, %%rax", ALT_NOT_XEN);
 }
=20
 static __always_inline void write_cr2(unsigned long x)
@@ -128,7 +128,7 @@ static __always_inline void write_cr2(unsigned long x)
 static inline unsigned long __read_cr3(void)
 {
 	return PVOP_ALT_CALL0(unsigned long, pv_ops, mmu.read_cr3,
-			      "mov %%cr3, %%rax;", ALT_NOT_XEN);
+			      "mov %%cr3, %%rax", ALT_NOT_XEN);
 }
=20
 static inline void write_cr3(unsigned long x)
@@ -516,18 +516,18 @@ static inline void __set_fixmap(unsigned /* enum fixed_=
addresses */ idx,
=20
 static __always_inline unsigned long arch_local_save_flags(void)
 {
-	return PVOP_ALT_CALLEE0(unsigned long, pv_ops, irq.save_fl, "pushf; pop %%r=
ax;",
+	return PVOP_ALT_CALLEE0(unsigned long, pv_ops, irq.save_fl, "pushf; pop %%r=
ax",
 				ALT_NOT_XEN);
 }
=20
 static __always_inline void arch_local_irq_disable(void)
 {
-	PVOP_ALT_VCALLEE0(pv_ops, irq.irq_disable, "cli;", ALT_NOT_XEN);
+	PVOP_ALT_VCALLEE0(pv_ops, irq.irq_disable, "cli", ALT_NOT_XEN);
 }
=20
 static __always_inline void arch_local_irq_enable(void)
 {
-	PVOP_ALT_VCALLEE0(pv_ops, irq.irq_enable, "sti;", ALT_NOT_XEN);
+	PVOP_ALT_VCALLEE0(pv_ops, irq.irq_enable, "sti", ALT_NOT_XEN);
 }
=20
 static __always_inline unsigned long arch_local_irq_save(void)
@@ -553,9 +553,9 @@ static __always_inline unsigned long arch_local_irq_save(=
void)
 	call PARA_INDIRECT(pv_ops+PV_IRQ_save_fl);
 .endm
=20
-#define SAVE_FLAGS ALTERNATIVE_2 "PARA_IRQ_save_fl;",			\
-				 "ALT_CALL_INSTR;", ALT_CALL_ALWAYS,	\
-				 "pushf; pop %rax;", ALT_NOT_XEN
+#define SAVE_FLAGS ALTERNATIVE_2 "PARA_IRQ_save_fl",			\
+				 "ALT_CALL_INSTR", ALT_CALL_ALWAYS,	\
+				 "pushf; pop %rax", ALT_NOT_XEN
 #endif
 #endif /* CONFIG_PARAVIRT_XXL */
 #endif	/* CONFIG_X86_64 */
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/par=
avirt_types.h
index 7ccd416..9bcf6bc 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -210,7 +210,7 @@ extern struct paravirt_patch_template pv_ops;
  */
 #define PARAVIRT_CALL					\
 	ANNOTATE_RETPOLINE_SAFE "\n\t"			\
-	"call *%[paravirt_opptr];"
+	"call *%[paravirt_opptr]"
=20
 /*
  * These macros are intended to wrap calls through one of the paravirt

