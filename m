Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9373213BF
	for <lists+linux-tip-commits@lfdr.de>; Mon, 22 Feb 2021 11:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbhBVKHN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 22 Feb 2021 05:07:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbhBVKFq (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 22 Feb 2021 05:05:46 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA64C061794;
        Mon, 22 Feb 2021 02:05:00 -0800 (PST)
Date:   Mon, 22 Feb 2021 10:04:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613988298;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f/nb5ZPoMLItbBMeUxA8HeH6eiYzXLf6qk8oNPk3uT0=;
        b=LIpl3BwU8U8+pZD4rW6bhgJQ69m0O3NSq6TM+WpaAKoj89ubyhl2L6H4kE68rn29inTaF5
        +hQLEkb0vA7bcVzXnuYndwSLBJQp3Vn4287UzqWwZPg3Ix0/9Bk/cmkE9jLHWize7oLRAH
        EWRO4mXkfFFM+WK6/+A5vcJx1ZSWd8ftUE6rrQcCjNd1PFt9/okKO1F8p7T/HWhM5i1AVf
        Qc243Ot+4x1vT1xascHgLM7giBSePoJGPtRzconQniA6Z6hpyypR5ygyEpey5unMZUWWn4
        hJOid5l83YLcFh7ziun1SBeuU5lLZiiAo/imyYl1b/Ci2LhnBaAcIcqptCTVeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613988298;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f/nb5ZPoMLItbBMeUxA8HeH6eiYzXLf6qk8oNPk3uT0=;
        b=agmi4xJfjDp7bik9hCK1nme73sBy8TyhFce1R1PzYiqqXPkwNs9Fit7CQllq3HVIDjNQxo
        6XN+lu2/EX2IVWDg==
From:   "tip-bot2 for Tom Rix" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] clocksource/drivers/mxs_timer: Add missing
 semicolon when DEBUG is defined
Cc:     Tom Rix <trix@redhat.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210118211955.763609-1-trix@redhat.com>
References: <20210118211955.763609-1-trix@redhat.com>
MIME-Version: 1.0
Message-ID: <161398829772.20312.16867985680081373214.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     7da390694afbaed8e0f05717a541dfaf1077ba51
Gitweb:        https://git.kernel.org/tip/7da390694afbaed8e0f05717a541dfaf107=
7ba51
Author:        Tom Rix <trix@redhat.com>
AuthorDate:    Mon, 18 Jan 2021 13:19:55 -08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 18 Jan 2021 22:28:59 +01:00

clocksource/drivers/mxs_timer: Add missing semicolon when DEBUG is defined

When DEBUG is defined this error occurs

drivers/clocksource/mxs_timer.c:138:1: error:
  expected =E2=80=98;=E2=80=99 before =E2=80=98}=E2=80=99 token

The preceding statement needs a semicolon.
Replace pr_info() with pr_debug() and remove the unneeded ifdef.

Fixes: eb8703e2ef7c ("clockevents/drivers/mxs: Migrate to new 'set-state' int=
erface")
Signed-off-by: Tom Rix <trix@redhat.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210118211955.763609-1-trix@redhat.com
---
 drivers/clocksource/mxs_timer.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/clocksource/mxs_timer.c b/drivers/clocksource/mxs_timer.c
index bc96a4c..e52e12d 100644
--- a/drivers/clocksource/mxs_timer.c
+++ b/drivers/clocksource/mxs_timer.c
@@ -131,10 +131,7 @@ static void mxs_irq_clear(char *state)
=20
 	/* Clear pending interrupt */
 	timrot_irq_acknowledge();
-
-#ifdef DEBUG
-	pr_info("%s: changing mode to %s\n", __func__, state)
-#endif /* DEBUG */
+	pr_debug("%s: changing mode to %s\n", __func__, state);
 }
=20
 static int mxs_shutdown(struct clock_event_device *evt)
