Return-Path: <linux-tip-commits+bounces-3717-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FD0A4880A
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Feb 2025 19:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAFB8188A938
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Feb 2025 18:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5981C270023;
	Thu, 27 Feb 2025 18:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lt6JE2OK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lb4fisJ6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC75E21B9DD;
	Thu, 27 Feb 2025 18:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740681891; cv=none; b=Y2VMdBSnPG4F/tR6QsSWbwXW6QGrDi+ihN31EsU8lVF2pejPYH12EzTJtB+39625RlC13LlDCPLpYEZqtTA54QyVGrD+p4hzHWkzoHVmp6VNHD51zg7juqECxykYc0hQqzARxQ65psv5ovOLl+b39duLHcfRHcREbwbJnPg/KKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740681891; c=relaxed/simple;
	bh=qZVa2FfIOD+tvjK1GniRWlmgNAwRhH43ndWjbEK69wM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hJ/VlNFIk03Gwy8WeDqWESEOo4T6ETaq9fKz+0T7M6UpHqR/W1aS6jEkQwnCkTeJYk/Pa0/+4rQmklrK3yqRz456xa9r1ZuIZrWVdjpvsM/SsmJ7FyV2h5BjzzgaLXyVH6jYHlv1j/7M4nX8zl5xaJt7P8WLD3N6A5hrs//h4oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lt6JE2OK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lb4fisJ6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 27 Feb 2025 18:44:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740681888;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NaitRgbFIRxd5khauK0yKaY3/YMKSanBzbjMiCElCIc=;
	b=lt6JE2OKvF8Q674TB2h5X/v6WJmW8c2uUf15J2cU/CW6/02QA18gsRDZge6MdgqFaeUQ1j
	3Du34F/28zMYaP6YX646geKHC+njLu3jQdMSpjpvEKqp9GYPxR4BuLtbuaLbDvWnTnn4t1
	wXE86PfrQp2nWPTwD9NSYD6YdCixb+UpFW6hvcZtvRfGLYbgEHOSN12l7i687n3AY0wb+F
	TAFPhguKUPCAdWG5LaGM7PSSXYW/4W1GJ8LuCVXiQurLoL4DnwV//EvWHORS9Qqzsecd83
	oZJn+88dqVLNj5hpYhiWwknHiz5qeDUWaLg/ldEo1qWTxxLCZaNzCSYlln8OXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740681888;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NaitRgbFIRxd5khauK0yKaY3/YMKSanBzbjMiCElCIc=;
	b=lb4fisJ6UnmEaRxNOzHVrPJBjtwD3njkeAIsyb4hPMV4TmDL9G3BtDwC5ulc3VB0STxrKE
	sFnYUdEIrifccNBA==
From: "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Refine and simplify the magic number check
 during signal return
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>, Ingo Molnar <mingo@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Oleg Nesterov <oleg@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241211014500.3738-1-chang.seok.bae@intel.com>
References: <20241211014500.3738-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174068188734.10177.17059393969800577740.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     dc8aa31a7ac2c4290ea974c13cb0094e08f8948f
Gitweb:        https://git.kernel.org/tip/dc8aa31a7ac2c4290ea974c13cb0094e08f8948f
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Tue, 10 Dec 2024 17:45:00 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 27 Feb 2025 19:38:06 +01:00

x86/fpu: Refine and simplify the magic number check during signal return

Before restoring xstate from the user space buffer, the kernel performs
sanity checks on these magic numbers: magic1 in the software reserved
area, and magic2 at the end of XSAVE region.

The position of magic2 is calculated based on the xstate size derived
from the user space buffer. But, the in-kernel record is directly
available and reliable for this purpose.

This reliance on user space data is also inconsistent with the recent
fix in:

  d877550eaf2d ("x86/fpu: Stop relying on userspace for info to fault in xsave buffer")

Simply use fpstate->user_size, and then get rid of unnecessary
size-evaluation code.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/r/20241211014500.3738-1-chang.seok.bae@intel.com
---
 arch/x86/kernel/fpu/signal.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 8f62e06..6c69cb2 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -27,19 +27,14 @@
 static inline bool check_xstate_in_sigframe(struct fxregs_state __user *fxbuf,
 					    struct _fpx_sw_bytes *fx_sw)
 {
-	int min_xstate_size = sizeof(struct fxregs_state) +
-			      sizeof(struct xstate_header);
 	void __user *fpstate = fxbuf;
 	unsigned int magic2;
 
 	if (__copy_from_user(fx_sw, &fxbuf->sw_reserved[0], sizeof(*fx_sw)))
 		return false;
 
-	/* Check for the first magic field and other error scenarios. */
-	if (fx_sw->magic1 != FP_XSTATE_MAGIC1 ||
-	    fx_sw->xstate_size < min_xstate_size ||
-	    fx_sw->xstate_size > current->thread.fpu.fpstate->user_size ||
-	    fx_sw->xstate_size > fx_sw->extended_size)
+	/* Check for the first magic field */
+	if (fx_sw->magic1 != FP_XSTATE_MAGIC1)
 		goto setfx;
 
 	/*
@@ -48,7 +43,7 @@ static inline bool check_xstate_in_sigframe(struct fxregs_state __user *fxbuf,
 	 * fpstate layout with out copying the extended state information
 	 * in the memory layout.
 	 */
-	if (__get_user(magic2, (__u32 __user *)(fpstate + fx_sw->xstate_size)))
+	if (__get_user(magic2, (__u32 __user *)(fpstate + current->thread.fpu.fpstate->user_size)))
 		return false;
 
 	if (likely(magic2 == FP_XSTATE_MAGIC2))

