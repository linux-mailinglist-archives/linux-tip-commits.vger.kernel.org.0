Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F04B362490
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 Apr 2021 17:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236058AbhDPPyO (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 16 Apr 2021 11:54:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58240 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235902AbhDPPyJ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 16 Apr 2021 11:54:09 -0400
Date:   Fri, 16 Apr 2021 15:53:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618588423;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TBlAOKz1vrKK3XzxUpDoIMpVfL+X6c7jyjqivQ6O2Jo=;
        b=thZNK/GZ47yLg2t00L0CIR5CNfPLDV8gQN0IaSyIeA/gJKn+WOniexRjHzzPhQVWthpc4L
        wQDO8HT4ELqqEgfnCtrLwP2KemXo5Ex3ods6DQp1dmTx/dHrOONmdOoXu+DuHgxu6pqk2o
        PBnVExiY2LicmydC11AV2ltBg+vu7++B46MJ5apokytdg4FGd02j1TEODEfh0sujxQH9TN
        eWjuTle/sHuGwa5Mgl6w3pCm9UfNCc8Ds0e2uitaH+IahMDeHtcc/nzyF4E4ohrNY62xhB
        OBFH7utwy8rzgN8MA26P1fXTAbsn6kljkben+St5OsNNCU9/pxFfG5mIwVfqWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618588423;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TBlAOKz1vrKK3XzxUpDoIMpVfL+X6c7jyjqivQ6O2Jo=;
        b=qc7GwRHSOAHhV3wd3VQwwL4L/26VWKdQrw5n/EjK9ALRP9oStyBHO12AaXPNvLZ+0xKD0h
        Ti6iHKn6SBxWz/Aw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Don't make LATENCYTOP select SCHED_DEBUG
Cc:     Mel Gorman <mgorman@suse.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210412102001.224578981@infradead.org>
References: <20210412102001.224578981@infradead.org>
MIME-Version: 1.0
Message-ID: <161858842323.29796.12620568643743680131.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     d86ba831656611872e4939b895503ddac63d8196
Gitweb:        https://git.kernel.org/tip/d86ba831656611872e4939b895503ddac63d8196
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 24 Mar 2021 19:48:34 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 16 Apr 2021 17:06:33 +02:00

sched: Don't make LATENCYTOP select SCHED_DEBUG

SCHED_DEBUG is not in fact required for LATENCYTOP, don't select it.

Suggested-by: Mel Gorman <mgorman@suse.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Valentin Schneider <valentin.schneider@arm.com>
Link: https://lkml.kernel.org/r/20210412102001.224578981@infradead.org
---
 lib/Kconfig.debug | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 2779c29..5f98376 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1670,7 +1670,6 @@ config LATENCYTOP
 	select KALLSYMS_ALL
 	select STACKTRACE
 	select SCHEDSTATS
-	select SCHED_DEBUG
 	help
 	  Enable this option if you want to use the LatencyTOP tool
 	  to find out which userspace is blocking on what kernel operations.
