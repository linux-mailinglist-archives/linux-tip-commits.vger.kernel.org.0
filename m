Return-Path: <linux-tip-commits+bounces-3922-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37936A4DAE2
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 11:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2634A3B0972
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 10:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FA920298A;
	Tue,  4 Mar 2025 10:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gnPUxKJv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Uf0SIv0W"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0004320125F;
	Tue,  4 Mar 2025 10:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741084595; cv=none; b=T4MKb8HQAB/rOkW1jU44DabPJduPmdBPG4/hAyHvZNqisBZ8tFAwz/o5VhHasIZSS/jCr+eowLj+jhwoC1iOcFM7/cOmA09fFGqZWH+9GpyxhW2v3JSJUJM7RLYPbd4VLnEEvoccOes3kz+F/hL72BHLxuRVQ0ZO9K9U1JZntx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741084595; c=relaxed/simple;
	bh=2QzUiPmvp3sSI3LMoMs6IuY8F0aIXtY1nKt2lgL9XNc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Nj4MhLWURnwwsA8cs9Tv/5nx5PQy+XJiImGrI73XWSuP7UjqsbxK8kay03YN5ct52QPU+FBYj5APBHZPGslqgDHZNpzTdwKx+OLZYs6P0FZwJzdpHVpb8yPw6DKwmo5pp/WbEYtdGacO/pHN9E4037rhE5Z4GFXcAwN3E/tpuUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gnPUxKJv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Uf0SIv0W; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 10:36:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741084592;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LeKrUDkMFSjtp6Gz4npRyJqCB8gW+rIykbIf6XFF56c=;
	b=gnPUxKJvmkVnpaS97rThNtwun3PUO2iBXU47N97iAsnm0oCoJ0ctJPPGX1bKSIMPpVHPIG
	nFh03sswtGOfIADxY8MFhc54t1uZ3HL0lz0qTvOJgmDtJ/f3PK4OGZeljcv9jbDEKAx1yM
	EL51+/x3QFUnl2qZVzV5J1GLoNJD9tjav8Sg08I3RNpTm+84fCXrXEQBopHYs2nAWoPR2l
	50k22DRxNhbq7z7jKCPkOyRTQsP08aFXaN/BOto2xX6D/3+mqX163JgdtzAF+owzehp+eu
	W43lq1KNWR40XkI5jyXUJL4uNHQ0PwmEqqs70dKlZQVIL7K80/ftRIWPXtGMIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741084592;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LeKrUDkMFSjtp6Gz4npRyJqCB8gW+rIykbIf6XFF56c=;
	b=Uf0SIv0WhL6GTebA62iHOI+I8pRRNjhJmr7ZDtUvMIa73SoQ94n9KlFOHRWJ9Okg9g6VIn
	PBPBnkSHo2s0fPDQ==
From: "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/core] x86/softirq: Move softirq_pending to percpu hot section
Cc: Brian Gerst <brgerst@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Uros Bizjak <ubizjak@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250303165246.2175811-7-brgerst@gmail.com>
References: <20250303165246.2175811-7-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174108459203.14745.6387800090153938519.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     db04c0b33c68b99616cea4acc78a54b6d684244e
Gitweb:        https://git.kernel.org/tip/db04c0b33c68b99616cea4acc78a54b6d684244e
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Mon, 03 Mar 2025 11:52:41 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Mar 2025 11:24:28 +01:00

x86/softirq: Move softirq_pending to percpu hot section

No functional change.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250303165246.2175811-7-brgerst@gmail.com
---
 arch/x86/include/asm/current.h | 1 -
 arch/x86/include/asm/hardirq.h | 4 ++--
 arch/x86/kernel/irq.c          | 3 +++
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/current.h b/arch/x86/include/asm/current.h
index 8ba2c0f..f153c77 100644
--- a/arch/x86/include/asm/current.h
+++ b/arch/x86/include/asm/current.h
@@ -16,7 +16,6 @@ struct pcpu_hot {
 	struct task_struct	*current_task;
 	unsigned long		top_of_stack;
 	void			*hardirq_stack_ptr;
-	u16			softirq_pending;
 #ifdef CONFIG_X86_64
 	bool			hardirq_stack_inuse;
 #else
diff --git a/arch/x86/include/asm/hardirq.h b/arch/x86/include/asm/hardirq.h
index 6ffa8b7..f00c09f 100644
--- a/arch/x86/include/asm/hardirq.h
+++ b/arch/x86/include/asm/hardirq.h
@@ -3,7 +3,6 @@
 #define _ASM_X86_HARDIRQ_H
 
 #include <linux/threads.h>
-#include <asm/current.h>
 
 typedef struct {
 #if IS_ENABLED(CONFIG_KVM_INTEL)
@@ -66,7 +65,8 @@ extern u64 arch_irq_stat_cpu(unsigned int cpu);
 extern u64 arch_irq_stat(void);
 #define arch_irq_stat		arch_irq_stat
 
-#define local_softirq_pending_ref       pcpu_hot.softirq_pending
+DECLARE_PER_CPU_CACHE_HOT(u16, __softirq_pending);
+#define local_softirq_pending_ref       __softirq_pending
 
 #if IS_ENABLED(CONFIG_KVM_INTEL)
 /*
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index feca4f2..83a5252 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -33,6 +33,9 @@
 DEFINE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
 EXPORT_PER_CPU_SYMBOL(irq_stat);
 
+DEFINE_PER_CPU_CACHE_HOT(u16, __softirq_pending);
+EXPORT_PER_CPU_SYMBOL(__softirq_pending);
+
 atomic_t irq_err_count;
 
 /*

