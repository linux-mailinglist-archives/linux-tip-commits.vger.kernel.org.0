Return-Path: <linux-tip-commits+bounces-5155-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A56AA61E9
	for <lists+linux-tip-commits@lfdr.de>; Thu,  1 May 2025 19:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DE789A33AA
	for <lists+linux-tip-commits@lfdr.de>; Thu,  1 May 2025 17:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219861DC1AB;
	Thu,  1 May 2025 16:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qmSEv0CO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y+plwZkv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88E21A314A;
	Thu,  1 May 2025 16:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746118791; cv=none; b=ZHR66Aox86rQFrqvZGF7UpM1d70hHeCrHQk2KuPzYFpVJ6SDVaRQJorP1BAFUYVuZzyubggeumBVxCL7f9mzhBuywijv1QrSZCN8OvltgSe+I2UR5ZZc/X826sE0vkQrxY8jLaaGD//hrcBK9y/MwKbPagpD8uqYMCzbviKjn2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746118791; c=relaxed/simple;
	bh=d2TQn+yS9tH5nsB7ZanQ2HrKzYsVJ1fORmCBlUOx2lk=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=TW1q7mNr/KtVeC3pauUfqy33NIk+htSe7KrFWoTShSYT5arb1vEwNyQ6PeDBelfPRp4+0MKGZ8IccvX4JoGaoTioYh8zJkBt87/JyGY1EM6glgh+CKWE6C8sygYzkc49Ih/Ig2sHAwf4BzYezhQL8FZyg8aPvlkT07+TtF2+++8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qmSEv0CO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y+plwZkv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 01 May 2025 16:59:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746118781;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=LILwCHnsEdQJ4RiOkiicHNJJQQELBYZpwBHJyh5K/w4=;
	b=qmSEv0COkNWT0aZ9ni8ACXqn1VckAYJ5300GtuDtuj5rAktSM01pilZBbNP1cTM5U0wzRm
	QxRI7wa1ie6DjjesgtnWBIC11hyQ0oIrXXL9/Y0z03UmNGb2KfhLcYPQWeBOSMBS7RREaw
	qM3OENLoWTR384bUiKFVaI0R3T9I1iojyQ/RQjLaxz97KKE2yXOF4q15dOuM9oIObJZVVE
	69OSFsaXLkIDFxOBs3k/veEfW6DIEswcF7UhNkfsEkGsFxx3x1vaT3xTzyq3jm29lSIkIB
	uviagJLzcgMem3NHL94jeAZH7ItCeBA1Z+uIb/a0kijG52vd9LvxeqzCm4H3Qg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746118781;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=LILwCHnsEdQJ4RiOkiicHNJJQQELBYZpwBHJyh5K/w4=;
	b=y+plwZkvSibbDtV9lCaetKsGAgx/HktisAI4PslUCP6VwpcEU8wY9t0vkGI5dY+CLyLprI
	d/jeEFNWbV6ve3CA==
From: "tip-bot2 for Dan Williams" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/mm] x86/devmem: Remove duplicate range_is_allowed() definition
Cc: Dan Williams <dan.j.williams@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Nikolay Borisov <nik.borisov@suse.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174611877481.22196.10244252918339863915.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     1b3f2bd04d90f61e1f291b5e365b9bc4ce0ea7c7
Gitweb:        https://git.kernel.org/tip/1b3f2bd04d90f61e1f291b5e365b9bc4ce0ea7c7
Author:        Dan Williams <dan.j.williams@intel.com>
AuthorDate:    Tue, 29 Apr 2025 19:46:21 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 01 May 2025 09:43:48 -07:00

x86/devmem: Remove duplicate range_is_allowed() definition

17 years ago, Venki suggested [1] "A future improvement would be to
avoid the range_is_allowed duplication".

The only thing preventing a common implementation is that
phys_mem_access_prot_allowed() expects the range check to exit
immediately when PAT is disabled [2]. I.e. there is no cache conflict to
manage in that case. This cleanup was noticed on the path to
considering changing range_is_allowed() policy to blanket deny /dev/mem
for private (confidential computing) memory.

Note, however that phys_mem_access_prot_allowed() has long since stopped
being relevant for managing cache-type validation due to [3], and [4].

Commit 0124cecfc85a ("x86, PAT: disable /dev/mem mmap RAM with PAT") [1]
Commit 9e41bff2708e ("x86: fix /dev/mem mmap breakage when PAT is disabled") [2]
Commit 1886297ce0c8 ("x86/mm/pat: Fix BUG_ON() in mmap_mem() on QEMU/i386") [3]
Commit 0c3c8a18361a ("x86, PAT: Remove duplicate memtype reserve in devmem mmap") [4]

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lore.kernel.org/all/20250430024622.1134277-2-dan.j.williams%40intel.com
---
 arch/x86/mm/pat/memtype.c | 31 ++++---------------------------
 drivers/char/mem.c        | 18 ------------------
 include/linux/io.h        | 21 +++++++++++++++++++++
 3 files changed, 25 insertions(+), 45 deletions(-)

diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index 72d8cbc..c97b659 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -38,6 +38,7 @@
 #include <linux/kernel.h>
 #include <linux/pfn_t.h>
 #include <linux/slab.h>
+#include <linux/io.h>
 #include <linux/mm.h>
 #include <linux/highmem.h>
 #include <linux/fs.h>
@@ -773,38 +774,14 @@ pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 	return vma_prot;
 }
 
-#ifdef CONFIG_STRICT_DEVMEM
-/* This check is done in drivers/char/mem.c in case of STRICT_DEVMEM */
-static inline int range_is_allowed(unsigned long pfn, unsigned long size)
-{
-	return 1;
-}
-#else
-/* This check is needed to avoid cache aliasing when PAT is enabled */
-static inline int range_is_allowed(unsigned long pfn, unsigned long size)
-{
-	u64 from = ((u64)pfn) << PAGE_SHIFT;
-	u64 to = from + size;
-	u64 cursor = from;
-
-	if (!pat_enabled())
-		return 1;
-
-	while (cursor < to) {
-		if (!devmem_is_allowed(pfn))
-			return 0;
-		cursor += PAGE_SIZE;
-		pfn++;
-	}
-	return 1;
-}
-#endif /* CONFIG_STRICT_DEVMEM */
-
 int phys_mem_access_prot_allowed(struct file *file, unsigned long pfn,
 				unsigned long size, pgprot_t *vma_prot)
 {
 	enum page_cache_mode pcm = _PAGE_CACHE_MODE_WB;
 
+	if (!pat_enabled())
+		return 1;
+
 	if (!range_is_allowed(pfn, size))
 		return 0;
 
diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index 169eed1..4883995 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -61,29 +61,11 @@ static inline int page_is_allowed(unsigned long pfn)
 {
 	return devmem_is_allowed(pfn);
 }
-static inline int range_is_allowed(unsigned long pfn, unsigned long size)
-{
-	u64 from = ((u64)pfn) << PAGE_SHIFT;
-	u64 to = from + size;
-	u64 cursor = from;
-
-	while (cursor < to) {
-		if (!devmem_is_allowed(pfn))
-			return 0;
-		cursor += PAGE_SIZE;
-		pfn++;
-	}
-	return 1;
-}
 #else
 static inline int page_is_allowed(unsigned long pfn)
 {
 	return 1;
 }
-static inline int range_is_allowed(unsigned long pfn, unsigned long size)
-{
-	return 1;
-}
 #endif
 
 static inline bool should_stop_iteration(void)
diff --git a/include/linux/io.h b/include/linux/io.h
index 6a6bc4d..0642c7e 100644
--- a/include/linux/io.h
+++ b/include/linux/io.h
@@ -183,4 +183,25 @@ static inline void arch_io_free_memtype_wc(resource_size_t base,
 int devm_arch_io_reserve_memtype_wc(struct device *dev, resource_size_t start,
 				    resource_size_t size);
 
+#ifdef CONFIG_STRICT_DEVMEM
+static inline int range_is_allowed(unsigned long pfn, unsigned long size)
+{
+	u64 from = ((u64)pfn) << PAGE_SHIFT;
+	u64 to = from + size;
+	u64 cursor = from;
+
+	while (cursor < to) {
+		if (!devmem_is_allowed(pfn))
+			return 0;
+		cursor += PAGE_SIZE;
+		pfn++;
+	}
+	return 1;
+}
+#else
+static inline int range_is_allowed(unsigned long pfn, unsigned long size)
+{
+	return 1;
+}
+#endif
 #endif /* _LINUX_IO_H */

