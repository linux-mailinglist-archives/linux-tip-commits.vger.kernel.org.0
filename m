Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A76AC3B6976
	for <lists+linux-tip-commits@lfdr.de>; Mon, 28 Jun 2021 22:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236511AbhF1UIq (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 28 Jun 2021 16:08:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49884 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235144AbhF1UIj (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 28 Jun 2021 16:08:39 -0400
Date:   Mon, 28 Jun 2021 20:06:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624910772;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=8tOu19UM8xUtZzcwQ2juOdeb73lXusTclSjAKWiQw14=;
        b=Vv5o22K6P68/eyI9fbdTOmyyxJYWKUViZC5KO0DP5tV1VW9ZNySOpnWlnJ64Ja0jmiBXvJ
        kWpWUlIK1v+BYviN7+i3MJ0cM+Q7sx5CqNTds7n9526w/3zvbODfF8bfTZqhhS1cPLTsEB
        jrfqogzs8m04eOM09YaAddCHTtpEDsTKeSRvYGbdJos48S7fc7iAhOlr0rKUSs/fe2z8ZT
        COx6x4vOA+38Y6/CcxQq9/JM3UC/jd4fCQYoqRYSzNkMJgBdhu+ty1gILOLHtFPeJH1xrg
        0J/z9b3XuOdEWYkMABTBiJDQBtyCPbIHEn8ZjxmHxDb57OSG7R1vQZX84gmqVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624910772;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=8tOu19UM8xUtZzcwQ2juOdeb73lXusTclSjAKWiQw14=;
        b=6Ax6z7M0LGJl9olGLR2JTJOiiQmhcyOUE9EkUSm2em472l6iIrq0nXD0Q/iwgioWlqthyr
        UPrBiNuC87RTkZDQ==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/core: Disable CONFIG_SCHED_CORE by default
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162491077160.395.13821987420860261216.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     0e81c7c17c3edd469b6a87333059714a618d882c
Gitweb:        https://git.kernel.org/tip/0e81c7c17c3edd469b6a87333059714a618d882c
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Mon, 28 Jun 2021 21:55:16 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 28 Jun 2021 21:55:16 +02:00

sched/core: Disable CONFIG_SCHED_CORE by default

This option adds extra overhead to the scheduler, and most users wouldn't want it.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/Kconfig.preempt | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index bd7c414..3654a92 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -102,7 +102,6 @@ config PREEMPT_DYNAMIC
 
 config SCHED_CORE
 	bool "Core Scheduling for SMT"
-	default y
 	depends on SCHED_SMT
 	help
 	  This option permits Core Scheduling, a means of coordinated task
