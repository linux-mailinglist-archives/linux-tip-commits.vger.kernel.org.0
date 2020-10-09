Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 797DD288258
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 08:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729746AbgJIGg2 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 02:36:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55670 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732075AbgJIGfq (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 02:35:46 -0400
Date:   Fri, 09 Oct 2020 06:35:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602225343;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=775k0R0GTFbUc4mBVyLDNu/QFPFaLOs4Jup+5DySLcc=;
        b=sdTVHY7Sf+KL/dMsI0Yj2OOv+Ma2PVGvoJG6jaRYbc9inMP6P1pcnJNf/rGOCR6BYNtUof
        zVFHTYKYmuTrecj2t4f7jEVuC+LWfIVj1Npk5TIR6sCP05yL9rv4U/GRS2f355/QNzYjEo
        O/NocN7MjoLz4a4tNaOeAsvrVhSSBGheR0x8g4PYXgrb8oeypkYi1b8EL/Qldwmzn4kJZe
        UdgkruvZBExEPZ5iEKnMSk0oG6WedYG7MrSj76in/1B9y4uluzFLbdhYHb+a8mVDjS99ft
        nTevfGw5jjJRW7G7GWzoP+pmPwBheb8/Zzro99iv1iWZrTii4Uz3GuL6m0R8Cw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602225343;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=775k0R0GTFbUc4mBVyLDNu/QFPFaLOs4Jup+5DySLcc=;
        b=xzx+T4gJcUP56Xt9bbgZJTo0vA5UHc3J3D+M89+DioJZrFLqgu77SjKQ018Dg0ThnDaMXG
        WSQBWTGlAUcbxDBA==
From:   "tip-bot2 for Joel Fernandes (Google)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu/trace: Print negative GP numbers correctly
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160222534291.7002.1295780049705161610.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     c30068f41a0e899f870e0158a2c69c68d738bf96
Gitweb:        https://git.kernel.org/tip/c30068f41a0e899f870e0158a2c69c68d738bf96
Author:        Joel Fernandes (Google) <joel@joelfernandes.org>
AuthorDate:    Thu, 18 Jun 2020 21:36:39 -04:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 18:36:04 -07:00

rcu/trace: Print negative GP numbers correctly

GP numbers start from -300 and gp_seq numbers start of -1200 (for a
shift of 2). These negative numbers are printed as unsigned long which
not only takes up more text space, but is rather confusing to the reader
as they have to constantly expend energy to truncate the number. Just
print the negative numbering directly.

Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/trace/events/rcu.h | 54 ++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index ced7123..155b5cb 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -74,17 +74,17 @@ TRACE_EVENT_RCU(rcu_grace_period,
 
 	TP_STRUCT__entry(
 		__field(const char *, rcuname)
-		__field(unsigned long, gp_seq)
+		__field(long, gp_seq)
 		__field(const char *, gpevent)
 	),
 
 	TP_fast_assign(
 		__entry->rcuname = rcuname;
-		__entry->gp_seq = gp_seq;
+		__entry->gp_seq = (long)gp_seq;
 		__entry->gpevent = gpevent;
 	),
 
-	TP_printk("%s %lu %s",
+	TP_printk("%s %ld %s",
 		  __entry->rcuname, __entry->gp_seq, __entry->gpevent)
 );
 
@@ -114,8 +114,8 @@ TRACE_EVENT_RCU(rcu_future_grace_period,
 
 	TP_STRUCT__entry(
 		__field(const char *, rcuname)
-		__field(unsigned long, gp_seq)
-		__field(unsigned long, gp_seq_req)
+		__field(long, gp_seq)
+		__field(long, gp_seq_req)
 		__field(u8, level)
 		__field(int, grplo)
 		__field(int, grphi)
@@ -124,16 +124,16 @@ TRACE_EVENT_RCU(rcu_future_grace_period,
 
 	TP_fast_assign(
 		__entry->rcuname = rcuname;
-		__entry->gp_seq = gp_seq;
-		__entry->gp_seq_req = gp_seq_req;
+		__entry->gp_seq = (long)gp_seq;
+		__entry->gp_seq_req = (long)gp_seq_req;
 		__entry->level = level;
 		__entry->grplo = grplo;
 		__entry->grphi = grphi;
 		__entry->gpevent = gpevent;
 	),
 
-	TP_printk("%s %lu %lu %u %d %d %s",
-		  __entry->rcuname, __entry->gp_seq, __entry->gp_seq_req, __entry->level,
+	TP_printk("%s %ld %ld %u %d %d %s",
+		  __entry->rcuname, (long)__entry->gp_seq, (long)__entry->gp_seq_req, __entry->level,
 		  __entry->grplo, __entry->grphi, __entry->gpevent)
 );
 
@@ -153,7 +153,7 @@ TRACE_EVENT_RCU(rcu_grace_period_init,
 
 	TP_STRUCT__entry(
 		__field(const char *, rcuname)
-		__field(unsigned long, gp_seq)
+		__field(long, gp_seq)
 		__field(u8, level)
 		__field(int, grplo)
 		__field(int, grphi)
@@ -162,14 +162,14 @@ TRACE_EVENT_RCU(rcu_grace_period_init,
 
 	TP_fast_assign(
 		__entry->rcuname = rcuname;
-		__entry->gp_seq = gp_seq;
+		__entry->gp_seq = (long)gp_seq;
 		__entry->level = level;
 		__entry->grplo = grplo;
 		__entry->grphi = grphi;
 		__entry->qsmask = qsmask;
 	),
 
-	TP_printk("%s %lu %u %d %d %lx",
+	TP_printk("%s %ld %u %d %d %lx",
 		  __entry->rcuname, __entry->gp_seq, __entry->level,
 		  __entry->grplo, __entry->grphi, __entry->qsmask)
 );
@@ -197,17 +197,17 @@ TRACE_EVENT_RCU(rcu_exp_grace_period,
 
 	TP_STRUCT__entry(
 		__field(const char *, rcuname)
-		__field(unsigned long, gpseq)
+		__field(long, gpseq)
 		__field(const char *, gpevent)
 	),
 
 	TP_fast_assign(
 		__entry->rcuname = rcuname;
-		__entry->gpseq = gpseq;
+		__entry->gpseq = (long)gpseq;
 		__entry->gpevent = gpevent;
 	),
 
-	TP_printk("%s %lu %s",
+	TP_printk("%s %ld %s",
 		  __entry->rcuname, __entry->gpseq, __entry->gpevent)
 );
 
@@ -316,17 +316,17 @@ TRACE_EVENT_RCU(rcu_preempt_task,
 
 	TP_STRUCT__entry(
 		__field(const char *, rcuname)
-		__field(unsigned long, gp_seq)
+		__field(long, gp_seq)
 		__field(int, pid)
 	),
 
 	TP_fast_assign(
 		__entry->rcuname = rcuname;
-		__entry->gp_seq = gp_seq;
+		__entry->gp_seq = (long)gp_seq;
 		__entry->pid = pid;
 	),
 
-	TP_printk("%s %lu %d",
+	TP_printk("%s %ld %d",
 		  __entry->rcuname, __entry->gp_seq, __entry->pid)
 );
 
@@ -343,17 +343,17 @@ TRACE_EVENT_RCU(rcu_unlock_preempted_task,
 
 	TP_STRUCT__entry(
 		__field(const char *, rcuname)
-		__field(unsigned long, gp_seq)
+		__field(long, gp_seq)
 		__field(int, pid)
 	),
 
 	TP_fast_assign(
 		__entry->rcuname = rcuname;
-		__entry->gp_seq = gp_seq;
+		__entry->gp_seq = (long)gp_seq;
 		__entry->pid = pid;
 	),
 
-	TP_printk("%s %lu %d", __entry->rcuname, __entry->gp_seq, __entry->pid)
+	TP_printk("%s %ld %d", __entry->rcuname, __entry->gp_seq, __entry->pid)
 );
 
 /*
@@ -374,7 +374,7 @@ TRACE_EVENT_RCU(rcu_quiescent_state_report,
 
 	TP_STRUCT__entry(
 		__field(const char *, rcuname)
-		__field(unsigned long, gp_seq)
+		__field(long, gp_seq)
 		__field(unsigned long, mask)
 		__field(unsigned long, qsmask)
 		__field(u8, level)
@@ -385,7 +385,7 @@ TRACE_EVENT_RCU(rcu_quiescent_state_report,
 
 	TP_fast_assign(
 		__entry->rcuname = rcuname;
-		__entry->gp_seq = gp_seq;
+		__entry->gp_seq = (long)gp_seq;
 		__entry->mask = mask;
 		__entry->qsmask = qsmask;
 		__entry->level = level;
@@ -394,7 +394,7 @@ TRACE_EVENT_RCU(rcu_quiescent_state_report,
 		__entry->gp_tasks = gp_tasks;
 	),
 
-	TP_printk("%s %lu %lx>%lx %u %d %d %u",
+	TP_printk("%s %ld %lx>%lx %u %d %d %u",
 		  __entry->rcuname, __entry->gp_seq,
 		  __entry->mask, __entry->qsmask, __entry->level,
 		  __entry->grplo, __entry->grphi, __entry->gp_tasks)
@@ -415,19 +415,19 @@ TRACE_EVENT_RCU(rcu_fqs,
 
 	TP_STRUCT__entry(
 		__field(const char *, rcuname)
-		__field(unsigned long, gp_seq)
+		__field(long, gp_seq)
 		__field(int, cpu)
 		__field(const char *, qsevent)
 	),
 
 	TP_fast_assign(
 		__entry->rcuname = rcuname;
-		__entry->gp_seq = gp_seq;
+		__entry->gp_seq = (long)gp_seq;
 		__entry->cpu = cpu;
 		__entry->qsevent = qsevent;
 	),
 
-	TP_printk("%s %lu %d %s",
+	TP_printk("%s %ld %d %s",
 		  __entry->rcuname, __entry->gp_seq,
 		  __entry->cpu, __entry->qsevent)
 );
