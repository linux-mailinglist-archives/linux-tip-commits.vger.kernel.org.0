Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC16932FA53
	for <lists+linux-tip-commits@lfdr.de>; Sat,  6 Mar 2021 12:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhCFLzT (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 6 Mar 2021 06:55:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbhCFLyi (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 6 Mar 2021 06:54:38 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180D3C06174A;
        Sat,  6 Mar 2021 03:54:38 -0800 (PST)
Date:   Sat, 06 Mar 2021 11:54:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615031676;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rlGiB/Z9LS+RnYSZ3DG5HYgIlWJMtXloGMbgyI4YQRI=;
        b=TWO+DF2msmIGBLZ5wb1vq7Apvb5P7YHEf1j++UPY9DDZncn2voHsU2MdUXsLA4XsjfUEz8
        ESyxphjOj/WNyKAiOFjPZdkrTyBYf/5m7SjiE9U5PFk5ahEQHbKNVK05T+UGOf80JsJs7H
        KqzsLu2z1zjqRzWhc9mPPGn42cF9KVGoos2k2lu2KNq4gVvlHLDwsLanb0sdSmM0YxZGPn
        hNbKcps+TCQLtFLBnqaiK4c+qjlw+auiP449bRrLJuk/FoR/d315O3eUHKsUfqhy3ePVZj
        AVuhgEUwbxSnYNWlDFU9BUgxxUBfXb6Sb3ddyN4YycWfjh8UwrXi0JieTJEDXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615031676;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rlGiB/Z9LS+RnYSZ3DG5HYgIlWJMtXloGMbgyI4YQRI=;
        b=U+jB8Bvm9SouReSLPiMzuURaES63H2rT2wxvxzxY4CaO4yxzTcgD/mGEFh/Ugw0xTkzaGj
        rlLiBOVZCpV1DRDA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] static_call: Fix the module key fixup
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210225220351.GE4746@worktop.programming.kicks-ass.net>
References: <20210225220351.GE4746@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <161503167603.398.10804742889650750463.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     50bf8080a94d171e843fc013abec19d8ab9f50ae
Gitweb:        https://git.kernel.org/tip/50bf8080a94d171e843fc013abec19d8ab9f50ae
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 25 Feb 2021 23:03:51 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 06 Mar 2021 12:49:08 +01:00

static_call: Fix the module key fixup

Provided the target address of a R_X86_64_PC32 relocation is aligned,
the low two bits should be invariant between the relative and absolute
value.

Turns out the address is not aligned and things go sideways, ensure we
transfer the bits in the absolute form when fixing up the key address.

Fixes: 73f44fe19d35 ("static_call: Allow module use without exposing static_call_key")
Reported-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
