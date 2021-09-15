Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12F6940C8D9
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Sep 2021 17:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238431AbhIOPv0 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 15 Sep 2021 11:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238447AbhIOPvH (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 15 Sep 2021 11:51:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12553C061793;
        Wed, 15 Sep 2021 08:49:38 -0700 (PDT)
Date:   Wed, 15 Sep 2021 15:49:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631720976;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W/rypC6pk5Uk2EYk7ngl7+gyXOA/wL8PMAWXrZrCVkc=;
        b=x7AmVuQ4EwBAkiBVlk89WIb/CtRJk3NpqDzCUmCQf6YrXT3B4kEkdCJ+xVzun7xaTPAkgs
        toGiIODPZBhbRosMAj6CznQH80hC5WCvTe/hBooQLdIWnX/UPbcR1ezPh7aig4+E0fbIp7
        9+k7GYhsXMUMeF8evidXUo0qdfIx9Pw9WKGWujsMrS4ZGZagNkZL9v4SxtHa6bMZsSrfdP
        rHCH3h9C0GbAvqQOFEPb2ANJBQqdlERqhNy+ovR6rRrYtPkLWmSPKWzhwT//EWnrUQqNKa
        j2+uBY1yX+ZMSI20S8qqJKkum0Z7NIcAF2kMrYvy7uQ1HhforR+xgJsuD4f4iQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631720976;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W/rypC6pk5Uk2EYk7ngl7+gyXOA/wL8PMAWXrZrCVkc=;
        b=C47mhw99KnILZ/bsDoNRsLkz9CEjwl3wC+7eQEf7wL7jxGT9v9VpRFYmFIyto8KQsM9mdM
        MkrxV3zVu4SP7CDw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86/xen: Mark cpu_bringup_and_idle() as dead_end_function
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        Miroslav Benes <mbenes@suse.cz>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210624095147.693801717@infradead.org>
References: <20210624095147.693801717@infradead.org>
MIME-Version: 1.0
Message-ID: <163172097591.25758.2170551014828183480.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     9af9dcf11bda3e2c0e24c1acaacb8685ad974e93
Gitweb:        https://git.kernel.org/tip/9af9dcf11bda3e2c0e24c1acaacb8685ad974e93
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 24 Jun 2021 11:41:00 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 15 Sep 2021 15:51:44 +02:00

x86/xen: Mark cpu_bringup_and_idle() as dead_end_function

The asm_cpu_bringup_and_idle() function is required to push the return
value on the stack in order to make ORC happy, but the only reason
objtool doesn't complain is because of a happy accident.

The thing is that asm_cpu_bringup_and_idle() doesn't return, so
validate_branch() never terminates and falls through to the next
function, which in the normal case is the hypercall_page. And that, as
it happens, is 4095 NOPs and a RET.

Make asm_cpu_bringup_and_idle() terminate on it's own, by making the
function it calls as a dead-end. This way we no longer rely on what
code happens to come after.

Fixes: c3881eb58d56 ("x86/xen: Make the secondary CPU idle tasks reliable")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Link: https://lore.kernel.org/r/20210624095147.693801717@infradead.org
---
 tools/objtool/check.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index e5947fb..0e3981d 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -173,6 +173,7 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"rewind_stack_do_exit",
 		"kunit_try_catch_throw",
 		"xen_start_kernel",
+		"cpu_bringup_and_idle",
 	};
 
 	if (!func)
