Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4AB436559
	for <lists+linux-tip-commits@lfdr.de>; Thu, 21 Oct 2021 17:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbhJUPOp (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 21 Oct 2021 11:14:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60782 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbhJUPOo (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 21 Oct 2021 11:14:44 -0400
Date:   Thu, 21 Oct 2021 15:12:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634829147;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=955ZlGErv5h4fXeNwrdVy/Hko77v8BnoAAWeT1sBAqs=;
        b=nG3z45y8mj18z46Gj5AIczA0EqKw4Sn1YXL3io+qqmZOTHyQMdrLsXpd6q6gh1pgvd15iG
        vEaMSPX75IwxXVQHq24hNPndzWQTckag8gJtZiRnTZstWUAFubhXZ7qNr1qOLomWqRy8I8
        4F9+/FPN88Tv6ATeVZa40oLPGRtOf5nIYoZ79LZK0V55j+eL4GWXjT/iqMggGglA+zoNui
        pS+M/fjyg8XGX4E4JDBX4S+bkX06QrSmxosd0ceawfYHbYRD0ROSk7k80ITuzdf6QZH7vU
        /XJmP3S9L+4t8NmWE1XOWz9W0uIf1h6f34owskBpSOhQe65xLLkm+UOl7naKIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634829147;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=955ZlGErv5h4fXeNwrdVy/Hko77v8BnoAAWeT1sBAqs=;
        b=s/o6vwf7Pl3G8zrzDqH5CO+GtDT8iwsbKKXkWkaBTeMAcwxI1zHigJlYNZAMEQEUui73+b
        UXmSsFZoY1wat+BA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu/xstate: Use fpstate for xsave_to_user_sigframe()
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211013145323.077781448@linutronix.de>
References: <20211013145323.077781448@linutronix.de>
MIME-Version: 1.0
Message-ID: <163482914654.25758.9021208723737354687.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     0b2d39aa03574eb401cdfaac2f483a6f68173355
Gitweb:        https://git.kernel.org/tip/0b2d39aa03574eb401cdfaac2f483a6f68173355
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 13 Oct 2021 16:55:51 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 21 Oct 2021 14:04:46 +02:00

x86/fpu/xstate: Use fpstate for xsave_to_user_sigframe()

With dynamically enabled features the sigframe code must know the features
which are enabled for the task. Get them from fpstate.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211013145323.077781448@linutronix.de
---
 arch/x86/kernel/fpu/xstate.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index 24a1479..3e9eaf9 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -149,7 +149,7 @@ static inline int xsave_to_user_sigframe(struct xregs_state __user *buf)
 	 * internally, e.g. PKRU. That's user space ABI and also required
 	 * to allow the signal handler to modify PKRU.
 	 */
-	u64 mask = xfeatures_mask_uabi();
+	u64 mask = current->thread.fpu.fpstate->user_xfeatures;
 	u32 lmask = mask;
 	u32 hmask = mask >> 32;
 	int err;
