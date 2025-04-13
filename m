Return-Path: <linux-tip-commits+bounces-4926-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B18B9A87336
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Apr 2025 20:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB9B016ED34
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Apr 2025 18:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521AC1F37D4;
	Sun, 13 Apr 2025 18:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i/3uxFjr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i0AOr0wI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CDC17A586;
	Sun, 13 Apr 2025 18:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744570573; cv=none; b=DAVay7mrYqmPwZBD+qPPjZOognr/ukUaSEen41qlzkyEhZjVgzBQXDF8bwrdl7n+WkFzlHfiTei41o8pJL/F0NqhDVa541hk3fQG7aqgB8iF0DeXOVvKU5lUzGZ+vggyqVUrxYB4pIXoxo3Ryxzl9NqzruGlBMgJbx9vg+/3L2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744570573; c=relaxed/simple;
	bh=7p+jz5ryNwp+alh3S2bdI5FiC+q0DlVOT7aLC+AEnT0=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=Xgfxbje+WGelkXvoQh/mDf9bIuM5fdirqGFd7kNXYrWqWjdNWKHKk9xaQ5PpEc/a/M73YBTrAsJiyZchdpSw2EG6BW00fP8S6htBnDyaCKfUv+hYNHXd//YCsJi8aqaIS3mKtymcOq8B31qLkHNhg8JTpYq6z13DOanmnV9XXW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i/3uxFjr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i0AOr0wI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 13 Apr 2025 18:56:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744570569;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=cImakpOJSQ2GuQCxTiXUPOAllsdodofyb8JNgFfbkDk=;
	b=i/3uxFjrcvVihXh4cWaHTFn6qVWg3X7ok46akMOmoszQZbCWdUIsa+Fmx+clUT9VVB7nvS
	nb+nr9LEiMs3SfFysLMdDsQxhgeBka5cOT98TLclN5s2yROlTMJZkwo4QovEY66S4VbAXs
	zAo6AGzNGkyWWYrJQUvu38yC3E/bv+aTv0D/CrEZ1IHgWEFvcwPwnSsBA3JSTABfMlniNP
	s1Qe/hcEIPuqFNhwM5qMzzlzB9jW+4OLbprxNc3h2hHRl/eFPKITLmqAUZm+hR5cvNRXrq
	7SpDJPx3oMxH2UfBtsUXuo0NwkrI2RUhSrMu7b5cvRc/2YL1P7UJtST+jqVFkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744570569;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=cImakpOJSQ2GuQCxTiXUPOAllsdodofyb8JNgFfbkDk=;
	b=i0AOr0wIhMTDqESV8LzCERsmO1FODA5UhdQO/m+1nLM06RzCXN9ITHszR/FE9kNATpw5h2
	WSaFLRc2BdjNMrDQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/msr] x86/msr: Rename 'wrmsrl_cstar()' to 'wrmsrq_cstar()'
Cc: "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Juergen Gross <jgross@suse.com>, Dave Hansen <dave.hansen@intel.com>,
 Xin Li <xin@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174457056761.31282.2847437139703436581.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/msr branch of tip:

Commit-ID:     eef476f15c8350078efb48bd9b9f3ff50ae1bbbb
Gitweb:        https://git.kernel.org/tip/eef476f15c8350078efb48bd9b9f3ff50ae1bbbb
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 09 Apr 2025 22:29:07 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 10 Apr 2025 11:59:37 +02:00

x86/msr: Rename 'wrmsrl_cstar()' to 'wrmsrq_cstar()'

Suggested-by: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Xin Li <xin@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 arch/x86/kernel/cpu/common.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index bb986ba..079ded4 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2091,7 +2091,7 @@ DEFINE_PER_CPU_CACHE_HOT(unsigned long, cpu_current_top_of_stack) = TOP_OF_INIT_
 DEFINE_PER_CPU_CACHE_HOT(u64, __x86_call_depth);
 EXPORT_PER_CPU_SYMBOL(__x86_call_depth);
 
-static void wrmsrl_cstar(unsigned long val)
+static void wrmsrq_cstar(unsigned long val)
 {
 	/*
 	 * Intel CPUs do not support 32-bit SYSCALL. Writing to MSR_CSTAR
@@ -2107,7 +2107,7 @@ static inline void idt_syscall_init(void)
 	wrmsrq(MSR_LSTAR, (unsigned long)entry_SYSCALL_64);
 
 	if (ia32_enabled()) {
-		wrmsrl_cstar((unsigned long)entry_SYSCALL_compat);
+		wrmsrq_cstar((unsigned long)entry_SYSCALL_compat);
 		/*
 		 * This only works on Intel CPUs.
 		 * On AMD CPUs these MSRs are 32-bit, CPU truncates MSR_IA32_SYSENTER_EIP.
@@ -2119,7 +2119,7 @@ static inline void idt_syscall_init(void)
 			    (unsigned long)(cpu_entry_stack(smp_processor_id()) + 1));
 		wrmsrq_safe(MSR_IA32_SYSENTER_EIP, (u64)entry_SYSENTER_compat);
 	} else {
-		wrmsrl_cstar((unsigned long)entry_SYSCALL32_ignore);
+		wrmsrq_cstar((unsigned long)entry_SYSCALL32_ignore);
 		wrmsrq_safe(MSR_IA32_SYSENTER_CS, (u64)GDT_ENTRY_INVALID_SEG);
 		wrmsrq_safe(MSR_IA32_SYSENTER_ESP, 0ULL);
 		wrmsrq_safe(MSR_IA32_SYSENTER_EIP, 0ULL);

