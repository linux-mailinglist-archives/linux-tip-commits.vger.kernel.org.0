Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A32B3BB843
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Jul 2021 09:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbhGEH4N (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 5 Jul 2021 03:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbhGEH4M (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 5 Jul 2021 03:56:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB41CC061574;
        Mon,  5 Jul 2021 00:53:35 -0700 (PDT)
Date:   Mon, 05 Jul 2021 07:53:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625471614;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NssxjOugS+kx/aLFEb2XQX7x2ja8kY680/5dab28Vd0=;
        b=kiS4U2ZJ2hUXj+auAoHf9pYjh1L+edbCnRZTQx2vd9BHKJ+DctPCG7FFa+k/1TJ+mOc6ns
        ZSMjBHjt6sTZcxx4KWBo8er2YiOoXLoujRWiAZyMQ4/5ORyyn2L+Y/n8znBuzYangSjane
        UJiQ3ChZFz5OdWQCtEDPeraYobvDmmXc+DD0KQFIJOE0FhQZ5oBhYCIfgOoxcB+2IcnHJY
        Yet3sp3N1dzPaXJIc6cd1me+80NEI/Sog9nUM9fVl17nfEUUuuAz8A95+N7LH3CPgMrL3G
        pR35Va5rjQbPYCupjhNAEsHjI4c4h3c2f1eLAZRhv0nZx4GTSUa1DolnNqZJ0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625471614;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NssxjOugS+kx/aLFEb2XQX7x2ja8kY680/5dab28Vd0=;
        b=y4pnfvOcZk0PhvD0kqegHSqj27YMjJUlTcXHFHg5X6hvanbJhOEcwxXsLB9slk4DCBzIh7
        zfrLZ9KziQ0/h9DA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] static_call: Fix static_call_text_reserved() vs __init
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210628113045.106211657@infradead.org>
References: <20210628113045.106211657@infradead.org>
MIME-Version: 1.0
Message-ID: <162547161380.395.9445788023030500733.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     8e62ef8c9922d7deaa2d92dc30a87ba6f81fdee3
Gitweb:        https://git.kernel.org/tip/8e62ef8c9922d7deaa2d92dc30a87ba6f81fdee3
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 28 Jun 2021 13:24:11 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 02 Jul 2021 15:58:27 +02:00

static_call: Fix static_call_text_reserved() vs __init

It turns out that static_call_text_reserved() was reporting __init
text as being reserved past the time when the __init text was freed
and re-used.

This is mostly harmless and will at worst result in refusing a kprobe.

Fixes: 6333e8f73b83 ("static_call: Avoid kprobes on inline static_call()s")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Link: https://lore.kernel.org/r/20210628113045.106211657@infradead.org
---
 kernel/static_call.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/kernel/static_call.c b/kernel/static_call.c
index 723fcc9..43ba0b1 100644
--- a/kernel/static_call.c
+++ b/kernel/static_call.c
@@ -292,13 +292,15 @@ static int addr_conflict(struct static_call_site *site, void *start, void *end)
 
 static int __static_call_text_reserved(struct static_call_site *iter_start,
 				       struct static_call_site *iter_stop,
-				       void *start, void *end)
+				       void *start, void *end, bool init)
 {
 	struct static_call_site *iter = iter_start;
 
 	while (iter < iter_stop) {
-		if (addr_conflict(iter, start, end))
-			return 1;
+		if (init || !static_call_is_init(iter)) {
+			if (addr_conflict(iter, start, end))
+				return 1;
+		}
 		iter++;
 	}
 
@@ -324,7 +326,7 @@ static int __static_call_mod_text_reserved(void *start, void *end)
 
 	ret = __static_call_text_reserved(mod->static_call_sites,
 			mod->static_call_sites + mod->num_static_call_sites,
-			start, end);
+			start, end, mod->state == MODULE_STATE_COMING);
 
 	module_put(mod);
 
@@ -459,8 +461,9 @@ static inline int __static_call_mod_text_reserved(void *start, void *end)
 
 int static_call_text_reserved(void *start, void *end)
 {
+	bool init = system_state < SYSTEM_RUNNING;
 	int ret = __static_call_text_reserved(__start_static_call_sites,
-			__stop_static_call_sites, start, end);
+			__stop_static_call_sites, start, end, init);
 
 	if (ret)
 		return ret;
