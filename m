Return-Path: <linux-tip-commits+bounces-2967-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D889E25E8
	for <lists+linux-tip-commits@lfdr.de>; Tue,  3 Dec 2024 17:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF81F163AA6
	for <lists+linux-tip-commits@lfdr.de>; Tue,  3 Dec 2024 16:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612371F76AD;
	Tue,  3 Dec 2024 16:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iPBy0Cxg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Qm0bVau7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3B31E009A;
	Tue,  3 Dec 2024 16:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733241631; cv=none; b=gqI9JVle5rIb8VBrV+fVK68OKtUVCipW263u+sJHLGlu1CXO+aU5t2BvNBguQhPTv9wz4aoW1VpwXRzF3UAxag88CD1guHLkXxjmS2kVgwLU6aVkybESnlyw01W3O1q+Jf0EzRRYEbV5WCpTPj4gs2q4Smrt4LkYh7drupBoMlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733241631; c=relaxed/simple;
	bh=60WGLZMKSHbqBWl/mKnshvJZqGmbMEmezg+PMBw84So=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TbsWQbgkYqxkjMn9fBsLD2SW43gn7tKqpwXBTEq+39S4NL2B7S2LZVhK9vLdNET7TTldON+N7pvmE0n4EVFoS48iwW9+sH+UJ9E83dJ8Q8ABeNxwa/3mTKnJK040KSgR6VegK3+LI6UM3N5g6o04x8Nu3ke/Tj0icUn+vaDmxWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iPBy0Cxg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Qm0bVau7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 03 Dec 2024 16:00:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733241626;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vtZees0dsa0LLJZAZpwLTkebghj1mimhgQBhbtRSPmk=;
	b=iPBy0CxgnctBGUrn1Wlbk/h9qp/S1PeXMbtA2bFi8P1fE3cSu5mM/U8isQWBHCbNL+55X1
	CLHD/dPerYhPD84eEl45EivuGGgBMv9t/C/RU5rADU7Lb9h10HxZPHwogUfd8w2Zzes6Y+
	WjOTiQLWdCZKe1TxL0DpDYqNIWO18Av7hv6ZApAnd/4eck77LqoYJVGpFJv128wCijsHfU
	xwCGxB8vb4+YgX8xPOEMkIy+YviJ8k+Iv/HQyvcSi3c0/R50yqpVORqbpO+GZnwtQeCZpP
	jeWy5yHDVEYqrfqTRUwhVMJVwTqmE3dgcCifepCAl+pKPnByPo412IBFqBUnjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733241626;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vtZees0dsa0LLJZAZpwLTkebghj1mimhgQBhbtRSPmk=;
	b=Qm0bVau7Bom5dPb7/m3CFY4dkYxtcchim2BF7kJ3h/GpTwsIxzwSVrgi4TfDP38WBo+Mb1
	RxJ8VpOymWOwcfCQ==
From: "tip-bot2 for Lorenzo Stoakes" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Map pages in advance
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241129153134.82755-1-lorenzo.stoakes@oracle.com>
References: <20241129153134.82755-1-lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173324162538.412.1598661678492162187.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     eca51ce01d4956ab4b8f06bb55c031f4913fffcb
Gitweb:        https://git.kernel.org/tip/eca51ce01d4956ab4b8f06bb55c031f4913fffcb
Author:        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
AuthorDate:    Fri, 29 Nov 2024 15:31:34 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 03 Dec 2024 16:49:59 +01:00

perf: Map pages in advance

We are current refactoring struct page to make it smaller, removing
unneeded fields that correctly belong to struct folio.

Two of those fields are page->index and page->mapping. Perf is currently
making use of both of these, so this patch removes this usage as it turns
out it is unnecessary.

Perf establishes its own internally controlled memory-mapped pages using
vm_ops hooks. The first page in the mapping is the read/write user control
page, and the rest of the mapping consists of read-only pages.

The VMA is backed by kernel memory either from the buddy allocator or
vmalloc depending on configuration. It is intended to be mapped read/write,
but because it has a page_mkwrite() hook, vma_wants_writenotify() indicaets
that it should be mapped read-only.

When a write fault occurs, the provided page_mkwrite() hook,
perf_mmap_fault() (doing double duty handing faults as well) uses the
vmf->pgoff field to determine if this is the first page, allowing for the
desired read/write first page, read-only rest mapping.

For this to work the implementation has to carefully work around faulting
logic. When a page is write-faulted, the fault() hook is called first, then
its page_mkwrite() hook is called (to allow for dirty tracking in file
systems).

On fault we set the folio's mapping in perf_mmap_fault(), this is because
when do_page_mkwrite() is subsequently invoked, it treats a missing mapping
as an indicator that the fault should be retried.

We also set the folio's index so, given the folio is being treated as faux
user memory, it correctly references its offset within the VMA.

This explains why the mapping and index fields are used - but it's not
necessary.

We preallocate pages when perf_mmap() is called for the first time via
rb_alloc(), and further allocate auxiliary pages via rb_aux_alloc() as
needed if the mapping requires it.

This allocation is done in the f_ops->mmap() hook provided in perf_mmap(),
and so we can instead simply map all the memory right away here - there's
no point in handling (read) page faults when we don't demand page nor need
to be notified about them (perf does not).

This patch therefore changes this logic to map everything when the mmap()
hook is called, establishing a PFN map. It implements vm_ops->pfn_mkwrite()
to provide the required read/write vs. read-only behaviour, which does not
require the previously implemented workarounds.

While it is not ideal to use a VM_PFNMAP here, doing anything else will
result in the page_mkwrite() hook need to be provided, which requires the
same page->mapping hack this patch seeks to undo.

It will also result in the pages being treated as folios and placed on the
rmap, which really does not make sense for these mappings.

Semantically it makes sense to establish this as some kind of special
mapping, as the pages are managed by perf and are not strictly user pages,
but currently the only means by which we can do so functionally while
maintaining the required R/W and R/O bheaviour is a PFN map.

There should be no change to actual functionality as a result of this
change.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20241129153134.82755-1-lorenzo.stoakes@oracle.com
---
 kernel/events/core.c        | 116 +++++++++++++++++++++++------------
 kernel/events/ring_buffer.c |  19 +------
 2 files changed, 80 insertions(+), 55 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index e9f698c..4c6f6c2 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6277,41 +6277,6 @@ unlock:
 }
 EXPORT_SYMBOL_GPL(perf_event_update_userpage);
 
-static vm_fault_t perf_mmap_fault(struct vm_fault *vmf)
-{
-	struct perf_event *event = vmf->vma->vm_file->private_data;
-	struct perf_buffer *rb;
-	vm_fault_t ret = VM_FAULT_SIGBUS;
-
-	if (vmf->flags & FAULT_FLAG_MKWRITE) {
-		if (vmf->pgoff == 0)
-			ret = 0;
-		return ret;
-	}
-
-	rcu_read_lock();
-	rb = rcu_dereference(event->rb);
-	if (!rb)
-		goto unlock;
-
-	if (vmf->pgoff && (vmf->flags & FAULT_FLAG_WRITE))
-		goto unlock;
-
-	vmf->page = perf_mmap_to_page(rb, vmf->pgoff);
-	if (!vmf->page)
-		goto unlock;
-
-	get_page(vmf->page);
-	vmf->page->mapping = vmf->vma->vm_file->f_mapping;
-	vmf->page->index   = vmf->pgoff;
-
-	ret = 0;
-unlock:
-	rcu_read_unlock();
-
-	return ret;
-}
-
 static void ring_buffer_attach(struct perf_event *event,
 			       struct perf_buffer *rb)
 {
@@ -6551,13 +6516,87 @@ out_put:
 	ring_buffer_put(rb); /* could be last */
 }
 
+static vm_fault_t perf_mmap_pfn_mkwrite(struct vm_fault *vmf)
+{
+	/* The first page is the user control page, others are read-only. */
+	return vmf->pgoff == 0 ? 0 : VM_FAULT_SIGBUS;
+}
+
 static const struct vm_operations_struct perf_mmap_vmops = {
 	.open		= perf_mmap_open,
 	.close		= perf_mmap_close, /* non mergeable */
-	.fault		= perf_mmap_fault,
-	.page_mkwrite	= perf_mmap_fault,
+	.pfn_mkwrite	= perf_mmap_pfn_mkwrite,
 };
 
+static int map_range(struct perf_buffer *rb, struct vm_area_struct *vma)
+{
+	unsigned long nr_pages = vma_pages(vma);
+	int err = 0;
+	unsigned long pgoff;
+
+	/*
+	 * We map this as a VM_PFNMAP VMA.
+	 *
+	 * This is not ideal as this is designed broadly for mappings of PFNs
+	 * referencing memory-mapped I/O ranges or non-system RAM i.e. for which
+	 * !pfn_valid(pfn).
+	 *
+	 * We are mapping kernel-allocated memory (memory we manage ourselves)
+	 * which would more ideally be mapped using vm_insert_page() or a
+	 * similar mechanism, that is as a VM_MIXEDMAP mapping.
+	 *
+	 * However this won't work here, because:
+	 *
+	 * 1. It uses vma->vm_page_prot, but this field has not been completely
+	 *    setup at the point of the f_op->mmp() hook, so we are unable to
+	 *    indicate that this should be mapped CoW in order that the
+	 *    mkwrite() hook can be invoked to make the first page R/W and the
+	 *    rest R/O as desired.
+	 *
+	 * 2. Anything other than a VM_PFNMAP of valid PFNs will result in
+	 *    vm_normal_page() returning a struct page * pointer, which means
+	 *    vm_ops->page_mkwrite() will be invoked rather than
+	 *    vm_ops->pfn_mkwrite(), and this means we have to set page->mapping
+	 *    to work around retry logic in the fault handler, however this
+	 *    field is no longer allowed to be used within struct page.
+	 *
+	 * 3. Having a struct page * made available in the fault logic also
+	 *    means that the page gets put on the rmap and becomes
+	 *    inappropriately accessible and subject to map and ref counting.
+	 *
+	 * Ideally we would have a mechanism that could explicitly express our
+	 * desires, but this is not currently the case, so we instead use
+	 * VM_PFNMAP.
+	 *
+	 * We manage the lifetime of these mappings with internal refcounts (see
+	 * perf_mmap_open() and perf_mmap_close()) so we ensure the lifetime of
+	 * this mapping is maintained correctly.
+	 */
+	for (pgoff = 0; pgoff < nr_pages; pgoff++) {
+		unsigned long va = vma->vm_start + PAGE_SIZE * pgoff;
+		struct page *page = perf_mmap_to_page(rb, pgoff);
+
+		if (page == NULL) {
+			err = -EINVAL;
+			break;
+		}
+
+		/* Map readonly, perf_mmap_pfn_mkwrite() called on write fault. */
+		err = remap_pfn_range(vma, va, page_to_pfn(page), PAGE_SIZE,
+				      vm_get_page_prot(vma->vm_flags & ~VM_SHARED));
+		if (err)
+			break;
+	}
+
+#ifdef CONFIG_MMU
+	/* Clear any partial mappings on error. */
+	if (err)
+		zap_page_range_single(vma, vma->vm_start, nr_pages * PAGE_SIZE, NULL);
+#endif
+
+	return err;
+}
+
 static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct perf_event *event = file->private_data;
@@ -6776,6 +6815,9 @@ aux_unlock:
 	vm_flags_set(vma, VM_DONTCOPY | VM_DONTEXPAND | VM_DONTDUMP);
 	vma->vm_ops = &perf_mmap_vmops;
 
+	if (!ret)
+		ret = map_range(rb, vma);
+
 	if (event->pmu->event_mapped)
 		event->pmu->event_mapped(event, vma->vm_mm);
 
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 4f46f68..1805091 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -643,7 +643,6 @@ static void rb_free_aux_page(struct perf_buffer *rb, int idx)
 	struct page *page = virt_to_page(rb->aux_pages[idx]);
 
 	ClearPagePrivate(page);
-	page->mapping = NULL;
 	__free_page(page);
 }
 
@@ -819,7 +818,6 @@ static void perf_mmap_free_page(void *addr)
 {
 	struct page *page = virt_to_page(addr);
 
-	page->mapping = NULL;
 	__free_page(page);
 }
 
@@ -890,28 +888,13 @@ __perf_mmap_to_page(struct perf_buffer *rb, unsigned long pgoff)
 	return vmalloc_to_page((void *)rb->user_page + pgoff * PAGE_SIZE);
 }
 
-static void perf_mmap_unmark_page(void *addr)
-{
-	struct page *page = vmalloc_to_page(addr);
-
-	page->mapping = NULL;
-}
-
 static void rb_free_work(struct work_struct *work)
 {
 	struct perf_buffer *rb;
-	void *base;
-	int i, nr;
 
 	rb = container_of(work, struct perf_buffer, work);
-	nr = data_page_nr(rb);
-
-	base = rb->user_page;
-	/* The '<=' counts in the user page. */
-	for (i = 0; i <= nr; i++)
-		perf_mmap_unmark_page(base + (i * PAGE_SIZE));
 
-	vfree(base);
+	vfree(rb->user_page);
 	kfree(rb);
 }
 

