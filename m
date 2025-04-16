Return-Path: <linux-tip-commits+bounces-5002-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1250A8B328
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Apr 2025 10:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38C8919050DC
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Apr 2025 08:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959BC18DB37;
	Wed, 16 Apr 2025 08:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I57rABSM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+VtgGwvT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5293209;
	Wed, 16 Apr 2025 08:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744791438; cv=none; b=FMJ8B56gWi6RPSVeU5w36hV/+kvu1T+QTwYV/GxSlt55zOcrgbqe7U594j/6Z3n9d10axXKLQvT66byureVLqstOvBwlsa4reZxGiIEiojOErzwY08AUb3ADKQapS9DxVh+IYNuEqyMTxuJ9S0QJrrnD5CzOso3UFRhRjM8SbZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744791438; c=relaxed/simple;
	bh=dNIZtrb9sly63WSq4nwPB7J65aXLf7AlzqcC5excUCI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rSnpqyUsrWSSbwXb8WuE0WfoxFjmVS0reLF7RW3y2EnIZMFeAHHnM96BLCRZI6daGgfAknm77c/rooIkIsY8z+h2ZZVsFKxHoM/668iSquD4CFTJZimxIlVIKZqovMCFjrpsTgHJ7qdlQbCBLBPfdqUCFovyd2ge0dswUNJdwT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I57rABSM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+VtgGwvT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 16 Apr 2025 08:17:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744791434;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FwBOoUPeSwpEgvZ2QPoHlJ2c/vN2IfhUyCgjFAasDw8=;
	b=I57rABSMHwLQXQco0D3QRO1ydy1Tzik+1vquRReU3enSv+CHpD5lHhllr/SFpfWe2cR/Wv
	RXqAk4F5rglnDWkzOSLz/fnY/hXbdcssl+5PsmDNMYFQRlARnGbYjyKJK6M12I6VIVQdBg
	qm42SASOr5atrFypiTvpbYTqFoZ1/jrATvUgqmfQ6+ZutE6H0YxSRcHByaIlkg2JMzxhPG
	JKtYxclz5i7z4q8K7WvzJYskF+5/GgnpTdxWmeLG7CubDGQ/gN4oAm7vLmpy9uflk3w9gZ
	KBoodD+6UXSdXn/k0/2HKxT+emZw3U8Q3nHF69sde56l0m5J3V1jOJA2CmzRUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744791434;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FwBOoUPeSwpEgvZ2QPoHlJ2c/vN2IfhUyCgjFAasDw8=;
	b=+VtgGwvTOcnQeHiudedNOVvnbqKq2WlwBU6O6HzjbdjVbtJK8tVwPbXgtc/cWLydvY5k4T
	2AP3P8MLDgkO84Ag==
From: "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/fpu] x86/fpu: Rename fpu_reset_fpregs() to fpu_reset_fpstate_regs()
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>, Ingo Molnar <mingo@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Oleg Nesterov <oleg@redhat.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250416021720.12305-11-chang.seok.bae@intel.com>
References: <20250416021720.12305-11-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174479143396.31282.9678988534206071642.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     de8304c319bc020ef79d109909ad40e944d82c82
Gitweb:        https://git.kernel.org/tip/de8304c319bc020ef79d109909ad40e944d82c82
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Tue, 15 Apr 2025 19:17:00 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 16 Apr 2025 10:01:03 +02:00

x86/fpu: Rename fpu_reset_fpregs() to fpu_reset_fpstate_regs()

The original function name came from an overly compressed form of
'fpstate_regs' by commit:

    e61d6310a0f8 ("x86/fpu: Reset permission and fpstate on exec()")

However, the term 'fpregs' typically refers to physical FPU registers. In
contrast, this function copies the init values to fpu->fpstate->regs, not
hardware registers.

Rename the function to better reflect what it actually does.

No functional change.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Link: https://lore.kernel.org/r/20250416021720.12305-11-chang.seok.bae@intel.com
---
 arch/x86/kernel/fpu/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 3a19877..8d67443 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -733,7 +733,7 @@ static inline void restore_fpregs_from_init_fpstate(u64 features_mask)
 /*
  * Reset current->fpu memory state to the init values.
  */
-static void fpu_reset_fpregs(void)
+static void fpu_reset_fpstate_regs(void)
 {
 	struct fpu *fpu = x86_task_fpu(current);
 
@@ -768,7 +768,7 @@ void fpu__clear_user_states(struct fpu *fpu)
 
 	fpregs_lock();
 	if (!cpu_feature_enabled(X86_FEATURE_FPU)) {
-		fpu_reset_fpregs();
+		fpu_reset_fpstate_regs();
 		fpregs_unlock();
 		return;
 	}
@@ -798,7 +798,7 @@ void fpu__clear_user_states(struct fpu *fpu)
 void fpu_flush_thread(void)
 {
 	fpstate_reset(x86_task_fpu(current));
-	fpu_reset_fpregs();
+	fpu_reset_fpstate_regs();
 }
 /*
  * Load FPU context before returning to userspace.

