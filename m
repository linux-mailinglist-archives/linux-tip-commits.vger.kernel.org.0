Return-Path: <linux-tip-commits+bounces-3802-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA57A4C0FB
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 13:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3937918851EF
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 12:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9AF1EE7C6;
	Mon,  3 Mar 2025 12:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HG5bAIKj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1uMmePvw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6891F19A;
	Mon,  3 Mar 2025 12:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741006250; cv=none; b=dF1nTq0MwE9u59V03RjLFagWdj6dThwdAUQ5PzO5QauyBItoewfvzQ6tVpL1KUa7H6hRMOwVlm6YdtVCrwd8kr+GRxAv9JLsndUuDTW2vhIwTs/IWAYTI4xe9HTo689OMkT0541Qq8S3GcDWEx9d/7bQUeU4p1K450BDVf+ucCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741006250; c=relaxed/simple;
	bh=jKFWUEr4H2/w0nnELNAAEBCa2v1mA7owLO7zk59NIT8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LbO9tiWcMXfgr9F6O+tbIaB0Ob39qA0KGqPVg1pFCJTl8TWWuuvKb5P44n7U4QI4xvqHgLq1QUMFbmIOAV+McJEVkL54kX97Cv3sOIKphM9TOE/tl6yFFX5Ko/74R67+N1RRODibWg7uRKoOY9eYyZykTyUWYLLebIEgVZyD0fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HG5bAIKj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1uMmePvw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Mar 2025 12:50:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741006245;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NEmE9ahNwEwwTzjxMNYxU2gdgR31Xbk7JVVOcGVbkMM=;
	b=HG5bAIKjpNZP/YqTbIobzNqhviyfBuPe7h3C7+uN9OvHUWZnqbINkvYXHBt9u9WcyK6LjP
	aMtmxSudc24/BtYndyJXtzLCIzslefPytFZMK47WivZ2VF1AgYOZEdcsQXIrNMqs7ogqgn
	tSlu3DNfgwOrpQHufsCvD/rwvn+4f0gsHyWrGqeCI6unSuCKoM1F4tf1ZrVV8JkMaQx0Rr
	Z1MGwMPl5jjb8mzrXvctGjRACAjM4gA4FWswEEUCEQrKcPdhXyLZj0r34jpmC5PNYsTCUn
	g4UfxYnJcLW1wQ2xVG0qJ+WLVvVYLdVOaz6uJAc0LKvvdSYHtTaf9BHV7jebPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741006245;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NEmE9ahNwEwwTzjxMNYxU2gdgR31Xbk7JVVOcGVbkMM=;
	b=1uMmePvwDQ7NbIGtTEOTYZUjqeVJU390qeiZfKMUxJ0Ciy0pCFBn5xzuzfMcNhNJVVnbaZ
	1YqhGLggyeUoYoAw==
From: "tip-bot2 for David Hildenbrand" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm/pat: Fix VM_PAT handling when fork() fails in
 copy_page_range()
Cc: xingwei lee <xrivendell7@gmail.com>, yuxin wang <wang1315768607@163.com>,
 Marius Fleischer <fleischermarius@gmail.com>,
 David Hildenbrand <david@redhat.com>, Ingo Molnar <mingo@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Rik van Riel <riel@surriel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Xu <peterx@redhat.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241029210331.1339581-1-david@redhat.com>
References: <20241029210331.1339581-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174100624258.10177.4534865061014070904.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     4e1c520c95849e16f8dfbcacbfd37be5330447b9
Gitweb:        https://git.kernel.org/tip/4e1c520c95849e16f8dfbcacbfd37be5330447b9
Author:        David Hildenbrand <david@redhat.com>
AuthorDate:    Tue, 29 Oct 2024 22:03:31 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 03 Mar 2025 13:39:14 +01:00

x86/mm/pat: Fix VM_PAT handling when fork() fails in copy_page_range()

If track_pfn_copy() fails, we already added the dst VMA to the maple
tree. As fork() fails, we'll cleanup the maple tree, and stumble over
the dst VMA for which we neither performed any reservation nor copied
any page tables.

Consequently untrack_pfn() will see VM_PAT and try obtaining the
PAT information from the page table -- which fails because the page
table was not copied.

The easiest fix would be to simply clear the VM_PAT flag of the dst VMA
if track_pfn_copy() fails. However, the whole thing is about "simply"
clearing the VM_PAT flag is shaky as well: if we passed track_pfn_copy()
and performed a reservation, but copying the page tables fails, we'll
simply clear the VM_PAT flag, not properly undoing the reservation ...
which is also wrong.

So let's fix it properly: set the VM_PAT flag only if the reservation
succeeded (leaving it clear initially), and undo the reservation if
anything goes wrong while copying the page tables: clearing the VM_PAT
flag after undoing the reservation.

Note that any copied page table entries will get zapped when the VMA will
get removed later, after copy_page_range() succeeded; as VM_PAT is not set
then, we won't try cleaning VM_PAT up once more and untrack_pfn() will be
happy. Note that leaving these page tables in place without a reservation
is not a problem, as we are aborting fork(); this process will never run.

A reproducer can trigger this usually at the first try:

  https://gitlab.com/davidhildenbrand/scratchspace/-/raw/main/reproducers/pat_fork.c

  [   45.239440] WARNING: CPU: 26 PID: 11650 at arch/x86/mm/pat/memtype.c:983 get_pat_info+0xf6/0x110
  [   45.241082] Modules linked in: ...
  [   45.249119] CPU: 26 UID: 0 PID: 11650 Comm: repro3 Not tainted 6.12.0-rc5+ #92
  [   45.250598] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-2.fc40 04/01/2014
  [   45.252181] RIP: 0010:get_pat_info+0xf6/0x110
  ...
  [   45.268513] Call Trace:
  [   45.269003]  <TASK>
  [   45.269425]  ? __warn.cold+0xb7/0x14d
  [   45.270131]  ? get_pat_info+0xf6/0x110
  [   45.270846]  ? report_bug+0xff/0x140
  [   45.271519]  ? handle_bug+0x58/0x90
  [   45.272192]  ? exc_invalid_op+0x17/0x70
  [   45.272935]  ? asm_exc_invalid_op+0x1a/0x20
  [   45.273717]  ? get_pat_info+0xf6/0x110
  [   45.274438]  ? get_pat_info+0x71/0x110
  [   45.275165]  untrack_pfn+0x52/0x110
  [   45.275835]  unmap_single_vma+0xa6/0xe0
  [   45.276549]  unmap_vmas+0x105/0x1f0
  [   45.277256]  exit_mmap+0xf6/0x460
  [   45.277913]  __mmput+0x4b/0x120
  [   45.278512]  copy_process+0x1bf6/0x2aa0
  [   45.279264]  kernel_clone+0xab/0x440
  [   45.279959]  __do_sys_clone+0x66/0x90
  [   45.280650]  do_syscall_64+0x95/0x180

Likely this case was missed in:

  d155df53f310 ("x86/mm/pat: clear VM_PAT if copy_p4d_range failed")

... and instead of undoing the reservation we simply cleared the VM_PAT flag.

Keep the documentation of these functions in include/linux/pgtable.h,
one place is more than sufficient -- we should clean that up for the other
functions like track_pfn_remap/untrack_pfn separately.

Fixes: d155df53f310 ("x86/mm/pat: clear VM_PAT if copy_p4d_range failed")
Fixes: 2ab640379a0a ("x86: PAT: hooks in generic vm code to help archs to track pfnmap regions - v3")
Reported-by: xingwei lee <xrivendell7@gmail.com>
Reported-by: yuxin wang <wang1315768607@163.com>
Reported-by: Marius Fleischer <fleischermarius@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20241029210331.1339581-1-david@redhat.com
Closes: https://lore.kernel.org/lkml/CAJg=8jwijTP5fre8woS4JVJQ8iUA6v+iNcsOgtj9Zfpc3obDOQ@mail.gmail.com/
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Xu <peterx@redhat.com>
---
 arch/x86/mm/pat/memtype.c | 66 ++++++++++++++++++++++++--------------
 include/linux/pgtable.h   | 27 ++++++++++++----
 kernel/fork.c             |  4 ++-
 mm/memory.c               |  9 +----
 4 files changed, 70 insertions(+), 36 deletions(-)

diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index feb8cc6..3a9e6dd 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -984,27 +984,54 @@ static int get_pat_info(struct vm_area_struct *vma, resource_size_t *paddr,
 	return -EINVAL;
 }
 
-/*
- * track_pfn_copy is called when vma that is covering the pfnmap gets
- * copied through copy_page_range().
- *
- * If the vma has a linear pfn mapping for the entire range, we get the prot
- * from pte and reserve the entire vma range with single reserve_pfn_range call.
- */
-int track_pfn_copy(struct vm_area_struct *vma)
+int track_pfn_copy(struct vm_area_struct *dst_vma,
+		struct vm_area_struct *src_vma)
 {
+	const unsigned long vma_size = src_vma->vm_end - src_vma->vm_start;
 	resource_size_t paddr;
-	unsigned long vma_size = vma->vm_end - vma->vm_start;
 	pgprot_t pgprot;
+	int rc;
 
-	if (vma->vm_flags & VM_PAT) {
-		if (get_pat_info(vma, &paddr, &pgprot))
-			return -EINVAL;
-		/* reserve the whole chunk covered by vma. */
-		return reserve_pfn_range(paddr, vma_size, &pgprot, 1);
+	if (!(src_vma->vm_flags & VM_PAT))
+		return 0;
+
+	/*
+	 * Duplicate the PAT information for the dst VMA based on the src
+	 * VMA.
+	 */
+	if (get_pat_info(src_vma, &paddr, &pgprot))
+		return -EINVAL;
+	rc = reserve_pfn_range(paddr, vma_size, &pgprot, 1);
+	if (!rc)
+		/* Reservation for the destination VMA succeeded. */
+		vm_flags_set(dst_vma, VM_PAT);
+	return rc;
+}
+
+void untrack_pfn_copy(struct vm_area_struct *dst_vma,
+		struct vm_area_struct *src_vma)
+{
+	resource_size_t paddr;
+	unsigned long size;
+
+	if (!(dst_vma->vm_flags & VM_PAT))
+		return;
+
+	/*
+	 * As the page tables might not have been copied yet, the PAT
+	 * information is obtained from the src VMA, just like during
+	 * track_pfn_copy().
+	 */
+	if (get_pat_info(src_vma, &paddr, NULL)) {
+		size = src_vma->vm_end - src_vma->vm_start;
+		free_pfn_range(paddr, size);
 	}
 
-	return 0;
+	/*
+	 * Reservation was freed, any copied page tables will get cleaned
+	 * up later, but without getting PAT involved again.
+	 */
+	vm_flags_clear(dst_vma, VM_PAT);
 }
 
 /*
@@ -1095,15 +1122,6 @@ void untrack_pfn(struct vm_area_struct *vma, unsigned long pfn,
 	}
 }
 
-/*
- * untrack_pfn_clear is called if the following situation fits:
- *
- * 1) while mremapping a pfnmap for a new region,  with the old vma after
- * its pfnmap page table has been removed.  The new vma has a new pfnmap
- * to the same pfn & cache type with VM_PAT set.
- * 2) while duplicating vm area, the new vma fails to copy the pgtable from
- * old vma.
- */
 void untrack_pfn_clear(struct vm_area_struct *vma)
 {
 	vm_flags_clear(vma, VM_PAT);
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 94d267d..acf387d 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1508,15 +1508,25 @@ static inline void track_pfn_insert(struct vm_area_struct *vma, pgprot_t *prot,
 }
 
 /*
- * track_pfn_copy is called when vma that is covering the pfnmap gets
- * copied through copy_page_range().
+ * track_pfn_copy is called when a VM_PFNMAP VMA is about to get the page
+ * tables copied during copy_page_range().
  */
-static inline int track_pfn_copy(struct vm_area_struct *vma)
+static inline int track_pfn_copy(struct vm_area_struct *dst_vma,
+		struct vm_area_struct *src_vma)
 {
 	return 0;
 }
 
 /*
+ * untrack_pfn_copy is called when a VM_PFNMAP VMA failed to copy during
+ * copy_page_range(), but after track_pfn_copy() was already called.
+ */
+static inline void untrack_pfn_copy(struct vm_area_struct *dst_vma,
+		struct vm_area_struct *src_vma)
+{
+}
+
+/*
  * untrack_pfn is called while unmapping a pfnmap for a region.
  * untrack can be called for a specific region indicated by pfn and size or
  * can be for the entire vma (in which case pfn, size are zero).
@@ -1528,8 +1538,10 @@ static inline void untrack_pfn(struct vm_area_struct *vma,
 }
 
 /*
- * untrack_pfn_clear is called while mremapping a pfnmap for a new region
- * or fails to copy pgtable during duplicate vm area.
+ * untrack_pfn_clear is called in the following cases on a VM_PFNMAP VMA:
+ *
+ * 1) During mremap() on the src VMA after the page tables were moved.
+ * 2) During fork() on the dst VMA, immediately after duplicating the src VMA.
  */
 static inline void untrack_pfn_clear(struct vm_area_struct *vma)
 {
@@ -1540,7 +1552,10 @@ extern int track_pfn_remap(struct vm_area_struct *vma, pgprot_t *prot,
 			   unsigned long size);
 extern void track_pfn_insert(struct vm_area_struct *vma, pgprot_t *prot,
 			     pfn_t pfn);
-extern int track_pfn_copy(struct vm_area_struct *vma);
+extern int track_pfn_copy(struct vm_area_struct *dst_vma,
+		struct vm_area_struct *src_vma);
+extern void untrack_pfn_copy(struct vm_area_struct *dst_vma,
+		struct vm_area_struct *src_vma);
 extern void untrack_pfn(struct vm_area_struct *vma, unsigned long pfn,
 			unsigned long size, bool mm_wr_locked);
 extern void untrack_pfn_clear(struct vm_area_struct *vma);
diff --git a/kernel/fork.c b/kernel/fork.c
index 735405a..ca2ca38 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -504,6 +504,10 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
 	vma_numab_state_init(new);
 	dup_anon_vma_name(orig, new);
 
+	/* track_pfn_copy() will later take care of copying internal state. */
+	if (unlikely(new->vm_flags & VM_PFNMAP))
+		untrack_pfn_clear(new);
+
 	return new;
 }
 
diff --git a/mm/memory.c b/mm/memory.c
index 539c0f7..890333c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1379,11 +1379,7 @@ copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
 		return copy_hugetlb_page_range(dst_mm, src_mm, dst_vma, src_vma);
 
 	if (unlikely(src_vma->vm_flags & VM_PFNMAP)) {
-		/*
-		 * We do not free on error cases below as remove_vma
-		 * gets called on error from higher level routine
-		 */
-		ret = track_pfn_copy(src_vma);
+		ret = track_pfn_copy(dst_vma, src_vma);
 		if (ret)
 			return ret;
 	}
@@ -1420,7 +1416,6 @@ copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
 			continue;
 		if (unlikely(copy_p4d_range(dst_vma, src_vma, dst_pgd, src_pgd,
 					    addr, next))) {
-			untrack_pfn_clear(dst_vma);
 			ret = -ENOMEM;
 			break;
 		}
@@ -1430,6 +1425,8 @@ copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
 		raw_write_seqcount_end(&src_mm->write_protect_seq);
 		mmu_notifier_invalidate_range_end(&range);
 	}
+	if (ret && unlikely(src_vma->vm_flags & VM_PFNMAP))
+		untrack_pfn_copy(dst_vma, src_vma);
 	return ret;
 }
 

