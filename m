Return-Path: <linux-tip-commits+bounces-4956-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45217A878D4
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Apr 2025 09:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C642B166312
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Apr 2025 07:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C188258CF9;
	Mon, 14 Apr 2025 07:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U87bmQjB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yr8pKLyd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9B62580EA;
	Mon, 14 Apr 2025 07:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744616090; cv=none; b=PfuavI7wtx4atOBljuQYwipxUn+g5UkyhzfSafDEn9iTngB7qO7+S17rFie4jctTyek0UzxXxQ0xcE5ci7n45Twvoxw2ULmnMIJggnHx4a63dHdqY5Z9l0NmDw7VDMyhSQDygmz1axa1iWvm1Qb5sBXHKAvvOMpVCd0gQX4zKdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744616090; c=relaxed/simple;
	bh=QJjRnfHrrCcf9d1bYJQ2uDCQ2DyYd4p2lN166ILqT/c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=AGQQMBqYy9TKfpo983173zn5flTIMH/0RO6/nuCL/t3twMXAEyc8LkJEOMNU5ML5jln2EgoE7ULtlqJ807OSq4DTF9+h0xgLWBZr6f0kuhkqi1JymAuQzU+UNZ+E4xAm5EQYvwLHykIYicqQOmDr5xLA2Re44mFVLR9PYG3Su0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U87bmQjB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yr8pKLyd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 14 Apr 2025 07:34:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744616086;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YQWrLEgdYqVwPNYX0WNLUXZzoFmWZ1vapGBRNp2rCnE=;
	b=U87bmQjBj/0r8gVfs+2HKyyofwml9ZhbFaupctELK/3rF3tIyt+n4Yd/PKGEAbRbWgJ194
	O4b1ntzeO4Xoc8RV7wbGFKQOW1O+9EE2aJUMQwo34uyJE/N9V+hPV4UWLCehPL5aTsW9bS
	HrCZpPzxOU94xcZvoAT1dFYwZVuMFPDN0GiSF0trFS7GD/ouZl/moxLoIvChJwCFvxH4j1
	A3zLoVwXcV5yIm3y0f3Rl2on7XYfs1PrTmubmJ0efl58Sfy1D5LRurFCXeuAsVhsKQilrD
	60zw1MytWhvYfPRMg2QwMD6WVIdpZUQ3JTjaYaZmv0GLN4pf9DU1BD/IIlyTsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744616086;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YQWrLEgdYqVwPNYX0WNLUXZzoFmWZ1vapGBRNp2rCnE=;
	b=yr8pKLydGNuxl42elY0jzbxO8siwARORyqLcAx/oKD9sG9nyKOJi0j5Sgxr+ghUCoydvP2
	/cRKXaF6VO4wbdDg==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/merge] x86/fpu: Use 'fpstate' variable names consistently
Cc: Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@kernel.org>,
 Brian Gerst <brgerst@gmail.com>, "Chang S. Bae" <chang.seok.bae@intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250409211127.3544993-9-mingo@kernel.org>
References: <20250409211127.3544993-9-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174461608539.31282.4778128040777997792.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/merge branch of tip:

Commit-ID:     8b2a7a7294b34fa00adbecbd352ef19eb780261b
Gitweb:        https://git.kernel.org/tip/8b2a7a7294b34fa00adbecbd352ef19eb780261b
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 09 Apr 2025 23:11:27 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 14 Apr 2025 08:18:29 +02:00

x86/fpu: Use 'fpstate' variable names consistently

A few uses of 'fps' snuck in, which is rather confusing
(to me) as it suggests frames-per-second. ;-)

Rename them to the canonical 'fpstate' name.

No change in functionality.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Chang S. Bae <chang.seok.bae@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250409211127.3544993-9-mingo@kernel.org
---
 arch/x86/include/asm/fpu/api.h |  2 +-
 arch/x86/kernel/fpu/core.c     | 14 +++++++-------
 arch/x86/kernel/fpu/xstate.c   |  4 ++--
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
index f42de5f..8e6848f 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -136,7 +136,7 @@ static inline void fpstate_free(struct fpu *fpu) { }
 #endif
 
 /* fpstate-related functions which are exported to KVM */
-extern void fpstate_clear_xstate_component(struct fpstate *fps, unsigned int xfeature);
+extern void fpstate_clear_xstate_component(struct fpstate *fpstate, unsigned int xfeature);
 
 extern u64 xstate_get_guest_group_perm(void);
 
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 4d1a205..d0a45f6 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -273,16 +273,16 @@ EXPORT_SYMBOL_GPL(fpu_alloc_guest_fpstate);
 
 void fpu_free_guest_fpstate(struct fpu_guest *gfpu)
 {
-	struct fpstate *fps = gfpu->fpstate;
+	struct fpstate *fpstate = gfpu->fpstate;
 
-	if (!fps)
+	if (!fpstate)
 		return;
 
-	if (WARN_ON_ONCE(!fps->is_valloc || !fps->is_guest || fps->in_use))
+	if (WARN_ON_ONCE(!fpstate->is_valloc || !fpstate->is_guest || fpstate->in_use))
 		return;
 
 	gfpu->fpstate = NULL;
-	vfree(fps);
+	vfree(fpstate);
 }
 EXPORT_SYMBOL_GPL(fpu_free_guest_fpstate);
 
@@ -333,12 +333,12 @@ EXPORT_SYMBOL_GPL(fpu_update_guest_xfd);
  */
 void fpu_sync_guest_vmexit_xfd_state(void)
 {
-	struct fpstate *fps = x86_task_fpu(current)->fpstate;
+	struct fpstate *fpstate = x86_task_fpu(current)->fpstate;
 
 	lockdep_assert_irqs_disabled();
 	if (fpu_state_size_dynamic()) {
-		rdmsrl(MSR_IA32_XFD, fps->xfd);
-		__this_cpu_write(xfd_state, fps->xfd);
+		rdmsrl(MSR_IA32_XFD, fpstate->xfd);
+		__this_cpu_write(xfd_state, fpstate->xfd);
 	}
 }
 EXPORT_SYMBOL_GPL(fpu_sync_guest_vmexit_xfd_state);
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 4c771b9..a288597 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1431,9 +1431,9 @@ void xrstors(struct xregs_state *xstate, u64 mask)
 }
 
 #if IS_ENABLED(CONFIG_KVM)
-void fpstate_clear_xstate_component(struct fpstate *fps, unsigned int xfeature)
+void fpstate_clear_xstate_component(struct fpstate *fpstate, unsigned int xfeature)
 {
-	void *addr = get_xsave_addr(&fps->regs.xsave, xfeature);
+	void *addr = get_xsave_addr(&fpstate->regs.xsave, xfeature);
 
 	if (addr)
 		memset(addr, 0, xstate_sizes[xfeature]);

