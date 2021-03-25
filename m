Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 101D7348E8C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Mar 2021 12:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbhCYLJN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 25 Mar 2021 07:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbhCYLIk (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 25 Mar 2021 07:08:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157AAC06175F;
        Thu, 25 Mar 2021 04:08:40 -0700 (PDT)
Date:   Thu, 25 Mar 2021 11:08:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616670518;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xNg4FYleL+r0sDNN8078foPUBcvMcbwC5+est4TqJsw=;
        b=tYj2uQtVSWmENkw8wW25U9YgLr0xyMITN+kftjSQ8HFQLANVvJNvq+LtUlQVq2JP5Lqlym
        785R3GHKtqIOv5pd4buH4uogf7d6TLdJ97wtnkmU/N4ZtTBHqwVmVu2ydgr7HWR8UTxHvr
        dUMwUjswXOc56aQlxLVYTE82Xd9XAOqPML3TdByOTiYf81aURF39hMJjc2eQAhFD4VxqdN
        Q/bMaM3IHEXm8+5eqzPEsI8iaoEOdxWHXxC9cp8K0nbmxln4rmJ6YXYejkvNCsfDXnCaOY
        P4x4LDXwzXeiV5A1UfBKM7rludj/WpLrUspubAe5ajgIlUhPEu/Azczsq7hetQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616670518;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xNg4FYleL+r0sDNN8078foPUBcvMcbwC5+est4TqJsw=;
        b=bslZ7v/TBklOBK/ZPlXSP+SwPSWHEwV4+lv68qBJBfdoLAQiixQIbjCTEBrwZVpghwiYxB
        NZ64g1xI7Vv6qpBA==
From:   "tip-bot2 for Rasmus Villemoes" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Stop using magic values in sched_dynamic_mode()
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210325004515.531631-1-linux@rasmusvillemoes.dk>
References: <20210325004515.531631-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Message-ID: <161667051806.398.14556471814285205703.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     7e1b2eb74928b2478fd0630ce6c664334b480d00
Gitweb:        https://git.kernel.org/tip/7e1b2eb74928b2478fd0630ce6c664334b480d00
Author:        Rasmus Villemoes <linux@rasmusvillemoes.dk>
AuthorDate:    Thu, 25 Mar 2021 01:45:14 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 25 Mar 2021 11:39:12 +01:00

sched/core: Stop using magic values in sched_dynamic_mode()

Use the enum names which are also what is used in the switch() in
sched_dynamic_update().

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: https://lore.kernel.org/r/20210325004515.531631-1-linux@rasmusvillemoes.dk
---
 kernel/sched/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3384ea7..1fe9d3f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5376,13 +5376,13 @@ static int preempt_dynamic_mode = preempt_dynamic_full;
 static int sched_dynamic_mode(const char *str)
 {
 	if (!strcmp(str, "none"))
-		return 0;
+		return preempt_dynamic_none;
 
 	if (!strcmp(str, "voluntary"))
-		return 1;
+		return preempt_dynamic_voluntary;
 
 	if (!strcmp(str, "full"))
-		return 2;
+		return preempt_dynamic_full;
 
 	return -1;
 }
