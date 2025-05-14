Return-Path: <linux-tip-commits+bounces-5535-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED15AB65CC
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 May 2025 10:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C64307B6D3B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 May 2025 08:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DF6222566;
	Wed, 14 May 2025 08:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bKqKMOAc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LOmrDegf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729832222B9;
	Wed, 14 May 2025 08:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747210562; cv=none; b=bw/oDROTJZih30hdJzZB2HewY491Z7QTCp0dbj29OdmrlHaQhhPcY6USC87KgP/X6Kw7F76zpPO9e3hFObHDjUnvna2vLo6ykBmTWkwd/p5UlzMz805a03gJOqiDtzbfD/5pbSXcsOS+dMO35+5TfbiiuLq+iAfjVRM7t6PZmxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747210562; c=relaxed/simple;
	bh=mWLNDnatG6xVgkJtpID1GmaF+BJbhEmDLi+tmSnmJY8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RfRR8vWzWrCR0firnt4BLECWGqWNSCegd+FtxJAvddTD/EsIGI+WHLeD+/gjBKOZsmJUn6NOqENaOp5l+tCMHs/hwL8WV195PThZowG+cAvZA0jZsTXQBWHzXO0Jdqk6gQr4liOnGYvWIkssy07l0IObd3/y09TM/v2VWQES1SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bKqKMOAc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LOmrDegf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 14 May 2025 08:15:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747210557;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0bcw7JMdnkEvRhff3/pmf6K4X3Rjj+ZkR7PQYauiRf8=;
	b=bKqKMOAcRWXGkM6vv5ja5FBr77qXdj3aYGRK2hXSXWEkL8T2s88GSIlDcTWYZos34nVX2N
	oqaI41FiuAuEvecW1/7hDfp14DZjG6w5aE+81NiX5Tlm5S9sKecw4lqICnfVI0rRU59st2
	yeZvLxI8GMwEvx7JPJayolFpqAL4/I0f0sFl2cIAqWvC8e+oepxL6Gacfyp45utbbuLO5y
	ohIXHbZDbjWHMfFZ5d3XZ1i26GowmXqRnu+GerSqpnj5hz2mSfSiaRnlhnqRqXgHkdUceZ
	/CgDOzK4atHOi3FqWQqtUdMJwKDJ0k2HU57IXHAJnfm1RTbcc4BlVF+W28frSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747210557;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0bcw7JMdnkEvRhff3/pmf6K4X3Rjj+ZkR7PQYauiRf8=;
	b=LOmrDegfDp/W4vn7OOUGjgoJQu3fLfwUlpgNak56d4jgFXden2iqTVr1PP1Q7X4oUH/gYF
	UbkWotWr/A5fIiBw==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/boot: Defer initialization of VM space related
 global variables
Cc: Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250513111157.717727-9-ardb+git@google.com>
References: <20250513111157.717727-9-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174721055669.406.6313674757003043527.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     64797551baec252f953fa8234051f88b0c368ed5
Gitweb:        https://git.kernel.org/tip/64797551baec252f953fa8234051f88b0c368ed5
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Tue, 13 May 2025 13:11:59 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 14 May 2025 10:06:35 +02:00

x86/boot: Defer initialization of VM space related global variables

The global pseudo-constants 'page_offset_base', 'vmalloc_base' and
'vmemmap_base' are not used extremely early during the boot, and cannot be
used safely until after the KASLR memory randomization code in
kernel_randomize_memory() executes, which may update their values.

So there is no point in setting these variables extremely early, and it
can wait until after the kernel itself is mapped and running from its
permanent virtual mapping.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250513111157.717727-9-ardb+git@google.com
---
 arch/x86/boot/startup/map_kernel.c |  3 ---
 arch/x86/kernel/head64.c           |  9 ++++++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/boot/startup/map_kernel.c b/arch/x86/boot/startup/map_kernel.c
index 099ae25..905e873 100644
--- a/arch/x86/boot/startup/map_kernel.c
+++ b/arch/x86/boot/startup/map_kernel.c
@@ -29,9 +29,6 @@ static inline bool check_la57_support(void)
 	__pgtable_l5_enabled	= 1;
 	pgdir_shift		= 48;
 	ptrs_per_p4d		= 512;
-	page_offset_base	= __PAGE_OFFSET_BASE_L5;
-	vmalloc_base		= __VMALLOC_BASE_L5;
-	vmemmap_base		= __VMEMMAP_BASE_L5;
 
 	return true;
 }
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 510fb41..14f7dda 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -62,13 +62,10 @@ EXPORT_SYMBOL(ptrs_per_p4d);
 #ifdef CONFIG_DYNAMIC_MEMORY_LAYOUT
 unsigned long page_offset_base __ro_after_init = __PAGE_OFFSET_BASE_L4;
 EXPORT_SYMBOL(page_offset_base);
-SYM_PIC_ALIAS(page_offset_base);
 unsigned long vmalloc_base __ro_after_init = __VMALLOC_BASE_L4;
 EXPORT_SYMBOL(vmalloc_base);
-SYM_PIC_ALIAS(vmalloc_base);
 unsigned long vmemmap_base __ro_after_init = __VMEMMAP_BASE_L4;
 EXPORT_SYMBOL(vmemmap_base);
-SYM_PIC_ALIAS(vmemmap_base);
 #endif
 
 /* Wipe all early page tables except for the kernel symbol map */
@@ -244,6 +241,12 @@ asmlinkage __visible void __init __noreturn x86_64_start_kernel(char * real_mode
 	/* Kill off the identity-map trampoline */
 	reset_early_page_tables();
 
+	if (pgtable_l5_enabled()) {
+		page_offset_base	= __PAGE_OFFSET_BASE_L5;
+		vmalloc_base		= __VMALLOC_BASE_L5;
+		vmemmap_base		= __VMEMMAP_BASE_L5;
+	}
+
 	clear_bss();
 
 	/*

