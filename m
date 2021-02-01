Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0522D30A6A2
	for <lists+linux-tip-commits@lfdr.de>; Mon,  1 Feb 2021 12:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbhBALdt (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 1 Feb 2021 06:33:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbhBALdM (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 1 Feb 2021 06:33:12 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3811AC06174A;
        Mon,  1 Feb 2021 03:32:32 -0800 (PST)
Date:   Mon, 01 Feb 2021 11:32:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612179147;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8/LINtxTocdpokeTUXvfDqgvf1oVW4gUh50Pg2JqTw8=;
        b=NGIYpEARqPfgKL9M4S68p9jxbiA8xScupuZD66Oo57Q/1Scu2yUy26cLphznDK6OYxBN7+
        E7ETVC1n+pKeQL+cXzaf1PJjBuG5pTFyiZ6qCNDxWEdzfjB8mkW6+Or2iRBG+td+jp1k7j
        9biz2NwuS5sSjBmD1oLk9+RvMYCT+3migvBO8a7BJ9F5o7h2yDLywSZgAaaJ+YQZs1XONE
        U+BaPzWP3zI0JwUZ8K7za7Wt2CIQ8RVw6uMmtzT2pjxES8iG9qNzoojeF43INzC7iCqCOo
        MJQ0AUjX4QT+J2gLs59Y9HdQQfiHaKFcysK+9EZYCV2g05zsacy4I5AH4L3QTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612179147;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8/LINtxTocdpokeTUXvfDqgvf1oVW4gUh50Pg2JqTw8=;
        b=4QqFxyfvZ+q/X85Cl2m8HshdhGQX9yyHfqD7p9/YSTpfQVUdHMW0E/9PPsgqpNFSRQP0gF
        IVW4HTKyW2kvdfDw==
From:   "tip-bot2 for Will Deacon" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/mm] mm: proc: Invalidate TLB after clearing soft-dirty page state
Cc:     Will Deacon <will@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Yu Zhao <yuzhao@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210127235347.1402-2-will@kernel.org>
References: <20210127235347.1402-2-will@kernel.org>
MIME-Version: 1.0
Message-ID: <161217914630.23325.2846757263599207705.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/mm branch of tip:

Commit-ID:     912efa17e5121693dfbadae29768f4144a3f9e62
Gitweb:        https://git.kernel.org/tip/912efa17e5121693dfbadae29768f4144a3=
f9e62
Author:        Will Deacon <will@kernel.org>
AuthorDate:    Wed, 27 Jan 2021 23:53:42=20
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 29 Jan 2021 20:02:28 +01:00

mm: proc: Invalidate TLB after clearing soft-dirty page state

Since commit 0758cd830494 ("asm-generic/tlb: avoid potential double
flush"), TLB invalidation is elided in tlb_finish_mmu() if no entries
were batched via the tlb_remove_*() functions. Consequently, the
page-table modifications performed by clear_refs_write() in response to
a write to /proc/<pid>/clear_refs do not perform TLB invalidation.
Although this is fine when simply aging the ptes, in the case of
clearing the "soft-dirty" state we can end up with entries where
pte_write() is false, yet a writable mapping remains in the TLB.

Fix this by avoiding the mmu_gather API altogether: managing both the
'tlb_flush_pending' flag on the 'mm_struct' and explicit TLB
invalidation for the sort-dirty path, much like mprotect() does already.

Fixes: 0758cd830494 ("asm-generic/tlb: avoid potential double flush=E2=80=9D)
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Yu Zhao <yuzhao@google.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lkml.kernel.org/r/20210127235347.1402-2-will@kernel.org
---
 fs/proc/task_mmu.c |  9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 602e3a5..3cec6fb 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1210,7 +1210,6 @@ static ssize_t clear_refs_write(struct file *file, cons=
t char __user *buf,
 	struct mm_struct *mm;
 	struct vm_area_struct *vma;
 	enum clear_refs_types type;
-	struct mmu_gather tlb;
 	int itype;
 	int rv;
=20
@@ -1249,7 +1248,6 @@ static ssize_t clear_refs_write(struct file *file, cons=
t char __user *buf,
 			goto out_unlock;
 		}
=20
-		tlb_gather_mmu(&tlb, mm, 0, -1);
 		if (type =3D=3D CLEAR_REFS_SOFT_DIRTY) {
 			for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
 				if (!(vma->vm_flags & VM_SOFTDIRTY))
@@ -1258,15 +1256,18 @@ static ssize_t clear_refs_write(struct file *file, co=
nst char __user *buf,
 				vma_set_page_prot(vma);
 			}
=20
+			inc_tlb_flush_pending(mm);
 			mmu_notifier_range_init(&range, MMU_NOTIFY_SOFT_DIRTY,
 						0, NULL, mm, 0, -1UL);
 			mmu_notifier_invalidate_range_start(&range);
 		}
 		walk_page_range(mm, 0, mm->highest_vm_end, &clear_refs_walk_ops,
 				&cp);
-		if (type =3D=3D CLEAR_REFS_SOFT_DIRTY)
+		if (type =3D=3D CLEAR_REFS_SOFT_DIRTY) {
 			mmu_notifier_invalidate_range_end(&range);
-		tlb_finish_mmu(&tlb, 0, -1);
+			flush_tlb_mm(mm);
+			dec_tlb_flush_pending(mm);
+		}
 out_unlock:
 		mmap_write_unlock(mm);
 out_mm:
