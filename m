Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5456B2B82E3
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Nov 2020 18:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbgKRRS1 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 18 Nov 2020 12:18:27 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56200 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728067AbgKRRSY (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 18 Nov 2020 12:18:24 -0500
Date:   Wed, 18 Nov 2020 17:18:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605719898;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6s/APjPetxyFyOedmil45woCXPCoHno1BbvbB/r3vY0=;
        b=3nTT6f4Pq3IajZwUzY57Tk9Fr/WJ3QXLwaijeEzfw2Tg2SEUKErUDCsBRwn5dmyqcztAQC
        fCcnuxRJU+U+5cN/SHwXvJNaOdJsodN54+E0pWtLp59Z7cdQUrGvDv5SG3ICPAiRRBHuvu
        IgXGn+ssM+0TuqlXh3z4zjpd9EGDtrP8UT4nggHhAgJY+oIkss15KqSK0LtHUT8s04QWd1
        z4/Xaf5pwO28IVWsodD7FucT3cu5Qda/SyQdzTDAR3EeRpBExc8UVBqT+Ce98CYLFZh+XF
        bj7QUrAuYd5Y1DmYLSoIVOODaVO4h67FqNH7FQgq55TSnMdR+BrGeV5NBb6DSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605719898;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6s/APjPetxyFyOedmil45woCXPCoHno1BbvbB/r3vY0=;
        b=x+kjTf4WABTJfe8gHHZjjc1bnVlU5jjp2JPDp75HpHD49TxBtoIpQoEPV/wutajnHkWnNV
        Us62Snw/RKMwIzDQ==
From:   "tip-bot2 for Jarkko Sakkinen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Add a page reclaimer
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Jethro Beekman <jethro@fortanix.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201112220135.165028-22-jarkko@kernel.org>
References: <20201112220135.165028-22-jarkko@kernel.org>
MIME-Version: 1.0
Message-ID: <160571989801.11244.2221569549959403943.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     1728ab54b4be94aed89276eeb8e750a345659765
Gitweb:        https://git.kernel.org/tip/1728ab54b4be94aed89276eeb8e750a345659765
Author:        Jarkko Sakkinen <jarkko@kernel.org>
AuthorDate:    Fri, 13 Nov 2020 00:01:32 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 18 Nov 2020 18:04:11 +01:00

x86/sgx: Add a page reclaimer

Just like normal RAM, there is a limited amount of enclave memory available
and overcommitting it is a very valuable tool to reduce resource use.
Introduce a simple reclaim mechanism for enclave pages.

In contrast to normal page reclaim, the kernel cannot directly access
enclave memory.  To get around this, the SGX architecture provides a set of
functions to help.  Among other things, these functions copy enclave memory
to and from normal memory, encrypting it and protecting its integrity in
the process.

Implement a page reclaimer by using these functions. Picks victim pages in
LRU fashion from all the enclaves running in the system.  A new kernel
thread (ksgxswapd) reclaims pages in the background based on watermarks,
similar to normal kswapd.

All enclave pages can be reclaimed, architecturally.  But, there are some
limits to this, such as the special SECS metadata page which must be
reclaimed last.  The page version array (used to mitigate replaying old
reclaimed pages) is also architecturally reclaimable, but not yet
implemented.  The end result is that the vast majority of enclave pages are
currently reclaimable.

Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Jethro Beekman <jethro@fortanix.com>
Link: https://lkml.kernel.org/r/20201112220135.165028-22-jarkko@kernel.org
---
 arch/x86/kernel/cpu/sgx/driver.c |  59 ++--
 arch/x86/kernel/cpu/sgx/encl.c   | 483 +++++++++++++++++++++++++++++-
 arch/x86/kernel/cpu/sgx/encl.h   |  51 +++-
 arch/x86/kernel/cpu/sgx/ioctl.c  |  89 +++++-
 arch/x86/kernel/cpu/sgx/main.c   | 466 +++++++++++++++++++++++++++++-
 arch/x86/kernel/cpu/sgx/sgx.h    |  13 +-
 6 files changed, 1134 insertions(+), 27 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/driver.c b/arch/x86/kernel/cpu/sgx/driver.c
index 899c184..f2eac41 100644
--- a/arch/x86/kernel/cpu/sgx/driver.c
+++ b/arch/x86/kernel/cpu/sgx/driver.c
@@ -17,13 +17,24 @@ u32 sgx_misc_reserved_mask;
 static int sgx_open(struct inode *inode, struct file *file)
 {
 	struct sgx_encl *encl;
+	int ret;
 
 	encl = kzalloc(sizeof(*encl), GFP_KERNEL);
 	if (!encl)
 		return -ENOMEM;
 
+	kref_init(&encl->refcount);
 	xa_init(&encl->page_array);
 	mutex_init(&encl->lock);
+	INIT_LIST_HEAD(&encl->va_pages);
+	INIT_LIST_HEAD(&encl->mm_list);
+	spin_lock_init(&encl->mm_lock);
+
+	ret = init_srcu_struct(&encl->srcu);
+	if (ret) {
+		kfree(encl);
+		return ret;
+	}
 
 	file->private_data = encl;
 
@@ -33,31 +44,37 @@ static int sgx_open(struct inode *inode, struct file *file)
 static int sgx_release(struct inode *inode, struct file *file)
 {
 	struct sgx_encl *encl = file->private_data;
-	struct sgx_encl_page *entry;
-	unsigned long index;
-
-	xa_for_each(&encl->page_array, index, entry) {
-		if (entry->epc_page) {
-			sgx_free_epc_page(entry->epc_page);
-			encl->secs_child_cnt--;
-			entry->epc_page = NULL;
+	struct sgx_encl_mm *encl_mm;
+
+	/*
+	 * Drain the remaining mm_list entries. At this point the list contains
+	 * entries for processes, which have closed the enclave file but have
+	 * not exited yet. The processes, which have exited, are gone from the
+	 * list by sgx_mmu_notifier_release().
+	 */
+	for ( ; ; )  {
+		spin_lock(&encl->mm_lock);
+
+		if (list_empty(&encl->mm_list)) {
+			encl_mm = NULL;
+		} else {
+			encl_mm = list_first_entry(&encl->mm_list,
+						   struct sgx_encl_mm, list);
+			list_del_rcu(&encl_mm->list);
 		}
 
-		kfree(entry);
-	}
+		spin_unlock(&encl->mm_lock);
 
-	xa_destroy(&encl->page_array);
+		/* The enclave is no longer mapped by any mm. */
+		if (!encl_mm)
+			break;
 
-	if (!encl->secs_child_cnt && encl->secs.epc_page) {
-		sgx_free_epc_page(encl->secs.epc_page);
-		encl->secs.epc_page = NULL;
+		synchronize_srcu(&encl->srcu);
+		mmu_notifier_unregister(&encl_mm->mmu_notifier, encl_mm->mm);
+		kfree(encl_mm);
 	}
 
-	/* Detect EPC page leaks. */
-	WARN_ON_ONCE(encl->secs_child_cnt);
-	WARN_ON_ONCE(encl->secs.epc_page);
-
-	kfree(encl);
+	kref_put(&encl->refcount, sgx_encl_release);
 	return 0;
 }
 
@@ -70,6 +87,10 @@ static int sgx_mmap(struct file *file, struct vm_area_struct *vma)
 	if (ret)
 		return ret;
 
+	ret = sgx_encl_mm_add(encl, vma->vm_mm);
+	if (ret)
+		return ret;
+
 	vma->vm_ops = &sgx_vm_ops;
 	vma->vm_flags |= VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP | VM_IO;
 	vma->vm_private_data = encl;
diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 57eff30..b74dadf 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -12,11 +12,90 @@
 #include "encls.h"
 #include "sgx.h"
 
+/*
+ * ELDU: Load an EPC page as unblocked. For more info, see "OS Management of EPC
+ * Pages" in the SDM.
+ */
+static int __sgx_encl_eldu(struct sgx_encl_page *encl_page,
+			   struct sgx_epc_page *epc_page,
+			   struct sgx_epc_page *secs_page)
+{
+	unsigned long va_offset = encl_page->desc & SGX_ENCL_PAGE_VA_OFFSET_MASK;
+	struct sgx_encl *encl = encl_page->encl;
+	struct sgx_pageinfo pginfo;
+	struct sgx_backing b;
+	pgoff_t page_index;
+	int ret;
+
+	if (secs_page)
+		page_index = PFN_DOWN(encl_page->desc - encl_page->encl->base);
+	else
+		page_index = PFN_DOWN(encl->size);
+
+	ret = sgx_encl_get_backing(encl, page_index, &b);
+	if (ret)
+		return ret;
+
+	pginfo.addr = encl_page->desc & PAGE_MASK;
+	pginfo.contents = (unsigned long)kmap_atomic(b.contents);
+	pginfo.metadata = (unsigned long)kmap_atomic(b.pcmd) +
+			  b.pcmd_offset;
+
+	if (secs_page)
+		pginfo.secs = (u64)sgx_get_epc_virt_addr(secs_page);
+	else
+		pginfo.secs = 0;
+
+	ret = __eldu(&pginfo, sgx_get_epc_virt_addr(epc_page),
+		     sgx_get_epc_virt_addr(encl_page->va_page->epc_page) + va_offset);
+	if (ret) {
+		if (encls_failed(ret))
+			ENCLS_WARN(ret, "ELDU");
+
+		ret = -EFAULT;
+	}
+
+	kunmap_atomic((void *)(unsigned long)(pginfo.metadata - b.pcmd_offset));
+	kunmap_atomic((void *)(unsigned long)pginfo.contents);
+
+	sgx_encl_put_backing(&b, false);
+
+	return ret;
+}
+
+static struct sgx_epc_page *sgx_encl_eldu(struct sgx_encl_page *encl_page,
+					  struct sgx_epc_page *secs_page)
+{
+
+	unsigned long va_offset = encl_page->desc & SGX_ENCL_PAGE_VA_OFFSET_MASK;
+	struct sgx_encl *encl = encl_page->encl;
+	struct sgx_epc_page *epc_page;
+	int ret;
+
+	epc_page = sgx_alloc_epc_page(encl_page, false);
+	if (IS_ERR(epc_page))
+		return epc_page;
+
+	ret = __sgx_encl_eldu(encl_page, epc_page, secs_page);
+	if (ret) {
+		sgx_free_epc_page(epc_page);
+		return ERR_PTR(ret);
+	}
+
+	sgx_free_va_slot(encl_page->va_page, va_offset);
+	list_move(&encl_page->va_page->list, &encl->va_pages);
+	encl_page->desc &= ~SGX_ENCL_PAGE_VA_OFFSET_MASK;
+	encl_page->epc_page = epc_page;
+
+	return epc_page;
+}
+
 static struct sgx_encl_page *sgx_encl_load_page(struct sgx_encl *encl,
 						unsigned long addr,
 						unsigned long vm_flags)
 {
 	unsigned long vm_prot_bits = vm_flags & (VM_READ | VM_WRITE | VM_EXEC);
+	struct sgx_epc_page *epc_page;
 	struct sgx_encl_page *entry;
 
 	entry = xa_load(&encl->page_array, PFN_DOWN(addr));
@@ -31,11 +110,27 @@ static struct sgx_encl_page *sgx_encl_load_page(struct sgx_encl *encl,
 	if ((entry->vm_max_prot_bits & vm_prot_bits) != vm_prot_bits)
 		return ERR_PTR(-EFAULT);
 
-	/* No page found. */
-	if (!entry->epc_page)
-		return ERR_PTR(-EFAULT);
-
 	/* Entry successfully located. */
+	if (entry->epc_page) {
+		if (entry->desc & SGX_ENCL_PAGE_BEING_RECLAIMED)
+			return ERR_PTR(-EBUSY);
+
+		return entry;
+	}
+
+	if (!(encl->secs.epc_page)) {
+		epc_page = sgx_encl_eldu(&encl->secs, NULL);
+		if (IS_ERR(epc_page))
+			return ERR_CAST(epc_page);
+	}
+
+	epc_page = sgx_encl_eldu(entry, encl->secs.epc_page);
+	if (IS_ERR(epc_page))
+		return ERR_CAST(epc_page);
+
+	encl->secs_child_cnt++;
+	sgx_mark_page_reclaimable(entry->epc_page);
+
 	return entry;
 }
 
@@ -51,12 +146,23 @@ static vm_fault_t sgx_vma_fault(struct vm_fault *vmf)
 
 	encl = vma->vm_private_data;
 
+	/*
+	 * It's very unlikely but possible that allocating memory for the
+	 * mm_list entry of a forked process failed in sgx_vma_open(). When
+	 * this happens, vm_private_data is set to NULL.
+	 */
+	if (unlikely(!encl))
+		return VM_FAULT_SIGBUS;
+
 	mutex_lock(&encl->lock);
 
 	entry = sgx_encl_load_page(encl, addr, vma->vm_flags);
 	if (IS_ERR(entry)) {
 		mutex_unlock(&encl->lock);
 
+		if (PTR_ERR(entry) == -EBUSY)
+			return VM_FAULT_NOPAGE;
+
 		return VM_FAULT_SIGBUS;
 	}
 
@@ -76,11 +182,29 @@ static vm_fault_t sgx_vma_fault(struct vm_fault *vmf)
 		return VM_FAULT_SIGBUS;
 	}
 
+	sgx_encl_test_and_clear_young(vma->vm_mm, entry);
 	mutex_unlock(&encl->lock);
 
 	return VM_FAULT_NOPAGE;
 }
 
+static void sgx_vma_open(struct vm_area_struct *vma)
+{
+	struct sgx_encl *encl = vma->vm_private_data;
+
+	/*
+	 * It's possible but unlikely that vm_private_data is NULL. This can
+	 * happen in a grandchild of a process, when sgx_encl_mm_add() had
+	 * failed to allocate memory in this callback.
+	 */
+	if (unlikely(!encl))
+		return;
+
+	if (sgx_encl_mm_add(encl, vma->vm_mm))
+		vma->vm_private_data = NULL;
+}
+
+
 /**
  * sgx_encl_may_map() - Check if a requested VMA mapping is allowed
  * @encl:		an enclave pointer
@@ -151,4 +275,355 @@ static int sgx_vma_mprotect(struct vm_area_struct *vma, unsigned long start,
 const struct vm_operations_struct sgx_vm_ops = {
 	.fault = sgx_vma_fault,
 	.mprotect = sgx_vma_mprotect,
+	.open = sgx_vma_open,
+};
+
+/**
+ * sgx_encl_release - Destroy an enclave instance
+ * @kref:	address of a kref inside &sgx_encl
+ *
+ * Used together with kref_put(). Frees all the resources associated with the
+ * enclave and the instance itself.
+ */
+void sgx_encl_release(struct kref *ref)
+{
+	struct sgx_encl *encl = container_of(ref, struct sgx_encl, refcount);
+	struct sgx_va_page *va_page;
+	struct sgx_encl_page *entry;
+	unsigned long index;
+
+	xa_for_each(&encl->page_array, index, entry) {
+		if (entry->epc_page) {
+			/*
+			 * The page and its radix tree entry cannot be freed
+			 * if the page is being held by the reclaimer.
+			 */
+			if (sgx_unmark_page_reclaimable(entry->epc_page))
+				continue;
+
+			sgx_free_epc_page(entry->epc_page);
+			encl->secs_child_cnt--;
+			entry->epc_page = NULL;
+		}
+
+		kfree(entry);
+	}
+
+	xa_destroy(&encl->page_array);
+
+	if (!encl->secs_child_cnt && encl->secs.epc_page) {
+		sgx_free_epc_page(encl->secs.epc_page);
+		encl->secs.epc_page = NULL;
+	}
+
+	while (!list_empty(&encl->va_pages)) {
+		va_page = list_first_entry(&encl->va_pages, struct sgx_va_page,
+					   list);
+		list_del(&va_page->list);
+		sgx_free_epc_page(va_page->epc_page);
+		kfree(va_page);
+	}
+
+	if (encl->backing)
+		fput(encl->backing);
+
+	cleanup_srcu_struct(&encl->srcu);
+
+	WARN_ON_ONCE(!list_empty(&encl->mm_list));
+
+	/* Detect EPC page leak's. */
+	WARN_ON_ONCE(encl->secs_child_cnt);
+	WARN_ON_ONCE(encl->secs.epc_page);
+
+	kfree(encl);
+}
+
+/*
+ * 'mm' is exiting and no longer needs mmu notifications.
+ */
+static void sgx_mmu_notifier_release(struct mmu_notifier *mn,
+				     struct mm_struct *mm)
+{
+	struct sgx_encl_mm *encl_mm = container_of(mn, struct sgx_encl_mm, mmu_notifier);
+	struct sgx_encl_mm *tmp = NULL;
+
+	/*
+	 * The enclave itself can remove encl_mm.  Note, objects can't be moved
+	 * off an RCU protected list, but deletion is ok.
+	 */
+	spin_lock(&encl_mm->encl->mm_lock);
+	list_for_each_entry(tmp, &encl_mm->encl->mm_list, list) {
+		if (tmp == encl_mm) {
+			list_del_rcu(&encl_mm->list);
+			break;
+		}
+	}
+	spin_unlock(&encl_mm->encl->mm_lock);
+
+	if (tmp == encl_mm) {
+		synchronize_srcu(&encl_mm->encl->srcu);
+		mmu_notifier_put(mn);
+	}
+}
+
+static void sgx_mmu_notifier_free(struct mmu_notifier *mn)
+{
+	struct sgx_encl_mm *encl_mm = container_of(mn, struct sgx_encl_mm, mmu_notifier);
+
+	kfree(encl_mm);
+}
+
+static const struct mmu_notifier_ops sgx_mmu_notifier_ops = {
+	.release		= sgx_mmu_notifier_release,
+	.free_notifier		= sgx_mmu_notifier_free,
 };
+
+static struct sgx_encl_mm *sgx_encl_find_mm(struct sgx_encl *encl,
+					    struct mm_struct *mm)
+{
+	struct sgx_encl_mm *encl_mm = NULL;
+	struct sgx_encl_mm *tmp;
+	int idx;
+
+	idx = srcu_read_lock(&encl->srcu);
+
+	list_for_each_entry_rcu(tmp, &encl->mm_list, list) {
+		if (tmp->mm == mm) {
+			encl_mm = tmp;
+			break;
+		}
+	}
+
+	srcu_read_unlock(&encl->srcu, idx);
+
+	return encl_mm;
+}
+
+int sgx_encl_mm_add(struct sgx_encl *encl, struct mm_struct *mm)
+{
+	struct sgx_encl_mm *encl_mm;
+	int ret;
+
+	/*
+	 * Even though a single enclave may be mapped into an mm more than once,
+	 * each 'mm' only appears once on encl->mm_list. This is guaranteed by
+	 * holding the mm's mmap lock for write before an mm can be added or
+	 * remove to an encl->mm_list.
+	 */
+	mmap_assert_write_locked(mm);
+
+	/*
+	 * It's possible that an entry already exists in the mm_list, because it
+	 * is removed only on VFS release or process exit.
+	 */
+	if (sgx_encl_find_mm(encl, mm))
+		return 0;
+
+	encl_mm = kzalloc(sizeof(*encl_mm), GFP_KERNEL);
+	if (!encl_mm)
+		return -ENOMEM;
+
+	encl_mm->encl = encl;
+	encl_mm->mm = mm;
+	encl_mm->mmu_notifier.ops = &sgx_mmu_notifier_ops;
+
+	ret = __mmu_notifier_register(&encl_mm->mmu_notifier, mm);
+	if (ret) {
+		kfree(encl_mm);
+		return ret;
+	}
+
+	spin_lock(&encl->mm_lock);
+	list_add_rcu(&encl_mm->list, &encl->mm_list);
+	/* Pairs with smp_rmb() in sgx_reclaimer_block(). */
+	smp_wmb();
+	encl->mm_list_version++;
+	spin_unlock(&encl->mm_lock);
+
+	return 0;
+}
+
+static struct page *sgx_encl_get_backing_page(struct sgx_encl *encl,
+					      pgoff_t index)
+{
+	struct inode *inode = encl->backing->f_path.dentry->d_inode;
+	struct address_space *mapping = inode->i_mapping;
+	gfp_t gfpmask = mapping_gfp_mask(mapping);
+
+	return shmem_read_mapping_page_gfp(mapping, index, gfpmask);
+}
+
+/**
+ * sgx_encl_get_backing() - Pin the backing storage
+ * @encl:	an enclave pointer
+ * @page_index:	enclave page index
+ * @backing:	data for accessing backing storage for the page
+ *
+ * Pin the backing storage pages for storing the encrypted contents and Paging
+ * Crypto MetaData (PCMD) of an enclave page.
+ *
+ * Return:
+ *   0 on success,
+ *   -errno otherwise.
+ */
+int sgx_encl_get_backing(struct sgx_encl *encl, unsigned long page_index,
+			 struct sgx_backing *backing)
+{
+	pgoff_t pcmd_index = PFN_DOWN(encl->size) + 1 + (page_index >> 5);
+	struct page *contents;
+	struct page *pcmd;
+
+	contents = sgx_encl_get_backing_page(encl, page_index);
+	if (IS_ERR(contents))
+		return PTR_ERR(contents);
+
+	pcmd = sgx_encl_get_backing_page(encl, pcmd_index);
+	if (IS_ERR(pcmd)) {
+		put_page(contents);
+		return PTR_ERR(pcmd);
+	}
+
+	backing->page_index = page_index;
+	backing->contents = contents;
+	backing->pcmd = pcmd;
+	backing->pcmd_offset =
+		(page_index & (PAGE_SIZE / sizeof(struct sgx_pcmd) - 1)) *
+		sizeof(struct sgx_pcmd);
+
+	return 0;
+}
+
+/**
+ * sgx_encl_put_backing() - Unpin the backing storage
+ * @backing:	data for accessing backing storage for the page
+ * @do_write:	mark pages dirty
+ */
+void sgx_encl_put_backing(struct sgx_backing *backing, bool do_write)
+{
+	if (do_write) {
+		set_page_dirty(backing->pcmd);
+		set_page_dirty(backing->contents);
+	}
+
+	put_page(backing->pcmd);
+	put_page(backing->contents);
+}
+
+static int sgx_encl_test_and_clear_young_cb(pte_t *ptep, unsigned long addr,
+					    void *data)
+{
+	pte_t pte;
+	int ret;
+
+	ret = pte_young(*ptep);
+	if (ret) {
+		pte = pte_mkold(*ptep);
+		set_pte_at((struct mm_struct *)data, addr, ptep, pte);
+	}
+
+	return ret;
+}
+
+/**
+ * sgx_encl_test_and_clear_young() - Test and reset the accessed bit
+ * @mm:		mm_struct that is checked
+ * @page:	enclave page to be tested for recent access
+ *
+ * Checks the Access (A) bit from the PTE corresponding to the enclave page and
+ * clears it.
+ *
+ * Return: 1 if the page has been recently accessed and 0 if not.
+ */
+int sgx_encl_test_and_clear_young(struct mm_struct *mm,
+				  struct sgx_encl_page *page)
+{
+	unsigned long addr = page->desc & PAGE_MASK;
+	struct sgx_encl *encl = page->encl;
+	struct vm_area_struct *vma;
+	int ret;
+
+	ret = sgx_encl_find(mm, addr, &vma);
+	if (ret)
+		return 0;
+
+	if (encl != vma->vm_private_data)
+		return 0;
+
+	ret = apply_to_page_range(vma->vm_mm, addr, PAGE_SIZE,
+				  sgx_encl_test_and_clear_young_cb, vma->vm_mm);
+	if (ret < 0)
+		return 0;
+
+	return ret;
+}
+
+/**
+ * sgx_alloc_va_page() - Allocate a Version Array (VA) page
+ *
+ * Allocate a free EPC page and convert it to a Version Array (VA) page.
+ *
+ * Return:
+ *   a VA page,
+ *   -errno otherwise
+ */
+struct sgx_epc_page *sgx_alloc_va_page(void)
+{
+	struct sgx_epc_page *epc_page;
+	int ret;
+
+	epc_page = sgx_alloc_epc_page(NULL, true);
+	if (IS_ERR(epc_page))
+		return ERR_CAST(epc_page);
+
+	ret = __epa(sgx_get_epc_virt_addr(epc_page));
+	if (ret) {
+		WARN_ONCE(1, "EPA returned %d (0x%x)", ret, ret);
+		sgx_free_epc_page(epc_page);
+		return ERR_PTR(-EFAULT);
+	}
+
+	return epc_page;
+}
+
+/**
+ * sgx_alloc_va_slot - allocate a VA slot
+ * @va_page:	a &struct sgx_va_page instance
+ *
+ * Allocates a slot from a &struct sgx_va_page instance.
+ *
+ * Return: offset of the slot inside the VA page
+ */
+unsigned int sgx_alloc_va_slot(struct sgx_va_page *va_page)
+{
+	int slot = find_first_zero_bit(va_page->slots, SGX_VA_SLOT_COUNT);
+
+	if (slot < SGX_VA_SLOT_COUNT)
+		set_bit(slot, va_page->slots);
+
+	return slot << 3;
+}
+
+/**
+ * sgx_free_va_slot - free a VA slot
+ * @va_page:	a &struct sgx_va_page instance
+ * @offset:	offset of the slot inside the VA page
+ *
+ * Frees a slot from a &struct sgx_va_page instance.
+ */
+void sgx_free_va_slot(struct sgx_va_page *va_page, unsigned int offset)
+{
+	clear_bit(offset >> 3, va_page->slots);
+}
+
+/**
+ * sgx_va_page_full - is the VA page full?
+ * @va_page:	a &struct sgx_va_page instance
+ *
+ * Return: true if all slots have been taken
+ */
+bool sgx_va_page_full(struct sgx_va_page *va_page)
+{
+	int slot = find_first_zero_bit(va_page->slots, SGX_VA_SLOT_COUNT);
+
+	return slot == SGX_VA_SLOT_COUNT;
+}
diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/encl.h
index 8a4d1ed..d8d30cc 100644
--- a/arch/x86/kernel/cpu/sgx/encl.h
+++ b/arch/x86/kernel/cpu/sgx/encl.h
@@ -19,11 +19,18 @@
 #include <linux/xarray.h>
 #include "sgx.h"
 
+/* 'desc' bits holding the offset in the VA (version array) page. */
+#define SGX_ENCL_PAGE_VA_OFFSET_MASK	GENMASK_ULL(11, 3)
+
+/* 'desc' bit marking that the page is being reclaimed. */
+#define SGX_ENCL_PAGE_BEING_RECLAIMED	BIT(3)
+
 struct sgx_encl_page {
 	unsigned long desc;
 	unsigned long vm_max_prot_bits;
 	struct sgx_epc_page *epc_page;
 	struct sgx_encl *encl;
+	struct sgx_va_page *va_page;
 };
 
 enum sgx_encl_flags {
@@ -33,6 +40,13 @@ enum sgx_encl_flags {
 	SGX_ENCL_INITIALIZED	= BIT(3),
 };
 
+struct sgx_encl_mm {
+	struct sgx_encl *encl;
+	struct mm_struct *mm;
+	struct list_head list;
+	struct mmu_notifier mmu_notifier;
+};
+
 struct sgx_encl {
 	unsigned long base;
 	unsigned long size;
@@ -44,6 +58,30 @@ struct sgx_encl {
 	struct sgx_encl_page secs;
 	unsigned long attributes;
 	unsigned long attributes_mask;
+
+	cpumask_t cpumask;
+	struct file *backing;
+	struct kref refcount;
+	struct list_head va_pages;
+	unsigned long mm_list_version;
+	struct list_head mm_list;
+	spinlock_t mm_lock;
+	struct srcu_struct srcu;
+};
+
+#define SGX_VA_SLOT_COUNT 512
+
+struct sgx_va_page {
+	struct sgx_epc_page *epc_page;
+	DECLARE_BITMAP(slots, SGX_VA_SLOT_COUNT);
+	struct list_head list;
+};
+
+struct sgx_backing {
+	pgoff_t page_index;
+	struct page *contents;
+	struct page *pcmd;
+	unsigned long pcmd_offset;
 };
 
 extern const struct vm_operations_struct sgx_vm_ops;
@@ -65,4 +103,17 @@ static inline int sgx_encl_find(struct mm_struct *mm, unsigned long addr,
 int sgx_encl_may_map(struct sgx_encl *encl, unsigned long start,
 		     unsigned long end, unsigned long vm_flags);
 
+void sgx_encl_release(struct kref *ref);
+int sgx_encl_mm_add(struct sgx_encl *encl, struct mm_struct *mm);
+int sgx_encl_get_backing(struct sgx_encl *encl, unsigned long page_index,
+			 struct sgx_backing *backing);
+void sgx_encl_put_backing(struct sgx_backing *backing, bool do_write);
+int sgx_encl_test_and_clear_young(struct mm_struct *mm,
+				  struct sgx_encl_page *page);
+
+struct sgx_epc_page *sgx_alloc_va_page(void);
+unsigned int sgx_alloc_va_slot(struct sgx_va_page *va_page);
+void sgx_free_va_slot(struct sgx_va_page *va_page, unsigned int offset);
+bool sgx_va_page_full(struct sgx_va_page *va_page);
+
 #endif /* _X86_ENCL_H */
diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index 0ba0e67..6d37117 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -16,20 +16,77 @@
 #include "encl.h"
 #include "encls.h"
 
+static struct sgx_va_page *sgx_encl_grow(struct sgx_encl *encl)
+{
+	struct sgx_va_page *va_page = NULL;
+	void *err;
+
+	BUILD_BUG_ON(SGX_VA_SLOT_COUNT !=
+		(SGX_ENCL_PAGE_VA_OFFSET_MASK >> 3) + 1);
+
+	if (!(encl->page_cnt % SGX_VA_SLOT_COUNT)) {
+		va_page = kzalloc(sizeof(*va_page), GFP_KERNEL);
+		if (!va_page)
+			return ERR_PTR(-ENOMEM);
+
+		va_page->epc_page = sgx_alloc_va_page();
+		if (IS_ERR(va_page->epc_page)) {
+			err = ERR_CAST(va_page->epc_page);
+			kfree(va_page);
+			return err;
+		}
+
+		WARN_ON_ONCE(encl->page_cnt % SGX_VA_SLOT_COUNT);
+	}
+	encl->page_cnt++;
+	return va_page;
+}
+
+static void sgx_encl_shrink(struct sgx_encl *encl, struct sgx_va_page *va_page)
+{
+	encl->page_cnt--;
+
+	if (va_page) {
+		sgx_free_epc_page(va_page->epc_page);
+		list_del(&va_page->list);
+		kfree(va_page);
+	}
+}
+
 static int sgx_encl_create(struct sgx_encl *encl, struct sgx_secs *secs)
 {
 	struct sgx_epc_page *secs_epc;
+	struct sgx_va_page *va_page;
 	struct sgx_pageinfo pginfo;
 	struct sgx_secinfo secinfo;
 	unsigned long encl_size;
+	struct file *backing;
 	long ret;
 
+	va_page = sgx_encl_grow(encl);
+	if (IS_ERR(va_page))
+		return PTR_ERR(va_page);
+	else if (va_page)
+		list_add(&va_page->list, &encl->va_pages);
+	/* else the tail page of the VA page list had free slots. */
+
 	/* The extra page goes to SECS. */
 	encl_size = secs->size + PAGE_SIZE;
 
-	secs_epc = __sgx_alloc_epc_page();
-	if (IS_ERR(secs_epc))
-		return PTR_ERR(secs_epc);
+	backing = shmem_file_setup("SGX backing", encl_size + (encl_size >> 5),
+				   VM_NORESERVE);
+	if (IS_ERR(backing)) {
+		ret = PTR_ERR(backing);
+		goto err_out_shrink;
+	}
+
+	encl->backing = backing;
+
+	secs_epc = sgx_alloc_epc_page(&encl->secs, true);
+	if (IS_ERR(secs_epc)) {
+		ret = PTR_ERR(secs_epc);
+		goto err_out_backing;
+	}
 
 	encl->secs.epc_page = secs_epc;
 
@@ -63,6 +120,13 @@ err_out:
 	sgx_free_epc_page(encl->secs.epc_page);
 	encl->secs.epc_page = NULL;
 
+err_out_backing:
+	fput(encl->backing);
+	encl->backing = NULL;
+
+err_out_shrink:
+	sgx_encl_shrink(encl, va_page);
+
 	return ret;
 }
 
@@ -228,22 +292,36 @@ static int sgx_encl_add_page(struct sgx_encl *encl, unsigned long src,
 {
 	struct sgx_encl_page *encl_page;
 	struct sgx_epc_page *epc_page;
+	struct sgx_va_page *va_page;
 	int ret;
 
 	encl_page = sgx_encl_page_alloc(encl, offset, secinfo->flags);
 	if (IS_ERR(encl_page))
 		return PTR_ERR(encl_page);
 
-	epc_page = __sgx_alloc_epc_page();
+	epc_page = sgx_alloc_epc_page(encl_page, true);
 	if (IS_ERR(epc_page)) {
 		kfree(encl_page);
 		return PTR_ERR(epc_page);
 	}
 
+	va_page = sgx_encl_grow(encl);
+	if (IS_ERR(va_page)) {
+		ret = PTR_ERR(va_page);
+		goto err_out_free;
+	}
+
 	mmap_read_lock(current->mm);
 	mutex_lock(&encl->lock);
 
 	/*
+	 * Adding to encl->va_pages must be done under encl->lock.  Ditto for
+	 * deleting (via sgx_encl_shrink()) in the error path.
+	 */
+	if (va_page)
+		list_add(&va_page->list, &encl->va_pages);
+
+	/*
 	 * Insert prior to EADD in case of OOM.  EADD modifies MRENCLAVE, i.e.
 	 * can't be gracefully unwound, while failure on EADD/EXTEND is limited
 	 * to userspace errors (or kernel/hardware bugs).
@@ -273,6 +351,7 @@ static int sgx_encl_add_page(struct sgx_encl *encl, unsigned long src,
 			goto err_out;
 	}
 
+	sgx_mark_page_reclaimable(encl_page->epc_page);
 	mutex_unlock(&encl->lock);
 	mmap_read_unlock(current->mm);
 	return ret;
@@ -281,9 +360,11 @@ err_out:
 	xa_erase(&encl->page_array, PFN_DOWN(encl_page->desc));
 
 err_out_unlock:
+	sgx_encl_shrink(encl, va_page);
 	mutex_unlock(&encl->lock);
 	mmap_read_unlock(current->mm);
 
+err_out_free:
 	sgx_free_epc_page(epc_page);
 	kfree(encl_page);
 
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 38f2e80..3426785 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -16,6 +16,15 @@
 struct sgx_epc_section sgx_epc_sections[SGX_MAX_EPC_SECTIONS];
 static int sgx_nr_epc_sections;
 static struct task_struct *ksgxd_tsk;
+static DECLARE_WAIT_QUEUE_HEAD(ksgxd_waitq);
+
+/*
+ * These variables are part of the state of the reclaimer, and must be accessed
+ * with sgx_reclaimer_lock acquired.
+ */
+static LIST_HEAD(sgx_active_page_list);
+
+static DEFINE_SPINLOCK(sgx_reclaimer_lock);
 
 /*
  * Reset dirty EPC pages to uninitialized state. Laundry can be left with SECS
@@ -50,6 +59,348 @@ static void sgx_sanitize_section(struct sgx_epc_section *section)
 	list_splice(&dirty, &section->laundry_list);
 }
 
+static bool sgx_reclaimer_age(struct sgx_epc_page *epc_page)
+{
+	struct sgx_encl_page *page = epc_page->owner;
+	struct sgx_encl *encl = page->encl;
+	struct sgx_encl_mm *encl_mm;
+	bool ret = true;
+	int idx;
+
+	idx = srcu_read_lock(&encl->srcu);
+
+	list_for_each_entry_rcu(encl_mm, &encl->mm_list, list) {
+		if (!mmget_not_zero(encl_mm->mm))
+			continue;
+
+		mmap_read_lock(encl_mm->mm);
+		ret = !sgx_encl_test_and_clear_young(encl_mm->mm, page);
+		mmap_read_unlock(encl_mm->mm);
+
+		mmput_async(encl_mm->mm);
+
+		if (!ret)
+			break;
+	}
+
+	srcu_read_unlock(&encl->srcu, idx);
+
+	if (!ret)
+		return false;
+
+	return true;
+}
+
+static void sgx_reclaimer_block(struct sgx_epc_page *epc_page)
+{
+	struct sgx_encl_page *page = epc_page->owner;
+	unsigned long addr = page->desc & PAGE_MASK;
+	struct sgx_encl *encl = page->encl;
+	unsigned long mm_list_version;
+	struct sgx_encl_mm *encl_mm;
+	struct vm_area_struct *vma;
+	int idx, ret;
+
+	do {
+		mm_list_version = encl->mm_list_version;
+
+		/* Pairs with smp_rmb() in sgx_encl_mm_add(). */
+		smp_rmb();
+
+		idx = srcu_read_lock(&encl->srcu);
+
+		list_for_each_entry_rcu(encl_mm, &encl->mm_list, list) {
+			if (!mmget_not_zero(encl_mm->mm))
+				continue;
+
+			mmap_read_lock(encl_mm->mm);
+
+			ret = sgx_encl_find(encl_mm->mm, addr, &vma);
+			if (!ret && encl == vma->vm_private_data)
+				zap_vma_ptes(vma, addr, PAGE_SIZE);
+
+			mmap_read_unlock(encl_mm->mm);
+
+			mmput_async(encl_mm->mm);
+		}
+
+		srcu_read_unlock(&encl->srcu, idx);
+	} while (unlikely(encl->mm_list_version != mm_list_version));
+
+	mutex_lock(&encl->lock);
+
+	ret = __eblock(sgx_get_epc_virt_addr(epc_page));
+	if (encls_failed(ret))
+		ENCLS_WARN(ret, "EBLOCK");
+
+	mutex_unlock(&encl->lock);
+}
+
+static int __sgx_encl_ewb(struct sgx_epc_page *epc_page, void *va_slot,
+			  struct sgx_backing *backing)
+{
+	struct sgx_pageinfo pginfo;
+	int ret;
+
+	pginfo.addr = 0;
+	pginfo.secs = 0;
+
+	pginfo.contents = (unsigned long)kmap_atomic(backing->contents);
+	pginfo.metadata = (unsigned long)kmap_atomic(backing->pcmd) +
+			  backing->pcmd_offset;
+
+	ret = __ewb(&pginfo, sgx_get_epc_virt_addr(epc_page), va_slot);
+
+	kunmap_atomic((void *)(unsigned long)(pginfo.metadata -
+					      backing->pcmd_offset));
+	kunmap_atomic((void *)(unsigned long)pginfo.contents);
+
+	return ret;
+}
+
+static void sgx_ipi_cb(void *info)
+{
+}
+
+static const cpumask_t *sgx_encl_ewb_cpumask(struct sgx_encl *encl)
+{
+	cpumask_t *cpumask = &encl->cpumask;
+	struct sgx_encl_mm *encl_mm;
+	int idx;
+
+	/*
+	 * Can race with sgx_encl_mm_add(), but ETRACK has already been
+	 * executed, which means that the CPUs running in the new mm will enter
+	 * into the enclave with a fresh epoch.
+	 */
+	cpumask_clear(cpumask);
+
+	idx = srcu_read_lock(&encl->srcu);
+
+	list_for_each_entry_rcu(encl_mm, &encl->mm_list, list) {
+		if (!mmget_not_zero(encl_mm->mm))
+			continue;
+
+		cpumask_or(cpumask, cpumask, mm_cpumask(encl_mm->mm));
+
+		mmput_async(encl_mm->mm);
+	}
+
+	srcu_read_unlock(&encl->srcu, idx);
+
+	return cpumask;
+}
+
+/*
+ * Swap page to the regular memory transformed to the blocked state by using
+ * EBLOCK, which means that it can no loger be referenced (no new TLB entries).
+ *
+ * The first trial just tries to write the page assuming that some other thread
+ * has reset the count for threads inside the enlave by using ETRACK, and
+ * previous thread count has been zeroed out. The second trial calls ETRACK
+ * before EWB. If that fails we kick all the HW threads out, and then do EWB,
+ * which should be guaranteed the succeed.
+ */
+static void sgx_encl_ewb(struct sgx_epc_page *epc_page,
+			 struct sgx_backing *backing)
+{
+	struct sgx_encl_page *encl_page = epc_page->owner;
+	struct sgx_encl *encl = encl_page->encl;
+	struct sgx_va_page *va_page;
+	unsigned int va_offset;
+	void *va_slot;
+	int ret;
+
+	encl_page->desc &= ~SGX_ENCL_PAGE_BEING_RECLAIMED;
+
+	va_page = list_first_entry(&encl->va_pages, struct sgx_va_page,
+				   list);
+	va_offset = sgx_alloc_va_slot(va_page);
+	va_slot = sgx_get_epc_virt_addr(va_page->epc_page) + va_offset;
+	if (sgx_va_page_full(va_page))
+		list_move_tail(&va_page->list, &encl->va_pages);
+
+	ret = __sgx_encl_ewb(epc_page, va_slot, backing);
+	if (ret == SGX_NOT_TRACKED) {
+		ret = __etrack(sgx_get_epc_virt_addr(encl->secs.epc_page));
+		if (ret) {
+			if (encls_failed(ret))
+				ENCLS_WARN(ret, "ETRACK");
+		}
+
+		ret = __sgx_encl_ewb(epc_page, va_slot, backing);
+		if (ret == SGX_NOT_TRACKED) {
+			/*
+			 * Slow path, send IPIs to kick cpus out of the
+			 * enclave.  Note, it's imperative that the cpu
+			 * mask is generated *after* ETRACK, else we'll
+			 * miss cpus that entered the enclave between
+			 * generating the mask and incrementing epoch.
+			 */
+			on_each_cpu_mask(sgx_encl_ewb_cpumask(encl),
+					 sgx_ipi_cb, NULL, 1);
+			ret = __sgx_encl_ewb(epc_page, va_slot, backing);
+		}
+	}
+
+	if (ret) {
+		if (encls_failed(ret))
+			ENCLS_WARN(ret, "EWB");
+
+		sgx_free_va_slot(va_page, va_offset);
+	} else {
+		encl_page->desc |= va_offset;
+		encl_page->va_page = va_page;
+	}
+}
+
+static void sgx_reclaimer_write(struct sgx_epc_page *epc_page,
+				struct sgx_backing *backing)
+{
+	struct sgx_encl_page *encl_page = epc_page->owner;
+	struct sgx_encl *encl = encl_page->encl;
+	struct sgx_backing secs_backing;
+	int ret;
+
+	mutex_lock(&encl->lock);
+
+	sgx_encl_ewb(epc_page, backing);
+	encl_page->epc_page = NULL;
+	encl->secs_child_cnt--;
+
+	if (!encl->secs_child_cnt && test_bit(SGX_ENCL_INITIALIZED, &encl->flags)) {
+		ret = sgx_encl_get_backing(encl, PFN_DOWN(encl->size),
+					   &secs_backing);
+		if (ret)
+			goto out;
+
+		sgx_encl_ewb(encl->secs.epc_page, &secs_backing);
+
+		sgx_free_epc_page(encl->secs.epc_page);
+		encl->secs.epc_page = NULL;
+
+		sgx_encl_put_backing(&secs_backing, true);
+	}
+
+out:
+	mutex_unlock(&encl->lock);
+}
+
+/*
+ * Take a fixed number of pages from the head of the active page pool and
+ * reclaim them to the enclave's private shmem files. Skip the pages, which have
+ * been accessed since the last scan. Move those pages to the tail of active
+ * page pool so that the pages get scanned in LRU like fashion.
+ *
+ * Batch process a chunk of pages (at the moment 16) in order to degrade amount
+ * of IPI's and ETRACK's potentially required. sgx_encl_ewb() does degrade a bit
+ * among the HW threads with three stage EWB pipeline (EWB, ETRACK + EWB and IPI
+ * + EWB) but not sufficiently. Reclaiming one page at a time would also be
+ * problematic as it would increase the lock contention too much, which would
+ * halt forward progress.
+ */
+static void sgx_reclaim_pages(void)
+{
+	struct sgx_epc_page *chunk[SGX_NR_TO_SCAN];
+	struct sgx_backing backing[SGX_NR_TO_SCAN];
+	struct sgx_epc_section *section;
+	struct sgx_encl_page *encl_page;
+	struct sgx_epc_page *epc_page;
+	pgoff_t page_index;
+	int cnt = 0;
+	int ret;
+	int i;
+
+	spin_lock(&sgx_reclaimer_lock);
+	for (i = 0; i < SGX_NR_TO_SCAN; i++) {
+		if (list_empty(&sgx_active_page_list))
+			break;
+
+		epc_page = list_first_entry(&sgx_active_page_list,
+					    struct sgx_epc_page, list);
+		list_del_init(&epc_page->list);
+		encl_page = epc_page->owner;
+
+		if (kref_get_unless_zero(&encl_page->encl->refcount) != 0)
+			chunk[cnt++] = epc_page;
+		else
+			/* The owner is freeing the page. No need to add the
+			 * page back to the list of reclaimable pages.
+			 */
+			epc_page->flags &= ~SGX_EPC_PAGE_RECLAIMER_TRACKED;
+	}
+	spin_unlock(&sgx_reclaimer_lock);
+
+	for (i = 0; i < cnt; i++) {
+		epc_page = chunk[i];
+		encl_page = epc_page->owner;
+
+		if (!sgx_reclaimer_age(epc_page))
+			goto skip;
+
+		page_index = PFN_DOWN(encl_page->desc - encl_page->encl->base);
+		ret = sgx_encl_get_backing(encl_page->encl, page_index, &backing[i]);
+		if (ret)
+			goto skip;
+
+		mutex_lock(&encl_page->encl->lock);
+		encl_page->desc |= SGX_ENCL_PAGE_BEING_RECLAIMED;
+		mutex_unlock(&encl_page->encl->lock);
+		continue;
+
+skip:
+		spin_lock(&sgx_reclaimer_lock);
+		list_add_tail(&epc_page->list, &sgx_active_page_list);
+		spin_unlock(&sgx_reclaimer_lock);
+
+		kref_put(&encl_page->encl->refcount, sgx_encl_release);
+
+		chunk[i] = NULL;
+	}
+
+	for (i = 0; i < cnt; i++) {
+		epc_page = chunk[i];
+		if (epc_page)
+			sgx_reclaimer_block(epc_page);
+	}
+
+	for (i = 0; i < cnt; i++) {
+		epc_page = chunk[i];
+		if (!epc_page)
+			continue;
+
+		encl_page = epc_page->owner;
+		sgx_reclaimer_write(epc_page, &backing[i]);
+		sgx_encl_put_backing(&backing[i], true);
+
+		kref_put(&encl_page->encl->refcount, sgx_encl_release);
+		epc_page->flags &= ~SGX_EPC_PAGE_RECLAIMER_TRACKED;
+
+		section = &sgx_epc_sections[epc_page->section];
+		spin_lock(&section->lock);
+		list_add_tail(&epc_page->list, &section->page_list);
+		section->free_cnt++;
+		spin_unlock(&section->lock);
+	}
+}
+
+static unsigned long sgx_nr_free_pages(void)
+{
+	unsigned long cnt = 0;
+	int i;
+
+	for (i = 0; i < sgx_nr_epc_sections; i++)
+		cnt += sgx_epc_sections[i].free_cnt;
+
+	return cnt;
+}
+
+static bool sgx_should_reclaim(unsigned long watermark)
+{
+	return sgx_nr_free_pages() < watermark &&
+	       !list_empty(&sgx_active_page_list);
+}
+
 static int ksgxd(void *p)
 {
 	int i;
@@ -71,6 +422,20 @@ static int ksgxd(void *p)
 			WARN(1, "EPC section %d has unsanitized pages.\n", i);
 	}
 
+	while (!kthread_should_stop()) {
+		if (try_to_freeze())
+			continue;
+
+		wait_event_freezable(ksgxd_waitq,
+				     kthread_should_stop() ||
+				     sgx_should_reclaim(SGX_NR_HIGH_PAGES));
+
+		if (sgx_should_reclaim(SGX_NR_HIGH_PAGES))
+			sgx_reclaim_pages();
+
+		cond_resched();
+	}
+
 	return 0;
 }
 
@@ -100,6 +465,7 @@ static struct sgx_epc_page *__sgx_alloc_epc_page_from_section(struct sgx_epc_sec
 
 	page = list_first_entry(&section->page_list, struct sgx_epc_page, list);
 	list_del_init(&page->list);
+	section->free_cnt--;
 
 	spin_unlock(&section->lock);
 	return page;
@@ -133,6 +499,100 @@ struct sgx_epc_page *__sgx_alloc_epc_page(void)
 }
 
 /**
+ * sgx_mark_page_reclaimable() - Mark a page as reclaimable
+ * @page:	EPC page
+ *
+ * Mark a page as reclaimable and add it to the active page list. Pages
+ * are automatically removed from the active list when freed.
+ */
+void sgx_mark_page_reclaimable(struct sgx_epc_page *page)
+{
+	spin_lock(&sgx_reclaimer_lock);
+	page->flags |= SGX_EPC_PAGE_RECLAIMER_TRACKED;
+	list_add_tail(&page->list, &sgx_active_page_list);
+	spin_unlock(&sgx_reclaimer_lock);
+}
+
+/**
+ * sgx_unmark_page_reclaimable() - Remove a page from the reclaim list
+ * @page:	EPC page
+ *
+ * Clear the reclaimable flag and remove the page from the active page list.
+ *
+ * Return:
+ *   0 on success,
+ *   -EBUSY if the page is in the process of being reclaimed
+ */
+int sgx_unmark_page_reclaimable(struct sgx_epc_page *page)
+{
+	spin_lock(&sgx_reclaimer_lock);
+	if (page->flags & SGX_EPC_PAGE_RECLAIMER_TRACKED) {
+		/* The page is being reclaimed. */
+		if (list_empty(&page->list)) {
+			spin_unlock(&sgx_reclaimer_lock);
+			return -EBUSY;
+		}
+
+		list_del(&page->list);
+		page->flags &= ~SGX_EPC_PAGE_RECLAIMER_TRACKED;
+	}
+	spin_unlock(&sgx_reclaimer_lock);
+
+	return 0;
+}
+
+/**
+ * sgx_alloc_epc_page() - Allocate an EPC page
+ * @owner:	the owner of the EPC page
+ * @reclaim:	reclaim pages if necessary
+ *
+ * Iterate through EPC sections and borrow a free EPC page to the caller. When a
+ * page is no longer needed it must be released with sgx_free_epc_page(). If
+ * @reclaim is set to true, directly reclaim pages when we are out of pages. No
+ * mm's can be locked when @reclaim is set to true.
+ *
+ * Finally, wake up ksgxd when the number of pages goes below the watermark
+ * before returning back to the caller.
+ *
+ * Return:
+ *   an EPC page,
+ *   -errno on error
+ */
+struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim)
+{
+	struct sgx_epc_page *page;
+
+	for ( ; ; ) {
+		page = __sgx_alloc_epc_page();
+		if (!IS_ERR(page)) {
+			page->owner = owner;
+			break;
+		}
+
+		if (list_empty(&sgx_active_page_list))
+			return ERR_PTR(-ENOMEM);
+
+		if (!reclaim) {
+			page = ERR_PTR(-EBUSY);
+			break;
+		}
+
+		if (signal_pending(current)) {
+			page = ERR_PTR(-ERESTARTSYS);
+			break;
+		}
+
+		sgx_reclaim_pages();
+		cond_resched();
+	}
+
+	if (sgx_should_reclaim(SGX_NR_LOW_PAGES))
+		wake_up(&ksgxd_waitq);
+
+	return page;
+}
+
+/**
  * sgx_free_epc_page() - Free an EPC page
  * @page:	an EPC page
  *
@@ -143,12 +603,15 @@ void sgx_free_epc_page(struct sgx_epc_page *page)
 	struct sgx_epc_section *section = &sgx_epc_sections[page->section];
 	int ret;
 
+	WARN_ON_ONCE(page->flags & SGX_EPC_PAGE_RECLAIMER_TRACKED);
+
 	ret = __eremove(sgx_get_epc_virt_addr(page));
 	if (WARN_ONCE(ret, "EREMOVE returned %d (0x%x)", ret, ret))
 		return;
 
 	spin_lock(&section->lock);
 	list_add_tail(&page->list, &section->page_list);
+	section->free_cnt++;
 	spin_unlock(&section->lock);
 }
 
@@ -176,9 +639,12 @@ static bool __init sgx_setup_epc_section(u64 phys_addr, u64 size,
 
 	for (i = 0; i < nr_pages; i++) {
 		section->pages[i].section = index;
+		section->pages[i].flags = 0;
+		section->pages[i].owner = NULL;
 		list_add_tail(&section->pages[i].list, &section->laundry_list);
 	}
 
+	section->free_cnt = nr_pages;
 	return true;
 }
 
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index 91234f4..a188a68 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -15,9 +15,17 @@
 
 #define SGX_MAX_EPC_SECTIONS		8
 #define SGX_EEXTEND_BLOCK_SIZE		256
+#define SGX_NR_TO_SCAN			16
+#define SGX_NR_LOW_PAGES		32
+#define SGX_NR_HIGH_PAGES		64
+
+/* Pages, which are being tracked by the page reclaimer. */
+#define SGX_EPC_PAGE_RECLAIMER_TRACKED	BIT(0)
 
 struct sgx_epc_page {
 	unsigned int section;
+	unsigned int flags;
+	struct sgx_encl_page *owner;
 	struct list_head list;
 };
 
@@ -33,6 +41,7 @@ struct sgx_epc_section {
 	struct list_head page_list;
 	struct list_head laundry_list;
 	struct sgx_epc_page *pages;
+	unsigned long free_cnt;
 	spinlock_t lock;
 };
 
@@ -61,4 +70,8 @@ static inline void *sgx_get_epc_virt_addr(struct sgx_epc_page *page)
 struct sgx_epc_page *__sgx_alloc_epc_page(void);
 void sgx_free_epc_page(struct sgx_epc_page *page);
 
+void sgx_mark_page_reclaimable(struct sgx_epc_page *page);
+int sgx_unmark_page_reclaimable(struct sgx_epc_page *page);
+struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim);
+
 #endif /* _X86_SGX_H */
