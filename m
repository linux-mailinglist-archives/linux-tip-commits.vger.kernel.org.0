Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7A16362849
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 Apr 2021 21:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241214AbhDPTIZ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 16 Apr 2021 15:08:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59306 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234898AbhDPTIZ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 16 Apr 2021 15:08:25 -0400
Date:   Fri, 16 Apr 2021 19:07:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618600079;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RXeDpHhm+Qn3xDVhJ5riLOB/Nu6pLzHS8NqwHThHcGY=;
        b=PgGIwTz+NfLgme/GJ0yZtgNNqPkD5dtvgq4h9hN+OT88dtvHG+WIaRAyRzNAqRjR+i6hSo
        SX8Qjd3IbLmuawZz2R18HXBKCZVLTzBY7u0dp0nFx597odxLOUkIUJjW3b1oRuqGWGxjdR
        yqiI6UbdBY8HD4NhV6C/d18RDEzdBZJ0IfMcIMcHA8bakDX0D9mmibUHf9jZvkWJbCXgeK
        k2ObHG0XAyPUMgJ/uQvuhm06C7TqEJIGhgDo9QY5LQEaBBM7QTzNdpGmDIXhFqeUc3mxSE
        RntRdkRAKwrtIAdzJrbzAM6OBH5oSdpe4WhZFHqojtiWA2QRFzdoTBLJiH8oGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618600079;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RXeDpHhm+Qn3xDVhJ5riLOB/Nu6pLzHS8NqwHThHcGY=;
        b=/NSUdsD7Yc15Hj/Syis51bLF2Kv1Se9NBti+YgN6VcSsJHyQggCZSuVODx+yeS5sx4ySI0
        4nb15Eiq31hJAsAA==
From:   "tip-bot2 for Marc Kleine-Budde" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] time/timecounter: Mark 1st argument of
 timecounter_cyc2time() as const
Cc:     "Marc Kleine-Budde" <mkl@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210303103544.994855-1-mkl@pengutronix.de>
References: <20210303103544.994855-1-mkl@pengutronix.de>
MIME-Version: 1.0
Message-ID: <161860007673.29796.3934141418916152456.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     07ff4aed015c564d03fd518d2fb54e5e6948903c
Gitweb:        https://git.kernel.org/tip/07ff4aed015c564d03fd518d2fb54e5e6948903c
Author:        Marc Kleine-Budde <mkl@pengutronix.de>
AuthorDate:    Wed, 03 Mar 2021 11:35:44 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 16 Apr 2021 21:03:50 +02:00

time/timecounter: Mark 1st argument of timecounter_cyc2time() as const

The timecounter is not modified in this function. Mark it as const.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210303103544.994855-1-mkl@pengutronix.de

---
 include/linux/timecounter.h | 2 +-
 kernel/time/timecounter.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/timecounter.h b/include/linux/timecounter.h
index 754b74a..c6540ce 100644
--- a/include/linux/timecounter.h
+++ b/include/linux/timecounter.h
@@ -124,7 +124,7 @@ extern u64 timecounter_read(struct timecounter *tc);
  * This allows conversion of cycle counter values which were generated
  * in the past.
  */
-extern u64 timecounter_cyc2time(struct timecounter *tc,
+extern u64 timecounter_cyc2time(const struct timecounter *tc,
 				u64 cycle_tstamp);
 
 #endif
diff --git a/kernel/time/timecounter.c b/kernel/time/timecounter.c
index 85b98e7..e628528 100644
--- a/kernel/time/timecounter.c
+++ b/kernel/time/timecounter.c
@@ -76,7 +76,7 @@ static u64 cc_cyc2ns_backwards(const struct cyclecounter *cc,
 	return ns;
 }
 
-u64 timecounter_cyc2time(struct timecounter *tc,
+u64 timecounter_cyc2time(const struct timecounter *tc,
 			 u64 cycle_tstamp)
 {
 	u64 delta = (cycle_tstamp - tc->cycle_last) & tc->cc->mask;
