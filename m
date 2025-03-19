Return-Path: <linux-tip-commits+bounces-4385-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 737B9A68B24
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 12:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 458FD3B7305
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 11:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB536264624;
	Wed, 19 Mar 2025 11:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cOBkN+ic";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nixMarq3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258B026138B;
	Wed, 19 Mar 2025 11:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382248; cv=none; b=ShPogaFTmYB8P4zjQ8Nti8OLGr3gDfZYoxO9fxrSHTI12x3hKJxWsdkBDcFP9RqrPNtk6z+JTm2MpBGPQ4xJngii/kg518kav7X+96nPVo4/GAA+7YOkq3XSzmit5b3bn9K6BxHw5wuk4Z4Puq8ZS6q27TjDOinE876F2QWSJEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382248; c=relaxed/simple;
	bh=3rtLkxHPuyKjpmLYv4l00dPFHfhKBDESmaV/OQFK++Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sMKmUJ9P5hyGVjoKJ1D2hxZaRy5Rb3gjUnEM2QZ5CFhLswPtn4wZOsN5OjA7Cq/jwzsKOOjso70cXnFIB7Y5Nd9Qwugc8koDhnec2WXpX5GTu5lERoC8S1oKB4FqGxTpQNjIJGLw3luGZCD5f7Gew3vcVcO+LIup1QQB6VqAl+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cOBkN+ic; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nixMarq3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 19 Mar 2025 11:04:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742382244;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gx+A3ORE/SwcNYVLdJcGWWz2QINi3zeLLQT4huwhkJ0=;
	b=cOBkN+icLV1WzHqW5HXvd6yUHn7+eyOykTYtUB46+WB2pqpAAI0t+egJfzmvfQfGzTO7aG
	gJudrUm7JrB090jxdHKVqBQAdW9eFcNJznx4M6T6B+0LlZ1oEDES7xpvlPIwsfn4G/W3W3
	ouelEn3vqtHT4uuofX1QisiwgsgH8Wdp0MHk4Y0yzfxd0p0r+9eFStjdqy8tPmM6el/Hdo
	d6Bu6u3bB9qM5g1JBm8eEfp8e4cwEd2SVc+WaylYWwH9paIIJF1FBCJWKSIz3MVOpHazvN
	cFZzagYkRmF9QjcA3/Q3NmgaMjtjpXItKxFyIU3RyvFsFoiKEmJ3Q6XyOfjBwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742382244;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gx+A3ORE/SwcNYVLdJcGWWz2QINi3zeLLQT4huwhkJ0=;
	b=nixMarq3zzmS2dX8z+eFZN8bpkR79ofg+neWYoKTmhFrnF9heb4FmkbhaMb9bk2Kfr6P5o
	IJFYhKYE2T2f4VDA==
From: "tip-bot2 for Rik van Riel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/mm: Add global ASID process exit helpers
Cc: Rik van Riel <riel@surriel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250226030129.530345-10-riel@surriel.com>
References: <20250226030129.530345-10-riel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174238224409.14745.7561799986706737333.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     c9826613a9cbbf889b1fec6b7b943fe88ec2c212
Gitweb:        https://git.kernel.org/tip/c9826613a9cbbf889b1fec6b7b943fe88ec2c212
Author:        Rik van Riel <riel@surriel.com>
AuthorDate:    Tue, 25 Feb 2025 22:00:44 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Mar 2025 11:12:29 +01:00

x86/mm: Add global ASID process exit helpers

A global ASID is allocated for the lifetime of a process. Free the global ASID
at process exit time.

  [ bp: Massage, create helpers, hide details inside them. ]

Signed-off-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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

