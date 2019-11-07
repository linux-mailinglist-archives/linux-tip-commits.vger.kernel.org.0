Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFB0F34AE
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2019 17:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729823AbfKGQfq (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 7 Nov 2019 11:35:46 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:41810 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbfKGQfo (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 7 Nov 2019 11:35:44 -0500
Received: by mail-io1-f68.google.com with SMTP id r144so2966823iod.8
        for <linux-tip-commits@vger.kernel.org>; Thu, 07 Nov 2019 08:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+AFTD4gdG3RNMTGK/9nXRonGG4bAdvDwZYfzVR9Jo48=;
        b=AzwcHjDO9ne06auKd8BAeOXMMNo3yGj1X8Sp0qFud95nMtFfFK+WflXwPq/TijSNGI
         jJgYEyq/kNYkHeDfMsw6N+/OukY2VcVj9U9G4OvrzjGsxzMB3CCvaNY5BrmmEjYENCCG
         nGrhLAnFEc+N+sf2T9GsQuocS5my8/VmBQdJOrEI2oA0L43dgmXz8tnqfIRczB5QNC0V
         coxRzqMcel0OCCgGGsCNySkrFNZy7Xd6+PnsJuO5yr/mbPBxi4EWe0CJDPw5WabUtHjR
         eVu3z9yZQEHl4oubNjBTGeA7OLN6j+Uz1/HFE/OUCF6Xj0TVBikP/SIfPO+IBKtqytfP
         ZBNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+AFTD4gdG3RNMTGK/9nXRonGG4bAdvDwZYfzVR9Jo48=;
        b=Cfrw7WoXAEiARS+VIBqwKus/LQTxsHmEML9ic3w3uRZqCw3Lb2ARBVWsLZB+2KX9Ik
         teyjoYv4aI7UrNsDHu7rfjfdBh6cPqaI1pIZ3EnjmPCKempOcm6eCoseW4uCeKopxH9N
         qRoJxmSGDtgj19TiDdiR48wWzTJC4+dPlGs63qgqt+1jEm2wl7ELm6mr5Xsm8j5KoTaO
         x/V8lsrn9X+t7Svurk5pjerRptqwtP7p5ZuUMmHWYvYpiedsh8p5dQFzycKX9/XceZle
         EiTAc8FjNTo09XVk06xMKNZdPbRqi6QNr5YXaDL02tk7BZhM7NMysOSzyDMlIiRiNZ8B
         YAXQ==
X-Gm-Message-State: APjAAAUtw3HnLHEEx4VxkRuH5J4tOOnZBLOGNGOOtZvlTVdqwhSm0u2/
        1mbeBAGZkQa7mkXI2xdb/2eAOPUqSqin+iPZy6brrw==
X-Google-Smtp-Source: APXvYqzhsX0TLQEAxILApJRiP0wSy/GIZcyXlvCbDnsJ/W/YMhH5i9RTQiKdYXG153AUfbndzWkGg6JtTMWmdtVLYX4=
X-Received: by 2002:a5d:9059:: with SMTP id v25mr1209422ioq.58.1573144541410;
 Thu, 07 Nov 2019 08:35:41 -0800 (PST)
MIME-Version: 1.0
References: <20191106174804.74723-1-edumazet@google.com> <157307905904.29376.8711513726869840596.tip-bot2@tip-bot2>
 <CANn89iKXi3rWWruKoBwQ8rncwLvkbzjZJWuJL3K05fjAhcySwg@mail.gmail.com>
 <CANn89iL=xPxejRPC=wHY7q27fLOvFBK-7HtqU_HJo+go3S9UXA@mail.gmail.com>
 <20191107085255.GK20975@paulmck-ThinkPad-P72> <CANn89i+8Hq5j234zFRY05QxZU1n=Vr6S-kZCcvn3Z80xYaindg@mail.gmail.com>
 <20191107161149.GQ20975@paulmck-ThinkPad-P72>
In-Reply-To: <20191107161149.GQ20975@paulmck-ThinkPad-P72>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 7 Nov 2019 08:35:30 -0800
Message-ID: <CANn89iLMD0=tiQ181qQ=qKo=Nom-XX4MqonZw6pKiYUzTDVjQg@mail.gmail.com>
Subject: Re: [tip: timers/core] hrtimer: Annotate lockless access to timer->state
To:     paulmck@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-tip-commits@vger.kernel.org,
        syzbot <syzkaller@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Thu, Nov 7, 2019 at 8:11 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> OK, so this is due to timer_pending() lockless access to ->entry.pprev
> to determine whether or not the timer is on the list.  New one on me!
>
> Given that use case, I don't have an objection to your patch to list.h.
>
> Except...
>
> Would it make sense to add a READ_ONCE() to hlist_unhashed()
> and to then make timer_pending() invoke hlist_unhashed()?  That
> would better confine the needed uses of READ_ONCE().

Sounds good to me, I had the same idea but was too lazy to look at the
history of timer_pending()
to check if the pprev pointer check was really the same underlying idea.
