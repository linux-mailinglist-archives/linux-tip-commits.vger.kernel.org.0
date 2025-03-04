Return-Path: <linux-tip-commits+bounces-3977-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A85EDA4ED81
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 20:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEF6317029C
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 19:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CC427BF94;
	Tue,  4 Mar 2025 19:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nhjeub44";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AglTSxeg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1405278146;
	Tue,  4 Mar 2025 19:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741116848; cv=none; b=OpucViEsGtJpLu+rAkmrnOBIBw49Lb7nIgLGx9mbNN1Qq26S1YeWHCL/ph/msuJExz5GaF3qhhwFEj4ourrJyHYiwkYDqLYuISSppuYw0uweCwQdZ/4GRWSnl+9fxG1OpQmKk8l9OI1YxFE+f4FqaKjqG1OYnifsm2W0UZq+eo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741116848; c=relaxed/simple;
	bh=1Xxwf7LfsDI0pRWi6XHqs+crd+MP4bXuCO6vWxPZ1dQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mQcmL89zELnmhTE5kgQeQlc0zdYbYguG8j8vbUiiwyDuJAul2gNhWkA5ylbu3EAdJ8oSe+4zeTVJ+bwswU7IKxx0EBuJyC7QGOJxxliUgNT/OYXQ9jtKenO5tnruz4SugSsZyWPbChP1Y9Sch7Sy8YR9jDgtJMiuE08qbwOBdj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nhjeub44; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AglTSxeg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 19:34:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741116844;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GBsHvgvYTcb3+Dl+MW9vQ7TDVB2cjwWHuEc4jNz6ElU=;
	b=nhjeub441XuLcqfKfYNlWtFsCRgX9gpTR8IZEzTaG52DElhknFD1hz8ViG0+NFzfpSu3NB
	44vLPJCP9dtzUKleFalCwZoI4LT6BL9nSS65WQTPFttI0NkET+lQm2KXf0soz/VT9nCR0i
	y47Rj9v74Elv1dxtoxE2mYziFFVCXlAwEewkmeJr0L1SxM6pBuc6FANPS2H5HZKy4C42yR
	mBIIY16/yJhyg4NJm5tabedqbsTnqCNlmPJN7GcTfDTtnCV/EEWjA2jV2itN0C5ob05tLm
	BY5d9sIITDv2w23MsVtMf/Zr2WNbZ5eSW8AMo/o+t5Z0Cc8iYTGKxexi/jpMlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741116844;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GBsHvgvYTcb3+Dl+MW9vQ7TDVB2cjwWHuEc4jNz6ElU=;
	b=AglTSxeg4GnxqFCN4MzWdb95Idk1Q+Gtjjha3ik+lyoC0OKpNE9NCu4hvTDxP7qf/twmLm
	KCqaNhIVhwagtOCA==
From: "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/percpu: Move pcpu_hot to percpu hot section
Cc: Brian Gerst <brgerst@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Uros Bizjak <ubizjak@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250303165246.2175811-3-brgerst@gmail.com>
References: <20250303165246.2175811-3-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174111684431.14745.1040591322972702460.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     cb6550fd7d3e4e71cb9e6978cc9cea91dcaebd08
Gitweb:        https://git.kernel.org/tip/cb6550fd7d3e4e71cb9e6978cc9cea91dcaebd08
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Mon, 03 Mar 2025 11:52:37 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Mar 2025 20:18:02 +01:00

x86/percpu: Move pcpu_hot to percpu hot section

Also change the alignment of the percpu hot section:

 -       PERCPU_SECTION(INTERNODE_CACHE_BYTES)
 +       PERCPU_SECTION(L1_CACHE_BYTES)

As vSMP will muck with INTERNODE_CACHE_BYTES that invalidates the
too-large-section assert we do:

  ASSERT(__per_cpu_hot_end - __per_cpu_hot_start <= 64, "percpu cache hot section too large")

[ mingo: Added INTERNODE_CACHE_BYTES fix & explanation. ]

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250303165246.2175811-3-brgerst@gmail.com
---
 arch/x86/include/asm/current.h | 28 +++++++++++-----------------
 arch/x86/kernel/cpu/common.c   |  2 +-
 arch/x86/kernel/vmlinux.lds.S  |  5 ++++-
 3 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/arch/x86/include/asm/current.h b/arch/x86/include/asm/current.h
index bf59538..60bc66e 100644
--- a/arch/x86/include/asm/current.h
+++ b/arch/x86/include/asm/current.h
@@ -13,32 +13,26 @@
 struct task_struct;
 
 struct pcpu_hot {
-	union {
-		struct {
-			struct task_struct	*current_task;
-			int			preempt_count;
-			int			cpu_number;
+	struct task_struct	*current_task;
+	int			preempt_count;
+	int			cpu_number;
 #ifdef CONFIG_MITIGATION_CALL_DEPTH_TRACKING
-			u64			call_depth;
+	u64			call_depth;
 #endif
-			unsigned long		top_of_stack;
-			void			*hardirq_stack_ptr;
-			u16			softirq_pending;
+	unsigned long		top_of_stack;
+	void			*hardirq_stack_ptr;
+	u16			softirq_pending;
 #ifdef CONFIG_X86_64
-			bool			hardirq_stack_inuse;
+	bool			hardirq_stack_inuse;
 #else
-			void			*softirq_stack_ptr;
+	void			*softirq_stack_ptr;
 #endif
-		};
-		u8	pad[64];
-	};
 };
-static_assert(sizeof(struct pcpu_hot) == 64);
 
-DECLARE_PER_CPU_ALIGNED(struct pcpu_hot, pcpu_hot);
+DECLARE_PER_CPU_CACHE_HOT(struct pcpu_hot, pcpu_hot);
 
 /* const-qualified alias to pcpu_hot, aliased by linker. */
-DECLARE_PER_CPU_ALIGNED(const struct pcpu_hot __percpu_seg_override,
+DECLARE_PER_CPU_CACHE_HOT(const struct pcpu_hot __percpu_seg_override,
 			const_pcpu_hot);
 
 static __always_inline struct task_struct *get_current(void)
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 88a6707..f00870b 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2064,7 +2064,7 @@ static __init int setup_setcpuid(char *arg)
 }
 __setup("setcpuid=", setup_setcpuid);
 
-DEFINE_PER_CPU_ALIGNED(struct pcpu_hot, pcpu_hot) = {
+DEFINE_PER_CPU_CACHE_HOT(struct pcpu_hot, pcpu_hot) = {
 	.current_task	= &init_task,
 	.preempt_count	= INIT_PREEMPT_COUNT,
 	.top_of_stack	= TOP_OF_INIT_STACK,
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 1769a71..0ef9870 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -187,6 +187,8 @@ SECTIONS
 
 		PAGE_ALIGNED_DATA(PAGE_SIZE)
 
+		CACHE_HOT_DATA(L1_CACHE_BYTES)
+
 		CACHELINE_ALIGNED_DATA(L1_CACHE_BYTES)
 
 		DATA_DATA
@@ -327,7 +329,8 @@ SECTIONS
 		EXIT_DATA
 	}
 
-	PERCPU_SECTION(INTERNODE_CACHE_BYTES)
+	PERCPU_SECTION(L1_CACHE_BYTES)
+	ASSERT(__per_cpu_hot_end - __per_cpu_hot_start <= 64, "percpu cache hot section too large")
 
 	RUNTIME_CONST_VARIABLES
 	RUNTIME_CONST(ptr, USER_PTR_MAX)

