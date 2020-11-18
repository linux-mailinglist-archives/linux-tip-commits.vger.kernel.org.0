Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5662B8304
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Nov 2020 18:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbgKRRTL (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 18 Nov 2020 12:19:11 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56226 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728115AbgKRRS0 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 18 Nov 2020 12:18:26 -0500
Date:   Wed, 18 Nov 2020 17:18:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605719903;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8V72oCA1bW+fF+N37bE1pvvy/NoJGnprWQk2A6P1IeY=;
        b=0c38E52mxGp+1RNaMFNKmuseXK2D3V9nFNSC+d8E+ByaDajHGTxKBgg3hgbiNZfBifL4/2
        E3HFypKThj+068bqa9mJEX00IT/PoJ+Ogx6va1L6/073Z5r1mwr0Z9p81gJp8xwecYhoI+
        AVvzE7AIIiyIT+HRgklWweHP63ZFSzK1nS6wmEYadTfGHPYn6M7IlLG376baIS7U35A8Bx
        E+9VdMxIIilJ7t2aUy0wQvunYsKdNr/MUfbtx+r2pH2AO8BpR5nuA0RlXMwmGSfADxE+WZ
        ypf8v49SBk1iYq79hKMGzdgTez6pYpvsLziD4kZJ2pxEEN5XCB+nAKQE/req+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605719903;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8V72oCA1bW+fF+N37bE1pvvy/NoJGnprWQk2A6P1IeY=;
        b=JnmHmvhNmErYwMYAEO4UNlwS0C0ncpm3O2LHpYcKIow39EQyNj7/gxb1M5V7SCGb0Ht+CE
        LBH3NAVTXGqZnxBQ==
From:   "tip-bot2 for Jarkko Sakkinen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Add SGX_IOC_ENCLAVE_INIT
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Jethro Beekman <jethro@fortanix.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201112220135.165028-15-jarkko@kernel.org>
References: <20201112220135.165028-15-jarkko@kernel.org>
MIME-Version: 1.0
Message-ID: <160571990235.11244.1417906329452941749.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     9d0c151b41fed7b879030f4e533143d098781701
Gitweb:        https://git.kernel.org/tip/9d0c151b41fed7b879030f4e533143d098781701
Author:        Jarkko Sakkinen <jarkko@kernel.org>
AuthorDate:    Fri, 13 Nov 2020 00:01:25 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 18 Nov 2020 18:02:49 +01:00

x86/sgx: Add SGX_IOC_ENCLAVE_INIT

Enclaves have two basic states. They are either being built and are
malleable and can be modified by doing things like adding pages. Or,
they are locked down and not accepting changes. They can only be run
after they have been locked down. The ENCLS[EINIT] function induces the
transition from being malleable to locked-down.

Add an ioctl() that performs ENCLS[EINIT]. After this, new pages can
no longer be added with ENCLS[EADD]. This is also the time where the
enclave can be measured to verify its integrity.

Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Tested-by: Jethro Beekman <jethro@fortanix.com>
Link: https://lkml.kernel.org/r/20201112220135.165028-15-jarkko@kernel.org
---
 arch/x86/include/uapi/asm/sgx.h  |  11 ++-
 arch/x86/kernel/cpu/sgx/driver.c |  27 ++++-
 arch/x86/kernel/cpu/sgx/driver.h |   8 +-
 arch/x86/kernel/cpu/sgx/encl.h   |   3 +-
 arch/x86/kernel/cpu/sgx/ioctl.c  | 193 +++++++++++++++++++++++++++++-
 5 files changed, 241 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/uapi/asm/sgx.h b/arch/x86/include/uapi/asm/sgx.h
index 835f7e5..66f2d32 100644
--- a/arch/x86/include/uapi/asm/sgx.h
+++ b/arch/x86/include/uapi/asm/sgx.h
@@ -23,6 +23,8 @@ enum sgx_page_flags {
 	_IOW(SGX_MAGIC, 0x00, struct sgx_enclave_create)
 #define SGX_IOC_ENCLAVE_ADD_PAGES \
 	_IOWR(SGX_MAGIC, 0x01, struct sgx_enclave_add_pages)
+#define SGX_IOC_ENCLAVE_INIT \
+	_IOW(SGX_MAGIC, 0x02, struct sgx_enclave_init)
 
 /**
  * struct sgx_enclave_create - parameter structure for the
@@ -52,4 +54,13 @@ struct sgx_enclave_add_pages {
 	__u64 count;
 };
 
+/**
+ * struct sgx_enclave_init - parameter structure for the
+ *                           %SGX_IOC_ENCLAVE_INIT ioctl
+ * @sigstruct:	address for the SIGSTRUCT data
+ */
+struct sgx_enclave_init {
+	__u64 sigstruct;
+};
+
 #endif /* _UAPI_ASM_X86_SGX_H */
diff --git a/arch/x86/kernel/cpu/sgx/driver.c b/arch/x86/kernel/cpu/sgx/driver.c
index ee947b7..bf5c4a3 100644
--- a/arch/x86/kernel/cpu/sgx/driver.c
+++ b/arch/x86/kernel/cpu/sgx/driver.c
@@ -10,6 +10,10 @@
 #include "driver.h"
 #include "encl.h"
 
+u64 sgx_attributes_reserved_mask;
+u64 sgx_xfrm_reserved_mask = ~0x3;
+u32 sgx_misc_reserved_mask;
+
 static int sgx_open(struct inode *inode, struct file *file)
 {
 	struct sgx_encl *encl;
@@ -117,8 +121,31 @@ static struct miscdevice sgx_dev_enclave = {
 
 int __init sgx_drv_init(void)
 {
+	unsigned int eax, ebx, ecx, edx;
+	u64 attr_mask;
+	u64 xfrm_mask;
+
 	if (!cpu_feature_enabled(X86_FEATURE_SGX_LC))
 		return -ENODEV;
 
+	cpuid_count(SGX_CPUID, 0, &eax, &ebx, &ecx, &edx);
+
+	if (!(eax & 1))  {
+		pr_err("SGX disabled: SGX1 instruction support not available.\n");
+		return -ENODEV;
+	}
+
+	sgx_misc_reserved_mask = ~ebx | SGX_MISC_RESERVED_MASK;
+
+	cpuid_count(SGX_CPUID, 1, &eax, &ebx, &ecx, &edx);
+
+	attr_mask = (((u64)ebx) << 32) + (u64)eax;
+	sgx_attributes_reserved_mask = ~attr_mask | SGX_ATTR_RESERVED_MASK;
+
+	if (cpu_feature_enabled(X86_FEATURE_OSXSAVE)) {
+		xfrm_mask = (((u64)edx) << 32) + (u64)ecx;
+		sgx_xfrm_reserved_mask = ~xfrm_mask;
+	}
+
 	return misc_register(&sgx_dev_enclave);
 }
diff --git a/arch/x86/kernel/cpu/sgx/driver.h b/arch/x86/kernel/cpu/sgx/driver.h
index a728e8e..6b00632 100644
--- a/arch/x86/kernel/cpu/sgx/driver.h
+++ b/arch/x86/kernel/cpu/sgx/driver.h
@@ -12,6 +12,14 @@
 #include <uapi/asm/sgx.h>
 #include "sgx.h"
 
+#define SGX_EINIT_SPIN_COUNT	20
+#define SGX_EINIT_SLEEP_COUNT	50
+#define SGX_EINIT_SLEEP_TIME	20
+
+extern u64 sgx_attributes_reserved_mask;
+extern u64 sgx_xfrm_reserved_mask;
+extern u32 sgx_misc_reserved_mask;
+
 long sgx_ioctl(struct file *filep, unsigned int cmd, unsigned long arg);
 
 int sgx_drv_init(void);
diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/encl.h
index 7cc1758..8a4d1ed 100644
--- a/arch/x86/kernel/cpu/sgx/encl.h
+++ b/arch/x86/kernel/cpu/sgx/encl.h
@@ -30,6 +30,7 @@ enum sgx_encl_flags {
 	SGX_ENCL_IOCTL		= BIT(0),
 	SGX_ENCL_DEBUG		= BIT(1),
 	SGX_ENCL_CREATED	= BIT(2),
+	SGX_ENCL_INITIALIZED	= BIT(3),
 };
 
 struct sgx_encl {
@@ -41,6 +42,8 @@ struct sgx_encl {
 	struct mutex lock;
 	struct xarray page_array;
 	struct sgx_encl_page secs;
+	unsigned long attributes;
+	unsigned long attributes_mask;
 };
 
 extern const struct vm_operations_struct sgx_vm_ops;
diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index 82acff7..e036819 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -51,6 +51,8 @@ static int sgx_encl_create(struct sgx_encl *encl, struct sgx_secs *secs)
 	encl->secs.encl = encl;
 	encl->base = secs->base;
 	encl->size = secs->size;
+	encl->attributes = secs->attributes;
+	encl->attributes_mask = SGX_ATTR_DEBUG | SGX_ATTR_MODE64BIT | SGX_ATTR_KSS;
 
 	/* Set only after completion, as encl->lock has not been taken. */
 	set_bit(SGX_ENCL_CREATED, &encl->flags);
@@ -334,7 +336,8 @@ static long sgx_ioc_enclave_add_pages(struct sgx_encl *encl, void __user *arg)
 	unsigned long c;
 	int ret;
 
-	if (!test_bit(SGX_ENCL_CREATED, &encl->flags))
+	if (!test_bit(SGX_ENCL_CREATED, &encl->flags) ||
+	    test_bit(SGX_ENCL_INITIALIZED, &encl->flags))
 		return -EINVAL;
 
 	if (copy_from_user(&add_arg, arg, sizeof(add_arg)))
@@ -382,6 +385,191 @@ static long sgx_ioc_enclave_add_pages(struct sgx_encl *encl, void __user *arg)
 	return ret;
 }
 
+static int __sgx_get_key_hash(struct crypto_shash *tfm, const void *modulus,
+			      void *hash)
+{
+	SHASH_DESC_ON_STACK(shash, tfm);
+
+	shash->tfm = tfm;
+
+	return crypto_shash_digest(shash, modulus, SGX_MODULUS_SIZE, hash);
+}
+
+static int sgx_get_key_hash(const void *modulus, void *hash)
+{
+	struct crypto_shash *tfm;
+	int ret;
+
+	tfm = crypto_alloc_shash("sha256", 0, CRYPTO_ALG_ASYNC);
+	if (IS_ERR(tfm))
+		return PTR_ERR(tfm);
+
+	ret = __sgx_get_key_hash(tfm, modulus, hash);
+
+	crypto_free_shash(tfm);
+	return ret;
+}
+
+static int sgx_encl_init(struct sgx_encl *encl, struct sgx_sigstruct *sigstruct,
+			 void *token)
+{
+	u64 mrsigner[4];
+	int i, j, k;
+	void *addr;
+	int ret;
+
+	/*
+	 * Deny initializing enclaves with attributes (namely provisioning)
+	 * that have not been explicitly allowed.
+	 */
+	if (encl->attributes & ~encl->attributes_mask)
+		return -EACCES;
+
+	/*
+	 * Attributes should not be enforced *only* against what's available on
+	 * platform (done in sgx_encl_create) but checked and enforced against
+	 * the mask for enforcement in sigstruct. For example an enclave could
+	 * opt to sign with AVX bit in xfrm, but still be loadable on a platform
+	 * without it if the sigstruct->body.attributes_mask does not turn that
+	 * bit on.
+	 */
+	if (sigstruct->body.attributes & sigstruct->body.attributes_mask &
+	    sgx_attributes_reserved_mask)
+		return -EINVAL;
+
+	if (sigstruct->body.miscselect & sigstruct->body.misc_mask &
+	    sgx_misc_reserved_mask)
+		return -EINVAL;
+
+	if (sigstruct->body.xfrm & sigstruct->body.xfrm_mask &
+	    sgx_xfrm_reserved_mask)
+		return -EINVAL;
+
+	ret = sgx_get_key_hash(sigstruct->modulus, mrsigner);
+	if (ret)
+		return ret;
+
+	mutex_lock(&encl->lock);
+
+	/*
+	 * ENCLS[EINIT] is interruptible because it has such a high latency,
+	 * e.g. 50k+ cycles on success. If an IRQ/NMI/SMI becomes pending,
+	 * EINIT may fail with SGX_UNMASKED_EVENT so that the event can be
+	 * serviced.
+	 */
+	for (i = 0; i < SGX_EINIT_SLEEP_COUNT; i++) {
+		for (j = 0; j < SGX_EINIT_SPIN_COUNT; j++) {
+			addr = sgx_get_epc_virt_addr(encl->secs.epc_page);
+
+			preempt_disable();
+
+			for (k = 0; k < 4; k++)
+				wrmsrl(MSR_IA32_SGXLEPUBKEYHASH0 + k, mrsigner[k]);
+
+			ret = __einit(sigstruct, token, addr);
+
+			preempt_enable();
+
+			if (ret == SGX_UNMASKED_EVENT)
+				continue;
+			else
+				break;
+		}
+
+		if (ret != SGX_UNMASKED_EVENT)
+			break;
+
+		msleep_interruptible(SGX_EINIT_SLEEP_TIME);
+
+		if (signal_pending(current)) {
+			ret = -ERESTARTSYS;
+			goto err_out;
+		}
+	}
+
+	if (ret & ENCLS_FAULT_FLAG) {
+		if (encls_failed(ret))
+			ENCLS_WARN(ret, "EINIT");
+
+		ret = -EIO;
+	} else if (ret) {
+		pr_debug("EINIT returned %d\n", ret);
+		ret = -EPERM;
+	} else {
+		set_bit(SGX_ENCL_INITIALIZED, &encl->flags);
+	}
+
+err_out:
+	mutex_unlock(&encl->lock);
+	return ret;
+}
+
+/**
+ * sgx_ioc_enclave_init() - handler for %SGX_IOC_ENCLAVE_INIT
+ * @encl:	an enclave pointer
+ * @arg:	userspace pointer to a struct sgx_enclave_init instance
+ *
+ * Flush any outstanding enqueued EADD operations and perform EINIT.  The
+ * Launch Enclave Public Key Hash MSRs are rewritten as necessary to match
+ * the enclave's MRSIGNER, which is caculated from the provided sigstruct.
+ *
+ * Return:
+ * - 0:		Success.
+ * - -EPERM:	Invalid SIGSTRUCT.
+ * - -EIO:	EINIT failed because of a power cycle.
+ * - -errno:	POSIX error.
+ */
+static long sgx_ioc_enclave_init(struct sgx_encl *encl, void __user *arg)
+{
+	struct sgx_sigstruct *sigstruct;
+	struct sgx_enclave_init init_arg;
+	struct page *initp_page;
+	void *token;
+	int ret;
+
+	if (!test_bit(SGX_ENCL_CREATED, &encl->flags) ||
+	    test_bit(SGX_ENCL_INITIALIZED, &encl->flags))
+		return -EINVAL;
+
+	if (copy_from_user(&init_arg, arg, sizeof(init_arg)))
+		return -EFAULT;
+
+	initp_page = alloc_page(GFP_KERNEL);
+	if (!initp_page)
+		return -ENOMEM;
+
+	sigstruct = kmap(initp_page);
+	token = (void *)((unsigned long)sigstruct + PAGE_SIZE / 2);
+	memset(token, 0, SGX_LAUNCH_TOKEN_SIZE);
+
+	if (copy_from_user(sigstruct, (void __user *)init_arg.sigstruct,
+			   sizeof(*sigstruct))) {
+		ret = -EFAULT;
+		goto out;
+	}
+
+	/*
+	 * A legacy field used with Intel signed enclaves. These used to mean
+	 * regular and architectural enclaves. The CPU only accepts these values
+	 * but they do not have any other meaning.
+	 *
+	 * Thus, reject any other values.
+	 */
+	if (sigstruct->header.vendor != 0x0000 &&
+	    sigstruct->header.vendor != 0x8086) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = sgx_encl_init(encl, sigstruct, token);
+
+out:
+	kunmap(initp_page);
+	__free_page(initp_page);
+	return ret;
+}
+
+
 long sgx_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 {
 	struct sgx_encl *encl = filep->private_data;
@@ -397,6 +585,9 @@ long sgx_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 	case SGX_IOC_ENCLAVE_ADD_PAGES:
 		ret = sgx_ioc_enclave_add_pages(encl, (void __user *)arg);
 		break;
+	case SGX_IOC_ENCLAVE_INIT:
+		ret = sgx_ioc_enclave_init(encl, (void __user *)arg);
+		break;
 	default:
 		ret = -ENOIOCTLCMD;
 		break;
