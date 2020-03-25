Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAD53193404
	for <lists+linux-tip-commits@lfdr.de>; Wed, 25 Mar 2020 23:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbgCYW5f (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 25 Mar 2020 18:57:35 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34418 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727384AbgCYW5f (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 25 Mar 2020 18:57:35 -0400
Received: by mail-oi1-f195.google.com with SMTP id e9so3827532oii.1
        for <linux-tip-commits@vger.kernel.org>; Wed, 25 Mar 2020 15:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9jk+TK7FwkOPEaur7O1L8OS9jETz+MSJg1VV7n1BSs4=;
        b=GxwBWqTFlxG98S9ZgY1fMAL0tAsYuZ0m+aPOljO3Xfs1s1k4IM4Z6rhrMk6Ql7XSUT
         4mWApBCFTrfKp6drIjCeBZ22t4OkenZwoP1FZahVthaLuTjjCewBRL8aIev2Piwxo6C+
         FHZxYBo9uKWkC4O6tYuCA1ZkX528etgAPF6vNu/Ddp4VMdv7e6BS77PDAiIiXSPpKoiL
         Cax5k/ZorEWQg+IbDRPMrYRocxX/yUcB0Zs31hlqT5atlkJmA6MnjPjtppi9UDN7fGdj
         xPMWWHj0TJTqYinpZxUGm+KtY+jLE4ETwlGGBh5xV1Wh9z8hvhHiMtJO6b6NX1wEMpOO
         RLnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9jk+TK7FwkOPEaur7O1L8OS9jETz+MSJg1VV7n1BSs4=;
        b=ZwqwOoQdWqzwdWGRYvytkNRpOxO+URU1rsA/H0GrvOy+SBMdAEEaDCj1qRdMFQPYYn
         wN3atOldsiC+wNAUvCBiFIP+biziSvZ5UNEPZwjjFoGcGck/Vx8TkKjd6EzdkVNBbTkv
         eXk1a0UIR1hCCBx5J+R0wJoPT32xu62B8WFkQTldkFYHOXFOjubFHuh9SEfsJe6jgcdB
         bh2f33xBMS8rDDgCJ9pvYYOyno52kxzVBJnFbSPVSFUUk001KqluRFV0cZdxx5immlq6
         djlYw+ffR++mw4ayfFEOU0jjnk5uk/c2oltCGXTKJjXqpuLU+thrNfK4DClBtZPUpAa1
         T5JA==
X-Gm-Message-State: ANhLgQ063HFKTC+FN8mg90tN6NzwqV4BNEkPzAJcps1RR9XTAtosDpBY
        u2J7UhOmSm+sZmTdG/1yjNeag+IXt0iOLO/vaHOmpw==
X-Google-Smtp-Source: ADFU+vs75qlVmpOsRcDth/eoqYjqQ/mG2s3897unixiQ4nm2aHS/No7meg/TiHJFnk+64H57Bfx8zHOHDUqC1RdlIoU=
X-Received: by 2002:aca:682:: with SMTP id 124mr4297113oig.69.1585177053451;
 Wed, 25 Mar 2020 15:57:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200111052125.238212-1-saravanak@google.com> <158460766637.28353.11325960928759668587.tip-bot2@tip-bot2>
 <20200324175955.GA16972@arm.com> <CAGETcx8Qhy3y66vJyi8kRvg1+hXf-goDvyty-bsG5qFrA-CKgg@mail.gmail.com>
 <CAGETcx80wvGnS0-MwJ9M9RR9Mny0jmmep+JfwaUJUOR2bfJYsQ@mail.gmail.com> <87lfnoxg2a.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87lfnoxg2a.fsf@nanos.tec.linutronix.de>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 25 Mar 2020 15:56:56 -0700
Message-ID: <CAGETcx_3GSKmSveiGrM2vQp=q57iZYc0T4ELMY7Zw8UwzPEnYA@mail.gmail.com>
Subject: Re: [tip: timers/core] clocksource/drivers/timer-probe: Avoid
 creating dead devices
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ionela Voinescu <ionela.voinescu@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-tip-commits@vger.kernel.org, x86 <x86@kernel.org>,
        liviu.dudau@arm.com, sudeep.holla@arm.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Wed, Mar 25, 2020 at 2:47 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Saravana Kannan <saravanak@google.com> writes:
> > On Tue, Mar 24, 2020 at 11:34 AM Saravana Kannan <saravanak@google.com> wrote:
> > I took a closer look. So two different drivers [1] [2] are saying they
> > know how to handle "arm,vexpress-sysreg" and are expecting to run at
> > the same time. That seems a bit unusual to me. I wonder if this is a
> > violation of the device-driver model because this expectation would
> > never be allowed if these device drivers were actual drivers
> > registered with driver-core. But that's a discussion for another time.
> >
> > To fix this issue you are facing, this patch should work:
> > https://lore.kernel.org/lkml/20200324195302.203115-1-saravanak@google.com/T/#u
>
> Sorry, that's not a fix. That's a crude hack.

If device nodes are being handled by drivers without binding a driver
to struct devices, then not setting OF_POPULATED is wrong. So the
original patch sets it. There are also very valid reasons for allowing
OF_POPULATED to be cleared by a driver as discussed here [1].

The approach of the original patch (setting the flag and letting the
driver sometimes clear it) is also followed by many other frameworks
like irq, clk, i2c, etc. Even ingenic-timer.c already does it for the
exact same reason.

So, why is the vexpress fix a crude hack?

> As this is also causing trouble on tegra30-cardhu-a04 the only sane
> solution is to revert it and start over with a proper solution for the
> vexpress problem and a root cause analysis for the tegra.

If someone can tell me which of the timer drivers are relevant for
tegra30-cardhu-a04, I can help fix it.
If you want to revert the original patch first before waiting for a
tegra fix, that's okay by me.

However, for vexpress, what do you propose I do? The driver itself is
doing weird stuff with two drivers handling the exact same device. I
can't just go edit the DT files because technically I don't know their
hardware. Looks to me like they should have a separate and proper
device for the timer and not have two drivers handle the same device.
If you don't like my vexpress fix, then don't take it but ask the
vexpress maintainer to fix their DT and driver maybe? But that might
break the kernel compatibility with existing DT binaries on devices
(yes, vexpress seems like a virtual platform, so updating DT blobs
might not be hard). My vexpress fix doesn't break backwards
compatibility.

So, can you please accept my vexpress fix or tell us what you think is
a "proper solution"?

-Saravana
