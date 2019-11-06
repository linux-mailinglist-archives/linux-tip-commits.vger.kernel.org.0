Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52807F217C
	for <lists+linux-tip-commits@lfdr.de>; Wed,  6 Nov 2019 23:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfKFWQy (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 6 Nov 2019 17:16:54 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45430 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbfKFWQy (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 6 Nov 2019 17:16:54 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iSTbf-0004AT-Vz; Wed, 06 Nov 2019 23:16:52 +0100
Date:   Wed, 6 Nov 2019 23:16:51 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Eric Dumazet <edumazet@google.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-tip-commits@vger.kernel.org,
        syzbot <syzkaller@googlegroups.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>
Subject: Re: [tip: timers/core] hrtimer: Annotate lockless access to
 timer->state
In-Reply-To: <CANn89iKBaEdCzgF-MT1wrxBZtBD2Ktr9qeThTG_XKOy742XcmQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1911062316310.1869@nanos.tec.linutronix.de>
References: <20191106174804.74723-1-edumazet@google.com> <157307438959.29376.9644507314555163943.tip-bot2@tip-bot2> <CANn89iKBaEdCzgF-MT1wrxBZtBD2Ktr9qeThTG_XKOy742XcmQ@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Wed, 6 Nov 2019, Eric Dumazet wrote:
> > -static inline int hrtimer_is_queued(struct hrtimer *timer)
> > +static inline bool hrtimer_is_queued(struct hrtimer *timer)
> >  {
> > -       return timer->state & HRTIMER_STATE_ENQUEUED;
> > +       /* The READ_ONCE pairs with the update functions of timer->state */
> > +       return !!READ_ONCE(timer->state) & HRTIMER_STATE_ENQUEUED;
> 
> You probably meant :
> 
> return !!(READ_ONCE(timer->state) & HRTIMER_STATE_ENQUEUED);
> 
> Sorry for not spotting this earlier.

Yes, I'm a moron....

