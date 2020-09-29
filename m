Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D43F227D148
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Sep 2020 16:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730178AbgI2Oe6 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 29 Sep 2020 10:34:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:44064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729299AbgI2Oe6 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 29 Sep 2020 10:34:58 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CABEC20739;
        Tue, 29 Sep 2020 14:34:56 +0000 (UTC)
Date:   Tue, 29 Sep 2020 10:34:54 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>
Subject: Re: [tip: core/rcu] rcu/tree: Mark the idle relevant functions
 noinstr
Message-ID: <20200929103454.03c29330@gandalf.local.home>
In-Reply-To: <20200929112541.GM2628@hirez.programming.kicks-ass.net>
References: <20200505134100.575356107@linutronix.de>
        <158991795300.17951.11897222265664137612.tip-bot2@tip-bot2>
        <20200929112541.GM2628@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Tue, 29 Sep 2020 13:25:41 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, May 19, 2020 at 07:52:33PM -0000, tip-bot2 for Thomas Gleixner wrote:
> > @@ -979,7 +988,7 @@ static void rcu_disable_urgency_upon_qs(struct rcu_data *rdp)
> >   * if the current CPU is not in its idle loop or is in an interrupt or
> >   * NMI handler, return true.
> >   */
> > -bool notrace rcu_is_watching(void)
> > +bool rcu_is_watching(void)
> >  {
> >  	bool ret;
> >    
> 
> This ^..
> 
> it is required because __ftrace_ops_list_func() /
> ftrace_ops_assist_func() call it outside of ftrace recursion, but only
> when FL_RCU, and perf happens to be the only user of that.
> 
> another morning wasted... :/

Those are fun to debug. :-p (I'll use this in another email).

Anyway, you bring up a good point. I should have this:

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 84f32dbc7be8..2d76eaaad4a7 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6993,16 +6993,14 @@ static void ftrace_ops_assist_func(unsigned long ip, unsigned long parent_ip,
 {
 	int bit;
 
-	if ((op->flags & FTRACE_OPS_FL_RCU) && !rcu_is_watching())
-		return;
-
 	bit = trace_test_and_set_recursion(TRACE_LIST_START, TRACE_LIST_MAX);
 	if (bit < 0)
 		return;
 
 	preempt_disable_notrace();
 
-	op->func(ip, parent_ip, op, regs);
+	if (!(op->flags & FTRACE_OPS_FL_RCU) || rcu_is_watching())
+		op->func(ip, parent_ip, op, regs);
 
 	preempt_enable_notrace();
 	trace_clear_recursion(bit);



-- Steve
