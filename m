Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D94C2B8308
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Nov 2020 18:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbgKRRTR (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 18 Nov 2020 12:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728125AbgKRRSZ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 18 Nov 2020 12:18:25 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4279FC0613D6;
        Wed, 18 Nov 2020 09:18:25 -0800 (PST)
Date:   Wed, 18 Nov 2020 17:18:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605719903;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wqW/hes8AG5vX2DtfW+eElUWT4khKtv66gqqeEBVPls=;
        b=1ts+M/dgNqRTLKMaUwHdjxbSPcUZyMk2H4NLe0WvOYnJzuhmeoZpqQnB7HAI/VX5dSWX7+
        cvR8UWWGUM6Z6vX5liYXe/OIJFbJiXQkNs56D8S0/IQRhz28goGX9cG+oNuPPmd+7W7MbA
        Z2rixqqZ2xIyIx6HcQZFfYCpbwFiG32UnTOHLE+A1lZuhaRuiy50tpbE/jZPg5S7jIVCRi
        iRMjxtwlvWvUpj79XSMZrK9W9zEGytyu0Nzfwh05VOrq8/fJoPdO/FeyWLZvB1xhLRHDlR
        nJDvRfFiN9JJw5OgfSmvg0nahhxklvZfnhpvYNhdg7XgCtuB8I4sR8zyFYqtoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605719903;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wqW/hes8AG5vX2DtfW+eElUWT4khKtv66gqqeEBVPls=;
        b=+cD5oHlHGf59nA2RlFTtKSryPmkzz09TR4XQNzkx5R5ZThKFnO6OUIFHzEbIuIjw4H5rHD
        ebmDU5AkxkQpBrBg==
From:   "tip-bot2 for Jarkko Sakkinen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Add SGX_IOC_ENCLAVE_ADD_PAGES
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Jethro Beekman <jethro@fortanix.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201112220135.165028-14-jarkko@kernel.org>
References: <20201112220135.165028-14-jarkko@kernel.org>
MIME-Version: 1.0
Message-ID: <160571990289.11244.12554545909138188274.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     c6d26d370767fa227fc44b98a8bdad112efdf563
Gitweb:        https://git.kernel.org/tip/c6d26d370767fa227fc44b98a8bdad112ef=
df563
Author:        Jarkko Sakkinen <jarkko@kernel.org>
AuthorDate:    Fri, 13 Nov 2020 00:01:24 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 18 Nov 2020 18:02:49 +01:00

x86/sgx: Add SGX_IOC_ENCLAVE_ADD_PAGES

SGX enclave pages are inaccessible to normal software. They must be
populated with data by copying from normal memory with the help of the
EADD and EEXTEND functions of the ENCLS instruction.

Add an ioctl() which performs EADD that adds new data to an enclave, and
optionally EEXTEND functions that hash the page contents and use the
hash as part of enclave =E2=80=9Cmeasurement=E2=80=9D to ensure enclave integ=
rity.

The enclave author gets to decide which pages will be included in the
enclave measurement with EEXTEND. Measurement is very slow and has
sometimes has very little value. For instance, an enclave _could_
measure every page of data and code, but would be slow to initialize.
Or, it might just measure its code and then trust that code to
initialize the bulk of its data after it starts running.

Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Tested-by: Jethro Beekman <jethro@fortanix.com>
Link: https://lkml.kernel.org/r/20201112220135.165028-14-jarkko@kernel.org
---
 arch/x86/include/uapi/asm/sgx.h |  30 +++-
 arch/x86/kernel/cpu/sgx/ioctl.c | 284 +++++++++++++++++++++++++++++++-
 arch/x86/kernel/cpu/sgx/sgx.h   |   1 +-
 3 files changed, 315 insertions(+)

diff --git a/arch/x86/include/uapi/asm/sgx.h b/arch/x86/include/uapi/asm/sgx.h
index f31bb17..835f7e5 100644
--- a/arch/x86/include/uapi/asm/sgx.h
+++ b/arch/x86/include/uapi/asm/sgx.h
@@ -8,10 +8,21 @@
 #include <linux/types.h>
 #include <linux/ioctl.h>
=20
+/**
+ * enum sgx_epage_flags - page control flags
+ * %SGX_PAGE_MEASURE:	Measure the page contents with a sequence of
+ *			ENCLS[EEXTEND] operations.
+ */
+enum sgx_page_flags {
+	SGX_PAGE_MEASURE	=3D 0x01,
+};
+
 #define SGX_MAGIC 0xA4
=20
 #define SGX_IOC_ENCLAVE_CREATE \
 	_IOW(SGX_MAGIC, 0x00, struct sgx_enclave_create)
+#define SGX_IOC_ENCLAVE_ADD_PAGES \
+	_IOWR(SGX_MAGIC, 0x01, struct sgx_enclave_add_pages)
=20
 /**
  * struct sgx_enclave_create - parameter structure for the
@@ -22,4 +33,23 @@ struct sgx_enclave_create  {
 	__u64	src;
 };
=20
+/**
+ * struct sgx_enclave_add_pages - parameter structure for the
+ *                                %SGX_IOC_ENCLAVE_ADD_PAGE ioctl
+ * @src:	start address for the page data
+ * @offset:	starting page offset
+ * @length:	length of the data (multiple of the page size)
+ * @secinfo:	address for the SECINFO data
+ * @flags:	page control flags
+ * @count:	number of bytes added (multiple of the page size)
+ */
+struct sgx_enclave_add_pages {
+	__u64 src;
+	__u64 offset;
+	__u64 length;
+	__u64 secinfo;
+	__u64 flags;
+	__u64 count;
+};
+
 #endif /* _UAPI_ASM_X86_SGX_H */
diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index 1355490..82acff7 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -101,6 +101,287 @@ static long sgx_ioc_enclave_create(struct sgx_encl *enc=
l, void __user *arg)
 	return ret;
 }
=20
+static struct sgx_encl_page *sgx_encl_page_alloc(struct sgx_encl *encl,
+						 unsigned long offset,
+						 u64 secinfo_flags)
+{
+	struct sgx_encl_page *encl_page;
+	unsigned long prot;
+
+	encl_page =3D kzalloc(sizeof(*encl_page), GFP_KERNEL);
+	if (!encl_page)
+		return ERR_PTR(-ENOMEM);
+
+	encl_page->desc =3D encl->base + offset;
+	encl_page->encl =3D encl;
+
+	prot =3D _calc_vm_trans(secinfo_flags, SGX_SECINFO_R, PROT_READ)  |
+	       _calc_vm_trans(secinfo_flags, SGX_SECINFO_W, PROT_WRITE) |
+	       _calc_vm_trans(secinfo_flags, SGX_SECINFO_X, PROT_EXEC);
+
+	/*
+	 * TCS pages must always RW set for CPU access while the SECINFO
+	 * permissions are *always* zero - the CPU ignores the user provided
+	 * values and silently overwrites them with zero permissions.
+	 */
+	if ((secinfo_flags & SGX_SECINFO_PAGE_TYPE_MASK) =3D=3D SGX_SECINFO_TCS)
+		prot |=3D PROT_READ | PROT_WRITE;
+
+	/* Calculate maximum of the VM flags for the page. */
+	encl_page->vm_max_prot_bits =3D calc_vm_prot_bits(prot, 0);
+
+	return encl_page;
+}
+
+static int sgx_validate_secinfo(struct sgx_secinfo *secinfo)
+{
+	u64 perm =3D secinfo->flags & SGX_SECINFO_PERMISSION_MASK;
+	u64 pt   =3D secinfo->flags & SGX_SECINFO_PAGE_TYPE_MASK;
+
+	if (pt !=3D SGX_SECINFO_REG && pt !=3D SGX_SECINFO_TCS)
+		return -EINVAL;
+
+	if ((perm & SGX_SECINFO_W) && !(perm & SGX_SECINFO_R))
+		return -EINVAL;
+
+	/*
+	 * CPU will silently overwrite the permissions as zero, which means
+	 * that we need to validate it ourselves.
+	 */
+	if (pt =3D=3D SGX_SECINFO_TCS && perm)
+		return -EINVAL;
+
+	if (secinfo->flags & SGX_SECINFO_RESERVED_MASK)
+		return -EINVAL;
+
+	if (memchr_inv(secinfo->reserved, 0, sizeof(secinfo->reserved)))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int __sgx_encl_add_page(struct sgx_encl *encl,
+			       struct sgx_encl_page *encl_page,
+			       struct sgx_epc_page *epc_page,
+			       struct sgx_secinfo *secinfo, unsigned long src)
+{
+	struct sgx_pageinfo pginfo;
+	struct vm_area_struct *vma;
+	struct page *src_page;
+	int ret;
+
+	/* Deny noexec. */
+	vma =3D find_vma(current->mm, src);
+	if (!vma)
+		return -EFAULT;
+
+	if (!(vma->vm_flags & VM_MAYEXEC))
+		return -EACCES;
+
+	ret =3D get_user_pages(src, 1, 0, &src_page, NULL);
+	if (ret < 1)
+		return -EFAULT;
+
+	pginfo.secs =3D (unsigned long)sgx_get_epc_virt_addr(encl->secs.epc_page);
+	pginfo.addr =3D encl_page->desc & PAGE_MASK;
+	pginfo.metadata =3D (unsigned long)secinfo;
+	pginfo.contents =3D (unsigned long)kmap_atomic(src_page);
+
+	ret =3D __eadd(&pginfo, sgx_get_epc_virt_addr(epc_page));
+
+	kunmap_atomic((void *)pginfo.contents);
+	put_page(src_page);
+
+	return ret ? -EIO : 0;
+}
+
+/*
+ * If the caller requires measurement of the page as a proof for the content,
+ * use EEXTEND to add a measurement for 256 bytes of the page. Repeat this
+ * operation until the entire page is measured."
+ */
+static int __sgx_encl_extend(struct sgx_encl *encl,
+			     struct sgx_epc_page *epc_page)
+{
+	unsigned long offset;
+	int ret;
+
+	for (offset =3D 0; offset < PAGE_SIZE; offset +=3D SGX_EEXTEND_BLOCK_SIZE) {
+		ret =3D __eextend(sgx_get_epc_virt_addr(encl->secs.epc_page),
+				sgx_get_epc_virt_addr(epc_page) + offset);
+		if (ret) {
+			if (encls_failed(ret))
+				ENCLS_WARN(ret, "EEXTEND");
+
+			return -EIO;
+		}
+	}
+
+	return 0;
+}
+
+static int sgx_encl_add_page(struct sgx_encl *encl, unsigned long src,
+			     unsigned long offset, struct sgx_secinfo *secinfo,
+			     unsigned long flags)
+{
+	struct sgx_encl_page *encl_page;
+	struct sgx_epc_page *epc_page;
+	int ret;
+
+	encl_page =3D sgx_encl_page_alloc(encl, offset, secinfo->flags);
+	if (IS_ERR(encl_page))
+		return PTR_ERR(encl_page);
+
+	epc_page =3D __sgx_alloc_epc_page();
+	if (IS_ERR(epc_page)) {
+		kfree(encl_page);
+		return PTR_ERR(epc_page);
+	}
+
+	mmap_read_lock(current->mm);
+	mutex_lock(&encl->lock);
+
+	/*
+	 * Insert prior to EADD in case of OOM.  EADD modifies MRENCLAVE, i.e.
+	 * can't be gracefully unwound, while failure on EADD/EXTEND is limited
+	 * to userspace errors (or kernel/hardware bugs).
+	 */
+	ret =3D xa_insert(&encl->page_array, PFN_DOWN(encl_page->desc),
+			encl_page, GFP_KERNEL);
+	if (ret)
+		goto err_out_unlock;
+
+	ret =3D __sgx_encl_add_page(encl, encl_page, epc_page, secinfo,
+				  src);
+	if (ret)
+		goto err_out;
+
+	/*
+	 * Complete the "add" before doing the "extend" so that the "add"
+	 * isn't in a half-baked state in the extremely unlikely scenario
+	 * the enclave will be destroyed in response to EEXTEND failure.
+	 */
+	encl_page->encl =3D encl;
+	encl_page->epc_page =3D epc_page;
+	encl->secs_child_cnt++;
+
+	if (flags & SGX_PAGE_MEASURE) {
+		ret =3D __sgx_encl_extend(encl, epc_page);
+		if (ret)
+			goto err_out;
+	}
+
+	mutex_unlock(&encl->lock);
+	mmap_read_unlock(current->mm);
+	return ret;
+
+err_out:
+	xa_erase(&encl->page_array, PFN_DOWN(encl_page->desc));
+
+err_out_unlock:
+	mutex_unlock(&encl->lock);
+	mmap_read_unlock(current->mm);
+
+	sgx_free_epc_page(epc_page);
+	kfree(encl_page);
+
+	return ret;
+}
+
+/**
+ * sgx_ioc_enclave_add_pages() - The handler for %SGX_IOC_ENCLAVE_ADD_PAGES
+ * @encl:       an enclave pointer
+ * @arg:	a user pointer to a struct sgx_enclave_add_pages instance
+ *
+ * Add one or more pages to an uninitialized enclave, and optionally extend =
the
+ * measurement with the contents of the page. The SECINFO and measurement ma=
sk
+ * are applied to all pages.
+ *
+ * A SECINFO for a TCS is required to always contain zero permissions because
+ * CPU silently zeros them. Allowing anything else would cause a mismatch in
+ * the measurement.
+ *
+ * mmap()'s protection bits are capped by the page permissions. For each page
+ * address, the maximum protection bits are computed with the following
+ * heuristics:
+ *
+ * 1. A regular page: PROT_R, PROT_W and PROT_X match the SECINFO permission=
s.
+ * 2. A TCS page: PROT_R | PROT_W.
+ *
+ * mmap() is not allowed to surpass the minimum of the maximum protection bi=
ts
+ * within the given address range.
+ *
+ * The function deinitializes kernel data structures for enclave and returns
+ * -EIO in any of the following conditions:
+ *
+ * - Enclave Page Cache (EPC), the physical memory holding enclaves, has
+ *   been invalidated. This will cause EADD and EEXTEND to fail.
+ * - If the source address is corrupted somehow when executing EADD.
+ *
+ * Return:
+ * - 0:		Success.
+ * - -EACCES:	The source page is located in a noexec partition.
+ * - -ENOMEM:	Out of EPC pages.
+ * - -EINTR:	The call was interrupted before data was processed.
+ * - -EIO:	Either EADD or EEXTEND failed because invalid source address
+ *		or power cycle.
+ * - -errno:	POSIX error.
+ */
+static long sgx_ioc_enclave_add_pages(struct sgx_encl *encl, void __user *ar=
g)
+{
+	struct sgx_enclave_add_pages add_arg;
+	struct sgx_secinfo secinfo;
+	unsigned long c;
+	int ret;
+
+	if (!test_bit(SGX_ENCL_CREATED, &encl->flags))
+		return -EINVAL;
+
+	if (copy_from_user(&add_arg, arg, sizeof(add_arg)))
+		return -EFAULT;
+
+	if (!IS_ALIGNED(add_arg.offset, PAGE_SIZE) ||
+	    !IS_ALIGNED(add_arg.src, PAGE_SIZE))
+		return -EINVAL;
+
+	if (add_arg.length & (PAGE_SIZE - 1))
+		return -EINVAL;
+
+	if (add_arg.offset + add_arg.length - PAGE_SIZE >=3D encl->size)
+		return -EINVAL;
+
+	if (copy_from_user(&secinfo, (void __user *)add_arg.secinfo,
+			   sizeof(secinfo)))
+		return -EFAULT;
+
+	if (sgx_validate_secinfo(&secinfo))
+		return -EINVAL;
+
+	for (c =3D 0 ; c < add_arg.length; c +=3D PAGE_SIZE) {
+		if (signal_pending(current)) {
+			if (!c)
+				ret =3D -EINTR;
+
+			break;
+		}
+
+		if (need_resched())
+			cond_resched();
+
+		ret =3D sgx_encl_add_page(encl, add_arg.src + c, add_arg.offset + c,
+					&secinfo, add_arg.flags);
+		if (ret)
+			break;
+	}
+
+	add_arg.count =3D c;
+
+	if (copy_to_user(arg, &add_arg, sizeof(add_arg)))
+		return -EFAULT;
+
+	return ret;
+}
+
 long sgx_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 {
 	struct sgx_encl *encl =3D filep->private_data;
@@ -113,6 +394,9 @@ long sgx_ioctl(struct file *filep, unsigned int cmd, unsi=
gned long arg)
 	case SGX_IOC_ENCLAVE_CREATE:
 		ret =3D sgx_ioc_enclave_create(encl, (void __user *)arg);
 		break;
+	case SGX_IOC_ENCLAVE_ADD_PAGES:
+		ret =3D sgx_ioc_enclave_add_pages(encl, (void __user *)arg);
+		break;
 	default:
 		ret =3D -ENOIOCTLCMD;
 		break;
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index bd9dcb1..91234f4 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -14,6 +14,7 @@
 #define pr_fmt(fmt) "sgx: " fmt
=20
 #define SGX_MAX_EPC_SECTIONS		8
+#define SGX_EEXTEND_BLOCK_SIZE		256
=20
 struct sgx_epc_page {
 	unsigned int section;
