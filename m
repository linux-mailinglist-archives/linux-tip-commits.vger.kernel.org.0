Return-Path: <linux-tip-commits+bounces-8040-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE9CD38DE4
	for <lists+linux-tip-commits@lfdr.de>; Sat, 17 Jan 2026 11:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B696301819C
	for <lists+linux-tip-commits@lfdr.de>; Sat, 17 Jan 2026 10:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1310930E0F3;
	Sat, 17 Jan 2026 10:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T7cotmrO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Sk6AOEHI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946F12C032C;
	Sat, 17 Jan 2026 10:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768647135; cv=none; b=guSDYc2ayX0tJQXvVnC8pDO8zz+QBHV5oxVsmCevshZ+eDkjzr8YCQbr9FYWuBYZ9Oez6X67qtLm2j+apCy7jBjQBSNCQln4nQuBgIODbFp/MgTyAlNn60tJzGuZnupFXzGxE/riRHeyuxKY1ZhF3Hx2gqWXxelQWuhggo5xjH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768647135; c=relaxed/simple;
	bh=WP0e1Rwj6U2KC5vjnNymRN35T3LGy9TaZmDN5fXVejM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KRt/6rP/L1XwmhHou6ESsGNXEeAF7Ls6Lok7Bguj7yOaNniJR0JisvKUIy6Qnpzo7rrrtyyCRvzTTxxSY9U8lxlTABIqJY4lBXiAtS5lqzNBEDaq3vDTlLDFeYc/Cf72NBRARj87jqE6aOj68acAsSGsU6ocqzINOKlSPCyEpOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T7cotmrO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Sk6AOEHI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 17 Jan 2026 10:52:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768647125;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d/W03sG2Mj4eXEXwruJooHBx/ctuB9Y65shFW+SpXeo=;
	b=T7cotmrOBocqJRahv1qRE0zOmofuMiB/xB4Q+9VfXTDevJHEjiXxivtFUD1t/+0lEdIegi
	jhYp10IbSxVkocOolheXM6BwBYnu7ePd/6S8nHKZPO5nIX/2hjzhdnaLIU9rMIuzzWpWRE
	rxZcVJie4Ok8MfSt8iie9ausxzQ7cDbAs2ojOmk9b9fP6wcdHwq2ft9JaVUKQAs9rsO9G0
	7m4bg/zwC0Fh53HMbyUadnIzJySabPvZb6P47RhrVaJDZYStbbtpWiuS2RWXNqLYR6+M4Z
	/xCPhogYqEiTzn0Gp0vo9n/CNvT2PpTIXvKsi2P16Z7626KqoPDLwXt3efvykg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768647125;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d/W03sG2Mj4eXEXwruJooHBx/ctuB9Y65shFW+SpXeo=;
	b=Sk6AOEHISHDL9JCmlLAZZLe6EjOl2p+XIcrZmTAj3i/q/rUExLSinw+G9Q4jRe9DDkajDi
	zXjtq9myr/h9NkBQ==
From: "tip-bot2 for Hou Wenlong" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/mm: Hide mm_free_global_asid() definition
 under CONFIG_BROADCAST_TLB_FLUSH
Cc: Hou Wenlong <houwenlong.hwl@antgroup.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Rik van Riel <riel@surriel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cb262a8ec8076fb26bb692aaf113848b1e6f40e40=2E1768448?=
 =?utf-8?q?079=2Egit=2Ehouwenlong=2Ehwl=40antgroup=2Ecom=3E?=
References: =?utf-8?q?=3Cb262a8ec8076fb26bb692aaf113848b1e6f40e40=2E17684480?=
 =?utf-8?q?79=2Egit=2Ehouwenlong=2Ehwl=40antgroup=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176864712057.510.13786059241373886036.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     954fc7ac15c18fc21c4a423e542f6df5dc727cad
Gitweb:        https://git.kernel.org/tip/954fc7ac15c18fc21c4a423e542f6df5dc7=
27cad
Author:        Hou Wenlong <houwenlong.hwl@antgroup.com>
AuthorDate:    Thu, 15 Jan 2026 11:38:34 +08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 16 Jan 2026 22:16:32 +01:00

x86/mm: Hide mm_free_global_asid() definition under CONFIG_BROADCAST_TLB_FLUSH

When CONFIG_BROADCAST_TLB_FLUSH is not enabled, mm_free_global_asid() remains
a globally visible symbol and generates a useless function call to it in
destroy_context(). Therefore, hide the mm_free_global_asid() definition under
CONFIG_BROADCAST_TLB_FLUSH and provide a static inline empty version when it
is not enabled to remove the function call.

Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Rik van Riel <riel@surriel.com>
Link: https://patch.msgid.link/b262a8ec8076fb26bb692aaf113848b1e6f40e40.17684=
48079.git.houwenlong.hwl@antgroup.com
---
 arch/x86/include/asm/mmu_context.h | 2 --
 arch/x86/include/asm/tlbflush.h    | 3 +++
 arch/x86/mm/tlb.c                  | 4 ++--
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_co=
ntext.h
index 73bf3b1..1acafb1 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -139,9 +139,7 @@ static inline void mm_reset_untag_mask(struct mm_struct *=
mm)
 #define enter_lazy_tlb enter_lazy_tlb
 extern void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk);
=20
-#define mm_init_global_asid mm_init_global_asid
 extern void mm_init_global_asid(struct mm_struct *mm);
-
 extern void mm_free_global_asid(struct mm_struct *mm);
=20
 /*
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 00daedf..5114bf5 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -292,9 +292,12 @@ static inline bool mm_in_asid_transition(struct mm_struc=
t *mm)
=20
 	return mm && READ_ONCE(mm->context.asid_transition);
 }
+
+extern void mm_free_global_asid(struct mm_struct *mm);
 #else
 static inline u16 mm_global_asid(struct mm_struct *mm) { return 0; }
 static inline void mm_init_global_asid(struct mm_struct *mm) { }
+static inline void mm_free_global_asid(struct mm_struct *mm) { }
 static inline void mm_assign_global_asid(struct mm_struct *mm, u16 asid) { }
 static inline void mm_clear_asid_transition(struct mm_struct *mm) { }
 static inline bool mm_in_asid_transition(struct mm_struct *mm) { return fals=
e; }
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index f5b93e0..621e09d 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -401,6 +401,7 @@ static void use_global_asid(struct mm_struct *mm)
 	mm_assign_global_asid(mm, asid);
 }
=20
+#ifdef CONFIG_BROADCAST_TLB_FLUSH
 void mm_free_global_asid(struct mm_struct *mm)
 {
 	if (!cpu_feature_enabled(X86_FEATURE_INVLPGB))
@@ -412,13 +413,12 @@ void mm_free_global_asid(struct mm_struct *mm)
 	guard(raw_spinlock_irqsave)(&global_asid_lock);
=20
 	/* The global ASID can be re-used only after flush at wrap-around. */
-#ifdef CONFIG_BROADCAST_TLB_FLUSH
 	__set_bit(mm->context.global_asid, global_asid_freed);
=20
 	mm->context.global_asid =3D 0;
 	global_asid_available++;
-#endif
 }
+#endif
=20
 /*
  * Is the mm transitioning from a CPU-local ASID to a global ASID?

