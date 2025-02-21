Return-Path: <linux-tip-commits+bounces-3569-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA92EA3F73E
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 15:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 152EF19C5225
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 14:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF29320FA86;
	Fri, 21 Feb 2025 14:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZPw1AudZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Fy2IsmCf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46CA20F07C;
	Fri, 21 Feb 2025 14:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740148121; cv=none; b=T2UlLZJXKGAgXCwcQKQmU9ULXiaDHvMfxWGO220/nXcHo6qG+71r+v6qUeWNd91f3eKplHDXvGXA/iJayIbBd+Ps6/NpLsuyEA6gBIeTTSMMhdMUL8IyM9NPY7jsY35Fkx/f6zkiIrTir8JeUSpQhG0WorpAk3VPLnVWNTZDtNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740148121; c=relaxed/simple;
	bh=Qfk8Q1B0AjLYBu59vf6w2206hMYXXmnBKLi09qQ1Edo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=W4qanSfZmrhnIjyrXgb709d7eqsTtrAqvZUnYynxjDAclNSJFNz0bEWc1mfrK3RAuI7k4xgqFUNRNthzH3VoCHN6QKdYPSDlbfz72xfA4YvZYm+StBSrXX5RDdfjuli63fFedeEN6nJCR9yXQuM2MT+7ZwF90YRHP2L1xBWNGD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZPw1AudZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Fy2IsmCf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Feb 2025 14:28:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740148118;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vH5iRePqFWY0jBXyv+qXJE548ytAEcprlSzOEoz/Ymg=;
	b=ZPw1AudZBLH1C1YQ5RhWoBMsQM+4c6uVBuhRKkOtpnA6u1qPCoNaV2yK0hYZPy10e9j9zx
	OSehMPNqIT1SW8aQqYNA852QWy3gTxgGixn+lKaBr0D3qBApF5O5wEdKmswv4z9M9j3t7A
	ee8TMd+pbOkIV0HZGrKjURIZCLh+362IeF+hXxpfpPA17M0Bs+Q5N3kZ+sHEQqMrFSpGYC
	G3TnUQb5a6W/3A7468gYxs2ijD2I2dOr9Ksvvba6JMUYBzcfP/dsask/wjmk4LG1JeFcKG
	Pm8rRzlruW40sjNoklCIDPpFGi1Y+2sKHPR6EdIcW4YVbo7IiIFzUF/U/VaLqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740148118;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vH5iRePqFWY0jBXyv+qXJE548ytAEcprlSzOEoz/Ymg=;
	b=Fy2IsmCf3Xmmhi7VEdPRm4KwjTsob6VCA8lBc6HDLBy4IF0pSHrYx2AHrBhr4+a1T+0FoS
	cXhUFIrMtzxOQ+AQ==
From: "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Make memremap(MEMREMAP_WB) map memory as
 encrypted by default
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250217163822.343400-3-kirill.shutemov@linux.intel.com>
References: <20250217163822.343400-3-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174014811760.10177.17006490943766230625.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     81256a50aa0fddefbf4849db8cad9f70c5167c04
Gitweb:        https://git.kernel.org/tip/81256a50aa0fddefbf4849db8cad9f70c5167c04
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Mon, 17 Feb 2025 18:38:21 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 21 Feb 2025 15:05:45 +01:00

x86/mm: Make memremap(MEMREMAP_WB) map memory as encrypted by default

Currently memremap(MEMREMAP_WB) can produce decrypted/shared mapping:

  memremap(MEMREMAP_WB)
    arch_memremap_wb()
      ioremap_cache()
        __ioremap_caller(.encrytped = false)

In such cases, the IORES_MAP_ENCRYPTED flag on the memory will determine
if the resulting mapping is encrypted or decrypted.

Creating a decrypted mapping without explicit request from the caller is
risky:

  - It can inadvertently expose the guest's data and compromise the
    guest.

  - Accessing private memory via shared/decrypted mapping on TDX will
    either trigger implicit conversion to shared or #VE (depending on
    VMM implementation).

    Implicit conversion is destructive: subsequent access to the same
    memory via private mapping will trigger a hard-to-debug #VE crash.

The kernel already provides a way to request decrypted mapping
explicitly via the MEMREMAP_DEC flag.

Modify memremap(MEMREMAP_WB) to produce encrypted/private mapping by
default unless MEMREMAP_DEC is specified or if the kernel runs on
a machine with SME enabled.

It fixes the crash due to #VE on kexec in TDX guests if CONFIG_EISA is
enabled.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-mm@kvack.org
Link: https://lore.kernel.org/r/20250217163822.343400-3-kirill.shutemov@linux.intel.com
---
 arch/x86/include/asm/io.h | 3 +++
 arch/x86/mm/ioremap.c     | 8 ++++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index ed580c7..1a0dc2b 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -175,6 +175,9 @@ extern void __iomem *ioremap_prot(resource_size_t offset, unsigned long size, un
 extern void __iomem *ioremap_encrypted(resource_size_t phys_addr, unsigned long size);
 #define ioremap_encrypted ioremap_encrypted
 
+void *arch_memremap_wb(phys_addr_t phys_addr, size_t size, unsigned long flags);
+#define arch_memremap_wb arch_memremap_wb
+
 /**
  * ioremap     -   map bus memory into CPU space
  * @offset:    bus address of the memory
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 38ff779..42c90b4 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -503,6 +503,14 @@ void iounmap(volatile void __iomem *addr)
 }
 EXPORT_SYMBOL(iounmap);
 
+void *arch_memremap_wb(phys_addr_t phys_addr, size_t size, unsigned long flags)
+{
+	if ((flags & MEMREMAP_DEC) || cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
+		return (void __force *)ioremap_cache(phys_addr, size);
+
+	return (void __force *)ioremap_encrypted(phys_addr, size);
+}
+
 /*
  * Convert a physical pointer to a virtual kernel pointer for /dev/mem
  * access

