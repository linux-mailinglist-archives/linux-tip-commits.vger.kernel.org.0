Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 998E52B8F90
	for <lists+linux-tip-commits@lfdr.de>; Thu, 19 Nov 2020 11:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbgKSJzN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 19 Nov 2020 04:55:13 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60910 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbgKSJzN (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 19 Nov 2020 04:55:13 -0500
Date:   Thu, 19 Nov 2020 09:55:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605779711;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oujh6hIaL/Ey5/RMDEctVzFNIo6dGc9hf0anc77FTYE=;
        b=hC0Ol8ZTjIXEvXqyjzdR6od0ekOXjRYj8dTWixWwXrUiOeazpWbwofI3NEOxETQZLGkhgv
        inqvjuKiIxjaKMe3QmOH9WQzu8zhl9XuIT38MNgfqob4u7QhD0f+lbqAoagaHu+JULbWsq
        3wZE5Qba2GjD64RyrqvvzO3OMROBOIUdUwEBXc1JFbZk0ciiBvIwx4Y28IgaHQn29sDY+j
        NmT0h0j25fUSwY+0x0eIlUaDjVEV2gYHGhU+yC5/RnqFhGtWSt28F4aY20XVhRCaHPk8xw
        GzzaHpw2ZE9KIdJq77ES2CcH5igcSaa9oPAHx84FJiiufZoWlgzgcQegCTbYjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605779711;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oujh6hIaL/Ey5/RMDEctVzFNIo6dGc9hf0anc77FTYE=;
        b=STjSEDVL3jhADgNJWsoksuLN+oi7Xt7I4ca3OlEJit1p7CsGTQekVaeswlkFe4sRXdk3g9
        leMOLe2VpEpY86AQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] tick/broadcast: Serialize access to tick_next_period
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201117132006.061341507@linutronix.de>
References: <20201117132006.061341507@linutronix.de>
MIME-Version: 1.0
Message-ID: <160577971090.11244.13109009707653054704.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     f73f64d5687192bc8eb7f3d9521ca6256b79f224
Gitweb:        https://git.kernel.org/tip/f73f64d5687192bc8eb7f3d9521ca6256b79f224
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 17 Nov 2020 14:19:43 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 19 Nov 2020 10:48:28 +01:00

tick/broadcast: Serialize access to tick_next_period

tick_broadcast_setup_oneshot() accesses tick_next_period twice without any
serialization. This is wrong in two aspects:

  - Reading it twice might make the broadcast data inconsistent if the
    variable is updated concurrently.

  - On 32bit systems the access might see an partial update

Protect it with jiffies_lock. That's safe as none of the callchains leading
up to this function can create a lock ordering violation:

timer interrupt
  run_local_timers()
    hrtimer_run_queues()
      hrtimer_switch_to_hres()
        tick_init_highres()
	  tick_switch_to_oneshot()
	    tick_broadcast_switch_to_oneshot()
or
     tick_check_oneshot_change()
       tick_nohz_switch_to_nohz()
         tick_switch_to_oneshot()
           tick_broadcast_switch_to_oneshot()

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201117132006.061341507@linutronix.de

---
 kernel/time/tick-broadcast.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index 36d7464..2a47c8f 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -877,6 +877,22 @@ static void tick_broadcast_init_next_event(struct cpumask *mask,
 	}
 }
 
+static inline ktime_t tick_get_next_period(void)
+{
+	ktime_t next;
+
+	/*
+	 * Protect against concurrent updates (store /load tearing on
+	 * 32bit). It does not matter if the time is already in the
+	 * past. The broadcast device which is about to be programmed will
+	 * fire in any case.
+	 */
+	raw_spin_lock(&jiffies_lock);
+	next = tick_next_period;
+	raw_spin_unlock(&jiffies_lock);
+	return next;
+}
+
 /**
  * tick_broadcast_setup_oneshot - setup the broadcast device
  */
@@ -905,10 +921,11 @@ static void tick_broadcast_setup_oneshot(struct clock_event_device *bc)
 			   tick_broadcast_oneshot_mask, tmpmask);
 
 		if (was_periodic && !cpumask_empty(tmpmask)) {
+			ktime_t nextevt = tick_get_next_period();
+
 			clockevents_switch_state(bc, CLOCK_EVT_STATE_ONESHOT);
-			tick_broadcast_init_next_event(tmpmask,
-						       tick_next_period);
-			tick_broadcast_set_event(bc, cpu, tick_next_period);
+			tick_broadcast_init_next_event(tmpmask, nextevt);
+			tick_broadcast_set_event(bc, cpu, nextevt);
 		} else
 			bc->next_event = KTIME_MAX;
 	} else {
