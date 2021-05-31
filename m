Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48DF739633E
	for <lists+linux-tip-commits@lfdr.de>; Mon, 31 May 2021 17:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbhEaPKt (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 31 May 2021 11:10:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54956 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234314AbhEaPIk (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 31 May 2021 11:08:40 -0400
Date:   Mon, 31 May 2021 15:06:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622473619;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0DGB+J48VICmPEFf3+0iQoTNpd3XdVmOmlambanNs5g=;
        b=OmH2RP7qpGatnyET8zi19Yx75Yp8c7zPr3ThWsXHZM/OFsoX78y5GmskuyIVmdWBr7j6Sw
        Va6NJxZ+1aBBJqRFpc8evcGUTYO6w5bjgXNm5SIwhN2fvdu8zD09uVT+0U3STSeWC3jxiv
        mH/VKpkzkd+Wv+fQjKhY0b3ckxmf+hq3jDJydGdKjNAYMWlbS10jGMuHfuBFDrpxhuzR4c
        wWe8mqcYRjQEE7D3acOEmxPQNfbDyZ63EyeYGoInB1StEo0CGEIcV3KdDhGJR8dhY4SrbO
        IbvHAfzpUBGMYkBezUrbXhJRXkG060qnmt9BjyYAOcJfaOaG2+QscAIpN8DfdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622473619;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0DGB+J48VICmPEFf3+0iQoTNpd3XdVmOmlambanNs5g=;
        b=ZHh2Ml89oxy7+GLon9uHS0+DI7pjuFnCsnPbc79c/E3Ddrb1Z/X+mOiiV4WXmSkraBzr9T
        WRhYwUZd2LEvRHCg==
From:   "tip-bot2 for Will Deacon" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timer_list: Print name of per-cpu wakeup device
Cc:     Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210524221818.15850-6-will@kernel.org>
References: <20210524221818.15850-6-will@kernel.org>
MIME-Version: 1.0
Message-ID: <162247361850.29796.2040439369895392133.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     245a057fee18be08d6ac12357463579d06bea077
Gitweb:        https://git.kernel.org/tip/245a057fee18be08d6ac12357463579d06bea077
Author:        Will Deacon <will@kernel.org>
AuthorDate:    Mon, 24 May 2021 23:18:18 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 31 May 2021 17:04:49 +02:00

timer_list: Print name of per-cpu wakeup device

With the introduction of per-cpu wakeup devices that can be used in
preference to the broadcast timer, print the name of such devices when
they are available.

Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210524221818.15850-6-will@kernel.org

---
 kernel/time/tick-broadcast.c |  7 +++++++
 kernel/time/tick-internal.h  |  1 +
 kernel/time/timer_list.c     | 10 +++++++++-
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index 9b84521..f7fe6fe 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -63,6 +63,13 @@ struct cpumask *tick_get_broadcast_mask(void)
 	return tick_broadcast_mask;
 }
 
+static struct clock_event_device *tick_get_oneshot_wakeup_device(int cpu);
+
+const struct clock_event_device *tick_get_wakeup_device(int cpu)
+{
+	return tick_get_oneshot_wakeup_device(cpu);
+}
+
 /*
  * Start the device in periodic mode
  */
diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
index 30c8963..6a742a2 100644
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -71,6 +71,7 @@ extern void tick_set_periodic_handler(struct clock_event_device *dev, int broadc
 extern int tick_broadcast_update_freq(struct clock_event_device *dev, u32 freq);
 extern struct tick_device *tick_get_broadcast_device(void);
 extern struct cpumask *tick_get_broadcast_mask(void);
+extern const struct clock_event_device *tick_get_wakeup_device(int cpu);
 # else /* !CONFIG_GENERIC_CLOCKEVENTS_BROADCAST: */
 static inline void tick_install_broadcast_device(struct clock_event_device *dev, int cpu) { }
 static inline int tick_is_broadcast_device(struct clock_event_device *dev) { return 0; }
diff --git a/kernel/time/timer_list.c b/kernel/time/timer_list.c
index 6939140..ed7d6ad 100644
--- a/kernel/time/timer_list.c
+++ b/kernel/time/timer_list.c
@@ -228,6 +228,14 @@ print_tickdevice(struct seq_file *m, struct tick_device *td, int cpu)
 	SEQ_printf(m, " event_handler:  %ps\n", dev->event_handler);
 	SEQ_printf(m, "\n");
 	SEQ_printf(m, " retries:        %lu\n", dev->retries);
+
+#ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
+	if (cpu >= 0) {
+		const struct clock_event_device *wd = tick_get_wakeup_device(cpu);
+
+		SEQ_printf(m, "Wakeup Device: %s\n", wd ? wd->name : "<NULL>");
+	}
+#endif
 	SEQ_printf(m, "\n");
 }
 
@@ -248,7 +256,7 @@ static void timer_list_show_tickdevices_header(struct seq_file *m)
 
 static inline void timer_list_header(struct seq_file *m, u64 now)
 {
-	SEQ_printf(m, "Timer List Version: v0.8\n");
+	SEQ_printf(m, "Timer List Version: v0.9\n");
 	SEQ_printf(m, "HRTIMER_MAX_CLOCK_BASES: %d\n", HRTIMER_MAX_CLOCK_BASES);
 	SEQ_printf(m, "now at %Ld nsecs\n", (unsigned long long)now);
 	SEQ_printf(m, "\n");
