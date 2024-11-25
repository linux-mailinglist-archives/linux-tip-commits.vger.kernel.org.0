Return-Path: <linux-tip-commits+bounces-2878-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 621279D8404
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Nov 2024 12:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23AA8284E74
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Nov 2024 11:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BA41953B0;
	Mon, 25 Nov 2024 11:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rCIutpk5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xCGeebeg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B909192589;
	Mon, 25 Nov 2024 11:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732532677; cv=none; b=Piu/uTyHPk0RFhZlFwtx61DyWlYmeTS8OZrJOC20ITdx5P6VIXiEGdaECD038aoze7VnRtS+2cMJLHdbniC+ApsT55UIBQMqQtszQig87yu+nxqNMh4idUm152lgzwGkq3HCX5Hkb+5PU+XDCYg1Py2SWEheOKj1OZc5ckC0IOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732532677; c=relaxed/simple;
	bh=mLOKU6wvbcxO9YVuTXH2X6BlYFhxP4NcQud1R9FrTaU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LV4R6j4HFru3SJxScRyKRXohqrRfyGoo/a6wSewe7Tu+YXk1e3tQdGWhnL2IpUSZ4P/Ns93bjLpVMxvxleYYrnNWVy2Hmd/4JQAPtifmwLqHGxIXWAWOp8x7Ky4XjvlpcGUFVSrH2wyRLRkGZ0wnB3E4DV2tpwtNSu1ylzPzl3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rCIutpk5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xCGeebeg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 25 Nov 2024 11:04:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732532673;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PerBfEWaibwe9ifvwUDPARS2RmRFDUHjPLDBghBqxVs=;
	b=rCIutpk54U+QPUYUmlf9K65Osfg7vwX/A/01e9vD+oxL7KyEKQGWKE0FNntW7Lyjp+JL9b
	Jqnw7lVRzO4hEayq5PDPR88RyS9+rEWn5/uUNyyTetEp0f8VH+RArvM0zPJjruJZs228te
	kIMu71oC8avDAwEACbw5QX1b7wwEUd/CsHEFoGo4TwaZuu4IOWVkESnhojytjWiiZgB4Gw
	csBH5zJ6xKES5RPzX4DY9C6iQ0FG/l3duC5MhrP8IXmZmjEmiR/6rWnOamN+8t6eAg4ANv
	Q0aPpS/AapECf5O1BfM+DKGyrN65NJ2CGL1hLCCGNGHnlLWToJ8R8wxjf0fbpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732532673;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PerBfEWaibwe9ifvwUDPARS2RmRFDUHjPLDBghBqxVs=;
	b=xCGeebegu84pPj7SSQkIkRrnN/qXXkrOEiDgenKO4EgIBgTWJBiA6/73P9qwblD7hF94uA
	W/P5okX4119ZTVAw==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/mm: Carve out INVLPG inline asm for use by others
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <ZyulbYuvrkshfsd2@antipodes>
References: <ZyulbYuvrkshfsd2@antipodes>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173253267297.412.14240274224411885362.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     f1d84b59cbb9547c243d93991acf187fdbe9fbe9
Gitweb:        https://git.kernel.org/tip/f1d84b59cbb9547c243d93991acf187fdbe9fbe9
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Tue, 19 Nov 2024 12:21:32 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 25 Nov 2024 11:28:02 +01:00

x86/mm: Carve out INVLPG inline asm for use by others

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/ZyulbYuvrkshfsd2@antipodes
---
 arch/x86/include/asm/tlb.h | 4 ++++
 arch/x86/mm/tlb.c          | 3 ++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
index 580636c..4d3c9d0 100644
--- a/arch/x86/include/asm/tlb.h
+++ b/arch/x86/include/asm/tlb.h
@@ -34,4 +34,8 @@ static inline void __tlb_remove_table(void *table)
 	free_page_and_swap_cache(table);
 }
 
+static inline void invlpg(unsigned long addr)
+{
+	asm volatile("invlpg (%0)" ::"r" (addr) : "memory");
+}
 #endif /* _ASM_X86_TLB_H */
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index b0d5a64..a2becb8 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -20,6 +20,7 @@
 #include <asm/cacheflush.h>
 #include <asm/apic.h>
 #include <asm/perf_event.h>
+#include <asm/tlb.h>
 
 #include "mm_internal.h"
 
@@ -1140,7 +1141,7 @@ STATIC_NOPV void native_flush_tlb_one_user(unsigned long addr)
 	bool cpu_pcide;
 
 	/* Flush 'addr' from the kernel PCID: */
-	asm volatile("invlpg (%0)" ::"r" (addr) : "memory");
+	invlpg(addr);
 
 	/* If PTI is off there is no user PCID and nothing to flush. */
 	if (!static_cpu_has(X86_FEATURE_PTI))

