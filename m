Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1956A194586
	for <lists+linux-tip-commits@lfdr.de>; Thu, 26 Mar 2020 18:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbgCZRgb (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 26 Mar 2020 13:36:31 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45834 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgCZRga (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 26 Mar 2020 13:36:30 -0400
Received: by mail-oi1-f195.google.com with SMTP id l22so6209764oii.12
        for <linux-tip-commits@vger.kernel.org>; Thu, 26 Mar 2020 10:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ksp5Sn0D2BCzxAWL5WIyush4E3FbeS39jm1gaEuKlPM=;
        b=aom4ucNcTUQhWPzVTqDvFvPAfYHfWfK0KLSjwT7h+o8E+zDmiouxvPbHIuwl5pVfUY
         8GCufmcl8u3PZF9YMIWcrKqJ6EHbF4eYWr2mRvWj34BTIFk34r6TcInkAgUovApwkg3O
         2ueLARfDzJxGCUeT6GiGdxUIGSyvnbUjRimkCviSJnK35uI+KiZXfruurW3fNlZJ+Xzw
         DmeeGVPr7T+um/KhA6QhHNfJsIVI7uhiXqReqvolCWpHGw83HSDPOZTp+nNX5yJSNuMZ
         p2b0ANcN/SPeBjNg8ybQ5St4js7J2n7+inzA+w60BpHcz407XVGG5RZNHRhVZc2NE76J
         1t3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ksp5Sn0D2BCzxAWL5WIyush4E3FbeS39jm1gaEuKlPM=;
        b=d26fwHlPy2Jd+BL16JmExImaUkRhaAOrhZaJodBVCbk93scPPDF3cOpq/oA6hhnS20
         6kRdc8uhLGNGX4igPOpKhmGSHE8DjrqGvXRhDU6CzQAmxg+ck0jONu+YAeN2zsPK7Hgs
         gHQLD/g6dyYGrhUgOwhENMkn+q9sYaDUM7l7EglvZ8lPX7QeQf7xAZ9IdYmJlp4uKzOY
         XjYI1uZmPlYn/3yr5RB1/FboPMzMaOVshJB0MVf0oZguxfjl8lfBxMN0YZr6xJpOMOGj
         eCELZN36rC5xH7W+AfCe3E3UoWJCQZLKlivdVn9KnhN9UBFr88YUaSikXpYD5qt+nseH
         3+dA==
X-Gm-Message-State: ANhLgQ3dEDzDFVCBSV0ycrincR5nQJ4Lfcs/4lMGGDqUEKoJkSi7biV3
        iKjPpZMVJRJi1pUORPE+wAYXwoKA9nXmYFimReahn/gA
X-Google-Smtp-Source: ADFU+vsUFgYfTh9MfYEpNtnCc+Ey7SO/N36tAbJifWJH/LQd66sU0sgoNrCQ52m6Fhte7Jrd4RO8rT31PNt+Uh5W3fg=
X-Received: by 2002:aca:f541:: with SMTP id t62mr993785oih.172.1585244189614;
 Thu, 26 Mar 2020 10:36:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200111052125.238212-1-saravanak@google.com> <158460766637.28353.11325960928759668587.tip-bot2@tip-bot2>
 <20200324175955.GA16972@arm.com> <CAGETcx8Qhy3y66vJyi8kRvg1+hXf-goDvyty-bsG5qFrA-CKgg@mail.gmail.com>
 <CAGETcx80wvGnS0-MwJ9M9RR9Mny0jmmep+JfwaUJUOR2bfJYsQ@mail.gmail.com>
 <87lfnoxg2a.fsf@nanos.tec.linutronix.de> <CAGETcx_3GSKmSveiGrM2vQp=q57iZYc0T4ELMY7Zw8UwzPEnYA@mail.gmail.com>
 <4be7d1bf-9039-4ca0-02ac-d90d01cf1c4b@linaro.org>
In-Reply-To: <4be7d1bf-9039-4ca0-02ac-d90d01cf1c4b@linaro.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 26 Mar 2020 10:35:46 -0700
Message-ID: <CAGETcx_uz91H-+6YfChA0PsGsC6Vc90grhTsgG3pAv=xGtqpSA@mail.gmail.com>
Subject: Re: [tip: timers/core] clocksource/drivers/timer-probe: Avoid
 creating dead devices
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-tip-commits@vger.kernel.org, x86 <x86@kernel.org>,
        liviu.dudau@arm.com, sudeep.holla@arm.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Thu, Mar 26, 2020 at 3:18 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Saravana,
>
> On 25/03/2020 23:56, Saravana Kannan wrote:
> > On Wed, Mar 25, 2020 at 2:47 PM Thomas Gleixner
> > <tglx@linutronix.de> wrote:
> >>
> >> Saravana Kannan <saravanak@google.com> writes:
> >>> On Tue, Mar 24, 2020 at 11:34 AM Saravana Kannan
> >>> <saravanak@google.com> wrote: I took a closer look. So two
> >>> different drivers [1] [2] are saying they know how to handle
> >>> "arm,vexpress-sysreg" and are expecting to run at the same
> >>> time. That seems a bit unusual to me. I wonder if this is a
> >>> violation of the device-driver model because this expectation
> >>> would never be allowed if these device drivers were actual
> >>> drivers registered with driver-core. But that's a discussion
> >>> for another time.
> >>>
> >>> To fix this issue you are facing, this patch should work:
> >>> https://lore.kernel.org/lkml/20200324195302.203115-1-saravanak@google=
.com/T/#u
> >>
> >>
> >>>
> >>>
> >>>
> > Sorry, that's not a fix. That's a crude hack.
> >
> > If device nodes are being handled by drivers without binding a
> > driver to struct devices, then not setting OF_POPULATED is wrong.
> > So the original patch sets it. There are also very valid reasons
> > for allowing OF_POPULATED to be cleared by a driver as discussed
> > here [1].
> >
> > The approach of the original patch (setting the flag and letting
> > the driver sometimes clear it) is also followed by many other
> > frameworks like irq, clk, i2c, etc. Even ingenic-timer.c already
> > does it for the exact same reason.
> >
> > So, why is the vexpress fix a crude hack?
> >
> >> As this is also causing trouble on tegra30-cardhu-a04 the only
> >> sane solution is to revert it and start over with a proper
> >> solution for the vexpress problem and a root cause analysis for
> >> the tegra.
> >
> > If someone can tell me which of the timer drivers are relevant for
> > tegra30-cardhu-a04, I can help fix it. If you want to revert the
> > original patch first before waiting for a tegra fix, that's okay by
> > me.
>
>
> It seems the OF_POPULATED flag change spotted something wrong in
> different drivers and that is a good thing. Thanks for your patch for
> that.
>
> Without putting in question your analysis, we need to stabilize the
> release, can you send a revert of your patch?
>
> Let's try to figure out what is happening and fix the issues in the
> other drivers for the next cycle.

Make sense. Will do soon.

-Saravana

>
> Thanks
>
>   -- Daniel
>
>
>
> --
> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
