Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01EAC2B8310
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Nov 2020 18:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgKRRTg (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 18 Nov 2020 12:19:36 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56190 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgKRRSU (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 18 Nov 2020 12:18:20 -0500
Date:   Wed, 18 Nov 2020 17:18:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605719898;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A66Bn3hIpk2Ld4Z8YXrXL2zjhpxjzSYDQmECyPorM5c=;
        b=tVeR5oAwkyq4hEpK1rTse5CVd7gXqGzTgIGivvIRIvXq3M37xNy4eNMpBrLOnJMok1fsUg
        tAllMP0yMQBBq90+vfor4Zo5QXtl9v8hcXglaGf2yN8kzCf190rlHsvFkoubx68WYvg9GX
        TjahTHlM5B2DajqGHuyUeAWhYPrD37Tu6UZ4/gTYbgYYNuWYYR37sKf1iRUd9zj7zRI7hG
        UpXWIyZ4NY7vmLS4xTN2IhFIOfzPQybjUVGva+6/A86rQsIPINHvt8YLU3ZCTjJ0CR3hz7
        4DxKNJkeX3QEGO5IsLmZbMvXg0h6OutSPli2WMDwal16CUDXcUF4OOXTjz2LDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605719898;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A66Bn3hIpk2Ld4Z8YXrXL2zjhpxjzSYDQmECyPorM5c=;
        b=zHn5BbbkREO/qgobfwd5cGCikEC/Tr+hQ6PEioM8kz7+lWt+r1jpn0v52fEIdsvzYxVOfW
        eczvwYdLBGrAH2Dw==
From:   "tip-bot2 for Jarkko Sakkinen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Add ptrace() support for the SGX driver
Cc:     Jarkko Sakkinen <jarkko@kernel.org>, Borislav Petkov <bp@suse.de>,
        Jethro Beekman <jethro@fortanix.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201112220135.165028-23-jarkko@kernel.org>
References: <20201112220135.165028-23-jarkko@kernel.org>
MIME-Version: 1.0
Message-ID: <160571989740.11244.11158819247884117127.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     947c6e11fa4310b31c10016ae9816cdca3f1694e
Gitweb:        https://git.kernel.org/tip/947c6e11fa4310b31c10016ae9816cdca3f1694e
Author:        Jarkko Sakkinen <jarkko@kernel.org>
AuthorDate:    Fri, 13 Nov 2020 00:01:33 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 18 Nov 2020 18:04:11 +01:00

x86/sgx: Add ptrace() support for the SGX driver

Enclave memory is normally inaccessible from outside the enclave. This
makes enclaves hard to debug. However, enclaves can be put in a debug
mode when they are being built. In that mode, enclave data *can* be read
and/or written by using the ENCLS[EDBGRD] and ENCLS[EDBGWR] functions.

This is obviously only for debugging and destroys all the protections
present with normal enclaves. But, enclaves know their own debug status
and can adjust their behavior appropriately.

Add a vm_ops->access() implementation which can be used to read and write
memory inside debug enclaves.  This is typically used via ptrace() APIs.

 [ bp: Massage. ]

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Tested-by: Jethro Beekman <jethro@fortanix.com>
Link: https://lkml.kernel.org/r/20201112220135.165028-23-jarkko@kernel.org
---
 arch/x86/kernel/cpu/sgx/encl.c | 111 ++++++++++++++++++++++++++++++++-
 1 file changed, 111 insertions(+)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index b74dadf..ee50a50 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -272,10 +272,121 @@ static int sgx_vma_mprotect(struct vm_area_struct *vma, unsigned long start,
 	return sgx_encl_may_map(vma->vm_private_data, start, end, newflags);
 }
 
+static int sgx_encl_debug_read(struct sgx_encl *encl, struct sgx_encl_page *page,
+			       unsigned long addr, void *data)
+{
+	unsigned long offset = addr & ~PAGE_MASK;
+	int ret;
+
+
+	ret = __edbgrd(sgx_get_epc_virt_addr(page->epc_page) + offset, data);
+	if (ret)
+		return -EIO;
+
+	return 0;
+}
+
+static int sgx_encl_debug_write(struct sgx_encl *encl, struct sgx_encl_page *page,
+				unsigned long addr, void *data)
+{
+	unsigned long offset = addr & ~PAGE_MASK;
+	int ret;
+
+	ret = __edbgwr(sgx_get_epc_virt_addr(page->epc_page) + offset, data);
+	if (ret)
+		return -EIO;
+
+	return 0;
+}
+
+/*
+ * Load an enclave page to EPC if required, and take encl->lock.
+ */
+static struct sgx_encl_page *sgx_encl_reserve_page(struct sgx_encl *encl,
+						   unsigned long addr,
+						   unsigned long vm_flags)
+{
+	struct sgx_encl_page *entry;
+
+	for ( ; ; ) {
+		mutex_lock(&encl->lock);
+
+		entry = sgx_encl_load_page(encl, addr, vm_flags);
+		if (PTR_ERR(entry) != -EBUSY)
+			break;
+
+		mutex_unlock(&encl->lock);
+	}
+
+	if (IS_ERR(entry))
+		mutex_unlock(&encl->lock);
+
+	return entry;
+}
+
+static int sgx_vma_access(struct vm_area_struct *vma, unsigned long addr,
+			  void *buf, int len, int write)
+{
+	struct sgx_encl *encl = vma->vm_private_data;
+	struct sgx_encl_page *entry = NULL;
+	char data[sizeof(unsigned long)];
+	unsigned long align;
+	int offset;
+	int cnt;
+	int ret = 0;
+	int i;
+
+	/*
+	 * If process was forked, VMA is still there but vm_private_data is set
+	 * to NULL.
+	 */
+	if (!encl)
+		return -EFAULT;
+
+	if (!test_bit(SGX_ENCL_DEBUG, &encl->flags))
+		return -EFAULT;
+
+	for (i = 0; i < len; i += cnt) {
+		entry = sgx_encl_reserve_page(encl, (addr + i) & PAGE_MASK,
+					      vma->vm_flags);
+		if (IS_ERR(entry)) {
+			ret = PTR_ERR(entry);
+			break;
+		}
+
+		align = ALIGN_DOWN(addr + i, sizeof(unsigned long));
+		offset = (addr + i) & (sizeof(unsigned long) - 1);
+		cnt = sizeof(unsigned long) - offset;
+		cnt = min(cnt, len - i);
+
+		ret = sgx_encl_debug_read(encl, entry, align, data);
+		if (ret)
+			goto out;
+
+		if (write) {
+			memcpy(data + offset, buf + i, cnt);
+			ret = sgx_encl_debug_write(encl, entry, align, data);
+			if (ret)
+				goto out;
+		} else {
+			memcpy(buf + i, data + offset, cnt);
+		}
+
+out:
+		mutex_unlock(&encl->lock);
+
+		if (ret)
+			break;
+	}
+
+	return ret < 0 ? ret : i;
+}
+
 const struct vm_operations_struct sgx_vm_ops = {
 	.fault = sgx_vma_fault,
 	.mprotect = sgx_vma_mprotect,
 	.open = sgx_vma_open,
+	.access = sgx_vma_access,
 };
 
 /**
