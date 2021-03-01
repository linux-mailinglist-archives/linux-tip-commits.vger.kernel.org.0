Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC4E9327BC0
	for <lists+linux-tip-commits@lfdr.de>; Mon,  1 Mar 2021 11:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbhCAKRI (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 1 Mar 2021 05:17:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232578AbhCAKQw (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 1 Mar 2021 05:16:52 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01816C06174A;
        Mon,  1 Mar 2021 02:16:11 -0800 (PST)
Date:   Mon, 01 Mar 2021 10:16:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614593769;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J0XQJbSpre/Yyi1s+ii91sER73lWBRJ1YQUJomumI50=;
        b=BjLbF2Jx64mg8XJ0lrdhJaOEuP9fC4xpL/wM3ZPNNLZ75i5ZGbIMd7zcwP9Hp+ao/ul1pF
        oCl+wbyDDiFIFNUY6VkvQ5kVTEmjs1he/K0juQfxKGiP8P8q0g87n8cbb9s+f7o2Rwap5p
        Qfam3900EdzMCclj6CTWCRRTDIwxYYmPjA6uBRCY8fBAs/hCdoDInh0m7RYSMwpSUA7ici
        n6wj265Ki65FLCDjcNaelqYFeFT32BNfPmFsPbfX+ENgVXhckM4sQS8bM2AtBAUKIG/O0b
        W/6ptBmhB3k109yE5S/NxyeQQ0uOjN5V1AeI6UkQVuxDagq/hx3BGUGiZ4WEEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614593769;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J0XQJbSpre/Yyi1s+ii91sER73lWBRJ1YQUJomumI50=;
        b=+5fjfb2ONEFHQGKQxeVdIvsAVnffYrp9R/zjtUL2wQyRjKh3qe33P5YLQJtjDI7gd1z5gx
        w71TR3eJiMGiGtBg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] static_call: Fix the module key fixup
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210225220351.GE4746@worktop.programming.kicks-ass.net>
References: <20210225220351.GE4746@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <161459376868.20312.9858096297457613530.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     8b97c027dfe4ba195be08fd0e18f716005763b8a
Gitweb:        https://git.kernel.org/tip/8b97c027dfe4ba195be08fd0e18f716005763b8a
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 25 Feb 2021 23:03:51 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 01 Mar 2021 11:02:10 +01:00

static_call: Fix the module key fixup

Provided the target address of a R_X86_64_PC32 relocation is aligned,
the low two bits should be invariant between the relative and absolute
value.

Turns out the address is not aligned and things go sideways, ensure we
transfer the bits in the absolute form when fixing up the key address.

Fixes: 73f44fe19d35 ("static_call: Allow module use without exposing static_call_key")
Reported-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Link: https://lkml.kernel.org/r/20210225220351.GE4746@worktop.programming.kicks-ass.net
---
 kernel/static_call.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/static_call.c b/kernel/static_call.c
index 6906c6e..ae82529 100644
--- a/kernel/static_call.c
+++ b/kernel/static_call.c
@@ -349,7 +349,8 @@ static int static_call_add_module(struct module *mod)
 	struct static_call_site *site;
 
 	for (site = start; site != stop; site++) {
-		unsigned long addr = (unsigned long)static_call_key(site);
+		unsigned long s_key = (long)site->key + (long)&site->key;
+		unsigned long addr = s_key & ~STATIC_CALL_SITE_FLAGS;
 		unsigned long key;
 
 		/*
@@ -373,8 +374,8 @@ static int static_call_add_module(struct module *mod)
 			return -EINVAL;
 		}
 
-		site->key = (key - (long)&site->key) |
-			    (site->key & STATIC_CALL_SITE_FLAGS);
+		key |= s_key & STATIC_CALL_SITE_FLAGS;
+		site->key = key - (long)&site->key;
 	}
 
 	return __static_call_init(mod, start, stop);
