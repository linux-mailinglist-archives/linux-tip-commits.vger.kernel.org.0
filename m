Return-Path: <linux-tip-commits+bounces-4633-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97ED7A7A1D8
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Apr 2025 13:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A9D21895F6A
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Apr 2025 11:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE5D2459FB;
	Thu,  3 Apr 2025 11:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rYlHTvTb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w1+nycr+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5224413C67C;
	Thu,  3 Apr 2025 11:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743679682; cv=none; b=OWeeTdKTNhujTMJ1UcjRTnOm70qB6P1P42/2nkvursu2pL6jIcYIpun716VQQEhE+XIHpcjFZZ0vo5GfpIMSPDtYqtQTpvfCy4aMrSLfQLpmpWClXbf+34qD2OLbZOLmWPNP09TPNcmN0YLM6Ax2mqXgFTaSrBwtyy0j+qIowmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743679682; c=relaxed/simple;
	bh=YL0AWRTibRJfBCtHowp82d6IH5sUGm5xqCzqWZrzsBA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=e8P9rA2KWc9o3lvW0VND8PK870Cv0ASzDsNsp2hZtoM/LBUJkV96n8a1wuFfNklUvvB0YFZUPOvjhR1zP0104oioFNidb8gLa4yRfTkKC7KnOB+D+Jetx2m6Yn+sc3t8aQaCKN/l+fruLh0KWBsifGPoTbHPWQHBFCevNE1tvBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rYlHTvTb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w1+nycr+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 03 Apr 2025 11:27:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743679678;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6PFl1ENgNMMFg/59oiSMeO0V+WWshPr8xbhA3jSiVPM=;
	b=rYlHTvTbypwz5CapPuaOppR6v7HWrT/+hCXzyjoaVrq/NB5i+n1v2JM+kTJlhi0mfrA3v9
	1mnFLlOD7KeaofgBbdjOE1CW8gQNN2NenZaTXaP35eeSkq7en7Vql0VI6OJMNb9EpBNP54
	rO/6QAx9dC/lEa4DEMhoih2q+0s5IFOcrm8qlC2sTUtM57TOVZwYrHXVohfBYExQkq2bBX
	g1KK3gB9JnxLcCZBmOBLWDNg2HrX1gOX6mEKzGp+vFc9MorcLHyJ2zMX3NPIQhoONMPV+y
	r1mKdEBoozwc//FklW6u+kH0xz+ef/PvVkMhorgU2Qh3vwM6xPVnzXffWGmSuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743679678;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6PFl1ENgNMMFg/59oiSMeO0V+WWshPr8xbhA3jSiVPM=;
	b=w1+nycr+0qfwEsvalCzwpzHKWSGD4eCG8YpwQKwkdPzJQeQ03oW7AdAW6RGtwALVVUjDdw
	HXeLVghNkfsCmTBQ==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/idle: Remove CONFIG_AS_TPAUSE
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
 Juergen Gross <jgross@suse.com>, Andrew Cooper <andrew.cooper3@citrix.com>,
 Rik van Riel <riel@surriel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250402180827.3762-4-ubizjak@gmail.com>
References: <20250402180827.3762-4-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174367967740.14745.10059693585282358485.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     a72d55dc3bd6555cc1f97459b42b7f62ae480f13
Gitweb:        https://git.kernel.org/tip/a72d55dc3bd6555cc1f97459b42b7f62ae480f13
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Wed, 02 Apr 2025 20:08:08 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 03 Apr 2025 13:19:18 +02:00

x86/idle: Remove CONFIG_AS_TPAUSE

There is not much point in CONFIG_AS_TPAUSE at all when the emitted
assembly is always the same - it only obfuscates the __tpause() code
in essence.

Remove the TPAUSE insn mnemonic from __tpause() and leave only
the equivalent byte-wise definition. This can then be changed
back to insn mnemonic once binutils 2.31.1 is the minimum version
to build the kernel. (Right now it's 2.25.)

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250402180827.3762-4-ubizjak@gmail.com
---
 arch/x86/Kconfig.assembler   |  4 ----
 arch/x86/include/asm/mwait.h | 11 ++---------
 2 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/arch/x86/Kconfig.assembler b/arch/x86/Kconfig.assembler
index 6d20a6c..fa88585 100644
--- a/arch/x86/Kconfig.assembler
+++ b/arch/x86/Kconfig.assembler
@@ -15,10 +15,6 @@ config AS_SHA256_NI
 	def_bool $(as-instr,sha256msg1 %xmm0$(comma)%xmm1)
 	help
 	  Supported by binutils >= 2.24 and LLVM integrated assembler
-config AS_TPAUSE
-	def_bool $(as-instr,tpause %ecx)
-	help
-	  Supported by binutils >= 2.31.1 and LLVM integrated assembler >= V7
 
 config AS_GFNI
 	def_bool $(as-instr,vgf2p8mulb %xmm0$(comma)%xmm1$(comma)%xmm2)
diff --git a/arch/x86/include/asm/mwait.h b/arch/x86/include/asm/mwait.h
index 0e020a6..6a2ec20 100644
--- a/arch/x86/include/asm/mwait.h
+++ b/arch/x86/include/asm/mwait.h
@@ -138,16 +138,9 @@ static __always_inline void mwait_idle_with_hints(unsigned long eax, unsigned lo
  */
 static inline void __tpause(u32 ecx, u32 edx, u32 eax)
 {
-	/* "tpause %ecx, %edx, %eax" */
-	#ifdef CONFIG_AS_TPAUSE
-	asm volatile("tpause %%ecx"
-		     :
-		     : "c"(ecx), "d"(edx), "a"(eax));
-	#else
+	/* "tpause %ecx" */
 	asm volatile(".byte 0x66, 0x0f, 0xae, 0xf1"
-		     :
-		     : "c"(ecx), "d"(edx), "a"(eax));
-	#endif
+		     :: "c" (ecx), "d" (edx), "a" (eax));
 }
 
 #endif /* _ASM_X86_MWAIT_H */

