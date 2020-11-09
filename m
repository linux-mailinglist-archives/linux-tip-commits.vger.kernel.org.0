Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9A902AB1D1
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Nov 2020 08:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgKIHlX (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 9 Nov 2020 02:41:23 -0500
Received: from mail.skyhub.de ([5.9.137.197]:49638 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728038AbgKIHlX (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 9 Nov 2020 02:41:23 -0500
Received: from nazgul.tnic (unknown [78.130.214.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 96CDA1EC01A2;
        Mon,  9 Nov 2020 08:41:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1604907681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=DIbuS2LfmwcrnVZ33gSShxTjK/kdj2tHi+5etzeHARo=;
        b=IFcPx3rGnVZYqcl2kZgqIvuKC8i1vlNx9POpmtwYUQvGM/40rl55/ikfGRrZGdrF/VeRLC
        I+ZpP1Gz+XO+GAZrLAg5wCZ9hl2XHPMVR3Aoc1z0NV1Z6i81akkRju1+i8WIwD4cC1h469
        7ynNQX+13clqx3ijBF5bfhmsEVUoKWM=
Date:   Mon, 9 Nov 2020 08:41:24 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>, x86-ml <x86@kernel.org>,
        linux-tip-commits@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [tip: perf/kprobes] locking/atomics: Regenerate the
 atomics-check SHA1's
Message-ID: <20201109074124.GB3781@nazgul.tnic>
References: <160476203869.11244.7869849163897430965.tip-bot2@tip-bot2>
 <20201107160444.GB30275@zn.tnic>
 <20201108090521.GA108695@gmail.com>
 <20201108092333.GA13870@zn.tnic>
 <CAHk-=whVvcAawxiKnoYLRvpPqzgtiqvV+ogBC=q2F0CBqNidnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whVvcAawxiKnoYLRvpPqzgtiqvV+ogBC=q2F0CBqNidnA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Sun, Nov 08, 2020 at 09:35:38AM -0800, Linus Torvalds wrote:
> So while we try to mark scripts executable, we then actually generally
> execute them using an explicit interpreter invocation anyway (ie using
>
>   $(CONFIG_SHELL) "some-script-path"
>
> or similar).

Thanks for explaining!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
