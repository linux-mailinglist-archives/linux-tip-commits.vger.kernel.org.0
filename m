Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E20683B15A2
	for <lists+linux-tip-commits@lfdr.de>; Wed, 23 Jun 2021 10:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhFWIVb (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 04:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbhFWIV3 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 04:21:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5492C061574;
        Wed, 23 Jun 2021 01:19:12 -0700 (PDT)
Date:   Wed, 23 Jun 2021 08:19:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624436349;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DkvabNEdqRRQ5MQHfB3jeoQXaXljO2p1Jo8CrAOOHyg=;
        b=2IVfpppJALoRf0QYsvZ0VkBrI/fbKweUWi5lXyKjQ718bLo6xcsOJsZX6N8XDWZPqf/ILp
        WEgjl6yTeU14nrC9QwtDfAkC2a3Ml6USBWTI+ARo8Zz/5FmlzsQ/gI3umcr4Zw7KF53nD9
        LysV8sMsFTFo3U6CHZJcz9oRlNVXhaW9S2qU7zoR5hqjeIPBmDHes79ugPB5cSZf6JgYJ7
        Ch9kraiALigt5xliMuFys2h5M9DhBqCkQlrP1u/SM6QMpa2xYH8PrkTUIGfLQVDB4HF5OL
        8wjdW+REtN2Puz3ZwJydCLQeY8J+aHfMd/VM420wVvkZFtHaBRGiQDtRyumSmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624436349;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DkvabNEdqRRQ5MQHfB3jeoQXaXljO2p1Jo8CrAOOHyg=;
        b=xcwIQKLsKRlKfx5yBuUa5D7SwO1isy6MC0DhUVi8fWSLNZTD6KG75SUCbJWlmiAh1Skfou
        8zy2H3HOehbhrCBg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] lockdep: Fix wait-type for empty stack
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210617190313.256987481@infradead.org>
References: <20210617190313.256987481@infradead.org>
MIME-Version: 1.0
Message-ID: <162443634860.395.11121182103864508829.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     f8b298cc39f0619544c607eaef09fd0b2afd10f3
Gitweb:        https://git.kernel.org/tip/f8b298cc39f0619544c607eaef09fd0b2afd10f3
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 17 Jun 2021 20:57:18 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 22 Jun 2021 16:42:08 +02:00

lockdep: Fix wait-type for empty stack

Even the very first lock can violate the wait-context check, consider
the various IRQ contexts.

Fixes: de8f5e4f2dc1 ("lockdep: Introduce wait-type checks")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Joerg Roedel <jroedel@suse.de>
Link: https://lore.kernel.org/r/20210617190313.256987481@infradead.org
---
 kernel/locking/lockdep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 6ff1e84..0584b20 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -4688,7 +4688,7 @@ static int check_wait_context(struct task_struct *curr, struct held_lock *next)
 	u8 curr_inner;
 	int depth;
 
-	if (!curr->lockdep_depth || !next_inner || next->trylock)
+	if (!next_inner || next->trylock)
 		return 0;
 
 	if (!next_outer)
