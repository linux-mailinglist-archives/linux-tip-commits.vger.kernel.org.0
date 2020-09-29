Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D64727D1E4
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Sep 2020 16:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731340AbgI2Ox1 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 29 Sep 2020 10:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbgI2Ox0 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 29 Sep 2020 10:53:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC329C061755;
        Tue, 29 Sep 2020 07:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7a3rid5iIIJ/qWOxgzz0xAKTGTBmmcrw4IkIb4Li8tM=; b=X7ULjOFEfMhygs0cAAFKwoUbfe
        QrG5N7Kc2U3BpZVT5FJ1yTq6eTIlCA9IijREqZr3c0IWBcSUmZVPOCbOEq0Ao0EIKNRvpriRzVGrF
        uzQSJyIPdgj1oAolKk15Y/NxtwSABCvGPuVwufOGvF/cQOaMm6J/wwVrqddJ9jO5todTEkBb2JcfB
        NL69gp4tOwEOJZGs1OZq7WT+Qi7ORRflp8NqFKgEbaY2sSj5rltPTfV09Xqsx44lxbF2tWddTWWeX
        htozEoPDRJf30TmOhA3RguREbipxKDSLBA55u3dtXj++42BpJ4ULmM3nln5JrG3hN0pHvwaFwbWLs
        0EGLMRZw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kNGzw-0007H5-Gs; Tue, 29 Sep 2020 14:52:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 93D57304B92;
        Tue, 29 Sep 2020 16:52:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4AF59210E84D1; Tue, 29 Sep 2020 16:52:55 +0200 (CEST)
Date:   Tue, 29 Sep 2020 16:52:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>
Subject: Re: [tip: core/rcu] rcu/tree: Mark the idle relevant functions
 noinstr
Message-ID: <20200929145255.GQ2628@hirez.programming.kicks-ass.net>
References: <20200505134100.575356107@linutronix.de>
 <158991795300.17951.11897222265664137612.tip-bot2@tip-bot2>
 <20200929112541.GM2628@hirez.programming.kicks-ass.net>
 <20200929103454.03c29330@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929103454.03c29330@gandalf.local.home>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Tue, Sep 29, 2020 at 10:34:54AM -0400, Steven Rostedt wrote:
> Anyway, you bring up a good point. I should have this:

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 84f32dbc7be8..2d76eaaad4a7 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -6993,16 +6993,14 @@ static void ftrace_ops_assist_func(unsigned long ip, unsigned long parent_ip,
>  {
>  	int bit;
>  
> -	if ((op->flags & FTRACE_OPS_FL_RCU) && !rcu_is_watching())
> -		return;
> -
>  	bit = trace_test_and_set_recursion(TRACE_LIST_START, TRACE_LIST_MAX);
>  	if (bit < 0)
>  		return;
>  
>  	preempt_disable_notrace();
>  
> -	op->func(ip, parent_ip, op, regs);
> +	if (!(op->flags & FTRACE_OPS_FL_RCU) || rcu_is_watching())
> +		op->func(ip, parent_ip, op, regs);
>  
>  	preempt_enable_notrace();
>  	trace_clear_recursion(bit);
> 
> 
> 
> -- Steve
