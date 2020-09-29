Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA61D27C885
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Sep 2020 14:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730427AbgI2Li4 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 29 Sep 2020 07:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730397AbgI2Lim (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 29 Sep 2020 07:38:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8196C0613D8;
        Tue, 29 Sep 2020 04:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=K45FSWL81eUOoatztmQCrTr+UOCs2bFaxc8jCxV4h2E=; b=HK07rgT4+5Xu5gL+tL9A4tn0IX
        jM/ADvK5/oWNeuIXWU6K3RnIhY1vuwBSueK1WwfthV5heHww/NJsh1rinbYDUQTfmKRXD6AP8bVMM
        oC9V/0T+D1iN2RlSzD6wtSt89XdsDwrdhoAgA7gPvwcYtBS/vBc8RBaxMVEtwEmKvpJorFPO8OkRA
        a07/liEG3nYca9WlxLdpt8QTFUZHQujS9iXhQDYov+4sdugMzqZ72zMEdoHVThEp43Zn8I2LJ0Tt9
        ngXca3KC3HfXLxSUpxtvVr02ipy7mqscBjSES6aQKIG04GA5hoRi6qhkKXIl9vIpsAgp0r9NLPScv
        63bFPlQA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kNDlQ-0006ot-G3; Tue, 29 Sep 2020 11:25:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E32AB30753E;
        Tue, 29 Sep 2020 13:25:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B392D200D4C4A; Tue, 29 Sep 2020 13:25:41 +0200 (CEST)
Date:   Tue, 29 Sep 2020 13:25:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [tip: core/rcu] rcu/tree: Mark the idle relevant functions
 noinstr
Message-ID: <20200929112541.GM2628@hirez.programming.kicks-ass.net>
References: <20200505134100.575356107@linutronix.de>
 <158991795300.17951.11897222265664137612.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158991795300.17951.11897222265664137612.tip-bot2@tip-bot2>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Tue, May 19, 2020 at 07:52:33PM -0000, tip-bot2 for Thomas Gleixner wrote:
> @@ -979,7 +988,7 @@ static void rcu_disable_urgency_upon_qs(struct rcu_data *rdp)
>   * if the current CPU is not in its idle loop or is in an interrupt or
>   * NMI handler, return true.
>   */
> -bool notrace rcu_is_watching(void)
> +bool rcu_is_watching(void)
>  {
>  	bool ret;
>  

This ^..

it is required because __ftrace_ops_list_func() /
ftrace_ops_assist_func() call it outside of ftrace recursion, but only
when FL_RCU, and perf happens to be the only user of that.

another morning wasted... :/
