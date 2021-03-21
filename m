Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53B01343215
	for <lists+linux-tip-commits@lfdr.de>; Sun, 21 Mar 2021 12:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbhCULFx (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 21 Mar 2021 07:05:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47614 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbhCULFh (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 21 Mar 2021 07:05:37 -0400
Date:   Sun, 21 Mar 2021 11:05:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616324736;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wIhJq0AmOs3TpVpI379NKyT/XsKDxqnjt04siXeuItA=;
        b=wH+viTmwr0tEVWMgghmWhfSduegR+55NHJNUuah1BIModU8eX2GjZ4Hd+h5AazxADxkY10
        KJXlCusrRELn8DZZzgohGk47cAhiDQ2YR7tyZ/aEmKfnpDr5mS+3lu4L3iFikcRGOGmwBs
        HATagJnTLwgKLEnrTWzlf5GLs20iA5UzjegXrMiVEZrNEpJm2fdaMMO+VJFoK8nK/Ik8hd
        KunZGcZgLIrsQlAf+5Lqq3rMD/XOAwhszKOZsiZyC/CcSbe5fCVl8kZd7+oEBEYOqR+U0v
        cWOsMpeHXyB+zLiMBRupJxZYOjGxgWf6z+hyS2gE+inMiC1nQIOpPgDh/3F4OQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616324736;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wIhJq0AmOs3TpVpI379NKyT/XsKDxqnjt04siXeuItA=;
        b=ZFSLHQrcABJzKUYEvXpIfV/4BOQ5tzwXEeA6elaDZ2ifSIH5Cu5FKHJRw6vJfmi0P56+RW
        WLr8+Immkk/vgFDg==
From:   "tip-bot2 for Tetsuo Handa" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] lockdep: Add a missing initialization hint to the
 "INFO: Trying to register non-static key" message
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210321064913.4619-1-penguin-kernel@I-love.SAKURA.ne.jp>
References: <20210321064913.4619-1-penguin-kernel@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Message-ID: <161632473539.398.8522082432141572296.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     3a85969e9d912d5dd85362ee37b5f81266e00e77
Gitweb:        https://git.kernel.org/tip/3a85969e9d912d5dd85362ee37b5f81266e00e77
Author:        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
AuthorDate:    Sun, 21 Mar 2021 15:49:13 +09:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 21 Mar 2021 11:59:57 +01:00

lockdep: Add a missing initialization hint to the "INFO: Trying to register non-static key" message

Since this message is printed when dynamically allocated spinlocks (e.g.
kzalloc()) are used without initialization (e.g. spin_lock_init()),
suggest to developers to check whether initialization functions for objects
were called, before making developers wonder what annotation is missing.

[ mingo: Minor tweaks to the message. ]

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210321064913.4619-1-penguin-kernel@I-love.SAKURA.ne.jp
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/lockdep.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index c6d0c1d..c30eb88 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -930,7 +930,8 @@ static bool assign_lock_key(struct lockdep_map *lock)
 		/* Debug-check: all keys must be persistent! */
 		debug_locks_off();
 		pr_err("INFO: trying to register non-static key.\n");
-		pr_err("the code is fine but needs lockdep annotation.\n");
+		pr_err("The code is fine but needs lockdep annotation, or maybe\n");
+		pr_err("you didn't initialize this object before use?\n");
 		pr_err("turning off the locking correctness validator.\n");
 		dump_stack();
 		return false;
