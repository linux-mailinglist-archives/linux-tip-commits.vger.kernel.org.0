Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 964F92B3A64
	for <lists+linux-tip-commits@lfdr.de>; Sun, 15 Nov 2020 23:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbgKOWvL (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 15 Nov 2020 17:51:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728120AbgKOWvK (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 15 Nov 2020 17:51:10 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55748C0613D1;
        Sun, 15 Nov 2020 14:51:10 -0800 (PST)
Date:   Sun, 15 Nov 2020 22:51:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605480668;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WcooQc5LVp+CoPe6nuQKKXq8gbqAljz9Tq7VEnqrLV8=;
        b=HDulBrP6jTqlQzQOvZppKX0N7+DBMxHGWnAx3bwn1ULhS30jxJrdENio32eaJKDkYuOifK
        u11jHAjMh77itu6YIj6totqO4uYB9h50YY7PeN4xbIl53T+zV8o/3GhzRuvS7unsGVW+oD
        FdliMfVqlLHzeIQQGdwRWnCCqPHw/jyZM4b+ESXeLJcs+GHEv0U0zWQiWX2Q5u8rbTT1UZ
        QjACBLus1IdI6b+IztBWYcl2fhey5J31BZFtK6kByKr9UriCS3PK5O1+PesgLHZ0irB3zz
        uhuTbvEq4hrCEoJPBTDJpOFnlKGs5W5Naiko//Vk6IkgwlKzCRhSdVGgs41APg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605480668;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WcooQc5LVp+CoPe6nuQKKXq8gbqAljz9Tq7VEnqrLV8=;
        b=H8AJz85uyJdKiwUcSMtQYBUf8iBeQrj66ykV7M3IRktfnBqRMwlUaeubdUGScUuhA++PbD
        KcBNF6zizA38jQAw==
From:   "tip-bot2 for Helge Deller" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timer_list: Use printk format instead of
 open-coded symbol lookup
Cc:     Helge Deller <deller@gmx.de>, Thomas Gleixner <tglx@linutronix.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20201104163401.GA3984@ls3530.fritz.box>
References: <20201104163401.GA3984@ls3530.fritz.box>
MIME-Version: 1.0
Message-ID: <160548066806.11244.12654291126762323623.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     da88f9b3113620dcd30fc203236aa53d5430ee98
Gitweb:        https://git.kernel.org/tip/da88f9b3113620dcd30fc203236aa53d5430ee98
Author:        Helge Deller <deller@gmx.de>
AuthorDate:    Wed, 04 Nov 2020 17:34:01 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 15 Nov 2020 20:47:14 +01:00

timer_list: Use printk format instead of open-coded symbol lookup

Use the "%ps" printk format string to resolve symbol names.

This works on all platforms, including ia64, ppc64 and parisc64 on which
one needs to dereference pointers to function descriptors instead of
function pointers.

Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201104163401.GA3984@ls3530.fritz.box


---
 kernel/time/timer_list.c | 66 +++++++++++----------------------------
 1 file changed, 19 insertions(+), 47 deletions(-)

diff --git a/kernel/time/timer_list.c b/kernel/time/timer_list.c
index acb326f..6939140 100644
--- a/kernel/time/timer_list.c
+++ b/kernel/time/timer_list.c
@@ -42,24 +42,11 @@ static void SEQ_printf(struct seq_file *m, const char *fmt, ...)
 	va_end(args);
 }
 
-static void print_name_offset(struct seq_file *m, void *sym)
-{
-	char symname[KSYM_NAME_LEN];
-
-	if (lookup_symbol_name((unsigned long)sym, symname) < 0)
-		SEQ_printf(m, "<%pK>", sym);
-	else
-		SEQ_printf(m, "%s", symname);
-}
-
 static void
 print_timer(struct seq_file *m, struct hrtimer *taddr, struct hrtimer *timer,
 	    int idx, u64 now)
 {
-	SEQ_printf(m, " #%d: ", idx);
-	print_name_offset(m, taddr);
-	SEQ_printf(m, ", ");
-	print_name_offset(m, timer->function);
+	SEQ_printf(m, " #%d: <%pK>, %ps", idx, taddr, timer->function);
 	SEQ_printf(m, ", S:%02x", timer->state);
 	SEQ_printf(m, "\n");
 	SEQ_printf(m, " # expires at %Lu-%Lu nsecs [in %Ld to %Ld nsecs]\n",
@@ -116,9 +103,7 @@ print_base(struct seq_file *m, struct hrtimer_clock_base *base, u64 now)
 
 	SEQ_printf(m, "  .resolution: %u nsecs\n", hrtimer_resolution);
 
-	SEQ_printf(m,   "  .get_time:   ");
-	print_name_offset(m, base->get_time);
-	SEQ_printf(m,   "\n");
+	SEQ_printf(m,   "  .get_time:   %ps\n", base->get_time);
 #ifdef CONFIG_HIGH_RES_TIMERS
 	SEQ_printf(m, "  .offset:     %Lu nsecs\n",
 		   (unsigned long long) ktime_to_ns(base->offset));
@@ -218,42 +203,29 @@ print_tickdevice(struct seq_file *m, struct tick_device *td, int cpu)
 	SEQ_printf(m, " next_event:     %Ld nsecs\n",
 		   (unsigned long long) ktime_to_ns(dev->next_event));
 
-	SEQ_printf(m, " set_next_event: ");
-	print_name_offset(m, dev->set_next_event);
-	SEQ_printf(m, "\n");
+	SEQ_printf(m, " set_next_event: %ps\n", dev->set_next_event);
 
-	if (dev->set_state_shutdown) {
-		SEQ_printf(m, " shutdown: ");
-		print_name_offset(m, dev->set_state_shutdown);
-		SEQ_printf(m, "\n");
-	}
+	if (dev->set_state_shutdown)
+		SEQ_printf(m, " shutdown:       %ps\n",
+			dev->set_state_shutdown);
 
-	if (dev->set_state_periodic) {
-		SEQ_printf(m, " periodic: ");
-		print_name_offset(m, dev->set_state_periodic);
-		SEQ_printf(m, "\n");
-	}
+	if (dev->set_state_periodic)
+		SEQ_printf(m, " periodic:       %ps\n",
+			dev->set_state_periodic);
 
-	if (dev->set_state_oneshot) {
-		SEQ_printf(m, " oneshot:  ");
-		print_name_offset(m, dev->set_state_oneshot);
-		SEQ_printf(m, "\n");
-	}
+	if (dev->set_state_oneshot)
+		SEQ_printf(m, " oneshot:        %ps\n",
+			dev->set_state_oneshot);
 
-	if (dev->set_state_oneshot_stopped) {
-		SEQ_printf(m, " oneshot stopped: ");
-		print_name_offset(m, dev->set_state_oneshot_stopped);
-		SEQ_printf(m, "\n");
-	}
+	if (dev->set_state_oneshot_stopped)
+		SEQ_printf(m, " oneshot stopped: %ps\n",
+			dev->set_state_oneshot_stopped);
 
-	if (dev->tick_resume) {
-		SEQ_printf(m, " resume:   ");
-		print_name_offset(m, dev->tick_resume);
-		SEQ_printf(m, "\n");
-	}
+	if (dev->tick_resume)
+		SEQ_printf(m, " resume:         %ps\n",
+			dev->tick_resume);
 
-	SEQ_printf(m, " event_handler:  ");
-	print_name_offset(m, dev->event_handler);
+	SEQ_printf(m, " event_handler:  %ps\n", dev->event_handler);
 	SEQ_printf(m, "\n");
 	SEQ_printf(m, " retries:        %lu\n", dev->retries);
 	SEQ_printf(m, "\n");
