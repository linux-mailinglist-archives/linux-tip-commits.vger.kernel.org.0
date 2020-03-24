Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5CD191A5C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Mar 2020 20:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725866AbgCXT4r (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 24 Mar 2020 15:56:47 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41835 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbgCXT4r (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 24 Mar 2020 15:56:47 -0400
Received: by mail-oi1-f194.google.com with SMTP id k9so7098047oia.8
        for <linux-tip-commits@vger.kernel.org>; Tue, 24 Mar 2020 12:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gZE4z9h2g7tfeXEc5lAdo2RFUTE0whOYKC3745O/DjI=;
        b=Ra6JwLi5z3SIsWkH0HVprH09WBCMNGYmHAb/yvkAu+VBUl9J2DnqUF/0wy5p7uiMbf
         5zeDHgEhuPqCMeuT4M+DDQuAeM5dfahvCpjNymmxCP0rjht3MJJo9QKr1fwlt7v1eSD3
         sJo1OI0/rWgiDIox7MLNOOI7jzJNBsXwEACdZwsdwuq5Pq7Caah54+C+GZ/+ZuiHCzjS
         CxNRMAaTZk5FcWjhJlIdstvN6xT3ZshO4df/Tnb0Zp/5SEVC4O9HQPASO241H2jI8X9W
         8i9m1ruR4g5JImXavIdUr5I8IdQ1hFn+15j+hcmJJTK7+kBffJNsuI2YbKGbsM7dgwe9
         imJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gZE4z9h2g7tfeXEc5lAdo2RFUTE0whOYKC3745O/DjI=;
        b=K3ueTGcVhc1UIOZMaqkklt7E4p5xaq/sNH+wxKsH0HphVeIy9WS/2vdCJ7HpVBiSUx
         yljdYu9DXxneuAnjwB4a33mScXVTAXhyh+oyHk5PZmHiVr+GZPJ2XVjbcDSUlGLqRfcL
         lQIWHFNgu2GvWc4Nt62NXpk4b4CXzqS4y1nx8/C5bx5UXFe2UpdOn5dAj4qQIaaRZkRT
         U4aPYq5G01AGtKQrJ9nR+aE9snf4KcNUBqBRxaidZxs9Kxnfm/ambU2c/7SCyPQn3kcb
         elehMFNnshXkXxKOv3dcCrmAqujA/jb97WrCDGcrpZr/bbJtpNJ8mITq8vKpyROx25Zy
         6CCQ==
X-Gm-Message-State: ANhLgQ2RjUZxB0vVVnI7lGHIaZ9qrgkzAkjZummbuJHKsDYCplHXP0Da
        cVXSOynmLF4q7GEBThFRgrHebYinmPc+hzcfYd8553VmGNI=
X-Google-Smtp-Source: ADFU+vsi6ImxLbDKf+vohQz5qbijEfOUjGladGN87+7hcEfgPvif7TEITopPoXfRrrJa5PBEiiiRC5sGMo/AGxzxa24=
X-Received: by 2002:aca:849:: with SMTP id 70mr4827661oii.30.1585079805548;
 Tue, 24 Mar 2020 12:56:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200111052125.238212-1-saravanak@google.com> <158460766637.28353.11325960928759668587.tip-bot2@tip-bot2>
 <20200324175955.GA16972@arm.com> <CAGETcx8Qhy3y66vJyi8kRvg1+hXf-goDvyty-bsG5qFrA-CKgg@mail.gmail.com>
In-Reply-To: <CAGETcx8Qhy3y66vJyi8kRvg1+hXf-goDvyty-bsG5qFrA-CKgg@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 24 Mar 2020 12:56:09 -0700
Message-ID: <CAGETcx80wvGnS0-MwJ9M9RR9Mny0jmmep+JfwaUJUOR2bfJYsQ@mail.gmail.com>
Subject: Re: [tip: timers/core] clocksource/drivers/timer-probe: Avoid
 creating dead devices
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-tip-commits@vger.kernel.org, x86 <x86@kernel.org>,
        liviu.dudau@arm.com, sudeep.holla@arm.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Tue, Mar 24, 2020 at 11:34 AM Saravana Kannan <saravanak@google.com> wrote:
>
> On Tue, Mar 24, 2020 at 11:00 AM Ionela Voinescu
> <ionela.voinescu@arm.com> wrote:
> >
> > Hi guys,
> >
> > On Thursday 19 Mar 2020 at 08:47:46 (-0000), tip-bot2 for Saravana Kannan wrote:
> > > The following commit has been merged into the timers/core branch of tip:
> > >
> > > Commit-ID:     4f41fe386a94639cd9a1831298d4f85db5662f1e
> > > Gitweb:        https://git.kernel.org/tip/4f41fe386a94639cd9a1831298d4f85db5662f1e
> > > Author:        Saravana Kannan <saravanak@google.com>
> > > AuthorDate:    Fri, 10 Jan 2020 21:21:25 -08:00
> > > Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
> > > CommitterDate: Tue, 17 Mar 2020 13:10:07 +01:00
> > >
> > > clocksource/drivers/timer-probe: Avoid creating dead devices
> > >
> > > Timer initialization is done during early boot way before the driver
> > > core starts processing devices and drivers. Timers initialized during
> > > this early boot period don't really need or use a struct device.
> > >
> > > However, for timers represented as device tree nodes, the struct devices
> > > are still created and sit around unused and wasting memory. This change
> > > avoid this by marking the device tree nodes as "populated" if the
> > > corresponding timer is successfully initialized.
> > >
> > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > > Link: https://lore.kernel.org/r/20200111052125.238212-1-saravanak@google.com
> > > ---
> > >  drivers/clocksource/timer-probe.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/clocksource/timer-probe.c b/drivers/clocksource/timer-probe.c
> > > index ee9574d..a10f28d 100644
> > > --- a/drivers/clocksource/timer-probe.c
> > > +++ b/drivers/clocksource/timer-probe.c
> > > @@ -27,8 +27,10 @@ void __init timer_probe(void)
> > >
> > >               init_func_ret = match->data;
> > >
> > > +             of_node_set_flag(np, OF_POPULATED);
> > >               ret = init_func_ret(np);
> > >               if (ret) {
> > > +                     of_node_clear_flag(np, OF_POPULATED);
> > >                       if (ret != -EPROBE_DEFER)
> > >                               pr_err("Failed to initialize '%pOF': %d\n", np,
> > >                                      ret);
> > >
> >
> > This patch is creating problems on some vexpress platforms - ones that
> > are using CLKSRC_VERSATILE (drivers/clocksource/timer-versatile.c).
> > I noticed issues on TC2 and FVPs (fixed virtual platforms) starting with
> > next-20200318 and still reproducible with next-20200323.
> >
> > It seems the issue this patch causes on TC2 and FVP is related to the
> > vexpress-sysreg node being used early for sched_clock_init
> > (timer_versatile.c: versatile_sched_clock_init). At this point (at
> > time_init) the node will be marked as OF_POPULATED, which flags that a
> > device is already created for it, but it is not, in this case.
> >
> > Later at sysreg_init (vexpress-sysreg.c) a device will fail to be created
> > for it, as one already exists. This will result in a failure to create a
> > bridge and a system controller for a bunch of devices (mostly clocks and
> > regulators).
> >
> > I think on the FVP it does not cause many issues as clocks are fixed and
> > regulator settings are probably nops so it boots fine and throws only
> > some warnings. On TC2 on the other hand it fails to boot and it hangs at
> > starting the kernel.
> >
> > In my opinion the idea of the patch is not bad, but I'm not an expert on
> > this so the most I can offer for now is the basic understanding of the
> > issue. I've Cc-ed a few folks to potentially suggest alternatives/fixes.
> >
> > For now, reverting this patch solves the problems on both platforms.
> > I tested this on next-20200318 which introduced the problem.
>
> I'll reply later today after I take a closer look. But will something
> like what timer-ingenic.c did work for you? You can clear the flag
> inside your early init.

Firstly, sorry my patch broke your platform.

I took a closer look. So two different drivers [1] [2] are saying they
know how to handle "arm,vexpress-sysreg" and are expecting to run at
the same time. That seems a bit unusual to me. I wonder if this is a
violation of the device-driver model because this expectation would
never be allowed if these device drivers were actual drivers
registered with driver-core. But that's a discussion for another time.

To fix this issue you are facing, this patch should work:
https://lore.kernel.org/lkml/20200324195302.203115-1-saravanak@google.com/T/#u

Can you please test it and give a Tested-by?

Thanks,
Saravana

[1] drivers/mfd/vexpress-sysreg.c:  { .compatible = "arm,vexpress-sysreg", },
[2] drivers/clocksource/timer-versatile.c:TIMER_OF_DECLARE(vexpress,
"arm,vexpress-sysreg"
