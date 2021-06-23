Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71B5C3B2342
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 00:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbhFWWNN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 18:13:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40042 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbhFWWMK (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 18:12:10 -0400
Date:   Wed, 23 Jun 2021 22:09:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624486181;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eM947Mnxh2T2LEUJpIe9ci9ZaDWpqmrGs3JchySzvgY=;
        b=ORgk+XUrrnwk3rqaQpP1YcXplL/nIE18FlixkphRiPioIpgp206EN/+3Lc1ErR5IPBDXDd
        KLutHtKK/nxPR1SRbV+MYXteSSvF/gsT5hRWTmzZV3HKLfthmkDnZKh1BE6YUK+KVRCZ79
        7HNI0Tbz5UqHryu+53QOYVP8yqiZWYGZfDtV3UomDx5db1+C+TGPG30spxwI0MOFVJOiUp
        ArHLCYQTSH+SvnlYPv34Fh7IolDrJTlxJflRYUgd7iGn8r4nXOAyyLYnfN0EgkaJsrxu1J
        5OAJaHJYB03eJQoKFxdaRtOKrdu0eQZm0ffWgkT9fQPdSFdHqUkNYsgOQKrEUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624486181;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eM947Mnxh2T2LEUJpIe9ci9ZaDWpqmrGs3JchySzvgY=;
        b=0DPVibBK1sbxdfqd6Nyc6bZdmaSArdeYonSbIzqRGgD+G5LRwEt/MOZ8GnemALCj4gr/5V
        +qYoBy+7SInEsuBg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Limit xstate copy size in xstateregs_set()
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210623121452.120741557@linutronix.de>
References: <20210623121452.120741557@linutronix.de>
MIME-Version: 1.0
Message-ID: <162448618055.395.13063574411215370598.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     07d6688b22e09be465652cf2da0da6bf86154df6
Gitweb:        https://git.kernel.org/tip/07d6688b22e09be465652cf2da0da6bf86154df6
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 23 Jun 2021 14:01:35 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 23 Jun 2021 17:49:46 +02:00

x86/fpu: Limit xstate copy size in xstateregs_set()

If the count argument is larger than the xstate size, this will happily
copy beyond the end of xstate.

Fixes: 91c3dba7dbc1 ("x86/fpu/xstate: Fix PTRACE frames for XSAVES")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Reviewed-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210623121452.120741557@linutronix.de
---
 arch/x86/kernel/fpu/regset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
index c413756..6bb8744 100644
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -117,7 +117,7 @@ int xstateregs_set(struct task_struct *target, const struct user_regset *regset,
 	/*
 	 * A whole standard-format XSAVE buffer is needed:
 	 */
-	if ((pos != 0) || (count < fpu_user_xstate_size))
+	if (pos != 0 || count != fpu_user_xstate_size)
 		return -EFAULT;
 
 	xsave = &fpu->state.xsave;
