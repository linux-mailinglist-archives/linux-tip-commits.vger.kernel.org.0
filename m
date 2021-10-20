Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95BA8434C73
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Oct 2021 15:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbhJTNrX (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 20 Oct 2021 09:47:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53050 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbhJTNrA (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 20 Oct 2021 09:47:00 -0400
Date:   Wed, 20 Oct 2021 13:44:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634737485;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bnQeHPJ3FTx5eUXeMdP6+SHxJ17JN/v9wXRgacKHxsA=;
        b=ZdWqEwOw5ElcoJU1Qb2YytRATJ8XatAkJHH+P6nBIu/9in6uKZjOAe7o9byVua0OqHZB9B
        ysxc+0+eEmJPA4LZEapGfIxwM55MXjY5Y4SAznLuuyzkXb9DdKinJFiYJkzGB2QyXpHgAz
        dsBYxC5PM9NJq7MyL/D3I4Ekqk+JeTaHPxyU7P0HcLYbwO7p98i3Wfjl7HdWr4Uo/fRCuw
        IvU/E6HgKhzzqZHMM0ZQXooYDGCGF7ZjbhxZKrBXjgfx4cbdqqOHTnt3uytWKzqLNq46ms
        eeU+kKFFi76gFRstiM20LQuPydPBR5MRC4hrofxQi7RwujgcYUYm1sUxbyrRMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634737485;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bnQeHPJ3FTx5eUXeMdP6+SHxJ17JN/v9wXRgacKHxsA=;
        b=nsih3hWS/qFsGhIHUdcHICFWPuzq6fck02SJwfctzloXC8Eepzl43bnalfs3CocZDGGFpp
        5fRAoWKy8OY9LcAg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Restrict xsaves()/xrstors() to independent states
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211015011538.608492174@linutronix.de>
References: <20211015011538.608492174@linutronix.de>
MIME-Version: 1.0
Message-ID: <163473748434.25758.13080896578721253318.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     f5daf836f292f795f9cf8f36e036bf47adcbc3a3
Gitweb:        https://git.kernel.org/tip/f5daf836f292f795f9cf8f36e036bf47adcbc3a3
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 15 Oct 2021 03:15:59 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 20 Oct 2021 15:27:26 +02:00

x86/fpu: Restrict xsaves()/xrstors() to independent states

These interfaces are really only valid for features which are independently
managed and not part of the task context state for various reasons.

Tighten the checks and adjust the misleading comments.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211015011538.608492174@linutronix.de
---
 arch/x86/kernel/fpu/xstate.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index c8def1b..5a76df9 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1175,20 +1175,14 @@ int copy_sigframe_from_user_to_xstate(struct xregs_state *xsave,
 	return copy_uabi_to_xstate(xsave, NULL, ubuf);
 }
 
-static bool validate_xsaves_xrstors(u64 mask)
+static bool validate_independent_components(u64 mask)
 {
 	u64 xchk;
 
 	if (WARN_ON_FPU(!cpu_feature_enabled(X86_FEATURE_XSAVES)))
 		return false;
-	/*
-	 * Validate that this is either a task->fpstate related component
-	 * subset or an independent one.
-	 */
-	if (mask & xfeatures_mask_independent())
-		xchk = ~xfeatures_mask_independent();
-	else
-		xchk = ~xfeatures_mask_all;
+
+	xchk = ~xfeatures_mask_independent();
 
 	if (WARN_ON_ONCE(!mask || mask & xchk))
 		return false;
@@ -1206,14 +1200,13 @@ static bool validate_xsaves_xrstors(u64 mask)
  * buffer should be zeroed otherwise a consecutive XRSTORS from that buffer
  * can #GP.
  *
- * The feature mask must either be a subset of the independent features or
- * a subset of the task->fpstate related features.
+ * The feature mask must be a subset of the independent features.
  */
 void xsaves(struct xregs_state *xstate, u64 mask)
 {
 	int err;
 
-	if (!validate_xsaves_xrstors(mask))
+	if (!validate_independent_components(mask))
 		return;
 
 	XSTATE_OP(XSAVES, xstate, (u32)mask, (u32)(mask >> 32), err);
@@ -1231,14 +1224,13 @@ void xsaves(struct xregs_state *xstate, u64 mask)
  * Proper usage is to restore the state which was saved with
  * xsaves() into @xstate.
  *
- * The feature mask must either be a subset of the independent features or
- * a subset of the task->fpstate related features.
+ * The feature mask must be a subset of the independent features.
  */
 void xrstors(struct xregs_state *xstate, u64 mask)
 {
 	int err;
 
-	if (!validate_xsaves_xrstors(mask))
+	if (!validate_independent_components(mask))
 		return;
 
 	XSTATE_OP(XRSTORS, xstate, (u32)mask, (u32)(mask >> 32), err);
