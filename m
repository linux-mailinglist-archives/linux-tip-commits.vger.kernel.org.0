Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A02833B2337
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 00:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbhFWWMu (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 18:12:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40250 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbhFWWMA (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 18:12:00 -0400
Date:   Wed, 23 Jun 2021 22:09:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624486179;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O1jK/uvgtsEF8s7CNbb0A1lNAQJLEKIS0orkdT++wt0=;
        b=hBanWkv6R77O+948FZp+mojTEIUPxB5ImPjdFRtqCeaueeEArtAa3Fpu4fW35VUovYH57n
        aOMAaSFFVLkPYRbNF7pzvDP9edt1hj5USws+OmzX1diF8pwo79pGXqtW7BjD93qosfgkGJ
        pkEbvSZj86b4fGETS/S9SLreuatK6hvhMFowsj5YKXx9V0uvRV4JoQ8t37mw8wGQ/1aem7
        4c9MUUYx0XYfALZN5V89AEVS6ddJ3LNh0Qa9kN9PnMjShaUL9MO/QUrkPzkEbMzXk70Os+
        m5ZsAVbqODTzlE7/JiH/GDTnv7xSqgeQMiYEvPW5DUR+hhH3Ibp0IugcY8L6Pg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624486179;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O1jK/uvgtsEF8s7CNbb0A1lNAQJLEKIS0orkdT++wt0=;
        b=rlXhNGkX7j9BxTT2RsIc0XqkWhuONZQGDZisQZnYOLmDS98mwbOYKH8T0ogS1wV07Yi1AB
        dv9lHHanZl2GlICw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Reject invalid MXCSR values in
 copy_kernel_to_xstate()
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210623121452.308388343@linutronix.de>
References: <20210623121452.308388343@linutronix.de>
MIME-Version: 1.0
Message-ID: <162448617894.395.180251854478791721.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     947f4947cf00ea1e6d319eb182c64ea51ba4de8d
Gitweb:        https://git.kernel.org/tip/947f4947cf00ea1e6d319eb182c64ea51ba4de8d
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 23 Jun 2021 14:01:37 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 23 Jun 2021 17:49:46 +02:00

x86/fpu: Reject invalid MXCSR values in copy_kernel_to_xstate()

Instead of masking out reserved bits, check them and reject the provided
state as invalid if not zero.

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210623121452.308388343@linutronix.de
---
 arch/x86/kernel/fpu/xstate.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 2b7b579..9cf84c5 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1154,6 +1154,19 @@ void copy_xstate_to_kernel(struct membuf to, struct xregs_state *xsave)
 		membuf_zero(&to, to.left);
 }
 
+static inline bool mxcsr_valid(struct xstate_header *hdr, const u32 *mxcsr)
+{
+	u64 mask = XFEATURE_MASK_FP | XFEATURE_MASK_SSE | XFEATURE_MASK_YMM;
+
+	/* Only check if it is in use */
+	if (hdr->xfeatures & mask) {
+		/* Reserved bits in MXCSR must be zero. */
+		if (*mxcsr & ~mxcsr_feature_mask)
+			return false;
+	}
+	return true;
+}
+
 /*
  * Convert from a ptrace standard-format kernel buffer to kernel XSAVE[S] format
  * and copy to the target thread. This is called from xstateregs_set().
@@ -1172,6 +1185,9 @@ int copy_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf)
 	if (validate_user_xstate_header(&hdr))
 		return -EINVAL;
 
+	if (!mxcsr_valid(&hdr, kbuf + offsetof(struct fxregs_state, mxcsr)))
+		return -EINVAL;
+
 	for (i = 0; i < XFEATURE_MAX; i++) {
 		u64 mask = ((u64)1 << i);
 
@@ -1202,9 +1218,6 @@ int copy_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf)
 	 */
 	xsave->header.xfeatures |= hdr.xfeatures;
 
-	/* mxcsr reserved bits must be masked to zero for historical reasons. */
-	xsave->i387.mxcsr &= mxcsr_feature_mask;
-
 	return 0;
 }
 
