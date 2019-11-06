Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99232F223E
	for <lists+linux-tip-commits@lfdr.de>; Wed,  6 Nov 2019 23:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbfKFW7t (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 6 Nov 2019 17:59:49 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:34889 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfKFW7s (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 6 Nov 2019 17:59:48 -0500
Received: by mail-il1-f193.google.com with SMTP id z12so38587ilp.2
        for <linux-tip-commits@vger.kernel.org>; Wed, 06 Nov 2019 14:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nHPMaxlZf+iGhM1WM76319OcCFkWQEtpxYutU0G9cJw=;
        b=iEu6GhMWKGPqDdROZouQTym9Q9mYeBlBHPK+wMf5Jjgyv8+GM3AcDGzbrL384Bdlj0
         42T8rNPK9zoNw8E1ls5Xp+9k2TClXGVOjNIm5NKUAPb+Qr172nOOfK2nE2Qn4kVqQ+cQ
         tTuJJP0khcgz4UIaZoYhgubAp2yRU+79WvUPTtKKIWe5TLE+t3aEGLnulUnR3soGkBzj
         huWb6mpQvbQK+Ax3gR3ThIR4y+tDj3u9RvYCPNO9cVM+YNlNgf1YcBlRIc3exBuIuG6A
         0ovL27GT7hJ0xPeEgwkgPva+XONkIK7uzqwCRPHMoNayG12B8zH3TnKF+5uHNEhfSIZT
         7vSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nHPMaxlZf+iGhM1WM76319OcCFkWQEtpxYutU0G9cJw=;
        b=CVGufgDNCfOrFA2MTCK+WvS9BgiLBru0H+k3N3tH2IYLV9uiK4mUS5N4y//+uj5Zd1
         c1OJE175/hEArbhCQ91ivYbNamE/RqsmWHeNWkmQSXT7mDYbAbYAm9644yYSahe0xlz8
         w2irhp1F0Rzd6Wh2DIN2gffykMMfGf/ztHuq7NACZZV3qOOXVcM3/V8ZDXZx2MhWmLB5
         7DGTYZfrXBfx4iskbMEjCQvI1njMAiEfbw7rLQm8h/Bim+jFZQtZIwHaSncLBFgckL6z
         cymB8qqzCNZTCwBmK2twE7lh4KNxCXbBbvbrNNtw+22wkoAfhCr89thA4bnWBrefJDrZ
         ZNRQ==
X-Gm-Message-State: APjAAAVhtUSMIV3PmjZNzbb6hzrBLtdfN8Yhasp5bS/FoCQ3PMomkcOs
        kGsV4RtNusJQpJ1bfXZKTQb5Wg2od7m2pxLkpxP/p0WLmUo=
X-Google-Smtp-Source: APXvYqwRlkwl+v6Wp7sQEggmeJvHEXOHwciMoehv4q2IiT26uzaSaja/7l372WrN9H5SZ6Cg0wK3AS/BitbRtuaosIQ=
X-Received: by 2002:a92:7e0d:: with SMTP id z13mr353370ilc.168.1573081187621;
 Wed, 06 Nov 2019 14:59:47 -0800 (PST)
MIME-Version: 1.0
References: <20191106174804.74723-1-edumazet@google.com> <157307905904.29376.8711513726869840596.tip-bot2@tip-bot2>
 <CANn89iKXi3rWWruKoBwQ8rncwLvkbzjZJWuJL3K05fjAhcySwg@mail.gmail.com>
In-Reply-To: <CANn89iKXi3rWWruKoBwQ8rncwLvkbzjZJWuJL3K05fjAhcySwg@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 6 Nov 2019 14:59:36 -0800
Message-ID: <CANn89iL=xPxejRPC=wHY7q27fLOvFBK-7HtqU_HJo+go3S9UXA@mail.gmail.com>
Subject: Re: [tip: timers/core] hrtimer: Annotate lockless access to timer->state
To:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-tip-commits@vger.kernel.org,
        syzbot <syzkaller@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Wed, Nov 6, 2019 at 2:53 PM Eric Dumazet <edumazet@google.com> wrote:
>
> On Wed, Nov 6, 2019 at 2:24 PM tip-bot2 for Eric Dumazet
> <tip-bot2@linutronix.de> wrote:
> >
> > The following commit has been merged into the timers/core branch of tip:
> >
> > Commit-ID:     56144737e67329c9aaed15f942d46a6302e2e3d8
> > Gitweb:        https://git.kernel.org/tip/56144737e67329c9aaed15f942d46a6302e2e3d8
> > Author:        Eric Dumazet <edumazet@google.com>
> > AuthorDate:    Wed, 06 Nov 2019 09:48:04 -08:00
> > Committer:     Thomas Gleixner <tglx@linutronix.de>
> > CommitterDate: Wed, 06 Nov 2019 23:18:31 +01:00
> >
> > hrtimer: Annotate lockless access to timer->state
> >
>
> I guess we also need to fix timer_pending(), since timer->entry.pprev
> could change while we read it.
>

It is interesting seeing hlist_add_head() has a WRITE_ONCE(h->first, n);,
but no WRITE_ONCE() for the pprev change.

The WRITE_ONCE() was added in commit 1c97be677f72b3c338312aecd36d8fff20322f32
("list: Use WRITE_ONCE() when adding to lists and hlists")
