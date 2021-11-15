Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94C7A451D3C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Nov 2021 01:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242249AbhKPA0H (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Nov 2021 19:26:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347437AbhKOUe7 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Nov 2021 15:34:59 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B259C04319A;
        Mon, 15 Nov 2021 12:22:39 -0800 (PST)
Date:   Mon, 15 Nov 2021 20:22:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637007751;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zB61eEF2oTbarsdlnpBGQRgnpmIf3awWYcyv24dOmcU=;
        b=LA4sG7+TR+92YM4/8nsMyDCnLssc961V/pnRoSib5inqgARK0/J6rvSE7JoBbPZh3ELpod
        TmmZw56dLH1KRC+tcP/A8QkCNuoWSgY8KAsB2yzdgzaGLYJPFokMNwh70jqp+c3O8MCTOH
        MfoAHwscTjSO8k9p9Mi2FU6cZ2p7FZvdIdgcCdPKqYjUoRoLZInbbQvSvl8n14/xL7evQu
        56SR52jIvyJR5+TFwRKrVEigTWgA0jyWlJ8F4GDkEdcr0rkWqgGmNWlyNdxNgIkArRCkFM
        XUu+opIor3vIsIcP8iWUrQ3cF2IfCUrojHtOKkuxeBPUqnk3fo3guW2AJ4d3Hg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637007751;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zB61eEF2oTbarsdlnpBGQRgnpmIf3awWYcyv24dOmcU=;
        b=DfJF+5LXwDCMo3/VRYo9Fyy5P+tr4kUwGjyHe/beXUPhMnSDM+ggoXX82St5nMfaB6pL6g
        1ZJ08NOO2XSBA2CQ==
From:   "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Hook arch_memory_failure() into mainline code
Cc:     Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211026220050.697075-6-tony.luck@intel.com>
References: <20211026220050.697075-6-tony.luck@intel.com>
MIME-Version: 1.0
Message-ID: <163700775070.414.638751842932448934.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     03b122da74b22fbe7cd98184fa5657a9ce13970c
Gitweb:        https://git.kernel.org/tip/03b122da74b22fbe7cd98184fa5657a9ce13970c
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Tue, 26 Oct 2021 15:00:48 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 15 Nov 2021 11:13:16 -08:00

x86/sgx: Hook arch_memory_failure() into mainline code

Add a call inside memory_failure() to call the arch specific code
to check if the address is an SGX EPC page and handle it.

Note the SGX EPC pages do not have a "struct page" entry, so the hook
goes in at the same point as the device mapping hook.

Pull the call to acquire the mutex earlier so the SGX errors are also
protected.

Make set_mce_nospec() skip SGX pages when trying to adjust
the 1:1 map.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Reviewed-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Tested-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lkml.kernel.org/r/20211026220050.697075-6-tony.luck@intel.com
---
 arch/x86/include/asm/processor.h  |  8 ++++++++
 arch/x86/include/asm/set_memory.h |  4 ++++
 include/linux/mm.h                | 13 +++++++++++++
 mm/memory-failure.c               | 19 +++++++++++++------
 4 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 355d38c..2c5f12a 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -855,4 +855,12 @@ enum mds_mitigations {
 	MDS_MITIGATION_VMWERV,
 };
 
+#ifdef CONFIG_X86_SGX
+int arch_memory_failure(unsigned long pfn, int flags);
+#define arch_memory_failure arch_memory_failure
+
+bool arch_is_platform_page(u64 paddr);
+#define arch_is_platform_page arch_is_platform_page
+#endif
+
 #endif /* _ASM_X86_PROCESSOR_H */
diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
index 8726175..ff0f2d9 100644
--- a/arch/x86/include/asm/set_memory.h
+++ b/arch/x86/include/asm/set_memory.h
@@ -2,6 +2,7 @@
 #ifndef _ASM_X86_SET_MEMORY_H
 #define _ASM_X86_SET_MEMORY_H
 
+#include <linux/mm.h>
 #include <asm/page.h>
 #include <asm-generic/set_memory.h>
 
@@ -99,6 +100,9 @@ static inline int set_mce_nospec(unsigned long pfn, bool unmap)
 	unsigned long decoy_addr;
 	int rc;
 
+	/* SGX pages are not in the 1:1 map */
+	if (arch_is_platform_page(pfn << PAGE_SHIFT))
+		return 0;
 	/*
 	 * We would like to just call:
 	 *      set_memory_XX((unsigned long)pfn_to_kaddr(pfn), 1);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index a7e4a9e..57f1aa2 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3231,6 +3231,19 @@ extern void shake_page(struct page *p);
 extern atomic_long_t num_poisoned_pages __read_mostly;
 extern int soft_offline_page(unsigned long pfn, int flags);
 
+#ifndef arch_memory_failure
+static inline int arch_memory_failure(unsigned long pfn, int flags)
+{
+	return -ENXIO;
+}
+#endif
+
+#ifndef arch_is_platform_page
+static inline bool arch_is_platform_page(u64 paddr)
+{
+	return false;
+}
+#endif
 
 /*
  * Error handlers for various types of pages.
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 07c875f..fddee33 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1651,21 +1651,28 @@ int memory_failure(unsigned long pfn, int flags)
 	if (!sysctl_memory_failure_recovery)
 		panic("Memory failure on page %lx", pfn);
 
+	mutex_lock(&mf_mutex);
+
 	p = pfn_to_online_page(pfn);
 	if (!p) {
+		res = arch_memory_failure(pfn, flags);
+		if (res == 0)
+			goto unlock_mutex;
+
 		if (pfn_valid(pfn)) {
 			pgmap = get_dev_pagemap(pfn, NULL);
-			if (pgmap)
-				return memory_failure_dev_pagemap(pfn, flags,
-								  pgmap);
+			if (pgmap) {
+				res = memory_failure_dev_pagemap(pfn, flags,
+								 pgmap);
+				goto unlock_mutex;
+			}
 		}
 		pr_err("Memory failure: %#lx: memory outside kernel control\n",
 			pfn);
-		return -ENXIO;
+		res = -ENXIO;
+		goto unlock_mutex;
 	}
 
-	mutex_lock(&mf_mutex);
-
 try_again:
 	if (PageHuge(p)) {
 		res = memory_failure_hugetlb(pfn, flags);
