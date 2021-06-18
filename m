Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E91F23ACFA6
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Jun 2021 18:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbhFRQFs (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 18 Jun 2021 12:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbhFRQFr (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 18 Jun 2021 12:05:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C897C061574;
        Fri, 18 Jun 2021 09:03:38 -0700 (PDT)
Date:   Fri, 18 Jun 2021 16:03:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624032217;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O0UO4w4rOsmiQaq+i1vnUzazgKvHygYcq5DooCqL1gY=;
        b=Lk5WJM6XVHuEenL2LQQDy/GTNl7A7ABxfJ+Tre+2i3C6iDo7CLOZzvoahwtR3/2/0g/yRs
        fLMh4n/Q2UPL0QGJ6rF6wNmHT7Dv1KIAIEen7GooMGMgy5Q846IXixpG/cPe0o2mLvmxnh
        h2yjIrMl3PQIJx4TmfT7328LKhtI7ZTzY3414JQCtAEvo1cBBmCv2SVxAJem+LgY9ZUaVD
        EVQ0rGfQCyKyRi4m+29xDkjEIpONIREetY8I1AWfXafVFADmUaH267o3dz5hDZ5/su2wOt
        +dci7Xg6qmm9phshQGTaRan6fu9zfzGqODd+fWU8ugC4My3dYEUkYlh552YQ/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624032217;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O0UO4w4rOsmiQaq+i1vnUzazgKvHygYcq5DooCqL1gY=;
        b=UkahyCyqLAROTvFr3I8AZOLGWGcKNiOMezh09cAm/rf4pDYnc6WAtUegitmo4ovck8YBVK
        a7ElAaWKJdtrHLCg==
From:   "tip-bot2 for Tony Lindgren" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/timer-ti-dm: Drop unnecessary restore
Cc:     Lokesh Vutla <lokeshvutla@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210518075306.35532-1-tony@atomide.com>
References: <20210518075306.35532-1-tony@atomide.com>
MIME-Version: 1.0
Message-ID: <162403221618.19906.4283672210096454045.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     3d41fff3ae3980c055f3c7861264c46c924f3e4c
Gitweb:        https://git.kernel.org/tip/3d41fff3ae3980c055f3c7861264c46c924f3e4c
Author:        Tony Lindgren <tony@atomide.com>
AuthorDate:    Tue, 18 May 2021 10:53:06 +03:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 16 Jun 2021 17:33:04 +02:00

clocksource/drivers/timer-ti-dm: Drop unnecessary restore

The device is not losing context on CPU_CLUSTER_PM_ERROR. As we are only
saving and restoring context with cpu_pm, there is no need to restore the
context in case of an error.

Note that the unnecessary restoring of context does not cause issues, it's
just not needed.

Cc: Lokesh Vutla <lokeshvutla@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210518075306.35532-1-tony@atomide.com
---
 drivers/clocksource/timer-ti-dm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index e5c631f..3e52c52 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -128,7 +128,8 @@ static int omap_timer_context_notifier(struct notifier_block *nb,
 			break;
 		omap_timer_save_context(timer);
 		break;
-	case CPU_CLUSTER_PM_ENTER_FAILED:
+	case CPU_CLUSTER_PM_ENTER_FAILED:	/* No need to restore context */
+		break;
 	case CPU_CLUSTER_PM_EXIT:
 		if ((timer->capability & OMAP_TIMER_ALWON) ||
 		    !atomic_read(&timer->enabled))
