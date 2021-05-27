Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A83039389E
	for <lists+linux-tip-commits@lfdr.de>; Fri, 28 May 2021 00:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236126AbhE0WQo (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 27 May 2021 18:16:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37264 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233563AbhE0WQo (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 27 May 2021 18:16:44 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622153709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bz5YiDobgLiDsvFe5ic6OsOwced+it1yYmTk8KM8Fx4=;
        b=em+xYYNwcrzT0I6ItJWqfS4Abi2XgsdH/oIG7iKRk8ULxctOPXISrWQn2jQYbTmPcHimnE
        ImeMVmcEppMZyongX40EulC5SHc4/ZzUX4nEMBSeENiDqzneY50wzdGZZt/PHbNOJgsaJT
        AKP6Lwg5Kf9iPMybrlYQUD7PULQVX6nEkePrnAu+q37L/ob93fOUwVSqi5soCUDLkBfZI6
        ijb4GfBT4OJAYPtOqkJVsK6fmjRZ4Wy9J432pIU0R1JQxKS4fUepW0eOaidkvswSUG7kPp
        7maDVu5Fj8OuHiHiJHCuD8kgHl/u1Q2vvt/bRnfYgRxc2FUwiXCtfTD8DkaJxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622153709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bz5YiDobgLiDsvFe5ic6OsOwced+it1yYmTk8KM8Fx4=;
        b=qVEw1+EWA+JML/2K6Tg6hNZZNYC7nXBisxw+bnQLaux5C0OFlIXchIg1HpywkNH31NTnst
        6d7tBov7MMA/z/DQ==
To:     tip-bot2 for Kan Liang <tip-bot2@linutronix.de>,
        linux-tip-commits@vger.kernel.org
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra \(Intel\)" <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [tip: perf/core] x86/fpu/xstate: Support dynamic supervisor feature for LBR
In-Reply-To: <159420190464.4006.9196645532990660696.tip-bot2@tip-bot2>
References: <1593780569-62993-21-git-send-email-kan.liang@linux.intel.com> <159420190464.4006.9196645532990660696.tip-bot2@tip-bot2>
Date:   Fri, 28 May 2021 00:15:08 +0200
Message-ID: <87y2bz7rir.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

Peter,

On Wed, Jul 08 2020 at 09:51, tip-bot wrote:
> The following commit has been merged into the perf/core branch of tip:
>
> Commit-ID:     f0dccc9da4c0fda049e99326f85db8c242fd781f
> Gitweb:        https://git.kernel.org/tip/f0dccc9da4c0fda049e99326f85db8c242fd781f
> Author:        Kan Liang <kan.liang@linux.intel.com>
> AuthorDate:    Fri, 03 Jul 2020 05:49:26 -07:00
> Committer:     Peter Zijlstra <peterz@infradead.org>
> CommitterDate: Wed, 08 Jul 2020 11:38:56 +02:00
>
> x86/fpu/xstate: Support dynamic supervisor feature for LBR
>
> Last Branch Records (LBR) registers are used to log taken branches and
> other control flows. In perf with call stack mode, LBR information is
> used to reconstruct a call stack. To get the complete call stack, perf
> has to save/restore all LBR registers during a context switch. Due to
> the large number of the LBR registers, e.g., the current platform has
> 96 LBR registers, this process causes a high CPU overhead. To reduce
> the CPU overhead during a context switch, an LBR state component that
> contains all the LBR related registers is introduced in hardware. All
> LBR registers can be saved/restored together using one XSAVES/XRSTORS
> instruction.
>
> However, the kernel should not save/restore the LBR state component at
> each context switch, like other state components, because of the
> following unique features of LBR:
> - The LBR state component only contains valuable information when LBR
>   is enabled in the perf subsystem, but for most of the time, LBR is
>   disabled.
> - The size of the LBR state component is huge. For the current
>   platform, it's 808 bytes.
> If the kernel saves/restores the LBR state at each context switch, for
> most of the time, it is just a waste of space and cycles.
>
> To efficiently support the LBR state component, it is desired to have:
> - only context-switch the LBR when the LBR feature is enabled in perf.
> - only allocate an LBR-specific XSAVE buffer on demand.
>   (Besides the LBR state, a legacy region and an XSAVE header have to be
>    included in the buffer as well. There is a total of (808+576) byte
>    overhead for the LBR-specific XSAVE buffer. The overhead only happens
>    when the perf is actively using LBRs. There is still a space-saving,
>    on average, when it replaces the constant 808 bytes of overhead for
>    every task, all the time on the systems that support architectural
>    LBR.)
> - be able to use XSAVES/XRSTORS for accessing LBR at run time.
>   However, the IA32_XSS should not be adjusted at run time.
>   (The XCR0 | IA32_XSS are used to determine the requested-feature
>   bitmap (RFBM) of XSAVES.)
>
> A solution, called dynamic supervisor feature, is introduced to address
> this issue, which
> - does not allocate a buffer in each task->fpu;
> - does not save/restore a state component at each context switch;
> - sets the bit corresponding to the dynamic supervisor feature in
>   IA32_XSS at boot time, and avoids setting it at run time.

This needs to be put on hold until the whole fpu signal restore mess is
sorted. The current failure modes are 'harmless', but once XSS comes
into play it becomes dangerous.

Please revert that stuff ASAP until the underlying issues of XSTATE are
sorted and then this wants to be posted again according to the rules I
layed out here:

  https://lore.kernel.org/lkml/874keo80bh.ffs@nanos.tec.linutronix.de/

No if, no but..

Thanks,

        tglx
