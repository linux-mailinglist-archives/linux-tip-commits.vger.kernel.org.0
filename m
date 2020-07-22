Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0380E229495
	for <lists+linux-tip-commits@lfdr.de>; Wed, 22 Jul 2020 11:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731332AbgGVJMr (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 22 Jul 2020 05:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729026AbgGVJM1 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 22 Jul 2020 05:12:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7327CC0619DC;
        Wed, 22 Jul 2020 02:12:27 -0700 (PDT)
Date:   Wed, 22 Jul 2020 09:12:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595409145;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ykLDGFVhG6I+aI6ataOFkWlYXVaQWp8dYyZT5K4M72Y=;
        b=JKien3SnUjbjE8eD2rJBNPJ+5dgXUeVg/BPRcdE97B14M96qHvkSKcMiL162gt6FO8s3wz
        679dkM6W82/ekM4cUNZ4dRP0Cw8MY3GvE8bk3YPUiN/y6AmDqAfSZ4vU0vGnS8P2/4YwHP
        X2a2cXm/z1DWsB2eVwePMPYvWOHjD5zO6JcnCNgcyaEYN4Wg9iTEgXYq8AnlWNAoDG3TD+
        SGAMbzepHuefdK4mh6WGapZj7vOiTOnSj2j0/3NdvEiRywnOkp+cPtKyYh3LgieXW1PxAU
        TF8mzNeuzsq94ZWV59m1g4nsuyS3aRGHgaRnwPkDSaYUYknAxhxiDo1+KTQKlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595409145;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ykLDGFVhG6I+aI6ataOFkWlYXVaQWp8dYyZT5K4M72Y=;
        b=3IyktS6BgqIYIel1atdLtxPYu81eB4fjvIU6d1JJ3sRZ7gB0eJW7UMHFPnYqJwId/zbvDd
        QmeIlJ1fNuFgw/Cw==
From:   "tip-bot2 for Randy Dunlap" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] trace/events/sched.h: fix duplicated word
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <25305c1d-4ee8-e091-d20f-e700ddad49fd@infradead.org>
References: <25305c1d-4ee8-e091-d20f-e700ddad49fd@infradead.org>
MIME-Version: 1.0
Message-ID: <159540914537.4006.9594833969262320461.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     2705937a0395bd15d515a2a302d26ebc8318c035
Gitweb:        https://git.kernel.org/tip/2705937a0395bd15d515a2a302d26ebc8318c035
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Wed, 15 Jul 2020 18:31:38 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 22 Jul 2020 10:22:05 +02:00

trace/events/sched.h: fix duplicated word

Change "It it" to "It is".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/25305c1d-4ee8-e091-d20f-e700ddad49fd@infradead.org
---
 include/trace/events/sched.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 0d5ff09..fec25b9 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -91,7 +91,7 @@ DEFINE_EVENT(sched_wakeup_template, sched_waking,
 
 /*
  * Tracepoint called when the task is actually woken; p->state == TASK_RUNNNG.
- * It it not always called from the waking context.
+ * It is not always called from the waking context.
  */
 DEFINE_EVENT(sched_wakeup_template, sched_wakeup,
 	     TP_PROTO(struct task_struct *p),
