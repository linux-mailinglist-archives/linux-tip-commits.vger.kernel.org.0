Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14B822B82E4
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Nov 2020 18:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbgKRRS2 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 18 Nov 2020 12:18:28 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56280 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727369AbgKRRS2 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 18 Nov 2020 12:18:28 -0500
Date:   Wed, 18 Nov 2020 17:18:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605719905;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v1RiKtwyJtzMetV1K28sOBcYIqol9pqEKiZ59GtSmtc=;
        b=lKSBcW/xXcU5nLyyYfJx36ya7GDvHKOg68yBjhFT0aXYACwWCrDE8ejs9eBrK+3els+GDv
        jdBjlmOy+CRJJyyKuqXBnMm8PcImefrzNck6nVDv9ybretTNj3rB0XUpQIJhTefMd8eCwP
        BLWld1yCLB/HmBE5/XLe9n5uDKqlvT16mdaLTVbgGjCe0oaZUE6tm3iRtT6aXAw2yN0uyj
        OzwwUskxyGFZ7TTZKNe2P+XuckXxSK7K9IDxKhdzktWDYDY6eDk5NkOCHSti+3B1Mo4km9
        6zfV3NXbJyMU8idbvtFzjlG2l57bIjx5Jdqx94Ht4AZnFIgezOnWpdmGTb6bnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605719905;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v1RiKtwyJtzMetV1K28sOBcYIqol9pqEKiZ59GtSmtc=;
        b=DTAh5x0HIoqnVzpb0A/3nje6qVPSGZuIWYJjSkp6+HpkMEqyFGFcRcrsQXc5v9vWLaqa9O
        mS3J2aKMVYDpNsCg==
From:   "tip-bot2 for Jarkko Sakkinen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Add an SGX misc driver interface
Cc:     kernel test robot <lkp@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Jethro Beekman <jethro@fortanix.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201112220135.165028-12-jarkko@kernel.org>
References: <20201112220135.165028-12-jarkko@kernel.org>
MIME-Version: 1.0
Message-ID: <160571990410.11244.2109411015512292419.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     3fe0778edac8628637e2fd23835996523b1a3372
Gitweb:        https://git.kernel.org/tip/3fe0778edac8628637e2fd23835996523b1a3372
Author:        Jarkko Sakkinen <jarkko@kernel.org>
AuthorDate:    Fri, 13 Nov 2020 00:01:22 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 18 Nov 2020 18:01:16 +01:00

x86/sgx: Add an SGX misc driver interface

Intel(R) SGX is a new hardware functionality that can be used by
applications to set aside private regions of code and data called
enclaves. New hardware protects enclave code and data from outside
access and modification.

Add a driver that presents a device file and ioctl API to build and
manage enclaves.

 [ bp: Small touchups, remove unused encl variable in sgx_encl_find() as
   Reported-by: kernel test robot <lkp@intel.com> ]

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Tested-by: Jethro Beekman <jethro@fortanix.com>
Link: https://lkml.kernel.org/r/20201112220135.165028-12-jarkko@kernel.org
---
 arch/x86/kernel/cpu/sgx/Makefile |   2 +-
 arch/x86/kernel/cpu/sgx/driver.c | 112 +++++++++++++++++++++++-
 arch/x86/kernel/cpu/sgx/driver.h |  16 +++-
 arch/x86/kernel/cpu/sgx/encl.c   | 146 ++++++++++++++++++++++++++++++-
 arch/x86/kernel/cpu/sgx/encl.h   |  58 ++++++++++++-
 arch/x86/kernel/cpu/sgx/main.c   |  12 +-
 6 files changed, 345 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/kernel/cpu/sgx/driver.c
 create mode 100644 arch/x86/kernel/cpu/sgx/driver.h
 create mode 100644 arch/x86/kernel/cpu/sgx/encl.c
 create mode 100644 arch/x86/kernel/cpu/sgx/encl.h

diff --git a/arch/x86/kernel/cpu/sgx/Makefile b/arch/x86/kernel/cpu/sgx/Makefile
index 79510ce..3fc4511 100644
--- a/arch/x86/kernel/cpu/sgx/Makefile
+++ b/arch/x86/kernel/cpu/sgx/Makefile
@@ -1,2 +1,4 @@
 obj-y += \
+	driver.o \
+	encl.o \
 	main.o
diff --git a/arch/x86/kernel/cpu/sgx/driver.c b/arch/x86/kernel/cpu/sgx/driver.c
new file mode 100644
index 0000000..c2810e1
--- /dev/null
+++ b/arch/x86/kernel/cpu/sgx/driver.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  Copyright(c) 2016-20 Intel Corporation. */
+
+#include <linux/acpi.h>
+#include <linux/miscdevice.h>
+#include <linux/mman.h>
+#include <linux/security.h>
+#include <linux/suspend.h>
+#include <asm/traps.h>
+#include "driver.h"
+#include "encl.h"
+
+static int sgx_open(struct inode *inode, struct file *file)
+{
+	struct sgx_encl *encl;
+
+	encl = kzalloc(sizeof(*encl), GFP_KERNEL);
+	if (!encl)
+		return -ENOMEM;
+
+	xa_init(&encl->page_array);
+	mutex_init(&encl->lock);
+
+	file->private_data = encl;
+
+	return 0;
+}
+
+static int sgx_release(struct inode *inode, struct file *file)
+{
+	struct sgx_encl *encl = file->private_data;
+	struct sgx_encl_page *entry;
+	unsigned long index;
+
+	xa_for_each(&encl->page_array, index, entry) {
+		if (entry->epc_page) {
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
+	/* Detect EPC page leaks. */
+	WARN_ON_ONCE(encl->secs_child_cnt);
+	WARN_ON_ONCE(encl->secs.epc_page);
+
+	kfree(encl);
+	return 0;
+}
+
+static int sgx_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct sgx_encl *encl = file->private_data;
+	int ret;
+
+	ret = sgx_encl_may_map(encl, vma->vm_start, vma->vm_end, vma->vm_flags);
+	if (ret)
+		return ret;
+
+	vma->vm_ops = &sgx_vm_ops;
+	vma->vm_flags |= VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP | VM_IO;
+	vma->vm_private_data = encl;
+
+	return 0;
+}
+
+static unsigned long sgx_get_unmapped_area(struct file *file,
+					   unsigned long addr,
+					   unsigned long len,
+					   unsigned long pgoff,
+					   unsigned long flags)
+{
+	if ((flags & MAP_TYPE) == MAP_PRIVATE)
+		return -EINVAL;
+
+	if (flags & MAP_FIXED)
+		return addr;
+
+	return current->mm->get_unmapped_area(file, addr, len, pgoff, flags);
+}
+
+static const struct file_operations sgx_encl_fops = {
+	.owner			= THIS_MODULE,
+	.open			= sgx_open,
+	.release		= sgx_release,
+	.mmap			= sgx_mmap,
+	.get_unmapped_area	= sgx_get_unmapped_area,
+};
+
+static struct miscdevice sgx_dev_enclave = {
+	.minor = MISC_DYNAMIC_MINOR,
+	.name = "sgx_enclave",
+	.nodename = "sgx_enclave",
+	.fops = &sgx_encl_fops,
+};
+
+int __init sgx_drv_init(void)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_SGX_LC))
+		return -ENODEV;
+
+	return misc_register(&sgx_dev_enclave);
+}
diff --git a/arch/x86/kernel/cpu/sgx/driver.h b/arch/x86/kernel/cpu/sgx/driver.h
new file mode 100644
index 0000000..cda9c43
--- /dev/null
+++ b/arch/x86/kernel/cpu/sgx/driver.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ARCH_SGX_DRIVER_H__
+#define __ARCH_SGX_DRIVER_H__
+
+#include <crypto/hash.h>
+#include <linux/kref.h>
+#include <linux/mmu_notifier.h>
+#include <linux/radix-tree.h>
+#include <linux/rwsem.h>
+#include <linux/sched.h>
+#include <linux/workqueue.h>
+#include "sgx.h"
+
+int sgx_drv_init(void);
+
+#endif /* __ARCH_X86_SGX_DRIVER_H__ */
diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
new file mode 100644
index 0000000..b9d445d
--- /dev/null
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  Copyright(c) 2016-20 Intel Corporation. */
+
+#include <linux/lockdep.h>
+#include <linux/mm.h>
+#include <linux/mman.h>
+#include <linux/shmem_fs.h>
+#include <linux/suspend.h>
+#include <linux/sched/mm.h>
+#include "arch.h"
+#include "encl.h"
+#include "encls.h"
+#include "sgx.h"
+
+static struct sgx_encl_page *sgx_encl_load_page(struct sgx_encl *encl,
+						unsigned long addr,
+						unsigned long vm_flags)
+{
+	unsigned long vm_prot_bits = vm_flags & (VM_READ | VM_WRITE | VM_EXEC);
+	struct sgx_encl_page *entry;
+
+	entry = xa_load(&encl->page_array, PFN_DOWN(addr));
+	if (!entry)
+		return ERR_PTR(-EFAULT);
+
+	/*
+	 * Verify that the faulted page has equal or higher build time
+	 * permissions than the VMA permissions (i.e. the subset of {VM_READ,
+	 * VM_WRITE, VM_EXECUTE} in vma->vm_flags).
+	 */
+	if ((entry->vm_max_prot_bits & vm_prot_bits) != vm_prot_bits)
+		return ERR_PTR(-EFAULT);
+
+	/* No page found. */
+	if (!entry->epc_page)
+		return ERR_PTR(-EFAULT);
+
+	/* Entry successfully located. */
+	return entry;
+}
+
+static vm_fault_t sgx_vma_fault(struct vm_fault *vmf)
+{
+	unsigned long addr = (unsigned long)vmf->address;
+	struct vm_area_struct *vma = vmf->vma;
+	struct sgx_encl_page *entry;
+	unsigned long phys_addr;
+	struct sgx_encl *encl;
+	vm_fault_t ret;
+
+	encl = vma->vm_private_data;
+
+	mutex_lock(&encl->lock);
+
+	entry = sgx_encl_load_page(encl, addr, vma->vm_flags);
+	if (IS_ERR(entry)) {
+		mutex_unlock(&encl->lock);
+
+		return VM_FAULT_SIGBUS;
+	}
+
+	phys_addr = sgx_get_epc_phys_addr(entry->epc_page);
+
+	ret = vmf_insert_pfn(vma, addr, PFN_DOWN(phys_addr));
+	if (ret != VM_FAULT_NOPAGE) {
+		mutex_unlock(&encl->lock);
+
+		return VM_FAULT_SIGBUS;
+	}
+
+	mutex_unlock(&encl->lock);
+
+	return VM_FAULT_NOPAGE;
+}
+
+/**
+ * sgx_encl_may_map() - Check if a requested VMA mapping is allowed
+ * @encl:		an enclave pointer
+ * @start:		lower bound of the address range, inclusive
+ * @end:		upper bound of the address range, exclusive
+ * @vm_flags:		VMA flags
+ *
+ * Iterate through the enclave pages contained within [@start, @end) to verify
+ * that the permissions requested by a subset of {VM_READ, VM_WRITE, VM_EXEC}
+ * do not contain any permissions that are not contained in the build time
+ * permissions of any of the enclave pages within the given address range.
+ *
+ * An enclave creator must declare the strongest permissions that will be
+ * needed for each enclave page. This ensures that mappings have the identical
+ * or weaker permissions than the earlier declared permissions.
+ *
+ * Return: 0 on success, -EACCES otherwise
+ */
+int sgx_encl_may_map(struct sgx_encl *encl, unsigned long start,
+		     unsigned long end, unsigned long vm_flags)
+{
+	unsigned long vm_prot_bits = vm_flags & (VM_READ | VM_WRITE | VM_EXEC);
+	struct sgx_encl_page *page;
+	unsigned long count = 0;
+	int ret = 0;
+
+	XA_STATE(xas, &encl->page_array, PFN_DOWN(start));
+
+	/*
+	 * Disallow READ_IMPLIES_EXEC tasks as their VMA permissions might
+	 * conflict with the enclave page permissions.
+	 */
+	if (current->personality & READ_IMPLIES_EXEC)
+		return -EACCES;
+
+	mutex_lock(&encl->lock);
+	xas_lock(&xas);
+	xas_for_each(&xas, page, PFN_DOWN(end - 1)) {
+		if (~page->vm_max_prot_bits & vm_prot_bits) {
+			ret = -EACCES;
+			break;
+		}
+
+		/* Reschedule on every XA_CHECK_SCHED iteration. */
+		if (!(++count % XA_CHECK_SCHED)) {
+			xas_pause(&xas);
+			xas_unlock(&xas);
+			mutex_unlock(&encl->lock);
+
+			cond_resched();
+
+			mutex_lock(&encl->lock);
+			xas_lock(&xas);
+		}
+	}
+	xas_unlock(&xas);
+	mutex_unlock(&encl->lock);
+
+	return ret;
+}
+
+static int sgx_vma_mprotect(struct vm_area_struct *vma, unsigned long start,
+			    unsigned long end, unsigned long newflags)
+{
+	return sgx_encl_may_map(vma->vm_private_data, start, end, newflags);
+}
+
+const struct vm_operations_struct sgx_vm_ops = {
+	.fault = sgx_vma_fault,
+	.mprotect = sgx_vma_mprotect,
+};
diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/encl.h
new file mode 100644
index 0000000..1df8011
--- /dev/null
+++ b/arch/x86/kernel/cpu/sgx/encl.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/**
+ * Copyright(c) 2016-20 Intel Corporation.
+ *
+ * Contains the software defined data structures for enclaves.
+ */
+#ifndef _X86_ENCL_H
+#define _X86_ENCL_H
+
+#include <linux/cpumask.h>
+#include <linux/kref.h>
+#include <linux/list.h>
+#include <linux/mm_types.h>
+#include <linux/mmu_notifier.h>
+#include <linux/mutex.h>
+#include <linux/notifier.h>
+#include <linux/srcu.h>
+#include <linux/workqueue.h>
+#include <linux/xarray.h>
+#include "sgx.h"
+
+struct sgx_encl_page {
+	unsigned long desc;
+	unsigned long vm_max_prot_bits;
+	struct sgx_epc_page *epc_page;
+	struct sgx_encl *encl;
+};
+
+struct sgx_encl {
+	unsigned long base;
+	unsigned long size;
+	unsigned int page_cnt;
+	unsigned int secs_child_cnt;
+	struct mutex lock;
+	struct xarray page_array;
+	struct sgx_encl_page secs;
+};
+
+extern const struct vm_operations_struct sgx_vm_ops;
+
+static inline int sgx_encl_find(struct mm_struct *mm, unsigned long addr,
+				struct vm_area_struct **vma)
+{
+	struct vm_area_struct *result;
+
+	result = find_vma(mm, addr);
+	if (!result || result->vm_ops != &sgx_vm_ops || addr < result->vm_start)
+		return -EINVAL;
+
+	*vma = result;
+
+	return 0;
+}
+
+int sgx_encl_may_map(struct sgx_encl *encl, unsigned long start,
+		     unsigned long end, unsigned long vm_flags);
+
+#endif /* _X86_ENCL_H */
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 2e53afc..38f2e80 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -9,6 +9,8 @@
 #include <linux/sched/mm.h>
 #include <linux/sched/signal.h>
 #include <linux/slab.h>
+#include "driver.h"
+#include "encl.h"
 #include "encls.h"
 
 struct sgx_epc_section sgx_epc_sections[SGX_MAX_EPC_SECTIONS];
@@ -232,9 +234,10 @@ static bool __init sgx_page_cache_init(void)
 
 static void __init sgx_init(void)
 {
+	int ret;
 	int i;
 
-	if (!boot_cpu_has(X86_FEATURE_SGX))
+	if (!cpu_feature_enabled(X86_FEATURE_SGX))
 		return;
 
 	if (!sgx_page_cache_init())
@@ -243,8 +246,15 @@ static void __init sgx_init(void)
 	if (!sgx_page_reclaimer_init())
 		goto err_page_cache;
 
+	ret = sgx_drv_init();
+	if (ret)
+		goto err_kthread;
+
 	return;
 
+err_kthread:
+	kthread_stop(ksgxd_tsk);
+
 err_page_cache:
 	for (i = 0; i < sgx_nr_epc_sections; i++) {
 		vfree(sgx_epc_sections[i].pages);
