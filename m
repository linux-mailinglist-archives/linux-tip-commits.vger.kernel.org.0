Return-Path: <linux-tip-commits+bounces-3570-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 602F4A3F73F
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 15:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4816419C5B70
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 14:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2742220FAAD;
	Fri, 21 Feb 2025 14:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WwYJDxOk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OhmXpsIH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D46B20F08B;
	Fri, 21 Feb 2025 14:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740148123; cv=none; b=Yq7nE0a7BCE0gf7H+pNqVARsDag4JONOYVpXtfrMXpx3pn/dGTMvfCEsXOSgdJv68Ot7yDEMk6LNEqb0cc0QLVMi2v+Atif7cZo6gWvjd9SJ25NSJT31QgBAsl+j4kvIVaS6idM6PjZ464rWoYf2C4dn/+apl/RSgyilbhM6knk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740148123; c=relaxed/simple;
	bh=Mx89Y6vurAWslm7Kn5lsZo1EfDTPBclLo/eWx5fRuVI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eAc8skeuRY9/b7fLdt5RyRXNv/sqMcBFKiHYhmELE33nsxFLa04OJ2Pky7xHe3qiKoLAMpslF5FjnyOQBTGtjGb1EcWmOS5gF5svzrq2sYWvUt1ax0/LQxHbkcjRGNqwaCwyYmivUjDXbFW1L4ea7FkA6JmYPJMkTJe4uvH40sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WwYJDxOk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OhmXpsIH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Feb 2025 14:28:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740148119;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KWndIPAXGE91G/D4TOAKxIsbHn8ei0K5UzfIIzlINAI=;
	b=WwYJDxOk7ieQwcquxiZW4fyM/CD9NC8re3G3C/mnYHwnan9ag8SzWQxNHvbKf82xzYNgVl
	WsJ+SkGGxyK7nIYw7fQhaKEVoiwktNvuyVPbpXptsNJXBLNFE7IyCWrUhuzoHS2I07zvN2
	auILsO/E6iBxYIqpLVmdDouTivZo3mjRlNJdHvoMlczgt7c/aHYHkbgcC/Nn3HqyxtQUAC
	dNhCK5jPeLMVURUQ+QxXm8x0Ibo4gj1zB7p4ttXpoweJf+DS2OUu3Gr6XNsZPBwtPcWetU
	RtTmVEiCLmzlSRMocdChmE33s8vXG/o29QxKYjhpZqtUp6Tl7mv4L6bxAaERGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740148119;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KWndIPAXGE91G/D4TOAKxIsbHn8ei0K5UzfIIzlINAI=;
	b=OhmXpsIHCHk66LVxzlotJzoEoOSP2NZJU3f+36Tdk+u33z0nXJad6Yh2C2V85aW6Duz5GU
	/yr7tfPAhiEN24BQ==
From: "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/mm] mm/memremap: Pass down MEMREMAP_* flags to arch_memremap_wb()
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250217163822.343400-2-kirill.shutemov@linux.intel.com>
References: <20250217163822.343400-2-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174014811865.10177.8934046854387322499.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     a9ebcb88136ca80cb53de27ca5ae77de18bbe368
Gitweb:        https://git.kernel.org/tip/a9ebcb88136ca80cb53de27ca5ae77de18bbe368
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Mon, 17 Feb 2025 18:38:20 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 21 Feb 2025 15:05:38 +01:00

mm/memremap: Pass down MEMREMAP_* flags to arch_memremap_wb()

x86 version of arch_memremap_wb() needs the flags to decide if the mapping
has to be encrypted or decrypted.

Pass down the flag to arch_memremap_wb(). All current implementations
ignore the argument.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-mm@kvack.org
Link: https://lore.kernel.org/r/20250217163822.343400-2-kirill.shutemov@linux.intel.com
---
 arch/arm/include/asm/io.h   | 2 +-
 arch/arm/mm/ioremap.c       | 2 +-
 arch/arm/mm/nommu.c         | 2 +-
 arch/riscv/include/asm/io.h | 2 +-
 kernel/iomem.c              | 5 +++--
 5 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index 1815748..bae5edf 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -381,7 +381,7 @@ void __iomem *ioremap_wc(resource_size_t res_cookie, size_t size);
 void iounmap(volatile void __iomem *io_addr);
 #define iounmap iounmap
 
-void *arch_memremap_wb(phys_addr_t phys_addr, size_t size);
+void *arch_memremap_wb(phys_addr_t phys_addr, size_t size, unsigned long flags);
 #define arch_memremap_wb arch_memremap_wb
 
 /*
diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
index 89f1c97..748698e 100644
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -436,7 +436,7 @@ void __arm_iomem_set_ro(void __iomem *ptr, size_t size)
 	set_memory_ro((unsigned long)ptr, PAGE_ALIGN(size) / PAGE_SIZE);
 }
 
-void *arch_memremap_wb(phys_addr_t phys_addr, size_t size)
+void *arch_memremap_wb(phys_addr_t phys_addr, size_t size, unsigned long flags)
 {
 	return (__force void *)arch_ioremap_caller(phys_addr, size,
 						   MT_MEMORY_RW,
diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
index 1a8f691..d638cc8 100644
--- a/arch/arm/mm/nommu.c
+++ b/arch/arm/mm/nommu.c
@@ -248,7 +248,7 @@ void __iomem *pci_remap_cfgspace(resource_size_t res_cookie, size_t size)
 EXPORT_SYMBOL_GPL(pci_remap_cfgspace);
 #endif
 
-void *arch_memremap_wb(phys_addr_t phys_addr, size_t size)
+void *arch_memremap_wb(phys_addr_t phys_addr, size_t size, unsigned long flags)
 {
 	return (void *)phys_addr;
 }
diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
index 1c5c641..0257f4a 100644
--- a/arch/riscv/include/asm/io.h
+++ b/arch/riscv/include/asm/io.h
@@ -136,7 +136,7 @@ __io_writes_outs(outs, u64, q, __io_pbr(), __io_paw())
 #include <asm-generic/io.h>
 
 #ifdef CONFIG_MMU
-#define arch_memremap_wb(addr, size)	\
+#define arch_memremap_wb(addr, size, flags)	\
 	((__force void *)ioremap_prot((addr), (size), _PAGE_KERNEL))
 #endif
 
diff --git a/kernel/iomem.c b/kernel/iomem.c
index dc21207..75e61c1 100644
--- a/kernel/iomem.c
+++ b/kernel/iomem.c
@@ -6,7 +6,8 @@
 #include <linux/ioremap.h>
 
 #ifndef arch_memremap_wb
-static void *arch_memremap_wb(resource_size_t offset, unsigned long size)
+static void *arch_memremap_wb(resource_size_t offset, unsigned long size,
+			      unsigned long flags)
 {
 #ifdef ioremap_cache
 	return (__force void *)ioremap_cache(offset, size);
@@ -91,7 +92,7 @@ void *memremap(resource_size_t offset, size_t size, unsigned long flags)
 		if (is_ram == REGION_INTERSECTS)
 			addr = try_ram_remap(offset, size, flags);
 		if (!addr)
-			addr = arch_memremap_wb(offset, size);
+			addr = arch_memremap_wb(offset, size, flags);
 	}
 
 	/*

