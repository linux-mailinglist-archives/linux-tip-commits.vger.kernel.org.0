Return-Path: <linux-tip-commits+bounces-3969-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5DBA4ED6E
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 20:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2B6B1884220
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 19:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1283264602;
	Tue,  4 Mar 2025 19:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="22qyehsH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6ulUFq0S"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D03925FA0E;
	Tue,  4 Mar 2025 19:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741116841; cv=none; b=lGu63/XDLtNaog/Lnf9k2lBiEdMCJ6AUN0+loCYS11s9/MjMH7TRo+zbL1S5zKmMbgByhwSvElPuDMUKq7NLXfkLHUgpOhFNmnTLnjIVhWSv/t3gtLLuKT7bmDZ6QC/92TY6lndN3MXLfrVMRDGB4jc/fjGjHxNDMvd2mS9lINI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741116841; c=relaxed/simple;
	bh=Q/iuT0PcvE0VVUWD0Nfc2bD365xHK75AuBtlNmO9+bw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=m1MfbdQ6PXvMxP6lCe0ZlHYOW5giEXcfTCKwo3RnZdEWGpTS8K7yx5jRpehx3wbTgSj2FbzgV9/gHAuczhdF9WN5d3uXhTvy5oJTC0r+NS0gzfKO0NKmoSHu2gAKlaEOXQO+R2lV86Wokq9i1NjHA8zrBV3orRDlfyBcFhXWSgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=22qyehsH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6ulUFq0S; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 19:33:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741116838;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xNgtpm6bp0a0Dfs1ekOo6/gVSkK0qx970BpaQ+bPDGg=;
	b=22qyehsHZHIl5JZYYkkRhryNHRRAMxlBxzwyLeWLVP1G2RLRtZ0s7ZQAdSAuFwW+mMRJRO
	uUxUSj0OhhDGDDlY47aRydSOvCf93q5I9SkjLiiHE/udMplX5nbSlg7mi3rrmbAIVxaF8s
	TWNUXk4aHLIuZv/F3ejk5BCjN/kKvxDmhSc10g0uHKr29l57luv8Hy+b17HwypegeoSS7u
	XAgrKQ9PlFNRjC53k9hfn2H99oYk0FzkUpndGEOO3pce4wzo7Niin9PsA02iY/Ivi7GDVL
	FWV+hTSvRj6YlZ2BWzlTtP8pLpeobokNHg1mTuOL+uQ9Eq70PxIIH53Y1wiiIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741116838;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xNgtpm6bp0a0Dfs1ekOo6/gVSkK0qx970BpaQ+bPDGg=;
	b=6ulUFq0SSvhYaD2pUhT8604ImD7DYIXphCXRTrZwJ/VJSpo8S5Jp+kR2hDOPUvZVZ0Pmgr
	C2FjGGgmkakUYXCQ==
From: "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/stackprotector: Move __stack_chk_guard to percpu
 hot section
Cc: Brian Gerst <brgerst@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Uros Bizjak <ubizjak@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250303165246.2175811-11-brgerst@gmail.com>
References: <20250303165246.2175811-11-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174111683805.14745.10697139549035138086.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     db421cdec99d0f18282f3c9fafc57a0a8a0ffdf9
Gitweb:        https://git.kernel.org/tip/db421cdec99d0f18282f3c9fafc57a0a8a0ffdf9
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Mon, 03 Mar 2025 11:52:45 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Mar 2025 20:18:02 +01:00

x86/stackprotector: Move __stack_chk_guard to percpu hot section

No functional change.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250303165246.2175811-11-brgerst@gmail.com
---
 arch/x86/include/asm/stackprotector.h | 2 +-
 arch/x86/kernel/cpu/common.c          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/stackprotector.h b/arch/x86/include/asm/stackprotector.h
index d43fb58..cd761b1 100644
--- a/arch/x86/include/asm/stackprotector.h
+++ b/arch/x86/include/asm/stackprotector.h
@@ -20,7 +20,7 @@
 
 #include <linux/sched.h>
 
-DECLARE_PER_CPU(unsigned long, __stack_chk_guard);
+DECLARE_PER_CPU_CACHE_HOT(unsigned long, __stack_chk_guard);
 
 /*
  * Initialize the stackprotector canary value.
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 3f45fdd..5809534 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2147,7 +2147,7 @@ void syscall_init(void)
 #endif /* CONFIG_X86_64 */
 
 #ifdef CONFIG_STACKPROTECTOR
-DEFINE_PER_CPU(unsigned long, __stack_chk_guard);
+DEFINE_PER_CPU_CACHE_HOT(unsigned long, __stack_chk_guard);
 #ifndef CONFIG_SMP
 EXPORT_PER_CPU_SYMBOL(__stack_chk_guard);
 #endif

