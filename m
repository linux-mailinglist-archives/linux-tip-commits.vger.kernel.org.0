Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34EE03B32C1
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 17:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbhFXPnY (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 24 Jun 2021 11:43:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45664 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbhFXPnX (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 24 Jun 2021 11:43:23 -0400
Date:   Thu, 24 Jun 2021 15:41:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624549263;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NzA/hd3X5EAN6+Q/fB2qSxvWVQFzwGmUDPOJni4vE38=;
        b=q83DmRDKvmqXoRm2Za8PRgMlAOTHm8F8IvKTwv042D6tRw5UavR1wyqrHQi6FzpeB9yQIV
        GJlWmdYyU6orcyQMiXos5BJB5u8iTmmP+2r1GxJLN1AqnYnCd0SYqFPcdCM31ytx4j4PXq
        AyMIdSkjlCFNj0bSe5Wy/daU8VYE2NGS7FP86MDqXPyVnbQOq7pT5XtMJfDcolz9V3pTkF
        gKTVPDphOatm6Gxv0fYdb6cM0uvCE+iuauPCSSLE/nZhV8HSWHgO0/Xx4qTlehQlShJUO0
        NWHgzNOk/t3hZCvxMcUyQgXXk+YwXCJDtARx5/f4m64L+U7oH1Axr7zIrwPshg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624549263;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NzA/hd3X5EAN6+Q/fB2qSxvWVQFzwGmUDPOJni4vE38=;
        b=pF5QzB61S0ImOU/ErduuinkoY/gCc+VePXFj5LdExwmGKpjr2M16/EtMvSggLb5QkTZTKo
        q5y2ZGvX43l0q9BA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu/xstate: Clear xstate header in
 copy_xstate_to_uabi_buf() again
Cc:     kernel test robot <oliver.sang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <875yy3wb8h.ffs@nanos.tec.linutronix.de>
References: <875yy3wb8h.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Message-ID: <162454926209.395.6930680604405562644.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     93c2cdc975aab53c222472c5b96c2d41dbeb350c
Gitweb:        https://git.kernel.org/tip/93c2cdc975aab53c222472c5b96c2d41dbeb350c
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 24 Jun 2021 17:09:18 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 24 Jun 2021 17:19:51 +02:00

x86/fpu/xstate: Clear xstate header in copy_xstate_to_uabi_buf() again

The change which made copy_xstate_to_uabi_buf() usable for
[x]fpregs_get() removed the zeroing of the header which means the
header, which is copied to user space later, contains except for the
xfeatures member, random stack content.

Add the memset() back to zero it before usage.

Fixes: eb6f51723f03 ("x86/fpu: Make copy_xstate_to_kernel() usable for [x]fpregs_get()")
Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/875yy3wb8h.ffs@nanos.tec.linutronix.de
---
 arch/x86/kernel/fpu/xstate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 21a10a6..c8def1b 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -982,6 +982,7 @@ void copy_xstate_to_uabi_buf(struct membuf to, struct task_struct *tsk,
 	unsigned int zerofrom;
 	int i;
 
+	memset(&header, 0, sizeof(header));
 	header.xfeatures = xsave->header.xfeatures;
 
 	/* Mask out the feature bits depending on copy mode */
