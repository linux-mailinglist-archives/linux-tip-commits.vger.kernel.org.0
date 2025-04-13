Return-Path: <linux-tip-commits+bounces-4930-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F087AA87346
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Apr 2025 20:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9476E188F070
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Apr 2025 18:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40331F4612;
	Sun, 13 Apr 2025 18:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IGdC0Wru";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OHegV4Et"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58451F416A;
	Sun, 13 Apr 2025 18:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744570577; cv=none; b=kp1yT9VGUTajeNFHK7NkLB1ehhose3k5yK3Fxot3/rpfOJMkK7b/6l1eoaUKCVm9Zui6LmYbmXl33fSVkxy0Fr/CVmtROKjw3E3KdIWUslsfXuDg+SubfYEBh7cr9+t3Ut/fuheuZ8+ICA5n95GFZ/vbWlm4Ski57IBcM9akvRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744570577; c=relaxed/simple;
	bh=2QqC6vTEu8SfrcroffSeK25X8g4KhBBI/lLB3smuHyg=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=JKPRbgMDY2KRo53wvHPfqpDQAruVsBFDuTWpvTs3MWLFC+nqkELLmjmY+RBdGg+5wVc6uAknmPAVfGABMBH6Iah/iSdXDdnDzhfxn5UA+2RRb7lOH/n1UwVG0LW/2lsZDw6bAhm3n8OJR8ahYyLRb+IubZeoB+EuXmayqeH7Nmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IGdC0Wru; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OHegV4Et; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 13 Apr 2025 18:56:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744570573;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=tLbz2YMylf4Y2pjIJBAdmQPnR3FoCqNMDibgiwZjw4I=;
	b=IGdC0WruRo/CA2faPGqT5hdyR1+9cUCPo5WGSoiwOlO3JKeROr1n7tddDV7YrRWKymRZS9
	ekBHJ7cUqQMQWKTJccU+rVdH3xmE22lvFc1g3iGxUMeAtHgjvMpiPrltEUbb4fjkuy7018
	PVLkAyQSco25ZmGwAUm2jPAwe1HBaE89gkZIB9EUAVu6BKV3dG0W7e3czqiJPoCD3W+hpx
	t4mkR6J5KsMb1/HIJ3frftUqEBtqpwpjeN8cmoVkxM902UqCbsm5nkLDMJUYf1eQUjxaYp
	wnKv/V4og5Zv2ajFJIGPmjY+xDmC3qeYSxJj/2IuD1mQELL42X3Q6ZFooJfAhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744570573;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=tLbz2YMylf4Y2pjIJBAdmQPnR3FoCqNMDibgiwZjw4I=;
	b=OHegV4EtcJl7jRA92oyct8vuaMmPdzsEzHAjz+LPRWgKzfrG3Vnrb4huTDxLeQmo7OBWeo
	1wKfrUGHAdVvYCAA==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/msr] x86/msr: Rename 'mce_wrmsrl()' to 'mce_wrmsrq()'
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
Message-ID: <174457057234.31282.3811749319812717744.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/msr branch of tip:

Commit-ID:     8e44e83f57c3289a41507eb79a315400629978ae
Gitweb:        https://git.kernel.org/tip/8e44e83f57c3289a41507eb79a315400629978ae
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 09 Apr 2025 22:29:03 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 10 Apr 2025 11:59:14 +02:00

x86/msr: Rename 'mce_wrmsrl()' to 'mce_wrmsrq()'

Suggested-by: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Xin Li <xin@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 arch/x86/kernel/cpu/mce/core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 765b799..255927f 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -423,7 +423,7 @@ noinstr u64 mce_rdmsrq(u32 msr)
 	return EAX_EDX_VAL(val, low, high);
 }
 
-static noinstr void mce_wrmsrl(u32 msr, u64 v)
+static noinstr void mce_wrmsrq(u32 msr, u64 v)
 {
 	u32 low, high;
 
@@ -829,7 +829,7 @@ clear_it:
 		/*
 		 * Clear state for this bank.
 		 */
-		mce_wrmsrl(mca_msr_reg(i, MCA_STATUS), 0);
+		mce_wrmsrq(mca_msr_reg(i, MCA_STATUS), 0);
 	}
 
 	/*
@@ -910,8 +910,8 @@ static noinstr bool quirk_skylake_repmov(void)
 	      MCI_STATUS_ADDRV | MCI_STATUS_MISCV |
 	      MCI_STATUS_AR | MCI_STATUS_S)) {
 		misc_enable &= ~MSR_IA32_MISC_ENABLE_FAST_STRING;
-		mce_wrmsrl(MSR_IA32_MISC_ENABLE, misc_enable);
-		mce_wrmsrl(MSR_IA32_MCx_STATUS(1), 0);
+		mce_wrmsrq(MSR_IA32_MISC_ENABLE, misc_enable);
+		mce_wrmsrq(MSR_IA32_MCx_STATUS(1), 0);
 
 		instrumentation_begin();
 		pr_err_once("Erratum detected, disable fast string copy instructions.\n");
@@ -1274,7 +1274,7 @@ static __always_inline void mce_clear_state(unsigned long *toclear)
 
 	for (i = 0; i < this_cpu_read(mce_num_banks); i++) {
 		if (arch_test_bit(i, toclear))
-			mce_wrmsrl(mca_msr_reg(i, MCA_STATUS), 0);
+			mce_wrmsrq(mca_msr_reg(i, MCA_STATUS), 0);
 	}
 }
 
@@ -1693,7 +1693,7 @@ out:
 	instrumentation_end();
 
 clear:
-	mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);
+	mce_wrmsrq(MSR_IA32_MCG_STATUS, 0);
 }
 EXPORT_SYMBOL_GPL(do_machine_check);
 

