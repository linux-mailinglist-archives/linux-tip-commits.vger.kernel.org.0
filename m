Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFAD3BB845
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Jul 2021 09:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhGEH4N (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 5 Jul 2021 03:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbhGEH4N (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 5 Jul 2021 03:56:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96239C061762;
        Mon,  5 Jul 2021 00:53:36 -0700 (PDT)
Date:   Mon, 05 Jul 2021 07:53:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625471615;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uo1icpZAxLgabDbaB47PzuQ0YlkYK8nrC3wnda1q7Ug=;
        b=Em2SNPgMWRa3GxE9XBGfc3n1iM/3NEB0cYmJF6ewyTHl7aYQpwpaJUN77rV47OUEF7OQ/6
        8IPrpdmBBkjq22sv8PvOttHwHK0I4ayHc7upF5X6c0z8gxPXwiXoGpjVtgSS3totDCoakf
        pYyc1TfsA8QmMrRphG7PwAbFFHpIrz1jwwCZvQQaVlgWBkqCkcAxRKPuSWMiFRH3mSJ5nq
        OM20Yo/wEMfS/2R6BmtL+7S8l68HKLogTorAY8m55nEx6v0uiOtMgauU+fFbO4HRKoPwnK
        R2BDh0nI/lZGqNFa10sLn1e/t2tvRFqMm+URMxlnfkPQHQDK85TYAJWqj2cvsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625471615;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uo1icpZAxLgabDbaB47PzuQ0YlkYK8nrC3wnda1q7Ug=;
        b=fWmBEBhCuo+knUbZrAc4McOxTSxoJklCfP7/CUCqkGwgiUy22X5sUlyX6SYC2OIcVPfEKx
        e2bC7jWzemrdfSDg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] jump_label: Fix jump_label_text_reserved() vs __init
Cc:     kernel test robot <oliver.sang@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210628113045.045141693@infradead.org>
References: <20210628113045.045141693@infradead.org>
MIME-Version: 1.0
Message-ID: <162547161442.395.12492462839642337254.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     b1487a958a6dd1f39f6ccd97c915bf132535cd1a
Gitweb:        https://git.kernel.org/tip/b1487a958a6dd1f39f6ccd97c915bf132535cd1a
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 28 Jun 2021 13:24:10 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 02 Jul 2021 15:58:26 +02:00

jump_label: Fix jump_label_text_reserved() vs __init

It turns out that jump_label_text_reserved() was reporting __init text
as being reserved past the time when the __init text was freed and
re-used.

For a long time, this resulted in, at worst, not being able to kprobe
text that happened to land at the re-used address. However a recent
commit e7bf1ba97afd ("jump_label, x86: Emit short JMP") made it a
fatal mistake because it now needs to read the instruction in order to
determine the conflict -- an instruction that's no longer there.

Fixes: 4c3ef6d79328 ("jump label: Add jump_label_text_reserved() to reserve jump points")
Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Link: https://lore.kernel.org/r/20210628113045.045141693@infradead.org
---
 kernel/jump_label.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index bdb0681..b156e15 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -316,14 +316,16 @@ static int addr_conflict(struct jump_entry *entry, void *start, void *end)
 }
 
 static int __jump_label_text_reserved(struct jump_entry *iter_start,
-		struct jump_entry *iter_stop, void *start, void *end)
+		struct jump_entry *iter_stop, void *start, void *end, bool init)
 {
 	struct jump_entry *iter;
 
 	iter = iter_start;
 	while (iter < iter_stop) {
-		if (addr_conflict(iter, start, end))
-			return 1;
+		if (init || !jump_entry_is_init(iter)) {
+			if (addr_conflict(iter, start, end))
+				return 1;
+		}
 		iter++;
 	}
 
@@ -562,7 +564,7 @@ static int __jump_label_mod_text_reserved(void *start, void *end)
 
 	ret = __jump_label_text_reserved(mod->jump_entries,
 				mod->jump_entries + mod->num_jump_entries,
-				start, end);
+				start, end, mod->state == MODULE_STATE_COMING);
 
 	module_put(mod);
 
@@ -788,8 +790,9 @@ early_initcall(jump_label_init_module);
  */
 int jump_label_text_reserved(void *start, void *end)
 {
+	bool init = system_state < SYSTEM_RUNNING;
 	int ret = __jump_label_text_reserved(__start___jump_table,
-			__stop___jump_table, start, end);
+			__stop___jump_table, start, end, init);
 
 	if (ret)
 		return ret;
