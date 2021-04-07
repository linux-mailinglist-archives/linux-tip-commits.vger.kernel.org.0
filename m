Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEC63568CC
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Apr 2021 12:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346381AbhDGKE1 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 7 Apr 2021 06:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350520AbhDGKDq (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 7 Apr 2021 06:03:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E79CC0613D7;
        Wed,  7 Apr 2021 03:03:35 -0700 (PDT)
Date:   Wed, 07 Apr 2021 10:03:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617789813;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3/MffSavdSXt6MO9qvM3cvdBR8fak9CGPPg2vvgX6Uw=;
        b=jkvyRkdrs0xOUsHTbKLenpuYxFMqwHWlQcXcrQGykJisAyqvgMyABMp4U5K8wuyVhOmAjJ
        Xc8OtfHpLEbwYcNy/vjs06PRMoT2QVaq+IMlk8lq4HOXOADpx+fZg6hFZEEpwBaL7GXRLS
        p3w50nszc8NlFpvOGGdFr2/5eIOQPg1lPQGXdekCm/8/w809jXEQywOX9yFQhh0Hp04/46
        mSvUCgNyvjNbetiqUmj/zNUGZP1AQEWBDFVwVCCXuN3Qj5kwdz8lr9ASRBmzkx5XkxsTOW
        1QV2DIDw+rL/33AYcd7A4010tv4URuz15fE8dRC7qdbPWcjF6Bk1q4rbZOHVpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617789813;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3/MffSavdSXt6MO9qvM3cvdBR8fak9CGPPg2vvgX6Uw=;
        b=wjf/jjITsAWdrW3JI3pKYfTV59g23CTbZlwYx2RfAC3vhEu9QfT0WaDoVlQjX76I5xvdrK
        hiImr7rml2+hBWCg==
From:   "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Introduce virtual EPC for use by KVM guests
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Kai Huang <kai.huang@intel.com>, Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <0c38ced8c8e5a69872db4d6a1c0dabd01e07cad7.1616136308.git.kai.huang@intel.com>
References: <0c38ced8c8e5a69872db4d6a1c0dabd01e07cad7.1616136308.git.kai.huang@intel.com>
MIME-Version: 1.0
Message-ID: <161778981326.29796.8052254661871074279.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     540745ddbc70eabdc7dbd3fcc00fe4fb17cd59ba
Gitweb:        https://git.kernel.org/tip/540745ddbc70eabdc7dbd3fcc00fe4fb17cd59ba
Author:        Sean Christopherson <sean.j.christopherson@intel.com>
AuthorDate:    Fri, 19 Mar 2021 20:22:21 +13:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 06 Apr 2021 09:43:17 +02:00

x86/sgx: Introduce virtual EPC for use by KVM guests

Add a misc device /dev/sgx_vepc to allow userspace to allocate "raw"
Enclave Page Cache (EPC) without an associated enclave. The intended
and only known use case for raw EPC allocation is to expose EPC to a
KVM guest, hence the 'vepc' moniker, virt.{c,h} files and X86_SGX_KVM
Kconfig.

The SGX driver uses the misc device /dev/sgx_enclave to support
userspace in creating an enclave. Each file descriptor returned from
opening /dev/sgx_enclave represents an enclave. Unlike the SGX driver,
KVM doesn't control how the guest uses the EPC, therefore EPC allocated
to a KVM guest is not associated with an enclave, and /dev/sgx_enclave
is not suitable for allocating EPC for a KVM guest.

Having separate device nodes for the SGX driver and KVM virtual EPC also
allows separate permission control for running host SGX enclaves and KVM
SGX guests.

To use /dev/sgx_vepc to allocate a virtual EPC instance with particular
size, the hypervisor opens /dev/sgx_vepc, and uses mmap() with the
intended size to get an address range of virtual EPC. Then it may use
the address range to create one KVM memory slot as virtual EPC for
a guest.

Implement the "raw" EPC allocation in the x86 core-SGX subsystem via
/dev/sgx_vepc rather than in KVM. Doing so has two major advantages:

  - Does not require changes to KVM's uAPI, e.g. EPC gets handled as
    just another memory backend for guests.

  - EPC management is wholly contained in the SGX subsystem, e.g. SGX
    does not have to export any symbols, changes to reclaim flows don't
    need to be routed through KVM, SGX's dirty laundry doesn't have to
    get aired out for the world to see, and so on and so forth.

The virtual EPC pages allocated to guests are currently not reclaimable.
Reclaiming an EPC page used by enclave requires a special reclaim
mechanism separate from normal page reclaim, and that mechanism is not
supported for virutal EPC pages. Due to the complications of handling
reclaim conflicts between guest and host, reclaiming virtual EPC pages
is significantly more complex than basic support for SGX virtualization.

 [ bp:
   - Massage commit message and comments
   - use cpu_feature_enabled()
   - vertically align struct members init
   - massage Virtual EPC clarification text
   - move Kconfig prompt to Virtualization ]

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Co-developed-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Dave Hansen <dave.hansen@intel.com>
Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://lkml.kernel.org/r/0c38ced8c8e5a69872db4d6a1c0dabd01e07cad7.1616136308.git.kai.huang@intel.com
---
 Documentation/x86/sgx.rst        |  16 ++-
 arch/x86/kernel/cpu/sgx/Makefile |   1 +-
 arch/x86/kernel/cpu/sgx/sgx.h    |   9 +-
 arch/x86/kernel/cpu/sgx/virt.c   | 259 ++++++++++++++++++++++++++++++-
 arch/x86/kvm/Kconfig             |  12 +-
 5 files changed, 297 insertions(+)
 create mode 100644 arch/x86/kernel/cpu/sgx/virt.c

diff --git a/Documentation/x86/sgx.rst b/Documentation/x86/sgx.rst
index f90076e..dd0ac96 100644
--- a/Documentation/x86/sgx.rst
+++ b/Documentation/x86/sgx.rst
@@ -234,3 +234,19 @@ As a result, when this happpens, user should stop running any new
 SGX workloads, (or just any new workloads), and migrate all valuable
 workloads. Although a machine reboot can recover all EPC memory, the bug
 should be reported to Linux developers.
+
+
+Virtual EPC
+===========
+
+The implementation has also a virtual EPC driver to support SGX enclaves
+in guests. Unlike the SGX driver, an EPC page allocated by the virtual
+EPC driver doesn't have a specific enclave associated with it. This is
+because KVM doesn't track how a guest uses EPC pages.
+
+As a result, the SGX core page reclaimer doesn't support reclaiming EPC
+pages allocated to KVM guests through the virtual EPC driver. If the
+user wants to deploy SGX applications both on the host and in guests
+on the same machine, the user should reserve enough EPC (by taking out
+total virtual EPC size of all SGX VMs from the physical EPC size) for
+host SGX applications so they can run with acceptable performance.
diff --git a/arch/x86/kernel/cpu/sgx/Makefile b/arch/x86/kernel/cpu/sgx/Makefile
index 91d3dc7..9c16567 100644
--- a/arch/x86/kernel/cpu/sgx/Makefile
+++ b/arch/x86/kernel/cpu/sgx/Makefile
@@ -3,3 +3,4 @@ obj-y += \
 	encl.o \
 	ioctl.o \
 	main.o
+obj-$(CONFIG_X86_SGX_KVM)	+= virt.o
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index 4aa40c6..4854f39 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -84,4 +84,13 @@ void sgx_mark_page_reclaimable(struct sgx_epc_page *page);
 int sgx_unmark_page_reclaimable(struct sgx_epc_page *page);
 struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim);
 
+#ifdef CONFIG_X86_SGX_KVM
+int __init sgx_vepc_init(void);
+#else
+static inline int __init sgx_vepc_init(void)
+{
+	return -ENODEV;
+}
+#endif
+
 #endif /* _X86_SGX_H */
diff --git a/arch/x86/kernel/cpu/sgx/virt.c b/arch/x86/kernel/cpu/sgx/virt.c
new file mode 100644
index 0000000..259cc46
--- /dev/null
+++ b/arch/x86/kernel/cpu/sgx/virt.c
@@ -0,0 +1,259 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device driver to expose SGX enclave memory to KVM guests.
+ *
+ * Copyright(c) 2021 Intel Corporation.
+ */
+
+#include <linux/miscdevice.h>
+#include <linux/mm.h>
+#include <linux/mman.h>
+#include <linux/sched/mm.h>
+#include <linux/sched/signal.h>
+#include <linux/slab.h>
+#include <linux/xarray.h>
+#include <asm/sgx.h>
+#include <uapi/asm/sgx.h>
+
+#include "encls.h"
+#include "sgx.h"
+
+struct sgx_vepc {
+	struct xarray page_array;
+	struct mutex lock;
+};
+
+/*
+ * Temporary SECS pages that cannot be EREMOVE'd due to having child in other
+ * virtual EPC instances, and the lock to protect it.
+ */
+static struct mutex zombie_secs_pages_lock;
+static struct list_head zombie_secs_pages;
+
+static int __sgx_vepc_fault(struct sgx_vepc *vepc,
+			    struct vm_area_struct *vma, unsigned long addr)
+{
+	struct sgx_epc_page *epc_page;
+	unsigned long index, pfn;
+	int ret;
+
+	WARN_ON(!mutex_is_locked(&vepc->lock));
+
+	/* Calculate index of EPC page in virtual EPC's page_array */
+	index = vma->vm_pgoff + PFN_DOWN(addr - vma->vm_start);
+
+	epc_page = xa_load(&vepc->page_array, index);
+	if (epc_page)
+		return 0;
+
+	epc_page = sgx_alloc_epc_page(vepc, false);
+	if (IS_ERR(epc_page))
+		return PTR_ERR(epc_page);
+
+	ret = xa_err(xa_store(&vepc->page_array, index, epc_page, GFP_KERNEL));
+	if (ret)
+		goto err_free;
+
+	pfn = PFN_DOWN(sgx_get_epc_phys_addr(epc_page));
+
+	ret = vmf_insert_pfn(vma, addr, pfn);
+	if (ret != VM_FAULT_NOPAGE) {
+		ret = -EFAULT;
+		goto err_delete;
+	}
+
+	return 0;
+
+err_delete:
+	xa_erase(&vepc->page_array, index);
+err_free:
+	sgx_free_epc_page(epc_page);
+	return ret;
+}
+
+static vm_fault_t sgx_vepc_fault(struct vm_fault *vmf)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	struct sgx_vepc *vepc = vma->vm_private_data;
+	int ret;
+
+	mutex_lock(&vepc->lock);
+	ret = __sgx_vepc_fault(vepc, vma, vmf->address);
+	mutex_unlock(&vepc->lock);
+
+	if (!ret)
+		return VM_FAULT_NOPAGE;
+
+	if (ret == -EBUSY && (vmf->flags & FAULT_FLAG_ALLOW_RETRY)) {
+		mmap_read_unlock(vma->vm_mm);
+		return VM_FAULT_RETRY;
+	}
+
+	return VM_FAULT_SIGBUS;
+}
+
+const struct vm_operations_struct sgx_vepc_vm_ops = {
+	.fault = sgx_vepc_fault,
+};
+
+static int sgx_vepc_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct sgx_vepc *vepc = file->private_data;
+
+	if (!(vma->vm_flags & VM_SHARED))
+		return -EINVAL;
+
+	vma->vm_ops = &sgx_vepc_vm_ops;
+	/* Don't copy VMA in fork() */
+	vma->vm_flags |= VM_PFNMAP | VM_IO | VM_DONTDUMP | VM_DONTCOPY;
+	vma->vm_private_data = vepc;
+
+	return 0;
+}
+
+static int sgx_vepc_free_page(struct sgx_epc_page *epc_page)
+{
+	int ret;
+
+	/*
+	 * Take a previously guest-owned EPC page and return it to the
+	 * general EPC page pool.
+	 *
+	 * Guests can not be trusted to have left this page in a good
+	 * state, so run EREMOVE on the page unconditionally.  In the
+	 * case that a guest properly EREMOVE'd this page, a superfluous
+	 * EREMOVE is harmless.
+	 */
+	ret = __eremove(sgx_get_epc_virt_addr(epc_page));
+	if (ret) {
+		/*
+		 * Only SGX_CHILD_PRESENT is expected, which is because of
+		 * EREMOVE'ing an SECS still with child, in which case it can
+		 * be handled by EREMOVE'ing the SECS again after all pages in
+		 * virtual EPC have been EREMOVE'd. See comments in below in
+		 * sgx_vepc_release().
+		 *
+		 * The user of virtual EPC (KVM) needs to guarantee there's no
+		 * logical processor is still running in the enclave in guest,
+		 * otherwise EREMOVE will get SGX_ENCLAVE_ACT which cannot be
+		 * handled here.
+		 */
+		WARN_ONCE(ret != SGX_CHILD_PRESENT, EREMOVE_ERROR_MESSAGE,
+			  ret, ret);
+		return ret;
+	}
+
+	sgx_free_epc_page(epc_page);
+
+	return 0;
+}
+
+static int sgx_vepc_release(struct inode *inode, struct file *file)
+{
+	struct sgx_vepc *vepc = file->private_data;
+	struct sgx_epc_page *epc_page, *tmp, *entry;
+	unsigned long index;
+
+	LIST_HEAD(secs_pages);
+
+	xa_for_each(&vepc->page_array, index, entry) {
+		/*
+		 * Remove all normal, child pages.  sgx_vepc_free_page()
+		 * will fail if EREMOVE fails, but this is OK and expected on
+		 * SECS pages.  Those can only be EREMOVE'd *after* all their
+		 * child pages. Retries below will clean them up.
+		 */
+		if (sgx_vepc_free_page(entry))
+			continue;
+
+		xa_erase(&vepc->page_array, index);
+	}
+
+	/*
+	 * Retry EREMOVE'ing pages.  This will clean up any SECS pages that
+	 * only had children in this 'epc' area.
+	 */
+	xa_for_each(&vepc->page_array, index, entry) {
+		epc_page = entry;
+		/*
+		 * An EREMOVE failure here means that the SECS page still
+		 * has children.  But, since all children in this 'sgx_vepc'
+		 * have been removed, the SECS page must have a child on
+		 * another instance.
+		 */
+		if (sgx_vepc_free_page(epc_page))
+			list_add_tail(&epc_page->list, &secs_pages);
+
+		xa_erase(&vepc->page_array, index);
+	}
+
+	/*
+	 * SECS pages are "pinned" by child pages, and "unpinned" once all
+	 * children have been EREMOVE'd.  A child page in this instance
+	 * may have pinned an SECS page encountered in an earlier release(),
+	 * creating a zombie.  Since some children were EREMOVE'd above,
+	 * try to EREMOVE all zombies in the hopes that one was unpinned.
+	 */
+	mutex_lock(&zombie_secs_pages_lock);
+	list_for_each_entry_safe(epc_page, tmp, &zombie_secs_pages, list) {
+		/*
+		 * Speculatively remove the page from the list of zombies,
+		 * if the page is successfully EREMOVE'd it will be added to
+		 * the list of free pages.  If EREMOVE fails, throw the page
+		 * on the local list, which will be spliced on at the end.
+		 */
+		list_del(&epc_page->list);
+
+		if (sgx_vepc_free_page(epc_page))
+			list_add_tail(&epc_page->list, &secs_pages);
+	}
+
+	if (!list_empty(&secs_pages))
+		list_splice_tail(&secs_pages, &zombie_secs_pages);
+	mutex_unlock(&zombie_secs_pages_lock);
+
+	kfree(vepc);
+
+	return 0;
+}
+
+static int sgx_vepc_open(struct inode *inode, struct file *file)
+{
+	struct sgx_vepc *vepc;
+
+	vepc = kzalloc(sizeof(struct sgx_vepc), GFP_KERNEL);
+	if (!vepc)
+		return -ENOMEM;
+	mutex_init(&vepc->lock);
+	xa_init(&vepc->page_array);
+
+	file->private_data = vepc;
+
+	return 0;
+}
+
+static const struct file_operations sgx_vepc_fops = {
+	.owner		= THIS_MODULE,
+	.open		= sgx_vepc_open,
+	.release	= sgx_vepc_release,
+	.mmap		= sgx_vepc_mmap,
+};
+
+static struct miscdevice sgx_vepc_dev = {
+	.minor		= MISC_DYNAMIC_MINOR,
+	.name		= "sgx_vepc",
+	.nodename	= "sgx_vepc",
+	.fops		= &sgx_vepc_fops,
+};
+
+int __init sgx_vepc_init(void)
+{
+	/* SGX virtualization requires KVM to work */
+	if (!cpu_feature_enabled(X86_FEATURE_VMX))
+		return -ENODEV;
+
+	INIT_LIST_HEAD(&zombie_secs_pages);
+	mutex_init(&zombie_secs_pages_lock);
+
+	return misc_register(&sgx_vepc_dev);
+}
diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index a788d51..f6b93a3 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -84,6 +84,18 @@ config KVM_INTEL
 	  To compile this as a module, choose M here: the module
 	  will be called kvm-intel.
 
+config X86_SGX_KVM
+	bool "Software Guard eXtensions (SGX) Virtualization"
+	depends on X86_SGX && KVM_INTEL
+	help
+
+	  Enables KVM guests to create SGX enclaves.
+
+	  This includes support to expose "raw" unreclaimable enclave memory to
+	  guests via a device node, e.g. /dev/sgx_vepc.
+
+	  If unsure, say N.
+
 config KVM_AMD
 	tristate "KVM for AMD processors support"
 	depends on KVM
