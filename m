Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8C74278D3
	for <lists+linux-tip-commits@lfdr.de>; Sat,  9 Oct 2021 12:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244854AbhJIKKB (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 9 Oct 2021 06:10:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49544 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244750AbhJIKJb (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 9 Oct 2021 06:09:31 -0400
Date:   Sat, 09 Oct 2021 10:07:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633774053;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TsmLx22RdeJXOzDhfJMDcgUCQc92VIsYk0FbQu69TCA=;
        b=HrwE8uGHgqUUGpEkfE2hUKxD46wPRib6D9uq/8ZCy3sep8//aO4h8yX2aNIWQUq02oe+j2
        GIuIVAfO+po335rfftRMgtz6Cl60SDUk/xwO8RFetSImzNDmGMTiJgKDm5iMfdx7OUrTvC
        kpQbxelyEMGNBaTcJb5VYmaqT6VIy3QYh04vfd5GS4YBnYj7GDMSEqhyAl4P7sRyY73n62
        SvjcCqWflaq4lfeXzsgxYODIltmxEIF0ymBDillTnk3e6c3e3qGHkiUQS9RA+kV3ClZjZv
        HDg63sLqltUGIh3zlJOJg4pSabm1zt/yq3rPITjjBOcDhdFvh6ghcJmKN3KAJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633774053;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TsmLx22RdeJXOzDhfJMDcgUCQc92VIsYk0FbQu69TCA=;
        b=43p78LGifadB3k1ayikYtnwvaeJk8HL8f6aIRHSzI/q2RkitDvPNsHp4R7+ltK/V8ev5l0
        G5FJPRRcdFjPCwBw==
From:   "tip-bot2 for Kees Cook" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Fill unconditional hole induced by sched_entity
Cc:     Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210924025450.4138503-1-keescook@chromium.org>
References: <20210924025450.4138503-1-keescook@chromium.org>
MIME-Version: 1.0
Message-ID: <163377405280.25758.581808828384380024.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     b2d5b9cec60fecc72a13191c2c6c05acf60975a5
Gitweb:        https://git.kernel.org/tip/b2d5b9cec60fecc72a13191c2c6c05acf60975a5
Author:        Kees Cook <keescook@chromium.org>
AuthorDate:    Thu, 23 Sep 2021 19:54:50 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 07 Oct 2021 13:51:17 +02:00

sched: Fill unconditional hole induced by sched_entity

With struct sched_entity before the other sched entities, its alignment
won't induce a struct hole. This saves 64 bytes in defconfig task_struct:

Before:
	...
        unsigned int               rt_priority;          /*   120     4 */

        /* XXX 4 bytes hole, try to pack */

        /* --- cacheline 2 boundary (128 bytes) --- */
        const struct sched_class  * sched_class;         /*   128     8 */

        /* XXX 56 bytes hole, try to pack */

        /* --- cacheline 3 boundary (192 bytes) --- */
        struct sched_entity        se __attribute__((__aligned__(64))); /*   192   448 */
        /* --- cacheline 10 boundary (640 bytes) --- */
        struct sched_rt_entity     rt;                   /*   640    48 */
        struct sched_dl_entity     dl __attribute__((__aligned__(8))); /*   688   224 */
        /* --- cacheline 14 boundary (896 bytes) was 16 bytes ago --- */

After:
	...
        unsigned int               rt_priority;          /*   120     4 */

        /* XXX 4 bytes hole, try to pack */

        /* --- cacheline 2 boundary (128 bytes) --- */
        struct sched_entity        se __attribute__((__aligned__(64))); /*   128   448 */
        /* --- cacheline 9 boundary (576 bytes) --- */
        struct sched_rt_entity     rt;                   /*   576    48 */
        struct sched_dl_entity     dl __attribute__((__aligned__(8))); /*   624   224 */
        /* --- cacheline 13 boundary (832 bytes) was 16 bytes ago --- */

Summary diff:
-	/* size: 7040, cachelines: 110, members: 188 */
+	/* size: 6976, cachelines: 109, members: 188 */

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210924025450.4138503-1-keescook@chromium.org
---
 include/linux/sched.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 193e16e..343603f 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -775,10 +775,10 @@ struct task_struct {
 	int				normal_prio;
 	unsigned int			rt_priority;
 
-	const struct sched_class	*sched_class;
 	struct sched_entity		se;
 	struct sched_rt_entity		rt;
 	struct sched_dl_entity		dl;
+	const struct sched_class	*sched_class;
 
 #ifdef CONFIG_SCHED_CORE
 	struct rb_node			core_node;
