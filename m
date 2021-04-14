Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFE3335EE35
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Apr 2021 09:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236846AbhDNHNr (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 14 Apr 2021 03:13:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51310 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349581AbhDNHNq (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 14 Apr 2021 03:13:46 -0400
Date:   Wed, 14 Apr 2021 09:13:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618384404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s1a8CshZw26m5BPo40fPgY70peR7b/oBo1WgNZJ84PU=;
        b=tfoPDrMz+bDx6GEZ18qfSmD32hyCOd50f121Wj+M1N+AESll+NPKTJF8jLv2RPCaxXKegg
        Qmj85Ehh8bOAwsEnwJ/iz6jAD4LdoA1J7qdCu3em3suVAWV7DKySDCGmpEHnue7IOOwTLp
        IZyNN0oGroPATeyUUzKracVt5rWp0GI+K4tL8eYArpqV0i5yX1tCXJrSwM6R31I7wRMHF0
        Cjqc5Jb6lIsy4oz9K6U5ScTtWg8lDKO2/XV2zpOBlE7V/OtBEkxLHjWFTnsC6yS6F2E9T9
        5MJNV8r1iC5vyO5erEIAeOt+AGF1L/PnXHV2seu3P/lvdWI8nVCWcro6LnDuLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618384404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s1a8CshZw26m5BPo40fPgY70peR7b/oBo1WgNZJ84PU=;
        b=/ji24/zUdBjSgpPBk3m4wRAgZ/rOTRnNiDW44YXS/9ETjOx6+6CyfN+OXZI6NdX9IRqo32
        kaapHP+y/CBhTlBg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>,
        linux-tip-commits@vger.kernel.org,
        Uladzislau Rezki <urezki@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [tip: core/rcu] softirq: Don't try waking ksoftirqd before it
 has been spawned
Message-ID: <20210414071322.nz64kow4sp4nwzmy@linutronix.de>
References: <161814860838.29796.15260901429057690999.tip-bot2@tip-bot2>
 <87czuz1tbc.ffs@nanos.tec.linutronix.de>
 <20210412183645.GF4510@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210412183645.GF4510@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On 2021-04-12 11:36:45 [-0700], Paul E. McKenney wrote:
> > Color me confused. I did not follow the discussion around this
> > completely, but wasn't it agreed on that this rcu torture muck can wait
> > until the threads are brought up?
> 
> Yes, we can cause rcutorture to wait.  But in this case, rcutorture
> is just the messenger, and making it wait would simply be ignoring
> the message.  The message is that someone could invoke any number of
> things that wait on a softirq handler's invocation during the interval
> before ksoftirqd has been spawned.

My memory on this is that the only user, that required this early
behaviour, was kprobe which was recently changed to not need it anymore.
Which makes the test as the only user that remains. Therefore I thought
that this test will be moved to later position (when ksoftirqd is up and
running) and that there is no more requirement for RCU to be completely
up that early in the boot process.

Did I miss anything?

> 
> 							Thanx, Paul

Sebastian
