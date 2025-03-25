Return-Path: <linux-tip-commits+bounces-4525-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C40E8A6EDC8
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 11:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E06903B0FDB
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 10:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9122566F2;
	Tue, 25 Mar 2025 10:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DlfPyjaY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AinLuDfR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CAC2566EA;
	Tue, 25 Mar 2025 10:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742898520; cv=none; b=k+kXIYnnN3UwXrHWnsHJJNpo1EBRThHqpcq1nDHIpeB6hhMqJFZpEERLFjSR+qpWCroBrqGpj5fBGKPcq2V1QRsFanWU9X1+K6JIHE4EjAIW0ecTkwQYf6GZaTyYdD4kmWKeD1OlWVefEMz1qhR9NHAXBe+6/ZR8WH6ubykfl1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742898520; c=relaxed/simple;
	bh=p6tU3XQ5FqzBMmF/GbpHhEMnZofGHOwjIHojxBkol18=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Vip+l9/HiCpMLfvdAjqiajsSQ2nF7CHNtEe/bfDlM0vDnHW/6cKErXaQxbkVklcQQabMjjrPBfn4nchn4RGvaM+28M/M+7bhRYRYgY1ejeD39fLs9EtStae3dwV4ZzbePreusvhfCs0cb5PqvStExPiyggN/73ZZ18fISFvz3L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DlfPyjaY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AinLuDfR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 10:28:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742898513;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IX7ZciLSSPhoHHVqBAEaO5fkvju9wRbHw8KbG8TUtEY=;
	b=DlfPyjaYCVUmYIwy6SSV3yeNnrQBN5TYYVRbCf7rvBJ9kToFzo4V+BNv/ivj0UHqUbX1sZ
	0k2vlec9obqdAPvv39vfOI1qRlZNzOlsdeVSCSWvGHgwNQKqn3k0aOY0LZosP/PLScjJWP
	IEz3Wu81fCf5nzMRIrxwirBtOpifr8dGJ0dKiHTQAUd56MIg4pqe/eqkJ/hebSJTqrb2qi
	3V/h/otQOQMl3u0G0ieKzrLB5i13er1Uwt2f+k2eg5wDm8+GCBrowGG26bVZC/dyFGcDjG
	B5hPuldczS4Hf1cdT2qHGQ2onBZvK5QE2gRrHztPaawUBmphsoYdl4UigSGGMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742898513;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IX7ZciLSSPhoHHVqBAEaO5fkvju9wRbHw8KbG8TUtEY=;
	b=AinLuDfRTioRq1I1CscvOq6j7I3sMK2r2JFwar7VBzcR5RJSAcGmc9qGo3MVfK2GW/fjEJ
	2jFy8+KFE62v81Bw==
From: "tip-bot2 for David Hildenbrand" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/mm/pat: Fix VM_PAT handling when fork() fails
 in copy_page_range()
Cc: xingwei lee <xrivendell7@gmail.com>, yuxin wang <wang1315768607@163.com>,
 Marius Fleischer <fleischermarius@gmail.com>,
 David Hildenbrand <david@redhat.com>, Ingo Molnar <mingo@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Rik van Riel <riel@surriel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250321112323.153741-1-david@redhat.com>
References: <20250321112323.153741-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289851258.14745.6063394229146983112.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     5bd79e2ed005fdedc7670fb6deaae1552aa8b694
Gitweb:        https://git.kernel.org/tip/5bd79e2ed005fdedc7670fb6deaae1552aa8b694
Author:        David Hildenbrand <david@redhat.com>
AuthorDate:    Fri, 21 Mar 2025 12:23:23 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 11:14:15 +01:00

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

  WARNING: CPU: 26 PID: 11650 at arch/x86/mm/pat/memtype.c:983 get_pat_info+0xf6/0x110
  Modules linked in: ...
  CPU: 26 UID: 0 PID: 11650 Comm: repro3 Not tainted 6.12.0-rc5+ #92
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-2.fc40 04/01/2014
  RIP: 0010:get_pat_info+0xf6/0x110
  ...
  Call Trace:
   <TASK>
   ...
   untrack_pfn+0x52/0x110
   unmap_single_vma+0xa6/0xe0
   unmap_vmas+0x105/0x1f0
   exit_mmap+0xf6/0x460
   __mmput+0x4b/0x120
   copy_process+0x1bf6/0x2aa0
   kernel_clone+0xab/0x440
   __do_sys_clone+0x66/0x90
   do_syscall_64+0x95/0x180

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
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Link: https://lore.kernel.org/r/20250321112323.153741-1-david@redhat.com
Closes: https://lore.kernel.org/lkml/CABOYnLx_dnqzpCW99G81DmOr+2UzdmZMk=T3uxwNxwz+R1RAwg@mail.gmail.com/
Closes: https://lore.kernel.org/lkml/CAJg=8jwijTP5fre8woS4JVJQ8iUA6v+iNcsOgtj9Zfpc3obDOQ@mail.gmail.com/
---
 arch/x86/mm/pat/memtype.c | 43 ++++++++++++++++----------------------
 include/linux/pgtable.h   | 31 +++++++++++++++++++++------
 kernel/fork.c             |  4 ++++-
 mm/memory.c               | 11 +++-------
 4 files changed, 52 insertions(+), 37 deletions(-)

diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index e40861c..35ceccb 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -984,26 +984,30 @@ static int get_pat_info(struct vm_area_struct *vma, resource_size_t *paddr,
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
+		struct vm_area_struct *src_vma, unsigned long *pfn)
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
-	}
+	if (!(src_vma->vm_flags & VM_PAT))
+		return 0;
 
+	/*
+	 * Duplicate the PAT information for the dst VMA based on the src
+	 * VMA.
+	 */
+	if (get_pat_info(src_vma, &paddr, &pgprot))
+		return -EINVAL;
+	rc = reserve_pfn_range(paddr, vma_size, &pgprot, 1);
+	if (rc)
+		return rc;
+
+	/* Reservation for the destination VMA succeeded. */
+	vm_flags_set(dst_vma, VM_PAT);
+	*pfn = PHYS_PFN(paddr);
 	return 0;
 }
 
@@ -1095,15 +1099,6 @@ void untrack_pfn(struct vm_area_struct *vma, unsigned long pfn,
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
index 94d267d..df2aff5 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1508,10 +1508,12 @@ static inline void track_pfn_insert(struct vm_area_struct *vma, pgprot_t *prot,
 }
 
 /*
- * track_pfn_copy is called when vma that is covering the pfnmap gets
- * copied through copy_page_range().
+ * track_pfn_copy is called when a VM_PFNMAP VMA is about to get the page
+ * tables copied during copy_page_range(). On success, stores the pfn to be
+ * passed to untrack_pfn_copy().
  */
-static inline int track_pfn_copy(struct vm_area_struct *vma)
+static inline int track_pfn_copy(struct vm_area_struct *dst_vma,
+		struct vm_area_struct *src_vma, unsigned long *pfn)
 {
 	return 0;
 }
@@ -1528,8 +1530,10 @@ static inline void untrack_pfn(struct vm_area_struct *vma,
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
@@ -1540,12 +1544,27 @@ extern int track_pfn_remap(struct vm_area_struct *vma, pgprot_t *prot,
 			   unsigned long size);
 extern void track_pfn_insert(struct vm_area_struct *vma, pgprot_t *prot,
 			     pfn_t pfn);
-extern int track_pfn_copy(struct vm_area_struct *vma);
+extern int track_pfn_copy(struct vm_area_struct *dst_vma,
+		struct vm_area_struct *src_vma, unsigned long *pfn);
 extern void untrack_pfn(struct vm_area_struct *vma, unsigned long pfn,
 			unsigned long size, bool mm_wr_locked);
 extern void untrack_pfn_clear(struct vm_area_struct *vma);
 #endif
 
+/*
+ * untrack_pfn_copy is called when a VM_PFNMAP VMA failed to copy during
+ * copy_page_range(), but after track_pfn_copy() was already called.
+ */
+static inline void untrack_pfn_copy(struct vm_area_struct *dst_vma,
+		unsigned long pfn)
+{
+	untrack_pfn(dst_vma, pfn, dst_vma->vm_end - dst_vma->vm_start, true);
+	/*
+	 * Reservation was freed, any copied page tables will get cleaned
+	 * up later, but without getting PAT involved again.
+	 */
+}
+
 #ifdef CONFIG_MMU
 #ifdef __HAVE_COLOR_ZERO_PAGE
 static inline int is_zero_pfn(unsigned long pfn)
diff --git a/kernel/fork.c b/kernel/fork.c
index f11ac96..91171e5 100644
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
index 4f6d976..53f7b0a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1362,12 +1362,12 @@ int
 copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
 {
 	pgd_t *src_pgd, *dst_pgd;
-	unsigned long next;
 	unsigned long addr = src_vma->vm_start;
 	unsigned long end = src_vma->vm_end;
 	struct mm_struct *dst_mm = dst_vma->vm_mm;
 	struct mm_struct *src_mm = src_vma->vm_mm;
 	struct mmu_notifier_range range;
+	unsigned long next, pfn;
 	bool is_cow;
 	int ret;
 
@@ -1378,11 +1378,7 @@ copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
 		return copy_hugetlb_page_range(dst_mm, src_mm, dst_vma, src_vma);
 
 	if (unlikely(src_vma->vm_flags & VM_PFNMAP)) {
-		/*
-		 * We do not free on error cases below as remove_vma
-		 * gets called on error from higher level routine
-		 */
-		ret = track_pfn_copy(src_vma);
+		ret = track_pfn_copy(dst_vma, src_vma, &pfn);
 		if (ret)
 			return ret;
 	}
@@ -1419,7 +1415,6 @@ copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
 			continue;
 		if (unlikely(copy_p4d_range(dst_vma, src_vma, dst_pgd, src_pgd,
 					    addr, next))) {
-			untrack_pfn_clear(dst_vma);
 			ret = -ENOMEM;
 			break;
 		}
@@ -1429,6 +1424,8 @@ copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
 		raw_write_seqcount_end(&src_mm->write_protect_seq);
 		mmu_notifier_invalidate_range_end(&range);
 	}
+	if (ret && unlikely(src_vma->vm_flags & VM_PFNMAP))
+		untrack_pfn_copy(dst_vma, pfn);
 	return ret;
 }
 

