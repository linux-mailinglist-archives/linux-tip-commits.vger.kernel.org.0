Return-Path: <linux-tip-commits+bounces-5471-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 885AEAAF7F1
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 12:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C5631C07E24
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 10:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9982253AB;
	Thu,  8 May 2025 10:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qlHqwZ6x";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DV8FupgM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83EB2222B8;
	Thu,  8 May 2025 10:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746700435; cv=none; b=QfGeRWOtMvlO6Jlf2grMFtAkILf4mRR1KA+V5uZVG/fZlGkrVwiFxswtD0F+Ezl1p57u4Q5OVO90dj2jEM8n7E7hc3qdVZoh4aW41FJXjCfHFsO4jx1prLKMF3oMQMj+XsNx4HOYzPpZUNJGxytCP4hFHQDAedvkBYIaBKpH6Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746700435; c=relaxed/simple;
	bh=uT33ThfEFTTKyYUD8cJx4Ow5IT8WHRVzt5kKHycak+M=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZPYpiHk5Jy6ljVY5bC1LhLWLo+5gz0yWZBLuaiIDHndjQd0sdzOn1IKF4wNSXMWAwJfVKmuCViMvLDSupNYzQT5j3W273nUz8NNQJ5kqSwem9zMd2RAk4YG3cx+CihnDNuQSk7xi7Jntn0sOG5krcLNrJcbiMFZAZNb3sg11V9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qlHqwZ6x; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DV8FupgM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 May 2025 10:33:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746700430;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uoT1ZZ49Nh5uucRa0lKAtTmIqpgVrNwR9UUee3vYvSY=;
	b=qlHqwZ6xaSgjRABt0QSev8NYOfDfgGr5Tqwxlchty5NF0+4MtYGHiIQophjc0BjwqWbHQa
	fmatj3jrCivxkv658UruS5XUTZs3ONgSWvO2NkdTIgokwk1DEM3Z/uPXrgzIvxxNaZr4NX
	8GFEDMfjhHfcv0oTwIFwENOl1gMk3zbY8oxxLjeADm196E7W7EkmnZPEvC+g9P6tvxyXeH
	zLpp+PO1pUlCK67bTTG92xJ+fK5aDhz5zd4D46kJZNTfw8gukIj6NWscyHMaSdUjqSyw9t
	FNGpLDrqfSpsOVKDe1xykKHNRr/wELBmpJld4PZccyj9fKn0cK39zuV/tyjXxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746700430;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uoT1ZZ49Nh5uucRa0lKAtTmIqpgVrNwR9UUee3vYvSY=;
	b=DV8FupgMDkp0ADqLRlb9yIsRexOoYhjQXs0zUjM5crkmH0BxuY1yx7CKRIWTXq0u/DsHIP
	AFAIu46Qg0oRh9DA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/futex] futex: Implement FUTEX2_NUMA
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250416162921.513656-17-bigeasy@linutronix.de>
References: <20250416162921.513656-17-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174670042954.406.3326605042998207322.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/futex branch of tip:

Commit-ID:     cec199c5e39bde7191a08087cc3d002ccfab31ff
Gitweb:        https://git.kernel.org/tip/cec199c5e39bde7191a08087cc3d002ccfab31ff
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 16 Apr 2025 18:29:16 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 03 May 2025 12:02:09 +02:00

futex: Implement FUTEX2_NUMA

Extend the futex2 interface to be numa aware.

When FUTEX2_NUMA is specified for a futex, the user value is extended
to two words (of the same size). The first is the user value we all
know, the second one will be the node to place this futex on.

  struct futex_numa_32 {
	u32 val;
	u32 node;
  };

When node is set to ~0, WAIT will set it to the current node_id such
that WAKE knows where to find it. If userspace corrupts the node value
between WAIT and WAKE, the futex will not be found and no wakeup will
happen.

When FUTEX2_NUMA is not set, the node is simply an extension of the
hash, such that traditional futexes are still interleaved over the
nodes.

This is done to avoid having to have a separate !numa hash-table.

[bigeasy: ensure to have at least hashsize of 4 in futex_init(), add
pr_info() for size and allocation information. Cast the naddr math to
void*]

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250416162921.513656-17-bigeasy@linutronix.de
---
 include/linux/futex.h      |   3 +-
 include/uapi/linux/futex.h |   7 +++-
 kernel/futex/core.c        | 100 +++++++++++++++++++++++++++++-------
 kernel/futex/futex.h       |  33 ++++++++++--
 4 files changed, 123 insertions(+), 20 deletions(-)

diff --git a/include/linux/futex.h b/include/linux/futex.h
index 40bc778..eccc997 100644
--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -34,6 +34,7 @@ union futex_key {
 		u64 i_seq;
 		unsigned long pgoff;
 		unsigned int offset;
+		/* unsigned int node; */
 	} shared;
 	struct {
 		union {
@@ -42,11 +43,13 @@ union futex_key {
 		};
 		unsigned long address;
 		unsigned int offset;
+		/* unsigned int node; */
 	} private;
 	struct {
 		u64 ptr;
 		unsigned long word;
 		unsigned int offset;
+		unsigned int node;	/* NOT hashed! */
 	} both;
 };
 
diff --git a/include/uapi/linux/futex.h b/include/uapi/linux/futex.h
index d2ee625..6b94da4 100644
--- a/include/uapi/linux/futex.h
+++ b/include/uapi/linux/futex.h
@@ -75,6 +75,13 @@
 #define FUTEX_32		FUTEX2_SIZE_U32 /* historical accident :-( */
 
 /*
+ * When FUTEX2_NUMA doubles the futex word, the second word is a node value.
+ * The special value -1 indicates no-node. This is the same value as
+ * NUMA_NO_NODE, except that value is not ABI, this is.
+ */
+#define FUTEX_NO_NODE		(-1)
+
+/*
  * Max numbers of elements in a futex_waitv array
  */
 #define FUTEX_WAITV_MAX		128
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 8054fda..1490e64 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -36,6 +36,8 @@
 #include <linux/pagemap.h>
 #include <linux/debugfs.h>
 #include <linux/plist.h>
+#include <linux/gfp.h>
+#include <linux/vmalloc.h>
 #include <linux/memblock.h>
 #include <linux/fault-inject.h>
 #include <linux/slab.h>
@@ -51,11 +53,14 @@
  * reside in the same cacheline.
  */
 static struct {
-	struct futex_hash_bucket *queues;
 	unsigned long            hashmask;
+	unsigned int		 hashshift;
+	struct futex_hash_bucket *queues[MAX_NUMNODES];
 } __futex_data __read_mostly __aligned(2*sizeof(long));
-#define futex_queues   (__futex_data.queues)
-#define futex_hashmask (__futex_data.hashmask)
+
+#define futex_hashmask	(__futex_data.hashmask)
+#define futex_hashshift	(__futex_data.hashshift)
+#define futex_queues	(__futex_data.queues)
 
 struct futex_private_hash {
 	rcuref_t	users;
@@ -339,15 +344,35 @@ __futex_hash(union futex_key *key, struct futex_private_hash *fph)
 {
 	struct futex_hash_bucket *hb;
 	u32 hash;
+	int node;
 
 	hb = __futex_hash_private(key, fph);
 	if (hb)
 		return hb;
 
 	hash = jhash2((u32 *)key,
-		      offsetof(typeof(*key), both.offset) / 4,
+		      offsetof(typeof(*key), both.offset) / sizeof(u32),
 		      key->both.offset);
-	return &futex_queues[hash & futex_hashmask];
+	node = key->both.node;
+
+	if (node == FUTEX_NO_NODE) {
+		/*
+		 * In case of !FLAGS_NUMA, use some unused hash bits to pick a
+		 * node -- this ensures regular futexes are interleaved across
+		 * the nodes and avoids having to allocate multiple
+		 * hash-tables.
+		 *
+		 * NOTE: this isn't perfectly uniform, but it is fast and
+		 * handles sparse node masks.
+		 */
+		node = (hash >> futex_hashshift) % nr_node_ids;
+		if (!node_possible(node)) {
+			node = find_next_bit_wrap(node_possible_map.bits,
+						  nr_node_ids, node);
+		}
+	}
+
+	return &futex_queues[node][hash & futex_hashmask];
 }
 
 /**
@@ -454,25 +479,49 @@ int get_futex_key(u32 __user *uaddr, unsigned int flags, union futex_key *key,
 	struct page *page;
 	struct folio *folio;
 	struct address_space *mapping;
-	int err, ro = 0;
+	int node, err, size, ro = 0;
 	bool fshared;
 
 	fshared = flags & FLAGS_SHARED;
+	size = futex_size(flags);
+	if (flags & FLAGS_NUMA)
+		size *= 2;
 
 	/*
 	 * The futex address must be "naturally" aligned.
 	 */
 	key->both.offset = address % PAGE_SIZE;
-	if (unlikely((address % sizeof(u32)) != 0))
+	if (unlikely((address % size) != 0))
 		return -EINVAL;
 	address -= key->both.offset;
 
-	if (unlikely(!access_ok(uaddr, sizeof(u32))))
+	if (unlikely(!access_ok(uaddr, size)))
 		return -EFAULT;
 
 	if (unlikely(should_fail_futex(fshared)))
 		return -EFAULT;
 
+	if (flags & FLAGS_NUMA) {
+		u32 __user *naddr = (void *)uaddr + size / 2;
+
+		if (futex_get_value(&node, naddr))
+			return -EFAULT;
+
+		if (node == FUTEX_NO_NODE) {
+			node = numa_node_id();
+			if (futex_put_value(node, naddr))
+				return -EFAULT;
+
+		} else if (node >= MAX_NUMNODES || !node_possible(node)) {
+			return -EINVAL;
+		}
+
+		key->both.node = node;
+
+	} else {
+		key->both.node = FUTEX_NO_NODE;
+	}
+
 	/*
 	 * PROCESS_PRIVATE futexes are fast.
 	 * As the mm cannot disappear under us and the 'key' only needs
@@ -1642,24 +1691,41 @@ int futex_hash_prctl(unsigned long arg2, unsigned long arg3, unsigned long arg4)
 static int __init futex_init(void)
 {
 	unsigned long hashsize, i;
-	unsigned int futex_shift;
+	unsigned int order, n;
+	unsigned long size;
 
 #ifdef CONFIG_BASE_SMALL
 	hashsize = 16;
 #else
-	hashsize = roundup_pow_of_two(256 * num_possible_cpus());
+	hashsize = 256 * num_possible_cpus();
+	hashsize /= num_possible_nodes();
+	hashsize = max(4, hashsize);
+	hashsize = roundup_pow_of_two(hashsize);
 #endif
+	futex_hashshift = ilog2(hashsize);
+	size = sizeof(struct futex_hash_bucket) * hashsize;
+	order = get_order(size);
 
-	futex_queues = alloc_large_system_hash("futex", sizeof(*futex_queues),
-					       hashsize, 0, 0,
-					       &futex_shift, NULL,
-					       hashsize, hashsize);
-	hashsize = 1UL << futex_shift;
+	for_each_node(n) {
+		struct futex_hash_bucket *table;
 
-	for (i = 0; i < hashsize; i++)
-		futex_hash_bucket_init(&futex_queues[i], NULL);
+		if (order > MAX_PAGE_ORDER)
+			table = vmalloc_huge_node(size, GFP_KERNEL, n);
+		else
+			table = alloc_pages_exact_nid(n, size, GFP_KERNEL);
+
+		BUG_ON(!table);
+
+		for (i = 0; i < hashsize; i++)
+			futex_hash_bucket_init(&table[i], NULL);
+
+		futex_queues[n] = table;
+	}
 
 	futex_hashmask = hashsize - 1;
+	pr_info("futex hash table entries: %lu (%lu bytes on %d NUMA nodes, total %lu KiB, %s).\n",
+		hashsize, size, num_possible_nodes(), size * num_possible_nodes() / 1024,
+		order > MAX_PAGE_ORDER ? "vmalloc" : "linear");
 	return 0;
 }
 core_initcall(futex_init);
diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index 899aed5..acc7953 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -54,7 +54,7 @@ static inline unsigned int futex_to_flags(unsigned int op)
 	return flags;
 }
 
-#define FUTEX2_VALID_MASK (FUTEX2_SIZE_MASK | FUTEX2_PRIVATE)
+#define FUTEX2_VALID_MASK (FUTEX2_SIZE_MASK | FUTEX2_NUMA | FUTEX2_PRIVATE)
 
 /* FUTEX2_ to FLAGS_ */
 static inline unsigned int futex2_to_flags(unsigned int flags2)
@@ -87,6 +87,19 @@ static inline bool futex_flags_valid(unsigned int flags)
 	if ((flags & FLAGS_SIZE_MASK) != FLAGS_SIZE_32)
 		return false;
 
+	/*
+	 * Must be able to represent both FUTEX_NO_NODE and every valid nodeid
+	 * in a futex word.
+	 */
+	if (flags & FLAGS_NUMA) {
+		int bits = 8 * futex_size(flags);
+		u64 max = ~0ULL;
+
+		max >>= 64 - bits;
+		if (nr_node_ids >= max)
+			return false;
+	}
+
 	return true;
 }
 
@@ -282,7 +295,7 @@ static inline int futex_cmpxchg_value_locked(u32 *curval, u32 __user *uaddr, u32
  * This looks a bit overkill, but generally just results in a couple
  * of instructions.
  */
-static __always_inline int futex_read_inatomic(u32 *dest, u32 __user *from)
+static __always_inline int futex_get_value(u32 *dest, u32 __user *from)
 {
 	u32 val;
 
@@ -299,12 +312,26 @@ Efault:
 	return -EFAULT;
 }
 
+static __always_inline int futex_put_value(u32 val, u32 __user *to)
+{
+	if (can_do_masked_user_access())
+		to = masked_user_access_begin(to);
+	else if (!user_read_access_begin(to, sizeof(*to)))
+		return -EFAULT;
+	unsafe_put_user(val, to, Efault);
+	user_read_access_end();
+	return 0;
+Efault:
+	user_read_access_end();
+	return -EFAULT;
+}
+
 static inline int futex_get_value_locked(u32 *dest, u32 __user *from)
 {
 	int ret;
 
 	pagefault_disable();
-	ret = futex_read_inatomic(dest, from);
+	ret = futex_get_value(dest, from);
 	pagefault_enable();
 
 	return ret;

