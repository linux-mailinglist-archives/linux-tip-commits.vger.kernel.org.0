Return-Path: <linux-tip-commits+bounces-3852-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFE4A4D655
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 09:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 221587A518B
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 08:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0421FCD16;
	Tue,  4 Mar 2025 08:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M0HFXHr4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9EPwVehO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F771FC7CA;
	Tue,  4 Mar 2025 08:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741076873; cv=none; b=ETs3Kjf1zY0h15GAj9wyKHmMryKcGuJg+W1SZRtxlMqvxygisB/+xKfnoTM2HT5uIt4BtjeGHy7DJmpzePAGsvk2VVGb93TpUi+THY+tIRPsnONjGOx8IPzoC6DiO+vcOBOgo2XGsNqmkRKi1b7m0aav890ebkV9RkHUfH7rNUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741076873; c=relaxed/simple;
	bh=thz0PlapWGgprfSqqFJWhfSixNdlkcF5gwe7/d2DPMg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kURnXCUWSN5NkAh2EHUOVGjiJseTsEjGb6MUoxyEWRCvcwjGBn/8K44q72ri4Mk5kG/20imK0nfp3yfVJOsShGePJkiSyioyQPHO5UmFxI6wDKAx0KowO1he/9iqfP0pD+dxe6xgnEa/0FTnDpxhhGjdRX5mGnFaVvG12dvv9ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M0HFXHr4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9EPwVehO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 08:27:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741076870;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eFtVPAqSTW2PvuJYKXNVR8OwjwyA7IHLcV7Rjr9Vu1w=;
	b=M0HFXHr4rZgHgLtRVsvHDpSjIi4cVEmwlNbN08YLru/YsoD8HTnT+Ew2yJE2rdrD/lsj6+
	jbHsNyYb0aI5M4sHKxyhwEvzhVdkRtqcXpuuym3Xyop5qRlcHPufA/qExTxKmBnWo9xrlP
	sO+ZYGWh3A6vjptBHmFyAdH9AuraDQVf/U5XXFcKyDUMi9VuOBtKt+Ddmp6/A18a9zIqeu
	f9+4Ql1azG8opy88ziAXaDC2SlLJt7XwlrtJcLHznM+4TVMi+z39t/u+NC6B34DtOLMp+4
	uu2Arz8P2bXtLguQMXThwUT84hfRQNTOLV9ZdIAO958N0VSa4zkKiMr/z2fr5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741076870;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eFtVPAqSTW2PvuJYKXNVR8OwjwyA7IHLcV7Rjr9Vu1w=;
	b=9EPwVehOqndX2nUk/AMIZdvgu3kBjZLYd7HFZULbTm8729fUWblXqMjhnvqXnU9RBz0QLX
	34ntDZolBskDJmCA==
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
Message-ID: <174107686973.14745.2524652179070904524.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     e765b2480bebb2539b5408e3ed3afe6f1a6f23a2
Gitweb:        https://git.kernel.org/tip/e765b2480bebb2539b5408e3ed3afe6f1a6f23a2
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Mon, 03 Mar 2025 11:52:37 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 03 Mar 2025 21:37:28 +01:00

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
index 962aaa6..24aa8d4 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2047,7 +2047,7 @@ static __init int setup_setcpuid(char *arg)
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

