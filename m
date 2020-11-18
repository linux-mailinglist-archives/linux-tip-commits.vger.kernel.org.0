Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 226282B8303
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Nov 2020 18:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbgKRRTL (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 18 Nov 2020 12:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbgKRRS0 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 18 Nov 2020 12:18:26 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC615C061A48;
        Wed, 18 Nov 2020 09:18:25 -0800 (PST)
Date:   Wed, 18 Nov 2020 17:18:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605719904;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=27Hx/9L6Bgvxvckao76MI16Fd3OlfNj6W6bPpXmngk4=;
        b=pKY/qw2JHXqdJcVFyYyGtsqcR/YnsJlNuGUrbH6j9LZ4rYRNAaYGhrGmRZwM/b4LI8EmUu
        up4KNGCFmtv08lRMzLfepBlpg/1bcvD11KyrwpU7PcImVz8dqGJ/8PvzZslf3bsWQk4qBs
        TwJjBlBDxsUpb41xI+ZvmELoi8eAF2iSi5kooSgEGGCnfFKmrXme1aAWSSNgQW/BVCWD0W
        sI9jzUGJ/BKdLgwZTWLMtyRO+JxhYfW+RczvBc0qefhthyMcBWAoPKNg5duqhfR7biDY5r
        YerKmLbpNHvfsyha0Q31qTPdpeC3L8ez1I5G0JuKJ77UJsyoISo05X90gX5XNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605719904;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=27Hx/9L6Bgvxvckao76MI16Fd3OlfNj6W6bPpXmngk4=;
        b=ES1bWJZ9IwqBn1oZXo3+/SFL9vvibEiuOZrR0LW46xqeL5ZYbjHqIQ7t/A5NCWTJ7t2vG6
        q4wXubJoEnARD2Cw==
From:   "tip-bot2 for Jarkko Sakkinen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Add SGX_IOC_ENCLAVE_CREATE
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Jethro Beekman <jethro@fortanix.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201112220135.165028-13-jarkko@kernel.org>
References: <20201112220135.165028-13-jarkko@kernel.org>
MIME-Version: 1.0
Message-ID: <160571990352.11244.15572010531955820807.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     888d249117876239593fe3039b6ead8ad6849035
Gitweb:        https://git.kernel.org/tip/888d249117876239593fe3039b6ead8ad6849035
Author:        Jarkko Sakkinen <jarkko@kernel.org>
AuthorDate:    Fri, 13 Nov 2020 00:01:23 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 18 Nov 2020 18:02:49 +01:00

x86/sgx: Add SGX_IOC_ENCLAVE_CREATE

Add an ioctl() that performs the ECREATE function of the ENCLS
instruction, which creates an SGX Enclave Control Structure (SECS).

Although the SECS is an in-memory data structure, it is present in
enclave memory and is not directly accessible by software.

Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Tested-by: Jethro Beekman <jethro@fortanix.com>
Link: https://lkml.kernel.org/r/20201112220135.165028-13-jarkko@kernel.org
---
 Documentation/userspace-api/ioctl/ioctl-number.rst |   1 +-
 arch/x86/include/uapi/asm/sgx.h                    |  25 ++-
 arch/x86/kernel/cpu/sgx/Makefile                   |   1 +-
 arch/x86/kernel/cpu/sgx/driver.c                   |  12 +-
 arch/x86/kernel/cpu/sgx/driver.h                   |   3 +-
 arch/x86/kernel/cpu/sgx/encl.c                     |   8 +-
 arch/x86/kernel/cpu/sgx/encl.h                     |   7 +-
 arch/x86/kernel/cpu/sgx/ioctl.c                    | 123 ++++++++++++-
 8 files changed, 180 insertions(+)
 create mode 100644 arch/x86/include/uapi/asm/sgx.h
 create mode 100644 arch/x86/kernel/cpu/sgx/ioctl.c

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index 55a2d9b..a4c75a2 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -323,6 +323,7 @@ Code  Seq#    Include File                                           Comments
                                                                      <mailto:tlewis@mindspring.com>
 0xA3  90-9F  linux/dtlk.h
 0xA4  00-1F  uapi/linux/tee.h                                        Generic TEE subsystem
+0xA4  00-1F  uapi/asm/sgx.h                                          <mailto:linux-sgx@vger.kernel.org>
 0xAA  00-3F  linux/uapi/linux/userfaultfd.h
 0xAB  00-1F  linux/nbd.h
 0xAC  00-1F  linux/raw.h
diff --git a/arch/x86/include/uapi/asm/sgx.h b/arch/x86/include/uapi/asm/sgx.h
new file mode 100644
index 0000000..f31bb17
--- /dev/null
+++ b/arch/x86/include/uapi/asm/sgx.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright(c) 2016-20 Intel Corporation.
+ */
+#ifndef _UAPI_ASM_X86_SGX_H
+#define _UAPI_ASM_X86_SGX_H
+
+#include <linux/types.h>
+#include <linux/ioctl.h>
+
+#define SGX_MAGIC 0xA4
+
+#define SGX_IOC_ENCLAVE_CREATE \
+	_IOW(SGX_MAGIC, 0x00, struct sgx_enclave_create)
+
+/**
+ * struct sgx_enclave_create - parameter structure for the
+ *                             %SGX_IOC_ENCLAVE_CREATE ioctl
+ * @src:	address for the SECS page data
+ */
+struct sgx_enclave_create  {
+	__u64	src;
+};
+
+#endif /* _UAPI_ASM_X86_SGX_H */
diff --git a/arch/x86/kernel/cpu/sgx/Makefile b/arch/x86/kernel/cpu/sgx/Makefile
index 3fc4511..91d3dc7 100644
--- a/arch/x86/kernel/cpu/sgx/Makefile
+++ b/arch/x86/kernel/cpu/sgx/Makefile
@@ -1,4 +1,5 @@
 obj-y += \
 	driver.o \
 	encl.o \
+	ioctl.o \
 	main.o
diff --git a/arch/x86/kernel/cpu/sgx/driver.c b/arch/x86/kernel/cpu/sgx/driver.c
index c2810e1..ee947b7 100644
--- a/arch/x86/kernel/cpu/sgx/driver.c
+++ b/arch/x86/kernel/cpu/sgx/driver.c
@@ -88,10 +88,22 @@ static unsigned long sgx_get_unmapped_area(struct file *file,
 	return current->mm->get_unmapped_area(file, addr, len, pgoff, flags);
 }
 
+#ifdef CONFIG_COMPAT
+static long sgx_compat_ioctl(struct file *filep, unsigned int cmd,
+			      unsigned long arg)
+{
+	return sgx_ioctl(filep, cmd, arg);
+}
+#endif
+
 static const struct file_operations sgx_encl_fops = {
 	.owner			= THIS_MODULE,
 	.open			= sgx_open,
 	.release		= sgx_release,
+	.unlocked_ioctl		= sgx_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl		= sgx_compat_ioctl,
+#endif
 	.mmap			= sgx_mmap,
 	.get_unmapped_area	= sgx_get_unmapped_area,
 };
diff --git a/arch/x86/kernel/cpu/sgx/driver.h b/arch/x86/kernel/cpu/sgx/driver.h
index cda9c43..a728e8e 100644
--- a/arch/x86/kernel/cpu/sgx/driver.h
+++ b/arch/x86/kernel/cpu/sgx/driver.h
@@ -9,8 +9,11 @@
 #include <linux/rwsem.h>
 #include <linux/sched.h>
 #include <linux/workqueue.h>
+#include <uapi/asm/sgx.h>
 #include "sgx.h"
 
+long sgx_ioctl(struct file *filep, unsigned int cmd, unsigned long arg);
+
 int sgx_drv_init(void);
 
 #endif /* __ARCH_X86_SGX_DRIVER_H__ */
diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index b9d445d..57eff30 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -46,6 +46,7 @@ static vm_fault_t sgx_vma_fault(struct vm_fault *vmf)
 	struct sgx_encl_page *entry;
 	unsigned long phys_addr;
 	struct sgx_encl *encl;
+	unsigned long pfn;
 	vm_fault_t ret;
 
 	encl = vma->vm_private_data;
@@ -61,6 +62,13 @@ static vm_fault_t sgx_vma_fault(struct vm_fault *vmf)
 
 	phys_addr = sgx_get_epc_phys_addr(entry->epc_page);
 
+	/* Check if another thread got here first to insert the PTE. */
+	if (!follow_pfn(vma, addr, &pfn)) {
+		mutex_unlock(&encl->lock);
+
+		return VM_FAULT_NOPAGE;
+	}
+
 	ret = vmf_insert_pfn(vma, addr, PFN_DOWN(phys_addr));
 	if (ret != VM_FAULT_NOPAGE) {
 		mutex_unlock(&encl->lock);
diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/encl.h
index 1df8011..7cc1758 100644
--- a/arch/x86/kernel/cpu/sgx/encl.h
+++ b/arch/x86/kernel/cpu/sgx/encl.h
@@ -26,9 +26,16 @@ struct sgx_encl_page {
 	struct sgx_encl *encl;
 };
 
+enum sgx_encl_flags {
+	SGX_ENCL_IOCTL		= BIT(0),
+	SGX_ENCL_DEBUG		= BIT(1),
+	SGX_ENCL_CREATED	= BIT(2),
+};
+
 struct sgx_encl {
 	unsigned long base;
 	unsigned long size;
+	unsigned long flags;
 	unsigned int page_cnt;
 	unsigned int secs_child_cnt;
 	struct mutex lock;
diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
new file mode 100644
index 0000000..1355490
--- /dev/null
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  Copyright(c) 2016-20 Intel Corporation. */
+
+#include <asm/mman.h>
+#include <linux/mman.h>
+#include <linux/delay.h>
+#include <linux/file.h>
+#include <linux/hashtable.h>
+#include <linux/highmem.h>
+#include <linux/ratelimit.h>
+#include <linux/sched/signal.h>
+#include <linux/shmem_fs.h>
+#include <linux/slab.h>
+#include <linux/suspend.h>
+#include "driver.h"
+#include "encl.h"
+#include "encls.h"
+
+static int sgx_encl_create(struct sgx_encl *encl, struct sgx_secs *secs)
+{
+	struct sgx_epc_page *secs_epc;
+	struct sgx_pageinfo pginfo;
+	struct sgx_secinfo secinfo;
+	unsigned long encl_size;
+	long ret;
+
+	/* The extra page goes to SECS. */
+	encl_size = secs->size + PAGE_SIZE;
+
+	secs_epc = __sgx_alloc_epc_page();
+	if (IS_ERR(secs_epc))
+		return PTR_ERR(secs_epc);
+
+	encl->secs.epc_page = secs_epc;
+
+	pginfo.addr = 0;
+	pginfo.contents = (unsigned long)secs;
+	pginfo.metadata = (unsigned long)&secinfo;
+	pginfo.secs = 0;
+	memset(&secinfo, 0, sizeof(secinfo));
+
+	ret = __ecreate((void *)&pginfo, sgx_get_epc_virt_addr(secs_epc));
+	if (ret) {
+		ret = -EIO;
+		goto err_out;
+	}
+
+	if (secs->attributes & SGX_ATTR_DEBUG)
+		set_bit(SGX_ENCL_DEBUG, &encl->flags);
+
+	encl->secs.encl = encl;
+	encl->base = secs->base;
+	encl->size = secs->size;
+
+	/* Set only after completion, as encl->lock has not been taken. */
+	set_bit(SGX_ENCL_CREATED, &encl->flags);
+
+	return 0;
+
+err_out:
+	sgx_free_epc_page(encl->secs.epc_page);
+	encl->secs.epc_page = NULL;
+
+	return ret;
+}
+
+/**
+ * sgx_ioc_enclave_create() - handler for %SGX_IOC_ENCLAVE_CREATE
+ * @encl:	An enclave pointer.
+ * @arg:	The ioctl argument.
+ *
+ * Allocate kernel data structures for the enclave and invoke ECREATE.
+ *
+ * Return:
+ * - 0:		Success.
+ * - -EIO:	ECREATE failed.
+ * - -errno:	POSIX error.
+ */
+static long sgx_ioc_enclave_create(struct sgx_encl *encl, void __user *arg)
+{
+	struct sgx_enclave_create create_arg;
+	void *secs;
+	int ret;
+
+	if (test_bit(SGX_ENCL_CREATED, &encl->flags))
+		return -EINVAL;
+
+	if (copy_from_user(&create_arg, arg, sizeof(create_arg)))
+		return -EFAULT;
+
+	secs = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!secs)
+		return -ENOMEM;
+
+	if (copy_from_user(secs, (void __user *)create_arg.src, PAGE_SIZE))
+		ret = -EFAULT;
+	else
+		ret = sgx_encl_create(encl, secs);
+
+	kfree(secs);
+	return ret;
+}
+
+long sgx_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
+{
+	struct sgx_encl *encl = filep->private_data;
+	int ret;
+
+	if (test_and_set_bit(SGX_ENCL_IOCTL, &encl->flags))
+		return -EBUSY;
+
+	switch (cmd) {
+	case SGX_IOC_ENCLAVE_CREATE:
+		ret = sgx_ioc_enclave_create(encl, (void __user *)arg);
+		break;
+	default:
+		ret = -ENOIOCTLCMD;
+		break;
+	}
+
+	clear_bit(SGX_ENCL_IOCTL, &encl->flags);
+	return ret;
+}
