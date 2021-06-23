Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD5023B236B
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 00:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbhFWWO6 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 18:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbhFWWOB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 18:14:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF43C061152;
        Wed, 23 Jun 2021 15:09:39 -0700 (PDT)
Date:   Wed, 23 Jun 2021 22:09:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624486177;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7qWnDOQ0nP4h4dKTYWhClV79T6IEy/WWqx+INA7ZUNw=;
        b=LG03opxVQ4OpgBm/Q9muDThL3/fV3etD2KNwK58opzCf92kG64nHXp4Ki4T6XKrqtmNqtK
        2B9FzgatsusAKqxLZ8mGVc03GxVe48jBP8KjFcf2eti/7s7PhktYv2TM0lwZkr70/WgIgy
        9nmVbHub8M9SYApuknfCof42U0yK2/5sT2fZYWxQTGJDJZHbFs3/UCiMSbplPOnsJhDDQx
        k5on5l5+eXVn7gelVKbp7BY//vyia1lIDYoWnfFS7WV4vywbTCB5uTpbGKLSFV0NzT7/9s
        hxpSnMKMgA9YJvMqOWtKcJ6QtA6gJ4tMKQhi/Q/LfJ0iZQC6nLMUZgzwdXsx3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624486177;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7qWnDOQ0nP4h4dKTYWhClV79T6IEy/WWqx+INA7ZUNw=;
        b=5KJV+8LoCJ2gjWfAUJZR88mTN4Abr7QqcBYJY4cSi2bz+UB3IsYDEctbLCUly/tp0AmvDJ
        rCC8LijcrCRfVBAQ==
From:   "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Fail ptrace() requests that try to set
 invalid MXCSR values
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210623121452.613614842@linutronix.de>
References: <20210623121452.613614842@linutronix.de>
MIME-Version: 1.0
Message-ID: <162448617630.395.1897834764877302937.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     145e9e0d8c6fada4a40f9fc65b34658077874d9c
Gitweb:        https://git.kernel.org/tip/145e9e0d8c6fada4a40f9fc65b34658077874d9c
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Wed, 23 Jun 2021 14:01:40 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 23 Jun 2021 17:49:46 +02:00

x86/fpu: Fail ptrace() requests that try to set invalid MXCSR values

There is no benefit from accepting and silently changing an invalid MXCSR
value supplied via ptrace().  Instead, return -EINVAL on invalid input.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210623121452.613614842@linutronix.de
---
 arch/x86/kernel/fpu/regset.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
index f24ce87..5610f77 100644
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -63,8 +63,9 @@ int xfpregs_set(struct task_struct *target, const struct user_regset *regset,
 	if (ret)
 		return ret;
 
-	/* Mask invalid MXCSR bits (for historical reasons). */
-	newstate.mxcsr &= mxcsr_feature_mask;
+	/* Do not allow an invalid MXCSR value. */
+	if (newstate.mxcsr & ~mxcsr_feature_mask)
+		return -EINVAL;
 
 	fpu__prepare_write(fpu);
 
