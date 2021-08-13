Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47BE73EB212
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Aug 2021 09:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239526AbhHMH7Y (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 13 Aug 2021 03:59:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35352 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234844AbhHMH7Y (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 13 Aug 2021 03:59:24 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628841536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4SzenS3v0C8mKzBqnFz4wtCWqUZ8Hxyl8xs0PNOkCDM=;
        b=L9LbdNDQYHpl4ube54bWMV93zLc1O98rtxT34P8capeHCXV5dNg9206/c90rv0Qc2jelcI
        M9ZULsdGMKPShL6Ba+aXz8WbJhmq1uBQAk40dgxf0b3peHQfRE4xVW5acfhwesSdV/vzop
        cT8oR7j6Ii+eJ3w984Czsg04EO9AY29fUiA6rRdBhqKdVsNd0SQe2yl/ym2BCqSAbJ+N/6
        03ERz4mQrpK45LFML+5bNXuQ9z74LhrDrcbuyHsPnH0ezZt9z+ZB1NEXufOV95Y+neH1Ax
        RGgQTgz/j73qBjmFpgDtCf1kc73caT5ypNCxV9GP3DcFdGPMQkwxi7mo0od5Qw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628841536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4SzenS3v0C8mKzBqnFz4wtCWqUZ8Hxyl8xs0PNOkCDM=;
        b=fdXtnLamNiTpGGar32U33o9zINXDrO9RLBvBA2K92xJAIKG1NLcvAv4OZqTZcQXKs2Va8l
        XD3+v18BiUD1MqAA==
To:     Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org,
        linux-tip-commits@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Subject: Re: [PATCH] hrtimer: Unbreak hrtimer_force_reprogram()
In-Reply-To: <8735recskh.ffs@tglx>
References: <20210713135158.054424875@linutronix.de>
 <162861133759.395.7795246170325882103.tip-bot2@tip-bot2>
 <7dfb3b15af67400227e7fa9e1916c8add0374ba9.camel@gmx.de>
 <87a6lmiwi0.ffs@tglx> <877dgqivhy.ffs@tglx> <8735recskh.ffs@tglx>
Date:   Fri, 13 Aug 2021 09:58:55 +0200
Message-ID: <87zgtlbwsg.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Thu, Aug 12 2021 at 22:32, Thomas Gleixner wrote:
> Since the recent consoliation of reprogramming functions,
> hrtimer_force_reprogram() is affected by a check whether the new expiry
> time is past the current expiry time.
>
> This breaks the NOHZ logic as that relies on the fact that the tick hrtimer
> is moved into the future. That means cpu_base->expires_next becomes stale
> and subsequent reprogramming attempts fail as well until the situation is
> cleaned up by an hrtimer interrupts.
>
> For some yet unknown reason this leads to a complete stall, so for now
> partially revert the offending commit to a known working state. The root
> cause for the stall is still investigated and will be fixed in a subsequent
> commit.

So with brain more awake I actually managed to decode the problem. It's
definitely the

           expires > cpu_base->expires_next

check. It not only prevents the NOHZ idle case from moving the next
timer interrupt into the future, it also causes the stall when switching
into high resolution / NOHZ mode. At that point the initial base value
can be smaller than the next event which prevents reprogramming and as
the base value stays stale it prevents any further reprogramming unless
there is a full update of the base which makes the problem go away.

TBH, that optimization logic to prevent reprogramming the timer hardware
for nothing is a bit fragile and non-obvious. I'll have a look to make
this more robust and less obscure.

Thanks,

        tglx

