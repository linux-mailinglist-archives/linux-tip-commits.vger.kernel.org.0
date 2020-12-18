Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD24C2DE729
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Dec 2020 17:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729663AbgLRQDU (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 18 Dec 2020 11:03:20 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53274 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728576AbgLRQDQ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 18 Dec 2020 11:03:16 -0500
Date:   Fri, 18 Dec 2020 16:02:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1608307353;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ak9hDsFJ30HPWeVTqWXDGAjW8p7OnzScgieDojIWkyA=;
        b=oCB7NvcyIrAvShyql31Wo9WaoBsLqn4Qhkt94SPDVWlkdkIAdkKtT/9Oe4uMxpA2t1STlv
        wSAMoDAetWJCh9d/7H1RMtjavfUCP2oFFvFhQNrtPxOJlbtgcG2j2PIpqfoMeU6EUTHXZr
        sKQNqn4svwa7e8IlT8a1y/IimELBP3ePif8mYYl/3VXCkm2WYxvN+RgV4JHqlrz8WdrY59
        rk4hWFjdaE6phcCNviYh+9NYSXxWm/NnWll0D6D2F/iWQ7HAg4nvM9UoY4ouuh/AKnbvP1
        KZbAaLK7lOKmu1k131APsSwbK6BNX1lVSbKgOoqhqjzbeRO7ohIb6pbBY8cpeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1608307353;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ak9hDsFJ30HPWeVTqWXDGAjW8p7OnzScgieDojIWkyA=;
        b=S00G7R8l8dO2A2KW+kDXOiCDOhetsUoKE/yWzobnhSs8sSRCimdwzjyOJ3S37o18DvBdAr
        ltTzaZE6PDtgwKBg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] jump_label: Fix usage in module __init
Cc:     Dexuan Cui <decui@microsoft.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jessica Yu <jeyu@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201216135435.GV3092@hirez.programming.kicks-ass.net>
References: <20201216135435.GV3092@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <160830735347.22759.2891847784480992331.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     55d2eba8e7cd439c11cdb204898c2d384227629b
Gitweb:        https://git.kernel.org/tip/55d2eba8e7cd439c11cdb204898c2d384227629b
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 16 Dec 2020 12:21:36 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 18 Dec 2020 16:53:12 +01:00

jump_label: Fix usage in module __init

When the static_key is part of the module, and the module calls
static_key_inc/enable() from it's __init section *AND* has a
static_branch_*() user in that very same __init section, things go
wobbly.

If the static_key lives outside the module, jump_label_add_module()
would append this module's sites to the key and jump_label_update()
would take the static_key_linked() branch and all would be fine.

If all the sites are outside of __init, then everything will be fine
too.

However, when all is aligned just as described above,
jump_label_update() calls __jump_label_update(.init = false) and we'll
not update sites in __init text.

Fixes: 19483677684b ("jump_label: Annotate entries that operate on __init code earlier")
Reported-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Tested-by: Jessica Yu <jeyu@kernel.org>
Link: https://lkml.kernel.org/r/20201216135435.GV3092@hirez.programming.kicks-ass.net
---
 kernel/jump_label.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index 015ef90..c6a39d6 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -793,6 +793,7 @@ int jump_label_text_reserved(void *start, void *end)
 static void jump_label_update(struct static_key *key)
 {
 	struct jump_entry *stop = __stop___jump_table;
+	bool init = system_state < SYSTEM_RUNNING;
 	struct jump_entry *entry;
 #ifdef CONFIG_MODULES
 	struct module *mod;
@@ -804,15 +805,16 @@ static void jump_label_update(struct static_key *key)
 
 	preempt_disable();
 	mod = __module_address((unsigned long)key);
-	if (mod)
+	if (mod) {
 		stop = mod->jump_entries + mod->num_jump_entries;
+		init = mod->state == MODULE_STATE_COMING;
+	}
 	preempt_enable();
 #endif
 	entry = static_key_entries(key);
 	/* if there are no users, entry can be NULL */
 	if (entry)
-		__jump_label_update(key, entry, stop,
-				    system_state < SYSTEM_RUNNING);
+		__jump_label_update(key, entry, stop, init);
 }
 
 #ifdef CONFIG_STATIC_KEYS_SELFTEST
