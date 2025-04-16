Return-Path: <linux-tip-commits+bounces-5005-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C03CEA8B331
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Apr 2025 10:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98C931905C3D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Apr 2025 08:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E4F2309BE;
	Wed, 16 Apr 2025 08:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hnMhyNXa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hWqtVdX+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0147222DF80;
	Wed, 16 Apr 2025 08:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744791441; cv=none; b=pu+85UZjz1tZeLSkmA3aRKT18IT1M5HIgft2Ti+dAjTI4K/6uvUaMAM9AOx5Y+66LzjeDFHYOv2w9af8Hf+8iNlr+7oegis8JuBOty40qtZMzFoarxb5fn6MYwwO4PAIXJ+QjzAZv3t3E5Qwd1oGJFeV7oHHDkML1H0nC/nL6Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744791441; c=relaxed/simple;
	bh=PLo4UID83ii5OtvsIo0MMVpSy29zid8FVQjk10dShJU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gYFMolFpdiG6EYVKrmGSDwIcIOysetH4uJ64fhVDRvWIvUvJb3iHU/PAS9N+Yhs3vYKixWxhZSkIX3FISEyLuvUbEKEJ0XOUNkvKTf884bc5fsd24XkxSEnYf/IduoFg7JXBgL1jadiozpXbltAauNfc1zF1LgaW9wXcF9+8Jw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hnMhyNXa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hWqtVdX+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 16 Apr 2025 08:17:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744791438;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WYrhx97vy5BgHEZHiU8DunHVn3Xr7CS6KxZ0lLfWqt4=;
	b=hnMhyNXaJcJWWJaXZodThPPXx6MwDCVfjs9DK5GUb3hwYKLbDWCCxB7RPJMk40CR5ULeyn
	BOA4UFi/5wWxADoE7vw2pWboiAAleHGq/a74rrSKOL2zSTY7g1PggyZFEc00Buqqa5ijU9
	RrjRm4BK/NPASm1sTSA+Uo17pMw1KzET8G85AVVvM3UzRlOPx1etY9Cc49+ZdvYN6BlpFQ
	1sRHrenfnB7c0u2LZmt9h4r2Yn2bDuyQgalRmMx5FEw8iTL06lx4luJwMZww2KvQosoPWW
	8naI2mtyKYh5TruePy/HwUsFP4AgCK1qJIlqVCAR4lMyHpR4nBMHCCyfafelwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744791438;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WYrhx97vy5BgHEZHiU8DunHVn3Xr7CS6KxZ0lLfWqt4=;
	b=hWqtVdX+6pBjKoD2FonWasH7SCAr7JjTDYerQ9Qea1cxYE04aj1uybsAm2vTbAWozPz1od
	TNzli70WhO3PwLAw==
From: "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Refactor xfeature bitmask update code for
 sigframe XSAVE
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>, Ingo Molnar <mingo@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Oleg Nesterov <oleg@redhat.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250416021720.12305-8-chang.seok.bae@intel.com>
References: <20250416021720.12305-8-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174479143782.31282.8590053248637936011.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     64e54461ab6e8524a8de4e63b7d1a3e4481b5cf3
Gitweb:        https://git.kernel.org/tip/64e54461ab6e8524a8de4e63b7d1a3e4481b5cf3
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Tue, 15 Apr 2025 19:16:57 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 16 Apr 2025 10:01:00 +02:00

x86/fpu: Refactor xfeature bitmask update code for sigframe XSAVE

Currently, saving register states in the signal frame, the legacy feature
bits are always set in xregs_state->header->xfeatures. This code sequence
can be generalized for reuse in similar cases.

Refactor the logic to ensure a consistent approach across similar usages.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Link: https://lore.kernel.org/r/20250416021720.12305-8-chang.seok.bae@intel.com
---
 arch/x86/kernel/fpu/signal.c | 11 +----------
 arch/x86/kernel/fpu/xstate.h | 13 +++++++++++++
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index b8b4fa9..c3ec251 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -114,7 +114,6 @@ static inline bool save_xstate_epilog(void __user *buf, int ia32_frame,
 {
 	struct xregs_state __user *x = buf;
 	struct _fpx_sw_bytes sw_bytes = {};
-	u32 xfeatures;
 	int err;
 
 	/* Setup the bytes not touched by the [f]xsave and reserved for SW. */
@@ -128,12 +127,6 @@ static inline bool save_xstate_epilog(void __user *buf, int ia32_frame,
 			  (__u32 __user *)(buf + fpstate->user_size));
 
 	/*
-	 * Read the xfeatures which we copied (directly from the cpu or
-	 * from the state in task struct) to the user buffers.
-	 */
-	err |= __get_user(xfeatures, (__u32 __user *)&x->header.xfeatures);
-
-	/*
 	 * For legacy compatible, we always set FP/SSE bits in the bit
 	 * vector while saving the state to the user context. This will
 	 * enable us capturing any changes(during sigreturn) to
@@ -144,9 +137,7 @@ static inline bool save_xstate_epilog(void __user *buf, int ia32_frame,
 	 * header as well as change any contents in the memory layout.
 	 * xrestore as part of sigreturn will capture all the changes.
 	 */
-	xfeatures |= XFEATURE_MASK_FPSSE;
-
-	err |= __put_user(xfeatures, (__u32 __user *)&x->header.xfeatures);
+	err |= set_xfeature_in_sigframe(x, XFEATURE_MASK_FPSSE);
 
 	return !err;
 }
diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index 9a3a8cc..4231e44 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -69,6 +69,19 @@ static inline u64 xfeatures_mask_independent(void)
 	return fpu_kernel_cfg.independent_features;
 }
 
+static inline int set_xfeature_in_sigframe(struct xregs_state __user *xbuf, u64 mask)
+{
+	u64 xfeatures;
+	int err;
+
+	/* Read the xfeatures value already saved in the user buffer */
+	err  = __get_user(xfeatures, &xbuf->header.xfeatures);
+	xfeatures |= mask;
+	err |= __put_user(xfeatures, &xbuf->header.xfeatures);
+
+	return err;
+}
+
 /*
  * Update the value of PKRU register that was already pushed onto the signal frame.
  */

