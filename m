Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2674135F034
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Apr 2021 10:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbhDNI6f (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 14 Apr 2021 04:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbhDNI6X (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 14 Apr 2021 04:58:23 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A897EC061574;
        Wed, 14 Apr 2021 01:58:01 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id z13so14890441lfd.9;
        Wed, 14 Apr 2021 01:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ph9XQ9XOgzFb8hQj36afy01qe+N6O8vJ6sBQUEUFgjQ=;
        b=ZKNL4S1a8QSlbHFJkJ3vEJnERpY2IX58VdvvrdSd7cjTOJrr0nS/9QDds6N+8n7bHS
         Ugwlg+PDn/r10PQyWTY75X3G/dF3bR+59EXUdeOAyxVdGyMt4tF/6ozpZyJx0kM/R4YM
         3m9ejgd9OCvDFW+KaIMoxdc3hyvDMwE8cau606/XA+cFXkO/Zp1ID37mrI3ZmyDW8kSa
         VVgd68R8iao1o/t/nsn99WR9uhahZm8Ng/3mvH0wuDwtMxxVjTxoLmtvYf1lTyni6hcV
         /fbN3ze2i3YEONGBJeGhoDacKaaa9i3UxpjUFSHIgiASHjyZ4ibeKUIKa1ifuPpCE//u
         d92A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ph9XQ9XOgzFb8hQj36afy01qe+N6O8vJ6sBQUEUFgjQ=;
        b=SDociZUk8gfwdOvIg027UdLo2QF0U92VkqiHH876cux5oGxJaKbwzf9LfRFlu4KbGN
         vyL3Omb+VNyHM170CUijca5BJw2swjuME9Mq0CzKVabYXs3Fkut1joRSw/L9HeZfWwEH
         4yNq6365cYDBgn91HYApHPNgSiqJmgrzyP5DdmCl86KKfh99gsmPT6r1RQzVrfdId8iZ
         GWhjIQH7nGq+xkAMbFSn3WYWNmJdhC+LoA5PGV2tXRuGh8mFoMdACCvakU2eLYpvaALl
         P7BK3eqR/4uKzRWcSkGanxER7sOp9QUvF6Ewnxx+K2080PAT4eCZZOw5G0fmYFrR0CPW
         wUtg==
X-Gm-Message-State: AOAM531J4rkPzyjinkmffmWUivZp1yFS6Kr04WJ8+EllJsB2alBTvbRX
        g0NheevuktTfVejvtTWX7p4=
X-Google-Smtp-Source: ABdhPJyPVJ48xxfFHJ8Zj6MwTawErcp9PqHJ4WYdoqnv+PkW4dG0fXP8ro5obRg6guPF61d7rCSVtQ==
X-Received: by 2002:a19:c143:: with SMTP id r64mr24937402lff.96.1618390680127;
        Wed, 14 Apr 2021 01:58:00 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id a2sm3942066lfh.19.2021.04.14.01.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 01:57:59 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Wed, 14 Apr 2021 10:57:57 +0200
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>,
        linux-tip-commits@vger.kernel.org,
        Uladzislau Rezki <urezki@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [tip: core/rcu] softirq: Don't try waking ksoftirqd before it
 has been spawned
Message-ID: <20210414085757.GA1917@pc638.lan>
References: <161814860838.29796.15260901429057690999.tip-bot2@tip-bot2>
 <87czuz1tbc.ffs@nanos.tec.linutronix.de>
 <20210412183645.GF4510@paulmck-ThinkPad-P17-Gen-1>
 <20210414071322.nz64kow4sp4nwzmy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414071322.nz64kow4sp4nwzmy@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Wed, Apr 14, 2021 at 09:13:22AM +0200, Sebastian Andrzej Siewior wrote:
> On 2021-04-12 11:36:45 [-0700], Paul E. McKenney wrote:
> > > Color me confused. I did not follow the discussion around this
> > > completely, but wasn't it agreed on that this rcu torture muck can wait
> > > until the threads are brought up?
> > 
> > Yes, we can cause rcutorture to wait.  But in this case, rcutorture
> > is just the messenger, and making it wait would simply be ignoring
> > the message.  The message is that someone could invoke any number of
> > things that wait on a softirq handler's invocation during the interval
> > before ksoftirqd has been spawned.
> 
> My memory on this is that the only user, that required this early
> behaviour, was kprobe which was recently changed to not need it anymore.
> Which makes the test as the only user that remains. Therefore I thought
> that this test will be moved to later position (when ksoftirqd is up and
> running) and that there is no more requirement for RCU to be completely
> up that early in the boot process.
> 
> Did I miss anything?
> 
Seems not. Let me wrap it up a bit though i may miss something:

1) Initially we had an issue with booting RISV because of:

36dadef23fcc ("kprobes: Init kprobes in early_initcall")

i.e. a developer decided to move initialization of kprobe at
early_initcall() phase. Since kprobe uses synchronize_rcu_tasks()
a system did not boot due to the fact that RCU-tasks were setup
at core_initcall() step. It happens later in this chain.

To address that issue, we had decided to move RCU-tasks setup
to before early_initcall() and it worked well:

https://lore.kernel.org/lkml/20210218083636.GA2030@pc638.lan/T/

2) After that fix you reported another issue. If the kernel is run
with "threadirqs=1" - it did not boot also. Because ksoftirqd does
not exist by that time, thus our early-rcu-self test did not pass.

3) Due to (2), Masami Hiramatsu proposed to fix kprobes by delaying
kprobe optimization and it also addressed initial issue:

https://lore.kernel.org/lkml/20210219112357.GA34462@pc638.lan/T/

At the same time Paul made another patch:

softirq: Don't try waking ksoftirqd before it has been spawned

it allows us to keep RCU-tasks initialization before even
early_initcall() where it is now and let our rcu-self-test
to be completed without any hanging.

--
Vlad Rezki
