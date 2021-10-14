Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 083FE42D7F1
	for <lists+linux-tip-commits@lfdr.de>; Thu, 14 Oct 2021 13:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbhJNLSY (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 14 Oct 2021 07:18:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41814 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbhJNLSY (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 14 Oct 2021 07:18:24 -0400
Date:   Thu, 14 Oct 2021 11:16:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634210178;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y5MyxG7fCwcsTwH1dNybKC0jDrFIaBRVOjsoYdFlqjQ=;
        b=sbPSu3IBatFVN3G7DQdOvxkN7z1J5JOUfiVqaLFznNEAEbnNXP3tmNnCU8BEmS1DKcgdz5
        w3imaV/xjhjCLRA1W0dRzpS66Yv71NX0Rr/w2O6tHU7nyCpZDTZ4nM6fPbzQgXxdZJ3Q1+
        jleYYpL+AT4c3EosgbeBLZhcZ7WFN2yL7XdsVA+S3nCxmJ8V0T0bLFUAkehtuDtc4RDnvg
        A3IjszriOZQ+5ZR0drq4l1BDdotdlzvdU2cy0wM0NMXwkxdxKhD1FWCbg2kVVNAUANZMgG
        2PZ7a6nyzBxYC88lxsqtOu+38yStx80vLd8/tPA1GJhRnPxh5Pa+EH+RoQxcLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634210178;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y5MyxG7fCwcsTwH1dNybKC0jDrFIaBRVOjsoYdFlqjQ=;
        b=cNV/u5+HlHXXbV0H9Tqv2/iGSBptw+eeWHcv5SZFakSNaATt4gz8kDH48ThXKEiFnKouXG
        Y3bJPHT+X941fZCw==
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
Message-ID: <163421017704.25758.5310890692010248228.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     804bccba71a57e7e5deb507a4c8ebbab730909c0
Gitweb:        https://git.kernel.org/tip/804bccba71a57e7e5deb507a4c8ebbab730909c0
Author:        Kees Cook <keescook@chromium.org>
AuthorDate:    Thu, 23 Sep 2021 19:54:50 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 14 Oct 2021 13:09:58 +02:00

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
