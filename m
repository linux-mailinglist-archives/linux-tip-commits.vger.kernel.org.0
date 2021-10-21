Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C25436891
	for <lists+linux-tip-commits@lfdr.de>; Thu, 21 Oct 2021 19:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbhJURDe (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 21 Oct 2021 13:03:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33162 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbhJURDd (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 21 Oct 2021 13:03:33 -0400
Date:   Thu, 21 Oct 2021 17:01:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634835676;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6IdmbozW4W2FIyBdb3DBh7kO6fSfw5CJYrO3gVCjwtA=;
        b=oMFiPxmHkITP7j3QM71bLXybDZJiM0oHDFFWD2+Cp5ygwna+QuDNgJd1A+FaO1J0CjIFKS
        oC5X3KwX9m6W2pzWMM/1vvYKrW2YFbWTAjfGWwJno1vB0GdEUtT7hgPgXJmyBs5Dd88LNC
        /OHlOpP2ctoC/CdB0w0P5SwXYBRlzxTvV8350nndeagPkXRiRNGE8qO9YP8SGwTUObE6cO
        p70dJOM78Krd1wVeC5bAKHCxpLf2u7B3q6HYqoIJUWlwzDLdxNCqPL1Cv5VrPpgKqwVm8C
        9iiBMsIt8oWRqSme2UfAoshBX69PudIB2ZGShqUIjGB0zXWwC1lhz924tiSrHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634835676;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6IdmbozW4W2FIyBdb3DBh7kO6fSfw5CJYrO3gVCjwtA=;
        b=TrfGbZNMPW738tC53FPH/XRQ6EgEzIjNEy7P3gv/V9E3FaHCkZu7HqFIMEALhkvK0FHuG2
        z7TWAFT+x6fztHAg==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Fix stack type check in vc_switch_off_ist()
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211021080833.30875-2-joro@8bytes.org>
References: <20211021080833.30875-2-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <163483567450.25758.4272839658974738251.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     5681981fb788281b09a4ea14d310d30b2bd89132
Gitweb:        https://git.kernel.org/tip/5681981fb788281b09a4ea14d310d30b2bd89132
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Thu, 21 Oct 2021 10:08:32 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 21 Oct 2021 18:24:44 +02:00

x86/sev: Fix stack type check in vc_switch_off_ist()

The value of STACK_TYPE_EXCEPTION_LAST points to the last _valid_
exception stack. Reflect that in the check done in the
vc_switch_off_ist() function.

Fixes: a13644f3a53de ("x86/entry/64: Add entry code for #VC handler")
Reported-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211021080833.30875-2-joro@8bytes.org
---
 arch/x86/kernel/traps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index a588009..f516f2b 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -709,7 +709,7 @@ asmlinkage __visible noinstr struct pt_regs *vc_switch_off_ist(struct pt_regs *r
 	stack = (unsigned long *)sp;
 
 	if (!get_stack_info_noinstr(stack, current, &info) || info.type == STACK_TYPE_ENTRY ||
-	    info.type >= STACK_TYPE_EXCEPTION_LAST)
+	    info.type > STACK_TYPE_EXCEPTION_LAST)
 		sp = __this_cpu_ist_top_va(VC2);
 
 sync:
