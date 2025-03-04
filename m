Return-Path: <linux-tip-commits+bounces-3972-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C146A4ED88
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 20:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F5413A963D
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 19:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFB02780F4;
	Tue,  4 Mar 2025 19:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GpvpH/Or";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bwZsjAp8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3749F276D3A;
	Tue,  4 Mar 2025 19:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741116845; cv=none; b=Te84sXZIhGR0O3N13ll+rdj8JW0TtMrIOOwUDsebWQ92q7oTJbLktTMMn545YG5xA8UPlDnE+aUmWTcmD4W4gmnY/nbrtLMYeAQKXKIkMtV7tCGizbyGymBXb2qoxLCuQmraCFV5T3C6juzeAYSmsK5+KA8HlJD1ABGFzi+Ouk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741116845; c=relaxed/simple;
	bh=DavwzwEjwI0leQr84GCRG5xhxXGBuenWovPYY3dC1b0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=i5dBTPPCTCr4sIg21aj8KsWCqGBuKGgJBoi1Iusg4594uxUzmNNv952B7okvaY++4TcmvQ1580UfN69fL7AaEIImSK1nkF7lYXdbf10ntN/NqgCAPr1Sf2BHr06K4mhow5A2+FElc3hQYaXejBAOeFh4oDKcfGrTEm6rG35rZ6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GpvpH/Or; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bwZsjAp8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 19:34:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741116841;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E6JjJa4ZHH6JBiLsYEtZvjKd7UV0koCYXW0ES9PzA2I=;
	b=GpvpH/OrnS+q1NtyAyY/kgIvXRyYIplA4hsuHudlhya0ZPqzMsZepN18uv4KUpmiNQksVL
	/wk0bPLDsLgpG/+IfbaT4VdsAv0D9B5nfXIJHNS8Mo8//JG1aEIO/H9EYx+yXsBsfGhE63
	7fWnOysrcFjBm66aP9et8hDIjeF21xg18N6rgMmhVVHRphPwdyMmjhWpHBn+6+qjqxVWDO
	vSPjptzcvB5hhis0vD4ocJh76pBZEz32hNZhr0OaJmEM4UXnm6NOIZai48knygxUXDc7bG
	kxJR/SltFaq+VkB0iEfpFjQgk9WlITwimiEgDlvB3EKRQb0gTnqnMzzRwks51Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741116841;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E6JjJa4ZHH6JBiLsYEtZvjKd7UV0koCYXW0ES9PzA2I=;
	b=bwZsjAp8vEjEygMuH5RgBkca0YTYvvoN1pnkl+FmbNalkIYpEUkcESMHuYC879kFXWkDeq
	QdDIOcAVjn35GECw==
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
Message-ID: <174111684113.14745.11754006944243399380.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     de3e8123a856af6257b6f5089baa2dc9de882705
Gitweb:        https://git.kernel.org/tip/de3e8123a856af6257b6f5089baa2dc9de882705
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Mon, 03 Mar 2025 11:52:41 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Mar 2025 20:18:02 +01:00

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

