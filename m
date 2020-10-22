Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAB8829640E
	for <lists+linux-tip-commits@lfdr.de>; Thu, 22 Oct 2020 19:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508325AbgJVRuy (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 22 Oct 2020 13:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504383AbgJVRux (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 22 Oct 2020 13:50:53 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D713C0613CE
        for <linux-tip-commits@vger.kernel.org>; Thu, 22 Oct 2020 10:50:53 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id k18so3318966wmj.5
        for <linux-tip-commits@vger.kernel.org>; Thu, 22 Oct 2020 10:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eVItXkL1JLXbyeJqJGRNhXfqfEg0ptT6nXNRxtfWxa0=;
        b=uBOvMYuKqG0FmnBNcmwnEIjVX9ZWYn6/V3Q+JkV0uQ4jD2H0eRa8UZr5RngEY/lGVU
         TxpCz9tVOXdbNEXOpvuuhexVoTvHnnw57wBjYCeYqMnSUbET6eHaGWsr4f/G9OtCnzZL
         9in6oLGAIQ2NhngHDk9FKAorm6E4FJCWL0sJiMFr1j3H8IV8EA7gXy81orJk1S/Lg85w
         EwtkkSJYCrDHUBDqlpq6BNTTuumV9XIiRmcVW82jvggBwCnfNcVpFT6QetpeHWZb8n6f
         XmVevVZzrBh6Uj1riTk13Ye8kwwzTEFQZQ8bf4OYrH5i+EvbgdG/s/qHWkSZNR3iOaju
         utOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eVItXkL1JLXbyeJqJGRNhXfqfEg0ptT6nXNRxtfWxa0=;
        b=OCUTBZ9Sb8RD7eh9IiPnlpZ2cpw1OlbVEKNBhZ16II8vPAL1EKHB9jdY+J7BvWhxUE
         /ymTQ+1LOuZJmHoX/6wI5qdBY3vEXJhaDk+5ALYVGS8qe2lBWapmJaM5naspZQpAtPCy
         rUiMurZ2IRtE60v4FIgmmVot5jzimXzB8KUyGioPjXzlrzLXaNfqlo2Ry+RhJcIDb2e4
         cLxLG4avW4vBLOykEFBJ2/GfD4LXyQ8KG7BBWBJ7bUEUqOxNphPiIKWCn5P2GS3LPfta
         n73PzU2SBDI/GIEfhzG0KQP1HtY/WfOy8CU5aShiQ5deAnzwW5mKcjGZOXX4+eNtbmH6
         P/RQ==
X-Gm-Message-State: AOAM53006xjvY6gLrE6fzhqfUlfjkJtgEdqKUvtBn+DQuKkAeVtEJZlu
        nqTuBa1pCIMUUvxrlq7DWOEQSFs1v77FfenYk3fKnA==
X-Google-Smtp-Source: ABdhPJzHcGP1pbwBmOgzPo8Pj6iY5KhlbzzQznsV8cunSNzexC1jV3N+lkbx1KObJ/UPbviNvCDOrF0ztwEa55B5lPE=
X-Received: by 2002:a05:600c:2256:: with SMTP id a22mr3644551wmm.138.1603389052121;
 Thu, 22 Oct 2020 10:50:52 -0700 (PDT)
MIME-Version: 1.0
References: <20201009144225.12019-1-jgross@suse.com> <160336379724.7002.17024152211307266195.tip-bot2@tip-bot2>
In-Reply-To: <160336379724.7002.17024152211307266195.tip-bot2@tip-bot2>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Thu, 22 Oct 2020 10:50:40 -0700
Message-ID: <CALCETrWs6iZ+OoEkPNr89biwkxdhr65yj30fwTLxiynvtnVXwg@mail.gmail.com>
Subject: Re: [tip: x86/urgent] x86/alternative: Don't call text_poke() in lazy
 TLB mode
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-tip-commits@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Thu, Oct 22, 2020 at 3:50 AM tip-bot2 for Juergen Gross
<tip-bot2@linutronix.de> wrote:
>
> The following commit has been merged into the x86/urgent branch of tip:
>
> Commit-ID:     abee7c494d8c41bb388839bccc47e06247f0d7de
> Gitweb:        https://git.kernel.org/tip/abee7c494d8c41bb388839bccc47e06247f0d7de
> Author:        Juergen Gross <jgross@suse.com>
> AuthorDate:    Fri, 09 Oct 2020 16:42:25 +02:00
> Committer:     Peter Zijlstra <peterz@infradead.org>
> CommitterDate: Thu, 22 Oct 2020 12:37:23 +02:00
>
> x86/alternative: Don't call text_poke() in lazy TLB mode
>
> When running in lazy TLB mode the currently active page tables might
> be the ones of a previous process, e.g. when running a kernel thread.
>
> This can be problematic in case kernel code is being modified via
> text_poke() in a kernel thread, and on another processor exit_mmap()
> is active for the process which was running on the first cpu before
> the kernel thread.
>
> As text_poke() is using a temporary address space and the former
> address space (obtained via cpu_tlbstate.loaded_mm) is restored
> afterwards, there is a race possible in case the cpu on which
> exit_mmap() is running wants to make sure there are no stale
> references to that address space on any cpu active (this e.g. is
> required when running as a Xen PV guest, where this problem has been
> observed and analyzed).
>
> In order to avoid that, drop off TLB lazy mode before switching to the
> temporary address space.

Now that I'm actually awake:

Acked-by: Andy Lutomirski <luto@kernel.org>

although it might be nice to at least have a comment that there's some
performance being left on the table.

PeterZ, I like your version except that, if we do that, I also think
we should move this whole mess into tlb.c instead of alternative.c.

--Andy

>
> Fixes: cefa929c034eb5d ("x86/mm: Introduce temporary mm structs")
> Signed-off-by: Juergen Gross <jgross@suse.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lkml.kernel.org/r/20201009144225.12019-1-jgross@suse.com
> ---
>  arch/x86/kernel/alternative.c |  9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index cdaab30..cd6be6f 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -807,6 +807,15 @@ static inline temp_mm_state_t use_temporary_mm(struct mm_struct *mm)
>         temp_mm_state_t temp_state;
>
>         lockdep_assert_irqs_disabled();
> +
> +       /*
> +        * Make sure not to be in TLB lazy mode, as otherwise we'll end up
> +        * with a stale address space WITHOUT being in lazy mode after
> +        * restoring the previous mm.
> +        */
> +       if (this_cpu_read(cpu_tlbstate.is_lazy))
> +               leave_mm(smp_processor_id());
> +
>         temp_state.mm = this_cpu_read(cpu_tlbstate.loaded_mm);
>         switch_mm_irqs_off(NULL, mm, current);
>


-- 
Andy Lutomirski
AMA Capital Management, LLC
