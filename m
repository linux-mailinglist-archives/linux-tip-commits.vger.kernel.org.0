Return-Path: <linux-tip-commits+bounces-4013-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD30A50DB6
	for <lists+linux-tip-commits@lfdr.de>; Wed,  5 Mar 2025 22:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 838B718947B4
	for <lists+linux-tip-commits@lfdr.de>; Wed,  5 Mar 2025 21:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF8F2580DE;
	Wed,  5 Mar 2025 21:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yWMOn6+/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r4TLSmQY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41369257AF5;
	Wed,  5 Mar 2025 21:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741210587; cv=none; b=eIXawYdCKFcOny+HA97y4PLJkNXPyqC2mme2IF7g06tvQhSIiKQmNbiSeIIDwPXDveyLS5Tabl6Ev4cylWoh0ufXExb2jaqTPxf5pUlAZ+VMoSSV22AtRoVVKawCsSREmRlul7Nq0qc3Yg4XjvMhQvVCyrp8SX2N8oe2y5EJot0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741210587; c=relaxed/simple;
	bh=IY+K7GlkOhG50Xs2Txts2kMXcY50LXd1LuqqQFmRBCI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QTh+BiZpYUxEAbqd68oyU7ldeBjIH+6Y4lqAQpse5Nf51hjrytBBB2LVca0/eSldW+9ALubpmKc2m0t9ktxPWIbcllWZlpgJcKRXwciRGUZDtGKfTkX6+UCRwMBX+rrrRA0pH09vPuRT7gzP6CD3Lz4EWOOtMaVBlE6n8GQkgZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yWMOn6+/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r4TLSmQY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 05 Mar 2025 21:36:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741210584;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r/oXkGQyNh2peOWpluNyT6RiUksBlMXUWWzLfycgHfw=;
	b=yWMOn6+/CfaMvdSgP0cuEVrFMCWeMGhYufxXATV2fePg501hbguH5BgV5Cpiga1Y++If4A
	QHHX7068SPw6atODEkjd2h+snT7WnkHbxH5k/7Qt034hn66o0z6OCC/0LkoFbjTBf1iHES
	2GRXFLtyts3sfxGSSrlV7EebWnzdTF36TkMrnaeEmxuI49FQPoGiW3aRVxFXfIq2Mi+fZV
	2Y/QkEkHqFGyXW4mpS0pdKaFHcyUv3K/HhdMsGMl72C4OgrOlJ5pvL8P0pkpiE4P3BZwDJ
	UqTZIzcqYG088bMQC545D7IZDp2zDRoei85V/qwz5uRVpnVSVKUTScOH2S0UGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741210584;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r/oXkGQyNh2peOWpluNyT6RiUksBlMXUWWzLfycgHfw=;
	b=r4TLSmQYPcHj1EEWcfgKXtjnDjQP5NmBYYrdHxO38dkoKVKDBCwe0dBw8HsJIiEjMqPoQb
	8wiy8oNX2tFreIDw==
From: "tip-bot2 for Rik van Riel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Add global ASID process exit helpers
Cc: Rik van Riel <riel@surriel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250226030129.530345-10-riel@surriel.com>
References: <20250226030129.530345-10-riel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174121058403.14745.12767917226754475731.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     26a3633bfddfcdd57f5f2e3d157806d68aff5ac4
Gitweb:        https://git.kernel.org/tip/26a3633bfddfcdd57f5f2e3d157806d68aff5ac4
Author:        Rik van Riel <riel@surriel.com>
AuthorDate:    Tue, 25 Feb 2025 22:00:44 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 05 Mar 2025 17:19:53 +01:00

x86/mm: Add global ASID process exit helpers

A global ASID is allocated for the lifetime of a process. Free the global ASID
at process exit time.

  [ bp: Massage, create helpers, hide details inside them. ]

Signed-off-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20250226030129.530345-10-riel@surriel.com
---
 arch/x86/include/asm/mmu_context.h |  8 +++++++-
 arch/x86/include/asm/tlbflush.h    |  9 +++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index a2c70e4..2398058 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -2,7 +2,6 @@
 #ifndef _ASM_X86_MMU_CONTEXT_H
 #define _ASM_X86_MMU_CONTEXT_H
 
-#include <asm/desc.h>
 #include <linux/atomic.h>
 #include <linux/mm_types.h>
 #include <linux/pkeys.h>
@@ -13,6 +12,7 @@
 #include <asm/paravirt.h>
 #include <asm/debugreg.h>
 #include <asm/gsseg.h>
+#include <asm/desc.h>
 
 extern atomic64_t last_mm_ctx_id;
 
@@ -139,6 +139,9 @@ static inline void mm_reset_untag_mask(struct mm_struct *mm)
 #define enter_lazy_tlb enter_lazy_tlb
 extern void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk);
 
+#define mm_init_global_asid mm_init_global_asid
+extern void mm_init_global_asid(struct mm_struct *mm);
+
 extern void mm_free_global_asid(struct mm_struct *mm);
 
 /*
@@ -163,6 +166,8 @@ static inline int init_new_context(struct task_struct *tsk,
 		mm->context.execute_only_pkey = -1;
 	}
 #endif
+
+	mm_init_global_asid(mm);
 	mm_reset_untag_mask(mm);
 	init_new_context_ldt(mm);
 	return 0;
@@ -172,6 +177,7 @@ static inline int init_new_context(struct task_struct *tsk,
 static inline void destroy_context(struct mm_struct *mm)
 {
 	destroy_context_ldt(mm);
+	mm_free_global_asid(mm);
 }
 
 extern void switch_mm(struct mm_struct *prev, struct mm_struct *next,
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 1f61a39..e6c3be0 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -261,6 +261,14 @@ static inline u16 mm_global_asid(struct mm_struct *mm)
 	return asid;
 }
 
+static inline void mm_init_global_asid(struct mm_struct *mm)
+{
+	if (cpu_feature_enabled(X86_FEATURE_INVLPGB)) {
+		mm->context.global_asid = 0;
+		mm->context.asid_transition = false;
+	}
+}
+
 static inline void mm_assign_global_asid(struct mm_struct *mm, u16 asid)
 {
 	/*
@@ -281,6 +289,7 @@ static inline bool mm_in_asid_transition(struct mm_struct *mm)
 }
 #else
 static inline u16 mm_global_asid(struct mm_struct *mm) { return 0; }
+static inline void mm_init_global_asid(struct mm_struct *mm) { }
 static inline void mm_assign_global_asid(struct mm_struct *mm, u16 asid) { }
 static inline bool mm_in_asid_transition(struct mm_struct *mm) { return false; }
 #endif /* CONFIG_BROADCAST_TLB_FLUSH */

