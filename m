Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDEA33F083
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Mar 2021 13:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbhCQMij (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Mar 2021 08:38:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49764 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbhCQMi3 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Mar 2021 08:38:29 -0400
Date:   Wed, 17 Mar 2021 12:38:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615984708;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M0lUdGEkmJVWbjEAsxHbVVCn26APtUZuSk7lTZDFCs4=;
        b=XkqXQjDJOT6WhXBzogJ64CabbLqy6mAHbmaCAczraXkpyrPhZsUkXGY26mnYsFUgdfGbZH
        HDj9r+SwR7D7YYlZFEXpZz+ICG0a8AaACvz7q1LKSGtxvHhzHqWMhtDUt+rQXoC0a4iHr/
        wa892jkohfaqVkvA7DOKPvCUsBnr778xWcVOgXg5ro73DSH9lrnw9Z1GFFq7RYm9py2wvx
        hMVb5B5PUFjtyEdg6KbZQSGrbhDpQAp4pFLbLv2OnyfypkFOTcFNyuuZ6rF1of1mUEH+1P
        zhYG+XGB69ghcR6Ms5cV8XLGw0p1qbUTzDjonCZGSVdig35UOAQhW8mbUjbNzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615984708;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M0lUdGEkmJVWbjEAsxHbVVCn26APtUZuSk7lTZDFCs4=;
        b=MLwcXdlOKHUGJdqB4hc/SJCK+satPfd/hAXuAqFrRrbvgt6KTfbQJVqgZkfbxmDv1lu9N/
        vE9LVNGi/EagcuDQ==
From:   "tip-bot2 for Nicholas Piggin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/wait_bit, mm/filemap: Increase page and bit
 waitqueue hash size
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210317075427.587806-1-npiggin@gmail.com>
References: <20210317075427.587806-1-npiggin@gmail.com>
MIME-Version: 1.0
Message-ID: <161598470782.398.7078277215554525953.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     873d7c4c6a920d43ff82e44121e54053d4edba93
Gitweb:        https://git.kernel.org/tip/873d7c4c6a920d43ff82e44121e54053d4edba93
Author:        Nicholas Piggin <npiggin@gmail.com>
AuthorDate:    Wed, 17 Mar 2021 17:54:27 +10:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 17 Mar 2021 09:32:30 +01:00

sched/wait_bit, mm/filemap: Increase page and bit waitqueue hash size

The page waitqueue hash is a bit small (256 entries) on very big systems. A
16 socket 1536 thread POWER9 system was found to encounter hash collisions
and excessive time in waitqueue locking at times. This was intermittent and
hard to reproduce easily with the setup we had (very little real IO
capacity). The theory is that sometimes (depending on allocation luck)
important pages would happen to collide a lot in the hash, slowing down page
locking, causing the problem to snowball.

An small test case was made where threads would write and fsync different
pages, generating just a small amount of contention across many pages.

Increasing page waitqueue hash size to 262144 entries increased throughput
by 182% while also reducing standard deviation 3x. perf before the increase:

  36.23%  [k] _raw_spin_lock_irqsave                -      -
              |
              |--34.60%--wake_up_page_bit
              |          0
              |          iomap_write_end.isra.38
              |          iomap_write_actor
              |          iomap_apply
              |          iomap_file_buffered_write
              |          xfs_file_buffered_aio_write
              |          new_sync_write

  17.93%  [k] native_queued_spin_lock_slowpath      -      -
              |
              |--16.74%--_raw_spin_lock_irqsave
              |          |
              |           --16.44%--wake_up_page_bit
              |                     iomap_write_end.isra.38
              |                     iomap_write_actor
              |                     iomap_apply
              |                     iomap_file_buffered_write
              |                     xfs_file_buffered_aio_write

This patch uses alloc_large_system_hash to allocate a bigger system hash
that scales somewhat with memory size. The bit/var wait-queue is also
changed to keep code matching, albiet with a smaller scale factor.

A very small CONFIG_BASE_SMALL option is also added because these are two
of the biggest static objects in the image on very small systems.

This hash could be made per-node, which may help reduce remote accesses
on well localised workloads, but that adds some complexity with indexing
and hotplug, so until we get a less artificial workload to test with,
keep it simple.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: https://lore.kernel.org/r/20210317075427.587806-1-npiggin@gmail.com
---
 kernel/sched/wait_bit.c | 30 +++++++++++++++++++++++-------
 mm/filemap.c            | 24 +++++++++++++++++++++---
 2 files changed, 44 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/wait_bit.c b/kernel/sched/wait_bit.c
index 02ce292..dba73de 100644
--- a/kernel/sched/wait_bit.c
+++ b/kernel/sched/wait_bit.c
@@ -2,19 +2,24 @@
 /*
  * The implementation of the wait_bit*() and related waiting APIs:
  */
+#include <linux/memblock.h>
 #include "sched.h"
 
-#define WAIT_TABLE_BITS 8
-#define WAIT_TABLE_SIZE (1 << WAIT_TABLE_BITS)
-
-static wait_queue_head_t bit_wait_table[WAIT_TABLE_SIZE] __cacheline_aligned;
+#define BIT_WAIT_TABLE_SIZE (1 << bit_wait_table_bits)
+#if CONFIG_BASE_SMALL
+static const unsigned int bit_wait_table_bits = 3;
+static wait_queue_head_t bit_wait_table[BIT_WAIT_TABLE_SIZE] __cacheline_aligned;
+#else
+static unsigned int bit_wait_table_bits __ro_after_init;
+static wait_queue_head_t *bit_wait_table __ro_after_init;
+#endif
 
 wait_queue_head_t *bit_waitqueue(void *word, int bit)
 {
 	const int shift = BITS_PER_LONG == 32 ? 5 : 6;
 	unsigned long val = (unsigned long)word << shift | bit;
 
-	return bit_wait_table + hash_long(val, WAIT_TABLE_BITS);
+	return bit_wait_table + hash_long(val, bit_wait_table_bits);
 }
 EXPORT_SYMBOL(bit_waitqueue);
 
@@ -152,7 +157,7 @@ EXPORT_SYMBOL(wake_up_bit);
 
 wait_queue_head_t *__var_waitqueue(void *p)
 {
-	return bit_wait_table + hash_ptr(p, WAIT_TABLE_BITS);
+	return bit_wait_table + hash_ptr(p, bit_wait_table_bits);
 }
 EXPORT_SYMBOL(__var_waitqueue);
 
@@ -246,6 +251,17 @@ void __init wait_bit_init(void)
 {
 	int i;
 
-	for (i = 0; i < WAIT_TABLE_SIZE; i++)
+	if (!CONFIG_BASE_SMALL) {
+		bit_wait_table = alloc_large_system_hash("bit waitqueue hash",
+							sizeof(wait_queue_head_t),
+							0,
+							22,
+							0,
+							&bit_wait_table_bits,
+							NULL,
+							0,
+							0);
+	}
+	for (i = 0; i < BIT_WAIT_TABLE_SIZE; i++)
 		init_waitqueue_head(bit_wait_table + i);
 }
diff --git a/mm/filemap.c b/mm/filemap.c
index 4370048..dbbb5b9 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -34,6 +34,7 @@
 #include <linux/security.h>
 #include <linux/cpuset.h>
 #include <linux/hugetlb.h>
+#include <linux/memblock.h>
 #include <linux/memcontrol.h>
 #include <linux/cleancache.h>
 #include <linux/shmem_fs.h>
@@ -990,19 +991,36 @@ EXPORT_SYMBOL(__page_cache_alloc);
  * at a cost of "thundering herd" phenomena during rare hash
  * collisions.
  */
-#define PAGE_WAIT_TABLE_BITS 8
-#define PAGE_WAIT_TABLE_SIZE (1 << PAGE_WAIT_TABLE_BITS)
+#define PAGE_WAIT_TABLE_SIZE (1 << page_wait_table_bits)
+#if CONFIG_BASE_SMALL
+static const unsigned int page_wait_table_bits = 4;
 static wait_queue_head_t page_wait_table[PAGE_WAIT_TABLE_SIZE] __cacheline_aligned;
+#else
+static unsigned int page_wait_table_bits __ro_after_init;
+static wait_queue_head_t *page_wait_table __ro_after_init;
+#endif
 
 static wait_queue_head_t *page_waitqueue(struct page *page)
 {
-	return &page_wait_table[hash_ptr(page, PAGE_WAIT_TABLE_BITS)];
+	return &page_wait_table[hash_ptr(page, page_wait_table_bits)];
 }
 
 void __init pagecache_init(void)
 {
 	int i;
 
+	if (!CONFIG_BASE_SMALL) {
+		page_wait_table = alloc_large_system_hash("page waitqueue hash",
+							sizeof(wait_queue_head_t),
+							0,
+							21,
+							0,
+							&page_wait_table_bits,
+							NULL,
+							0,
+							0);
+	}
+
 	for (i = 0; i < PAGE_WAIT_TABLE_SIZE; i++)
 		init_waitqueue_head(&page_wait_table[i]);
 
