Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E25D82AD6BA
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Nov 2020 13:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730392AbgKJMpW (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Nov 2020 07:45:22 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:58224 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730296AbgKJMpW (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Nov 2020 07:45:22 -0500
Date:   Tue, 10 Nov 2020 12:45:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605012320;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iD3uuvec7KvBLO1A3AiFYIoKWwhZn15/Y848zjVVSIU=;
        b=o5JgSqIxmlQZ3QKRjqvMWdh2CRUwcBOwIEnQiLRlXPIeNcUmJw0HscoYCaByIzqIhGWm8v
        U7Rys5LOOzkCmlT5LvIuGSwiVRbRyjxP+iWWu2mnpyjkgXGr8WFt0Ggj/yMNB8v/BgGRQr
        yOChq4+N4i0NoUlf7J0/P+cPTqz6LOiRGv7Em6r6vSXp9LCuW6zMRopcJUhxNHx2hOAlO8
        jtgZMc7ZP1aU8s3IJE58y9wZptj6vzwtOLTQTzKxhnHcwh4QHJQqkTN8V57UNQ4oJQOgSm
        6VoZJmtOzGpNwHAWCZbPO4WIR9AsFjkJYIQG4Oq7vCJfQ+adJeyy1Q7RusT8gA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605012320;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iD3uuvec7KvBLO1A3AiFYIoKWwhZn15/Y848zjVVSIU=;
        b=AEoz6KyPSVOquY7Pp/EYPXjFBbHn+QYDsxWGjE8+4mpT2kMmVFsTUBRg3qq4/CBxM1blPd
        vYvYgabM+iZInYAg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf: Simplify group_sched_out()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201029162901.904060564@infradead.org>
References: <20201029162901.904060564@infradead.org>
MIME-Version: 1.0
Message-ID: <160501231936.11244.12656213160461765711.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     8c7855d82933bab7fa5e96f0e568fc125c2e1ab4
Gitweb:        https://git.kernel.org/tip/8c7855d82933bab7fa5e96f0e568fc125c2e1ab4
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 29 Oct 2020 16:28:25 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 09 Nov 2020 18:12:35 +01:00

perf: Simplify group_sched_out()

Since event_sched_out() clears cpuctx->exclusive upon removal of an
exclusive event (and only group leaders can be exclusive), there is no
point in group_sched_out() trying to do it too. It is impossible for
cpuctx->exclusive to still be set here.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20201029162901.904060564@infradead.org
---
 kernel/events/core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index d67c9cb..9a57366 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2312,9 +2312,6 @@ group_sched_out(struct perf_event *group_event,
 		event_sched_out(event, cpuctx, ctx);
 
 	perf_pmu_enable(ctx->pmu);
-
-	if (group_event->attr.exclusive)
-		cpuctx->exclusive = 0;
 }
 
 #define DETACH_GROUP	0x01UL
