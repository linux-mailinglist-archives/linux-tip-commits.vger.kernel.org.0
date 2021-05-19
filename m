Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E67F388912
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 May 2021 10:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243775AbhESIKW (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 19 May 2021 04:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243292AbhESIKW (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 19 May 2021 04:10:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF6DC061760;
        Wed, 19 May 2021 01:09:02 -0700 (PDT)
Date:   Wed, 19 May 2021 08:09:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621411741;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ymD3Xd0Q56rVJqY1+dmNgamOmiGSxh5HDJ14KAGp/Uo=;
        b=UqdeRqEK/cXEdaRrM5dM1Ati5KtdfAePEVrFufquNKCHivjRcvnhpHohfb8i3busR7V06s
        STq1U/9JPN1VblqHR7tBK1eDfaEl0yEOzBk49hmcbF5C9ln7CH14xW+jAqDefBAcESw89A
        TvYQtAXg5udwwJ+Q4MkAnbmao09xcUJIR1zS0RL/ON8BrbcJtkmlgvC7ObToDAJK3rjr6I
        ge4tp2S5NeVY6/AC8GBO5ZDcTGbjt6thv8m0OSiMo7XrH6S/vSzcV8U+TFz52Q+TvmEzzs
        6CbgqAROLm0ujYkJFiBXmTQVLToJZCkYnuFi1DY0xBywDL2G58XKIw/wKMFAFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621411741;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ymD3Xd0Q56rVJqY1+dmNgamOmiGSxh5HDJ14KAGp/Uo=;
        b=bdKCc9O3Vtf8dI0JBuBxG+DVVuUgPWgSJFS1P8Gy5HBQzka8Tei+moYfRlOabirvSotNML
        UR3LR45lfqH6oiBw==
From:   "tip-bot2 for Leo Yan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] locking/lockdep: Correct calling tracepoints
Cc:     Leo Yan <leo.yan@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210512120937.90211-1-leo.yan@linaro.org>
References: <20210512120937.90211-1-leo.yan@linaro.org>
MIME-Version: 1.0
Message-ID: <162141174033.29796.3524122325407732983.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     89e70d5c583c55088faa2201d397ee30a15704aa
Gitweb:        https://git.kernel.org/tip/89e70d5c583c55088faa2201d397ee30a15704aa
Author:        Leo Yan <leo.yan@linaro.org>
AuthorDate:    Wed, 12 May 2021 20:09:37 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 18 May 2021 12:53:50 +02:00

locking/lockdep: Correct calling tracepoints

The commit eb1f00237aca ("lockdep,trace: Expose tracepoints") reverses
tracepoints for lock_contended() and lock_acquired(), thus the ftrace
log shows the wrong locking sequence that "acquired" event is prior to
"contended" event:

  <idle>-0       [001] d.s3 20803.501685: lock_acquire: 0000000008b91ab4 &sg_policy->update_lock
  <idle>-0       [001] d.s3 20803.501686: lock_acquired: 0000000008b91ab4 &sg_policy->update_lock
  <idle>-0       [001] d.s3 20803.501689: lock_contended: 0000000008b91ab4 &sg_policy->update_lock
  <idle>-0       [001] d.s3 20803.501690: lock_release: 0000000008b91ab4 &sg_policy->update_lock

This patch fixes calling tracepoints for lock_contended() and
lock_acquired().

Fixes: eb1f00237aca ("lockdep,trace: Expose tracepoints")
Signed-off-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210512120937.90211-1-leo.yan@linaro.org
---
 kernel/locking/lockdep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 48d736a..7641bd4 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -5736,7 +5736,7 @@ void lock_contended(struct lockdep_map *lock, unsigned long ip)
 {
 	unsigned long flags;
 
-	trace_lock_acquired(lock, ip);
+	trace_lock_contended(lock, ip);
 
 	if (unlikely(!lock_stat || !lockdep_enabled()))
 		return;
@@ -5754,7 +5754,7 @@ void lock_acquired(struct lockdep_map *lock, unsigned long ip)
 {
 	unsigned long flags;
 
-	trace_lock_contended(lock, ip);
+	trace_lock_acquired(lock, ip);
 
 	if (unlikely(!lock_stat || !lockdep_enabled()))
 		return;
