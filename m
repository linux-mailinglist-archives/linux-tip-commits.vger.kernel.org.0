Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDFA193430
	for <lists+linux-tip-commits@lfdr.de>; Thu, 26 Mar 2020 00:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbgCYXGw (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 25 Mar 2020 19:06:52 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40337 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbgCYXGw (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 25 Mar 2020 19:06:52 -0400
Received: by mail-ot1-f66.google.com with SMTP id e19so3907414otj.7
        for <linux-tip-commits@vger.kernel.org>; Wed, 25 Mar 2020 16:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gSeT6PbqAXC+RZ7fex1F/Qco9gPlMFnDZIOtqUymYIY=;
        b=kFfszCj8WOXLltRIen3p/mLqt3nA3hHtMUxnONC2/Xe8FHmTK4+aBGpJSExXNej03h
         zCdraEfzjqh8PZkTTGWuWNbSIE5M1EoEwtxM+00+J0P/Lpt7dZMIrYTPgAc430slst4T
         u44FxJACNVqfv5Cac2DUf4TFzWll1xxaIp+rv7IAyLSPcwZxwHBPpvCxYMYeb0DOrJoa
         87BVL3I3kldHT/5ZOgLDLdbIvYoByRTpl1o5sZyo9PONR9vYNu0MdjmhguRiXqldpiPS
         vKcqL+seFDV+pK6O6ph364nRp6f0qUcISe2kQvr2bthbUAwL7X5NUK1HkEkOyVHGdaEZ
         G8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gSeT6PbqAXC+RZ7fex1F/Qco9gPlMFnDZIOtqUymYIY=;
        b=tVVnPWlZ/VfJ0COpR5ZJo/MKARNkndSkCbqaiOoO9oOL6/dlzyQWbwMdE28mj5uvXe
         aCzsrvXnSZ2cK3QL0geR207eip+dbaSjgIhtLubR0kORjA46E3ty0v3k/YkIHUXskquP
         JLl6kb5nPMESB7/bkYtY/pdkc7VJ1K0fq66/9cjRRXk0JzY2AXqJy3KfvIqIF8Vb3g0s
         dPZh/x88qGqy+oyV5/tamYQ5pJDPIAUR7FBg4MpB217A2VHp5dN589DXBqqMa1FBYDjp
         v5k3rGkrF+WUBqR9rACH4znz7baBBAAheg9Cw+mkneqwX3EFrbrbdApgELhlhrG2vWBu
         l+Zw==
X-Gm-Message-State: ANhLgQ0ueCsko/U0mnAHhEKleYtofMUN2H+aKKmY9am3vFcWk26JXHoS
        oZbkQY2byShaiQJBY2YcRzHcybbsmT7p6jRbu4ZRFw==
X-Google-Smtp-Source: ADFU+vs0O3noWCqvzSEKQGm34TPZtpX8RSea0LBVKeJ7RPXLdbsBi2pRXsGBqAcvYH2k7BJZKzr+p6CkqgZ3OjLmCk0=
X-Received: by 2002:a9d:5ad:: with SMTP id 42mr4495473otd.231.1585177611608;
 Wed, 25 Mar 2020 16:06:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200111052125.238212-1-saravanak@google.com> <158460766637.28353.11325960928759668587.tip-bot2@tip-bot2>
 <20200324175955.GA16972@arm.com> <CAGETcx8Qhy3y66vJyi8kRvg1+hXf-goDvyty-bsG5qFrA-CKgg@mail.gmail.com>
 <CAGETcx80wvGnS0-MwJ9M9RR9Mny0jmmep+JfwaUJUOR2bfJYsQ@mail.gmail.com>
 <87lfnoxg2a.fsf@nanos.tec.linutronix.de> <CAGETcx_3GSKmSveiGrM2vQp=q57iZYc0T4ELMY7Zw8UwzPEnYA@mail.gmail.com>
In-Reply-To: <CAGETcx_3GSKmSveiGrM2vQp=q57iZYc0T4ELMY7Zw8UwzPEnYA@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 25 Mar 2020 16:06:15 -0700
Message-ID: <CAGETcx_BZhSmUpN+Gssp1jcjGzG7SdOmg9TAQRhn4q4G_rFUfg@mail.gmail.com>
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

On Wed, Mar 25, 2020 at 3:56 PM Saravana Kannan <saravanak@google.com> wrote:
>
> On Wed, Mar 25, 2020 at 2:47 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > Saravana Kannan <saravanak@google.com> writes:
> > > On Tue, Mar 24, 2020 at 11:34 AM Saravana Kannan <saravanak@google.com> wrote:
> > > I took a closer look. So two different drivers [1] [2] are saying they
> > > know how to handle "arm,vexpress-sysreg" and are expecting to run at
> > > the same time. That seems a bit unusual to me. I wonder if this is a
> > > violation of the device-driver model because this expectation would
> > > never be allowed if these device drivers were actual drivers
> > > registered with driver-core. But that's a discussion for another time.
> > >
> > > To fix this issue you are facing, this patch should work:
> > > https://lore.kernel.org/lkml/20200324195302.203115-1-saravanak@google.com/T/#u
> >
> > Sorry, that's not a fix. That's a crude hack.
>
> If device nodes are being handled by drivers without binding a driver
> to struct devices, then not setting OF_POPULATED is wrong. So the
> original patch sets it. There are also very valid reasons for allowing
> OF_POPULATED to be cleared by a driver as discussed here [1].

Forgot to include [1]
[1] - https://lore.kernel.org/lkml/20200111052125.238212-1-saravanak@google.com/T/#m7b043de4c75e6c1de309d3ca5146bb0c7b3dfc80
For some reason Paul's email is missing from lore.kernel.org.

-Saravana
