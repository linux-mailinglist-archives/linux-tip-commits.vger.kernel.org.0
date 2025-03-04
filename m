Return-Path: <linux-tip-commits+bounces-3985-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B44A4EDB1
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 20:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EE1F7A6090
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 19:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85F02777EE;
	Tue,  4 Mar 2025 19:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YcIZ+3pe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GFxsT2G8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24428266F12;
	Tue,  4 Mar 2025 19:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741117438; cv=none; b=E7hsWJ1niXDiKmwc5HZ4ZeqkZq/62tfPvE2Lx+hi0rSo1sTNCWjccGUUuQvKlL4ArIVMZ6sEcH10X0hQSL5raCirg5gITTIeyvWlUa4DF52RklrL0+VlzAXaqEAU75idI4FYCFU5AUOlgtSWHiYGhwnw6W835m42cj7126ONSYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741117438; c=relaxed/simple;
	bh=tzGvGdZVLE2rqZ8tPjah/TGzix/NWkCj1NmdpaA5vF0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dDp9BvhAxuS3GBncezZ2NqVSm0cQDvnZUetPeEGF4KxcOmTSGiLW4Ud1PKBd+Bq21V8eTulY4nLJ+vZvTfCL2S9M2DiqJ0WzcnhYIPx7ww2KhkAUJ9G0qyW3hgT+fXnANZcdVA3P0vC3aqvXDl1QpcTNITrtnG6AFwK1uLI3vI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YcIZ+3pe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GFxsT2G8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 19:43:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741117435;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oJ+79IUSFnMsUjJ2PX2WEwwG9KFpZD4bY/pV3Ftj60Q=;
	b=YcIZ+3peb9s3Prp9kyVUIL0U5tOXQTv2fTIFYKUYC2c58WDtHwfhbAw0Cl1mLCqCtURTR0
	aeEcfkrmkejcelUWv88foSGKAZiJW/Xe8DzqYl5JpL9BqNib1b/Uo7/gNwgMWm29qIOuhm
	snASpmGLmQglpSHLL8MgKJ864ew4QCOz1Fhd+IRzzeFng/wOHBcvSWjx6Bcbvn48qgu+nA
	t7MQWuoo4J54sQ56M9U9ecTM+I7K50aKfuAwxl4x0F4Txxk8d5BIE6Xk+R91HxmqJ19VNo
	cNzcHG2B2c31UxSGsiAlp5TmXCe1xRaE9e2Ks1PFwimgSjpF/lzL6/W1LSPQdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741117435;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oJ+79IUSFnMsUjJ2PX2WEwwG9KFpZD4bY/pV3Ftj60Q=;
	b=GFxsT2G8x/bYRSPVeb4Ac3HjacFdi7THokm5zDzIwEi62tK9Bai+QlokGonhLI6fTgBS6B
	Cd5XonZ5t/49HADQ==
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
Message-ID: <174111743444.14745.16643080741703726107.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     c8f1ac2bd7771a3bc536f897c142ca219cac13e1
Gitweb:        https://git.kernel.org/tip/c8f1ac2bd7771a3bc536f897c142ca219cac13e1
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Mon, 03 Mar 2025 11:52:41 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Mar 2025 20:30:33 +01:00

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

