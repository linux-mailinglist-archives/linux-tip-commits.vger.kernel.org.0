Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA3753568D6
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Apr 2021 12:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239762AbhDGKEr (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 7 Apr 2021 06:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350493AbhDGKDl (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 7 Apr 2021 06:03:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1179DC061760;
        Wed,  7 Apr 2021 03:03:32 -0700 (PDT)
Date:   Wed, 07 Apr 2021 10:03:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617789810;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xM/UU+o8Ip7UFOOavnz8TO1pCFJKthmwsKn0Ef2sAvc=;
        b=t2cvNUfJe8qfA8PW5tAcNP7a/BjVctcTPVP/cGPWG8+gsmLfdqrK82v0a31u1Umrg5VoLY
        Ey4RUtfa/XNWZVjyRwW2G92blj1kYMHcJkmYsHr7Cw22KBUbhQ3eRUMAWKNTQxspM2bUrx
        KXw6gyaS7yzIOBgdV+XSiafj093SVe33T7ikLozRVEZLoRnWeq5kWcVbC4Gt2Rb5WBnItV
        iGUp4yfXUZvvpm+uzvy7syTHA8l5WC7bD0sbGvTvaNECbFd/NSK4GvWk/0U/ZcLtl5UBeH
        uLcz/WcZorvrb1jCC22jD8U+S6CSlptkIGMOhqtzSqJYX4ojLhiiAvulTzVw0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617789810;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xM/UU+o8Ip7UFOOavnz8TO1pCFJKthmwsKn0Ef2sAvc=;
        b=fWsDpdihOkohkNFBL6WGfIcM/vtxkcB2k2q2ECQsW4vEp6rUUdDEkK1FKLkxJXQ8KlJb0y
        06iXL3CHN+upigAw==
From:   "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Move provisioning device creation out of SGX driver
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Kai Huang <kai.huang@intel.com>, Borislav Petkov <bp@suse.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <0f4d044d621561f26d5f4ef73e8dc6cd18cc7e79.1616136308.git.kai.huang@intel.com>
References: <0f4d044d621561f26d5f4ef73e8dc6cd18cc7e79.1616136308.git.kai.huang@intel.com>
MIME-Version: 1.0
Message-ID: <161778980986.29796.16353826808643557896.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     b3754e5d3da320af2bebb7a690002685c7f5c15c
Gitweb:        https://git.kernel.org/tip/b3754e5d3da320af2bebb7a690002685c7f5c15c
Author:        Sean Christopherson <sean.j.christopherson@intel.com>
AuthorDate:    Fri, 19 Mar 2021 20:23:09 +13:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 06 Apr 2021 19:18:46 +02:00

x86/sgx: Move provisioning device creation out of SGX driver

And extract sgx_set_attribute() out of sgx_ioc_enclave_provision() and
export it as symbol for KVM to use.

The provisioning key is sensitive. The SGX driver only allows to create
an enclave which can access the provisioning key when the enclave
creator has permission to open /dev/sgx_provision. It should apply to
a VM as well, as the provisioning key is platform-specific, thus an
unrestricted VM can also potentially compromise the provisioning key.

Move the provisioning device creation out of sgx_drv_init() to
sgx_init() as a preparation for adding SGX virtualization support,
so that even if the SGX driver is not enabled due to flexible launch
control not being available, SGX virtualization can still be enabled,
and use it to restrict a VM's capability of being able to access the
provisioning key.

 [ bp: Massage commit message. ]

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Acked-by: Dave Hansen <dave.hansen@intel.com>
Link: https://lkml.kernel.org/r/0f4d044d621561f26d5f4ef73e8dc6cd18cc7e79.1616136308.git.kai.huang@intel.com
---
 arch/x86/include/asm/sgx.h       |  3 ++-
 arch/x86/kernel/cpu/sgx/driver.c | 17 +---------
 arch/x86/kernel/cpu/sgx/ioctl.c  | 16 +--------
 arch/x86/kernel/cpu/sgx/main.c   | 57 ++++++++++++++++++++++++++++++-
 4 files changed, 61 insertions(+), 32 deletions(-)

diff --git a/arch/x86/include/asm/sgx.h b/arch/x86/include/asm/sgx.h
index 954042e..a16e2c9 100644
--- a/arch/x86/include/asm/sgx.h
+++ b/arch/x86/include/asm/sgx.h
@@ -372,4 +372,7 @@ int sgx_virt_einit(void __user *sigstruct, void __user *token,
 		   void __user *secs, u64 *lepubkeyhash, int *trapnr);
 #endif
 
+int sgx_set_attribute(unsigned long *allowed_attributes,
+		      unsigned int attribute_fd);
+
 #endif /* _ASM_X86_SGX_H */
diff --git a/arch/x86/kernel/cpu/sgx/driver.c b/arch/x86/kernel/cpu/sgx/driver.c
index 8ce6d83..aa9b8b8 100644
--- a/arch/x86/kernel/cpu/sgx/driver.c
+++ b/arch/x86/kernel/cpu/sgx/driver.c
@@ -136,10 +136,6 @@ static const struct file_operations sgx_encl_fops = {
 	.get_unmapped_area	= sgx_get_unmapped_area,
 };
 
-const struct file_operations sgx_provision_fops = {
-	.owner			= THIS_MODULE,
-};
-
 static struct miscdevice sgx_dev_enclave = {
 	.minor = MISC_DYNAMIC_MINOR,
 	.name = "sgx_enclave",
@@ -147,13 +143,6 @@ static struct miscdevice sgx_dev_enclave = {
 	.fops = &sgx_encl_fops,
 };
 
-static struct miscdevice sgx_dev_provision = {
-	.minor = MISC_DYNAMIC_MINOR,
-	.name = "sgx_provision",
-	.nodename = "sgx_provision",
-	.fops = &sgx_provision_fops,
-};
-
 int __init sgx_drv_init(void)
 {
 	unsigned int eax, ebx, ecx, edx;
@@ -187,11 +176,5 @@ int __init sgx_drv_init(void)
 	if (ret)
 		return ret;
 
-	ret = misc_register(&sgx_dev_provision);
-	if (ret) {
-		misc_deregister(&sgx_dev_enclave);
-		return ret;
-	}
-
 	return 0;
 }
diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index 7be9c06..83df20e 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -2,6 +2,7 @@
 /*  Copyright(c) 2016-20 Intel Corporation. */
 
 #include <asm/mman.h>
+#include <asm/sgx.h>
 #include <linux/mman.h>
 #include <linux/delay.h>
 #include <linux/file.h>
@@ -666,24 +667,11 @@ out:
 static long sgx_ioc_enclave_provision(struct sgx_encl *encl, void __user *arg)
 {
 	struct sgx_enclave_provision params;
-	struct file *file;
 
 	if (copy_from_user(&params, arg, sizeof(params)))
 		return -EFAULT;
 
-	file = fget(params.fd);
-	if (!file)
-		return -EINVAL;
-
-	if (file->f_op != &sgx_provision_fops) {
-		fput(file);
-		return -EINVAL;
-	}
-
-	encl->attributes_mask |= SGX_ATTR_PROVISIONKEY;
-
-	fput(file);
-	return 0;
+	return sgx_set_attribute(&encl->attributes_mask, params.fd);
 }
 
 long sgx_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 227f1e2..92cb11d 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -1,14 +1,17 @@
 // SPDX-License-Identifier: GPL-2.0
 /*  Copyright(c) 2016-20 Intel Corporation. */
 
+#include <linux/file.h>
 #include <linux/freezer.h>
 #include <linux/highmem.h>
 #include <linux/kthread.h>
+#include <linux/miscdevice.h>
 #include <linux/pagemap.h>
 #include <linux/ratelimit.h>
 #include <linux/sched/mm.h>
 #include <linux/sched/signal.h>
 #include <linux/slab.h>
+#include <asm/sgx.h>
 #include "driver.h"
 #include "encl.h"
 #include "encls.h"
@@ -743,6 +746,51 @@ void sgx_update_lepubkeyhash(u64 *lepubkeyhash)
 		wrmsrl(MSR_IA32_SGXLEPUBKEYHASH0 + i, lepubkeyhash[i]);
 }
 
+const struct file_operations sgx_provision_fops = {
+	.owner			= THIS_MODULE,
+};
+
+static struct miscdevice sgx_dev_provision = {
+	.minor = MISC_DYNAMIC_MINOR,
+	.name = "sgx_provision",
+	.nodename = "sgx_provision",
+	.fops = &sgx_provision_fops,
+};
+
+/**
+ * sgx_set_attribute() - Update allowed attributes given file descriptor
+ * @allowed_attributes:		Pointer to allowed enclave attributes
+ * @attribute_fd:		File descriptor for specific attribute
+ *
+ * Append enclave attribute indicated by file descriptor to allowed
+ * attributes. Currently only SGX_ATTR_PROVISIONKEY indicated by
+ * /dev/sgx_provision is supported.
+ *
+ * Return:
+ * -0:		SGX_ATTR_PROVISIONKEY is appended to allowed_attributes
+ * -EINVAL:	Invalid, or not supported file descriptor
+ */
+int sgx_set_attribute(unsigned long *allowed_attributes,
+		      unsigned int attribute_fd)
+{
+	struct file *file;
+
+	file = fget(attribute_fd);
+	if (!file)
+		return -EINVAL;
+
+	if (file->f_op != &sgx_provision_fops) {
+		fput(file);
+		return -EINVAL;
+	}
+
+	*allowed_attributes |= SGX_ATTR_PROVISIONKEY;
+
+	fput(file);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(sgx_set_attribute);
+
 static int __init sgx_init(void)
 {
 	int ret;
@@ -759,6 +807,10 @@ static int __init sgx_init(void)
 		goto err_page_cache;
 	}
 
+	ret = misc_register(&sgx_dev_provision);
+	if (ret)
+		goto err_kthread;
+
 	/*
 	 * Always try to initialize the native *and* KVM drivers.
 	 * The KVM driver is less picky than the native one and
@@ -770,10 +822,13 @@ static int __init sgx_init(void)
 	ret = sgx_drv_init();
 
 	if (sgx_vepc_init() && ret)
-		goto err_kthread;
+		goto err_provision;
 
 	return 0;
 
+err_provision:
+	misc_deregister(&sgx_dev_provision);
+
 err_kthread:
 	kthread_stop(ksgxd_tsk);
 
