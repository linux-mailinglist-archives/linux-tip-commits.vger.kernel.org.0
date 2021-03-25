Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8DDF348C35
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Mar 2021 10:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhCYJIE (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 25 Mar 2021 05:08:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46320 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbhCYJH4 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 25 Mar 2021 05:07:56 -0400
Date:   Thu, 25 Mar 2021 09:07:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616663274;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=81eaf/nkiDPYhHM7PQGZ088hidFdMbgdiYH1vBt0h2g=;
        b=w6NU+GsVosNOnV8bcLt3VXbLD6+M2JFrNHFHOKa+Icahfk4LotV4im7SIWEZyp/HZJ+fXj
        EpWiS+xoT8nngnVRZaocoFyo+u2igBr0eQSXZNwPAPEC0P+5RX8r4YgXwHyUAlvXKAiwgD
        vzMM0NbzQsyEoYGEYSwJ+uhpL5SbwPFxN11fv2DPRG9tu4CeC4600AOiA43LvgbxceZpjH
        fSfG2ycr47ebBXuPloVAcesR2JecXcNmivKr0YuoaasskXtIYYSl/gOl6HM4t7pCkGtKaX
        bDIpfo3EVlYWuqM4ML2SGOrsP3WIihnK9Dad2uGWalE2qsVs7PQJBiAF95MifQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616663274;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=81eaf/nkiDPYhHM7PQGZ088hidFdMbgdiYH1vBt0h2g=;
        b=/ZP2SMSGJ26712uvYo18d/x2t5GrkkHo8Rvkv+IGHj8b9cDVuBQHrV+Xo5h8mQmBwIwC35
        ayBgpZVKSPYe9pBQ==
From:   "tip-bot2 for Ira Weiny" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Remove unnecessary kmap() from sgx_ioc_enclave_init()
Cc:     Ira Weiny <ira.weiny@intel.com>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210324182246.2484875-1-ira.weiny@intel.com>
References: <20210324182246.2484875-1-ira.weiny@intel.com>
MIME-Version: 1.0
Message-ID: <161666327367.398.13497317317824782755.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     633b0616cfe085679471a4c0fae02e8c3a1a9866
Gitweb:        https://git.kernel.org/tip/633b0616cfe085679471a4c0fae02e8c3a1a9866
Author:        Ira Weiny <ira.weiny@intel.com>
AuthorDate:    Wed, 24 Mar 2021 11:22:46 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 25 Mar 2021 09:50:32 +01:00

x86/sgx: Remove unnecessary kmap() from sgx_ioc_enclave_init()

kmap() is inefficient and is being replaced by kmap_local_page(), if
possible. There is no readily apparent reason why initp_page needs to be
allocated and kmap'ed() except that 'sigstruct' needs to be page-aligned
and 'token' 512 byte-aligned.

Rather than change it to kmap_local_page(), use kmalloc() instead
because kmalloc() can give this alignment when allocating PAGE_SIZE
bytes.

Remove the alloc_page()/kmap() and replace with kmalloc(PAGE_SIZE, ...)
to get a page aligned kernel address.

In addition, add a comment to document the alignment requirements so that
others don't attempt to 'fix' this again.

 [ bp: Massage commit message. ]

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210324182246.2484875-1-ira.weiny@intel.com
---
 arch/x86/kernel/cpu/sgx/ioctl.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index 90a5caf..2e10367 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -604,7 +604,6 @@ static long sgx_ioc_enclave_init(struct sgx_encl *encl, void __user *arg)
 {
 	struct sgx_sigstruct *sigstruct;
 	struct sgx_enclave_init init_arg;
-	struct page *initp_page;
 	void *token;
 	int ret;
 
@@ -615,11 +614,15 @@ static long sgx_ioc_enclave_init(struct sgx_encl *encl, void __user *arg)
 	if (copy_from_user(&init_arg, arg, sizeof(init_arg)))
 		return -EFAULT;
 
-	initp_page = alloc_page(GFP_KERNEL);
-	if (!initp_page)
+	/*
+	 * 'sigstruct' must be on a page boundary and 'token' on a 512 byte
+	 * boundary.  kmalloc() will give this alignment when allocating
+	 * PAGE_SIZE bytes.
+	 */
+	sigstruct = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!sigstruct)
 		return -ENOMEM;
 
-	sigstruct = kmap(initp_page);
 	token = (void *)((unsigned long)sigstruct + PAGE_SIZE / 2);
 	memset(token, 0, SGX_LAUNCH_TOKEN_SIZE);
 
@@ -645,8 +648,7 @@ static long sgx_ioc_enclave_init(struct sgx_encl *encl, void __user *arg)
 	ret = sgx_encl_init(encl, sigstruct, token);
 
 out:
-	kunmap(initp_page);
-	__free_page(initp_page);
+	kfree(sigstruct);
 	return ret;
 }
 
