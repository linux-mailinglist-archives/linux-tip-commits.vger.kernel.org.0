Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1652E277A03
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Sep 2020 22:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgIXUN5 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 24 Sep 2020 16:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbgIXUN5 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 24 Sep 2020 16:13:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB2FC0613CE;
        Thu, 24 Sep 2020 13:13:56 -0700 (PDT)
Date:   Thu, 24 Sep 2020 20:13:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600978435;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b0p/stKwtIhcp5+uygcPVT0jPD8tZbpQyj2KTq05TCI=;
        b=frWGjDFQ/pTE1qB8JKwQ9yFvrV8fRVrVjRy4JBYlJTD/awZw6ff/9siXOJpGti8cWyoZNu
        3H636xE0qHx4C3pAAqtpMXuS37L6i5ZTTWyeSsD01I7DDlWH7pQKQo8+AnMHNP6Mmj9PqP
        qO6eo6hjXpqvDl9y+TRBwXZ7Fv95hGj1l638oZMDhLEAvQveTeINFVjnBW84dMz5a+2Tev
        PIwVZbPuBhMkD7QYDK5su938UKM0F99Dk9LJgaKOAbRMRfAZgEHqHJBORMpHWuCbm0TD7T
        r6k6AA9vIdd1FlQqdfQdDWsqIrYSsJIfio3aMWW74ULPgFxBLEeaPx8dNsDQGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600978435;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b0p/stKwtIhcp5+uygcPVT0jPD8tZbpQyj2KTq05TCI=;
        b=2j+GXwjj45Y0lURLsesTPugdwFCkRq9IZSTrqJTRx+O1phnXL9aYQ/0YzPWqN8JU80iLku
        UlCywWxLxXsC4IAQ==
From:   "tip-bot2 for Qianli Zhao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers: Mask invalid flags in do_init_timer()
Cc:     Qianli Zhao <zhaoqianli@xiaomi.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: =?utf-8?q?=3C9d79a8aa4eb56713af7379f99f062dedabcde140=2E15973?=
 =?utf-8?q?26756=2Egit=2Ezhaoqianli=40xiaomi=2Ecom=3E?=
References: =?utf-8?q?=3C9d79a8aa4eb56713af7379f99f062dedabcde140=2E159732?=
 =?utf-8?q?6756=2Egit=2Ezhaoqianli=40xiaomi=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <160097843425.7002.2118619969908419648.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     b952caf2d5ca898cc10d63be7722ae7a5daca696
Gitweb:        https://git.kernel.org/tip/b952caf2d5ca898cc10d63be7722ae7a5daca696
Author:        Qianli Zhao <zhaoqianli@xiaomi.com>
AuthorDate:    Thu, 13 Aug 2020 23:03:14 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 24 Sep 2020 22:12:18 +02:00

timers: Mask invalid flags in do_init_timer()

do_init_timer() accepts any combination of timer flags handed in by the
caller without a sanity check, but only TIMER_DEFFERABLE, TIMER_PINNED and
TIMER_IRQSAFE are valid.

If the supplied flags have other bits set, this could result in
malfunction. If bits are set in TIMER_CPUMASK the first timer usage could
deference a cpu base which is outside the range of possible CPUs. If
TIMER_MIGRATION is set, then the switch_timer_base() will live lock.

Prevent that with a sanity check which warns when invalid flags are
supplied and masks them out.

[ tglx: Made it WARN_ON_ONCE() and added context to the changelog ]

Signed-off-by: Qianli Zhao <zhaoqianli@xiaomi.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/9d79a8aa4eb56713af7379f99f062dedabcde140.1597326756.git.zhaoqianli@xiaomi.com
---
 include/linux/timer.h | 1 +
 kernel/time/timer.c   | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/linux/timer.h b/include/linux/timer.h
index 07910ae..d10bc7e 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -67,6 +67,7 @@ struct timer_list {
 #define TIMER_DEFERRABLE	0x00080000
 #define TIMER_PINNED		0x00100000
 #define TIMER_IRQSAFE		0x00200000
+#define TIMER_INIT_FLAGS	(TIMER_DEFERRABLE | TIMER_PINNED | TIMER_IRQSAFE)
 #define TIMER_ARRAYSHIFT	22
 #define TIMER_ARRAYMASK		0xFFC00000
 
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index a16764b..25e048d 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -794,6 +794,8 @@ static void do_init_timer(struct timer_list *timer,
 {
 	timer->entry.pprev = NULL;
 	timer->function = func;
+	if (WARN_ON_ONCE(flags & ~TIMER_INIT_FLAGS))
+		flags &= TIMER_INIT_FLAGS;
 	timer->flags = flags | raw_smp_processor_id();
 	lockdep_init_map(&timer->lockdep_map, name, key, 0);
 }
