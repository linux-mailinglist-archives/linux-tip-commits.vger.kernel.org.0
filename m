Return-Path: <linux-tip-commits+bounces-5484-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 953E5AAF80E
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 12:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FCE81BA2B87
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 10:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC5122F766;
	Thu,  8 May 2025 10:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fwj+x7EG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="575Xg/bj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5F922D9EE;
	Thu,  8 May 2025 10:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746700444; cv=none; b=ClzYFT9peOhx1F1goAa7BG5wiD5J76DKTNOgOwqhH75v9lfVFk+fWFMHA2d4SX5/yz/wXCi3qILmHPuBvP/puEHzHyc0c0qALfDH99Nk2FukC7hkzZ0rkD2gTsFY12NBl3ILA8llj1s8tsR4OOBd0geATgJtSkf7DRL7KQSgwDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746700444; c=relaxed/simple;
	bh=mA7GrKHz2wcSNkv3fLBCeulcepl/EJiXPs3ncekrNsU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UCw8319EXETb5maYgOK1xJdeZDhUD7rTb0frem/SWbuGuxGs+4MlRQo0UAs/Fhn2/c31gR5C3SFLrhQE5HMoN58RLKqN9YsHm9PfVdibFdx23DwemWwn3t54suqyS/lcovZcy25FG62aV99Om/MR5ELvyibNbt8sxjJqMtEJ+f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fwj+x7EG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=575Xg/bj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 May 2025 10:33:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746700440;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EcFUfkZ0gztSwEhwHr4JHjVSCVIG9KfSRz5DIHOct+I=;
	b=fwj+x7EGyFA6daulnbDUw+hM6i6v9TWAr7aL3XrJyEoAR4n8E0caqPD2vNOWsMkITk9pvb
	o43767kImtW9lMP4YNTcDDjXIF4+JvlDk/g2+f92erqlW0GXDmq8O09dnNfEV/4BbJlLVH
	wlCM71A034HdI5RVHcEuoBnLEEwDGHQaK5p5P9ZyN6ZYhQg6hWyz8HWBYp+iQJ5lpIZko+
	4zbMIUPEkjcW7/cT+UZ0Xe8eV2zl7zsjCUkUCCJ8g8r5JMe4XMoT6d6e5BmZQ7eKIlNEi2
	dSITjPXg4IEaVkWBqBWtxZwoQ08B0EVD34VxgVM5lfBRUb+DHdydU6bjqXXZnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746700440;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EcFUfkZ0gztSwEhwHr4JHjVSCVIG9KfSRz5DIHOct+I=;
	b=575Xg/bjigI+wbqKkUZ/FPFqIZjt4I7l9eGwb7fD1GLvv9bYNVTGy2j+2gWlqDNaKzcaP/
	szmztHct+viwMECQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/futex] mm: Add vmalloc_huge_node()
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Christoph Hellwig <hch@lst.de>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250416162921.513656-3-bigeasy@linutronix.de>
References: <20250416162921.513656-3-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174670043992.406.11877241430353306379.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/futex branch of tip:

Commit-ID:     55284f70134f01fdc9cc4c4905551cc1f37abd34
Gitweb:        https://git.kernel.org/tip/55284f70134f01fdc9cc4c4905551cc1f37abd34
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 16 Apr 2025 18:29:02 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 03 May 2025 12:02:05 +02:00

mm: Add vmalloc_huge_node()

To enable node specific hash-tables using huge pages if possible.

[bigeasy: use __vmalloc_node_range_noprof(), add nommu bits, inline
vmalloc_huge]

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20250416162921.513656-3-bigeasy@linutronix.de
---
 include/linux/vmalloc.h |  9 +++++++--
 mm/nommu.c              | 18 +++++++++++++++++-
 mm/vmalloc.c            | 11 ++++++-----
 3 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 31e9ffd..de95794 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -168,8 +168,13 @@ void *__vmalloc_node_noprof(unsigned long size, unsigned long align, gfp_t gfp_m
 		int node, const void *caller) __alloc_size(1);
 #define __vmalloc_node(...)	alloc_hooks(__vmalloc_node_noprof(__VA_ARGS__))
 
-void *vmalloc_huge_noprof(unsigned long size, gfp_t gfp_mask) __alloc_size(1);
-#define vmalloc_huge(...)	alloc_hooks(vmalloc_huge_noprof(__VA_ARGS__))
+void *vmalloc_huge_node_noprof(unsigned long size, gfp_t gfp_mask, int node) __alloc_size(1);
+#define vmalloc_huge_node(...)	alloc_hooks(vmalloc_huge_node_noprof(__VA_ARGS__))
+
+static inline void *vmalloc_huge(unsigned long size, gfp_t gfp_mask)
+{
+	return vmalloc_huge_node(size, gfp_mask, NUMA_NO_NODE);
+}
 
 extern void *__vmalloc_array_noprof(size_t n, size_t size, gfp_t flags) __alloc_size(1, 2);
 #define __vmalloc_array(...)	alloc_hooks(__vmalloc_array_noprof(__VA_ARGS__))
diff --git a/mm/nommu.c b/mm/nommu.c
index 617e7ba..70f92f9 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -200,7 +200,23 @@ void *vmalloc_noprof(unsigned long size)
 }
 EXPORT_SYMBOL(vmalloc_noprof);
 
-void *vmalloc_huge_noprof(unsigned long size, gfp_t gfp_mask) __weak __alias(__vmalloc_noprof);
+/*
+ *	vmalloc_huge_node  -  allocate virtually contiguous memory, on a node
+ *
+ *	@size:		allocation size
+ *	@gfp_mask:	flags for the page level allocator
+ *	@node:          node to use for allocation or NUMA_NO_NODE
+ *
+ *	Allocate enough pages to cover @size from the page level
+ *	allocator and map them into contiguous kernel virtual space.
+ *
+ *	Due to NOMMU implications the node argument and HUGE page attribute is
+ *	ignored.
+ */
+void *vmalloc_huge_node_noprof(unsigned long size, gfp_t gfp_mask, int node)
+{
+	return __vmalloc_noprof(size, gfp_mask);
+}
 
 /*
  *	vzalloc - allocate virtually contiguous memory with zero fill
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 3ed720a..8b9f6d3 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3943,9 +3943,10 @@ void *vmalloc_noprof(unsigned long size)
 EXPORT_SYMBOL(vmalloc_noprof);
 
 /**
- * vmalloc_huge - allocate virtually contiguous memory, allow huge pages
+ * vmalloc_huge_node - allocate virtually contiguous memory, allow huge pages
  * @size:      allocation size
  * @gfp_mask:  flags for the page level allocator
+ * @node:	    node to use for allocation or NUMA_NO_NODE
  *
  * Allocate enough pages to cover @size from the page level
  * allocator and map them into contiguous kernel virtual space.
@@ -3954,13 +3955,13 @@ EXPORT_SYMBOL(vmalloc_noprof);
  *
  * Return: pointer to the allocated memory or %NULL on error
  */
-void *vmalloc_huge_noprof(unsigned long size, gfp_t gfp_mask)
+void *vmalloc_huge_node_noprof(unsigned long size, gfp_t gfp_mask, int node)
 {
 	return __vmalloc_node_range_noprof(size, 1, VMALLOC_START, VMALLOC_END,
-				    gfp_mask, PAGE_KERNEL, VM_ALLOW_HUGE_VMAP,
-				    NUMA_NO_NODE, __builtin_return_address(0));
+					   gfp_mask, PAGE_KERNEL, VM_ALLOW_HUGE_VMAP,
+					   node, __builtin_return_address(0));
 }
-EXPORT_SYMBOL_GPL(vmalloc_huge_noprof);
+EXPORT_SYMBOL_GPL(vmalloc_huge_node_noprof);
 
 /**
  * vzalloc - allocate virtually contiguous memory with zero fill

