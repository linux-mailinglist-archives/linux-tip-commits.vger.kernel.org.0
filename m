Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA3C2403D5E
	for <lists+linux-tip-commits@lfdr.de>; Wed,  8 Sep 2021 18:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbhIHQKI (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 8 Sep 2021 12:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbhIHQKH (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 8 Sep 2021 12:10:07 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45FCBC061575
        for <linux-tip-commits@vger.kernel.org>; Wed,  8 Sep 2021 09:08:59 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id t19so5398803lfe.13
        for <linux-tip-commits@vger.kernel.org>; Wed, 08 Sep 2021 09:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F5ZeFAknLDpJj0gufvdFHOmCevevfl6tESN6kJ6gAYQ=;
        b=K7yBmZ5ODUwzJy0G0jcYOAQOAvzjZ2K4Y7BSVXC/PKjsSnt1W/esVP6NG0CrPEqZLv
         vl4EG3Oho6nNuiO8w8cWwRpynP/MON/EPcKbZHzGYWwDVVwQZqCDcHY5KbbkKxwnRGzQ
         FQmC6QIVNuaqe/2ky5dtaOZcTd7jTkqvfEY6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F5ZeFAknLDpJj0gufvdFHOmCevevfl6tESN6kJ6gAYQ=;
        b=DT3rYCEWkoofLLdAEQbSbIGdfdqfwciSr8wRKROcIcfRjwacx3HtsA5IJTiXIkK6V2
         5mnHvNb0bQ5Xvb1WhwRqeWpXs3xRq915zRwrsLJWONFbsOl1VA3rDE5bQssZCPhlUvH7
         j1GByrN3+mdrlG0ErbcboEFyK9OPSfZq7BCZThpKPkfBWh5ug3YVBlbNoSrYyChgN5MZ
         G3+IrCnl9n1m8szgMUcjwv5K5Jb5ar213r5HFNtkI6+S2vPHeYcU6LCSwR9lg7yLwwgF
         Cf4UWCpSMc8GkNHZTYmfBVgxw/p/+FP11svgo+xYOxtE1iiAiBg43iLYz9TSJDevmMq0
         zGxQ==
X-Gm-Message-State: AOAM530FYIhiCTOnQzCe19UfPJEFCMQVqx4Gso9bTrK144kJ9M/cJ719
        C0CvCTU0aOxqiUM+DqViTY8dQpYHCPR4NVTqXkk=
X-Google-Smtp-Source: ABdhPJxsrUJB9YMPQR9IY51U6mQ14jyPVe8Jw6RhR4zrWd5E75rRpgCefNsItg9k0WYQ2nPV0sZMNA==
X-Received: by 2002:a19:f00a:: with SMTP id p10mr3047985lfc.37.1631117335690;
        Wed, 08 Sep 2021 09:08:55 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id g16sm229342lfb.13.2021.09.08.09.08.50
        for <linux-tip-commits@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Sep 2021 09:08:54 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id m4so4381586ljq.8
        for <linux-tip-commits@vger.kernel.org>; Wed, 08 Sep 2021 09:08:50 -0700 (PDT)
X-Received: by 2002:a2e:8107:: with SMTP id d7mr3580653ljg.68.1631117329470;
 Wed, 08 Sep 2021 09:08:49 -0700 (PDT)
MIME-Version: 1.0
References: <20180926182920.27644-2-paulmck@linux.ibm.com> <tip-6e89e831a90172bc3d34ecbba52af5b9c4a447d1@git.kernel.org>
 <YTiXyiA92dM9726M@hirez.programming.kicks-ass.net> <YTiiC1mxzHyUJ47F@hirez.programming.kicks-ass.net>
 <20210908144217.GA603644@rowland.harvard.edu>
In-Reply-To: <20210908144217.GA603644@rowland.harvard.edu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 8 Sep 2021 09:08:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiXJygbW+_1BdSX6M8j6z4w8gRSHVcaD5saihaNJApnoQ@mail.gmail.com>
Message-ID: <CAHk-=wiXJygbW+_1BdSX6M8j6z4w8gRSHVcaD5saihaNJApnoQ@mail.gmail.com>
Subject: Re: [tip:locking/core] tools/memory-model: Add extra ordering for
 locks and remove it for ordinary release/acquire
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Anvin <hpa@zytor.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Will Deacon <will@kernel.org>,
        linux-tip-commits@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Wed, Sep 8, 2021 at 7:42 AM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> there is no reason _in theory_ why a CPU shouldn't reorder and interleave
> the operations to get:

I agree about the theory part.

But I think the LKMM should be the strongest ordering that is reasonable.

And it should take common architecture behavior into account.

IOW, if there is some rare architecture where the above can happen,
but no common sane one allows it in practice, we should strive to make
the LKMM the _stronger_ one.

We sure as hell shouldn't say "RISC-V is potentially very weakly
ordered, so we'll allow that weak ordering".

Because overly weak ordering only causes problems for others. And the
performance arguments for it have historically been garbage anyway.
See the pain powerpc goes through because of bad ordering (and even
more so alpha), and see how arm actually strengthened their ordering
to make everybody happier.

So if this is purely a RISC-V thing, then I think it's entirely reasonable to

        spin_unlock(&r);
        spin_lock(&s);

cannot be reordered.

Strict specifications are not a bad thing, and weak memory ordering is
not inherently good.

             Linus
