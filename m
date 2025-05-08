Return-Path: <linux-tip-commits+bounces-5469-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41430AAF7EA
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 12:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5453B1C0652E
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 10:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD7A22332B;
	Thu,  8 May 2025 10:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2i1Jp4Ad";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5wWDNr8R"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D36A220F4D;
	Thu,  8 May 2025 10:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746700433; cv=none; b=KofPuceXNNEyi9ty9d8fOW+1t/AjLrPQ1Bnd+Ng+zFkih9QgTqyaYO9jpFdifZxlm9lYkeruXbJqG+DONveKb+HHmH3afz1gVMGa9AE6RKrVrpysa4Agk0tJdAOQPquMTqGCxtdellW5WlD/VbRL9ui3QLZ43lsQUOFrkAcfqf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746700433; c=relaxed/simple;
	bh=98eUnWNb55YjmFNxlDfT4WOYmvJyGWHpgrHaXNM1K10=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ObkMXP9Hvjqlps0a8oQO4xINIuv8+FPTgoA8eCiXO9OgdCn/2oHlZXfEAsMa0yzOVC1Kz+PXGCyS9e8T1oi4MDHazxzYHvZHsnUscGJmIv2EEau42CKogJSGosF53AXWNliCN6xhSLUoLf19IpIcYXn1QihBvJ6Zxc/FzQrwOHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2i1Jp4Ad; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5wWDNr8R; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 May 2025 10:33:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746700429;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vi/3jjGfR/LGYpXh+CUnNWYUp+0vmninNYoz5u/kLiI=;
	b=2i1Jp4AdegFed6C7L/RxHOjnuKCO7miVNQjYJN42FejWDwzJugsCHmTe86ujbSG5LDLMOm
	tpok4YYrbkpsYrwLgl3nolNEoIeTE4Bri3Mo0i6iHkXcFkxbfTYD33oht+RNO9sM2Vjflm
	5PZZwZT7qeFF7OY+tF3ulEErt6AtxwcNavKCXJ+aGpYesuURW8z/PgYMuwNGFM8XZYXLKR
	14Hi+FYbgOLv8urF7ncf202zIJLInnhh5qXgw07J0LNPvxJtjHRCqFa6W7d4zJgWAI57Bb
	vFfO5FZnkbgJtki2xcJp0oj1I4XQzr+O2UbBhyE6UrMfDz1NmxYpgP6fO9WqLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746700429;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vi/3jjGfR/LGYpXh+CUnNWYUp+0vmninNYoz5u/kLiI=;
	b=5wWDNr8RRdg7thMniGTX5yB/9UHfilPFGIl6QURqAJQPTu+lJDaIz6UT9K25QAias1tEhX
	H+IQp07zoea6bkDA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/futex] futex: Implement FUTEX2_MPOL
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250416162921.513656-18-bigeasy@linutronix.de>
References: <20250416162921.513656-18-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174670042876.406.4365999547221575535.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/futex branch of tip:

Commit-ID:     c042c505210dc3453f378df432c10fff3d471bc5
Gitweb:        https://git.kernel.org/tip/c042c505210dc3453f378df432c10fff3d471bc5
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 16 Apr 2025 18:29:17 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 03 May 2025 12:02:09 +02:00

futex: Implement FUTEX2_MPOL

Extend the futex2 interface to be aware of mempolicy.

When FUTEX2_MPOL is specified and there is a MPOL_PREFERRED or
home_node specified covering the futex address, use that hash-map.

Notably, in this case the futex will go to the global node hashtable,
even if it is a PRIVATE futex.

When FUTEX2_NUMA|FUTEX2_MPOL is specified and the user specified node
value is FUTEX_NO_NODE, the MPOL lookup (as described above) will be
tried first before reverting to setting node to the local node.

[bigeasy: add CONFIG_FUTEX_MPOL, add MPOL to FUTEX2_VALID_MASK, write
the node only to user if FUTEX_NO_NODE was supplied]

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250416162921.513656-18-bigeasy@linutronix.de
---
 include/linux/mmap_lock.h  |   4 +-
 include/uapi/linux/futex.h |   2 +-
 init/Kconfig               |   5 ++-
 kernel/futex/core.c        | 116 +++++++++++++++++++++++++++++++-----
 kernel/futex/futex.h       |   6 +-
 5 files changed, 115 insertions(+), 18 deletions(-)

diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index 4706c67..e0eddfd 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -7,6 +7,7 @@
 #include <linux/rwsem.h>
 #include <linux/tracepoint-defs.h>
 #include <linux/types.h>
+#include <linux/cleanup.h>
 
 #define MMAP_LOCK_INITIALIZER(name) \
 	.mmap_lock = __RWSEM_INITIALIZER((name).mmap_lock),
@@ -211,6 +212,9 @@ static inline void mmap_read_unlock(struct mm_struct *mm)
 	up_read(&mm->mmap_lock);
 }
 
+DEFINE_GUARD(mmap_read_lock, struct mm_struct *,
+	     mmap_read_lock(_T), mmap_read_unlock(_T))
+
 static inline void mmap_read_unlock_non_owner(struct mm_struct *mm)
 {
 	__mmap_lock_trace_released(mm, false);
diff --git a/include/uapi/linux/futex.h b/include/uapi/linux/futex.h
index 6b94da4..7e2744e 100644
--- a/include/uapi/linux/futex.h
+++ b/include/uapi/linux/futex.h
@@ -63,7 +63,7 @@
 #define FUTEX2_SIZE_U32		0x02
 #define FUTEX2_SIZE_U64		0x03
 #define FUTEX2_NUMA		0x04
-			/*	0x08 */
+#define FUTEX2_MPOL		0x08
 			/*	0x10 */
 			/*	0x20 */
 			/*	0x40 */
diff --git a/init/Kconfig b/init/Kconfig
index 4b84da2..b373267 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1704,6 +1704,11 @@ config FUTEX_PRIVATE_HASH
 	depends on FUTEX && !BASE_SMALL && MMU
 	default y
 
+config FUTEX_MPOL
+	bool
+	depends on FUTEX && NUMA
+	default y
+
 config EPOLL
 	bool "Enable eventpoll support" if EXPERT
 	default y
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 1490e64..19a2c65 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -43,6 +43,8 @@
 #include <linux/slab.h>
 #include <linux/prctl.h>
 #include <linux/rcuref.h>
+#include <linux/mempolicy.h>
+#include <linux/mmap_lock.h>
 
 #include "futex.h"
 #include "../locking/rtmutex_common.h"
@@ -328,6 +330,75 @@ struct futex_hash_bucket *futex_hash(union futex_key *key)
 
 #endif /* CONFIG_FUTEX_PRIVATE_HASH */
 
+#ifdef CONFIG_FUTEX_MPOL
+
+static int __futex_key_to_node(struct mm_struct *mm, unsigned long addr)
+{
+	struct vm_area_struct *vma = vma_lookup(mm, addr);
+	struct mempolicy *mpol;
+	int node = FUTEX_NO_NODE;
+
+	if (!vma)
+		return FUTEX_NO_NODE;
+
+	mpol = vma_policy(vma);
+	if (!mpol)
+		return FUTEX_NO_NODE;
+
+	switch (mpol->mode) {
+	case MPOL_PREFERRED:
+		node = first_node(mpol->nodes);
+		break;
+	case MPOL_PREFERRED_MANY:
+	case MPOL_BIND:
+		if (mpol->home_node != NUMA_NO_NODE)
+			node = mpol->home_node;
+		break;
+	default:
+		break;
+	}
+
+	return node;
+}
+
+static int futex_key_to_node_opt(struct mm_struct *mm, unsigned long addr)
+{
+	int seq, node;
+
+	guard(rcu)();
+
+	if (!mmap_lock_speculate_try_begin(mm, &seq))
+		return -EBUSY;
+
+	node = __futex_key_to_node(mm, addr);
+
+	if (mmap_lock_speculate_retry(mm, seq))
+		return -EAGAIN;
+
+	return node;
+}
+
+static int futex_mpol(struct mm_struct *mm, unsigned long addr)
+{
+	int node;
+
+	node = futex_key_to_node_opt(mm, addr);
+	if (node >= FUTEX_NO_NODE)
+		return node;
+
+	guard(mmap_read_lock)(mm);
+	return __futex_key_to_node(mm, addr);
+}
+
+#else /* !CONFIG_FUTEX_MPOL */
+
+static int futex_mpol(struct mm_struct *mm, unsigned long addr)
+{
+	return FUTEX_NO_NODE;
+}
+
+#endif /* CONFIG_FUTEX_MPOL */
+
 /**
  * __futex_hash - Return the hash bucket
  * @key:	Pointer to the futex key for which the hash is calculated
@@ -342,18 +413,20 @@ struct futex_hash_bucket *futex_hash(union futex_key *key)
 static struct futex_hash_bucket *
 __futex_hash(union futex_key *key, struct futex_private_hash *fph)
 {
-	struct futex_hash_bucket *hb;
+	int node = key->both.node;
 	u32 hash;
-	int node;
 
-	hb = __futex_hash_private(key, fph);
-	if (hb)
-		return hb;
+	if (node == FUTEX_NO_NODE) {
+		struct futex_hash_bucket *hb;
+
+		hb = __futex_hash_private(key, fph);
+		if (hb)
+			return hb;
+	}
 
 	hash = jhash2((u32 *)key,
 		      offsetof(typeof(*key), both.offset) / sizeof(u32),
 		      key->both.offset);
-	node = key->both.node;
 
 	if (node == FUTEX_NO_NODE) {
 		/*
@@ -480,6 +553,7 @@ int get_futex_key(u32 __user *uaddr, unsigned int flags, union futex_key *key,
 	struct folio *folio;
 	struct address_space *mapping;
 	int node, err, size, ro = 0;
+	bool node_updated = false;
 	bool fshared;
 
 	fshared = flags & FLAGS_SHARED;
@@ -501,27 +575,37 @@ int get_futex_key(u32 __user *uaddr, unsigned int flags, union futex_key *key,
 	if (unlikely(should_fail_futex(fshared)))
 		return -EFAULT;
 
+	node = FUTEX_NO_NODE;
+
 	if (flags & FLAGS_NUMA) {
 		u32 __user *naddr = (void *)uaddr + size / 2;
 
 		if (futex_get_value(&node, naddr))
 			return -EFAULT;
 
-		if (node == FUTEX_NO_NODE) {
-			node = numa_node_id();
-			if (futex_put_value(node, naddr))
-				return -EFAULT;
-
-		} else if (node >= MAX_NUMNODES || !node_possible(node)) {
+		if (node != FUTEX_NO_NODE &&
+		    (node >= MAX_NUMNODES || !node_possible(node)))
 			return -EINVAL;
-		}
+	}
 
-		key->both.node = node;
+	if (node == FUTEX_NO_NODE && (flags & FLAGS_MPOL)) {
+		node = futex_mpol(mm, address);
+		node_updated = true;
+	}
 
-	} else {
-		key->both.node = FUTEX_NO_NODE;
+	if (flags & FLAGS_NUMA) {
+		u32 __user *naddr = (void *)uaddr + size / 2;
+
+		if (node == FUTEX_NO_NODE) {
+			node = numa_node_id();
+			node_updated = true;
+		}
+		if (node_updated && futex_put_value(node, naddr))
+			return -EFAULT;
 	}
 
+	key->both.node = node;
+
 	/*
 	 * PROCESS_PRIVATE futexes are fast.
 	 * As the mm cannot disappear under us and the 'key' only needs
diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index acc7953..069fc2a 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -39,6 +39,7 @@
 #define FLAGS_HAS_TIMEOUT	0x0040
 #define FLAGS_NUMA		0x0080
 #define FLAGS_STRICT		0x0100
+#define FLAGS_MPOL		0x0200
 
 /* FUTEX_ to FLAGS_ */
 static inline unsigned int futex_to_flags(unsigned int op)
@@ -54,7 +55,7 @@ static inline unsigned int futex_to_flags(unsigned int op)
 	return flags;
 }
 
-#define FUTEX2_VALID_MASK (FUTEX2_SIZE_MASK | FUTEX2_NUMA | FUTEX2_PRIVATE)
+#define FUTEX2_VALID_MASK (FUTEX2_SIZE_MASK | FUTEX2_NUMA | FUTEX2_MPOL | FUTEX2_PRIVATE)
 
 /* FUTEX2_ to FLAGS_ */
 static inline unsigned int futex2_to_flags(unsigned int flags2)
@@ -67,6 +68,9 @@ static inline unsigned int futex2_to_flags(unsigned int flags2)
 	if (flags2 & FUTEX2_NUMA)
 		flags |= FLAGS_NUMA;
 
+	if (flags2 & FUTEX2_MPOL)
+		flags |= FLAGS_MPOL;
+
 	return flags;
 }
 

