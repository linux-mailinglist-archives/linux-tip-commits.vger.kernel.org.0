Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9815B38F1A4
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 May 2021 18:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbhEXQgE (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 24 May 2021 12:36:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:38378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232442AbhEXQgE (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 24 May 2021 12:36:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2AAAF6140A
        for <linux-tip-commits@vger.kernel.org>; Mon, 24 May 2021 16:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621874076;
        bh=ZLC8qQnMj4ooJVxFsue4U3K8DWfx8sWZhRr0SsKBcjk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=POmSP74CcUe0KM1A6asTBP5N4cIxU9qdYs5z543h7DwZAi5wWbC+pl8QLI6UkE1G6
         U2321BNMHejTCio06KhWeZyVujf8vQIy+zgeNhstptLNWb6bS9wo4kjmQHjw8R9RQ7
         rDHKy1e6H75XccxTC3E4MurrWi1N7CxvXPUaoIPAE8H1JJPUyPfBJveR7+OMBO7WMb
         /KTAlJ/Fh8Af5kcO1Yyo8m4CXLiQGwCYoOM+g6bXJ59tCp7VDgQ9uPdE0oprCspy5H
         lR6K0JCV1oyUIeWhz5lnd4yvQLgA/LvwtZ+H4tx1sa5np3laPH6v18fkAuQHee3yOl
         JoTZIcQaf1WPA==
Received: by mail-ed1-f48.google.com with SMTP id s6so32648354edu.10
        for <linux-tip-commits@vger.kernel.org>; Mon, 24 May 2021 09:34:36 -0700 (PDT)
X-Gm-Message-State: AOAM532UST6ZyOJ7JuNP0z8OOJTA3GP22LkAkEuGoBzznUVuZnHMI9Yb
        jZHlPnqewzWVL85adRq8vJju8G4Hy3JesG+ksMtBjg==
X-Google-Smtp-Source: ABdhPJy/LkAdwUDEi2HBwJHj8sOm3jtgls+wbFBUGYPLK3LBnPye3W6g3OUK8gFArWJZcw6647SJKzgVJmX+8UAAWoY=
X-Received: by 2002:a05:6402:4251:: with SMTP id g17mr26424758edb.238.1621874074727;
 Mon, 24 May 2021 09:34:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200512145444.15483-6-yu-cheng.yu@intel.com> <158964181793.17951.15480349640697746223.tip-bot2@tip-bot2>
In-Reply-To: <158964181793.17951.15480349640697746223.tip-bot2@tip-bot2>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 24 May 2021 09:34:23 -0700
X-Gmail-Original-Message-ID: <CALCETrXfLbsrBX42Y094YLWTG=pqkrf+aSCLruCGzqnZ0Y=P-Q@mail.gmail.com>
Message-ID: <CALCETrXfLbsrBX42Y094YLWTG=pqkrf+aSCLruCGzqnZ0Y=P-Q@mail.gmail.com>
Subject: Re: [tip: x86/fpu] x86/fpu/xstate: Define new functions for clearing
 fpregs and xstates
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-tip-commits@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>, x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Sat, May 16, 2020 at 8:10 AM tip-bot2 for Fenghua Yu
<tip-bot2@linutronix.de> wrote:
>
> The following commit has been merged into the x86/fpu branch of tip:
>
> Commit-ID:     b860eb8dce5906b14e3a7f3c771e0b3d6ef61b94
> Gitweb:        https://git.kernel.org/tip/b860eb8dce5906b14e3a7f3c771e0b3d6ef61b94
> Author:        Fenghua Yu <fenghua.yu@intel.com>
> AuthorDate:    Tue, 12 May 2020 07:54:39 -07:00
> Committer:     Borislav Petkov <bp@suse.de>
> CommitterDate: Wed, 13 May 2020 13:41:50 +02:00
>
> x86/fpu/xstate: Define new functions for clearing fpregs and xstates

syzbot says this is busted.  I've made no effort to identify the
precise bug that is making syzbot complain, but:

>  /*
> - * Clear FPU registers by setting them up from
> - * the init fpstate:
> + * Clear FPU registers by setting them up from the init fpstate.
> + * Caller must do fpregs_[un]lock() around it.
>   */
> -static inline void copy_init_fpstate_to_fpregs(void)
> +static inline void copy_init_fpstate_to_fpregs(u64 features_mask)
>  {
> -       fpregs_lock();
> -



>         if (use_xsave())
> -               copy_kernel_to_xregs(&init_fpstate.xsave, -1);
> +               copy_kernel_to_xregs(&init_fpstate.xsave, features_mask);
>         else if (static_cpu_has(X86_FEATURE_FXSR))
>                 copy_kernel_to_fxregs(&init_fpstate.fxsave);
>         else
> @@ -307,9 +305,6 @@ static inline void copy_init_fpstate_to_fpregs(void)
>
>         if (boot_cpu_has(X86_FEATURE_OSPKE))
>                 copy_init_pkru_to_fpregs();

if (boot_cpu_has(X86_FEATURE_OSPKE) && (features_mask & PKRU)), perhaps?

> -
> -       fpregs_mark_activate();
> -       fpregs_unlock();
>  }
>
>  /*
> @@ -318,18 +313,40 @@ static inline void copy_init_fpstate_to_fpregs(void)
>   * Called by sys_execve(), by the signal handler code and by various
>   * error paths.
>   */
> -void fpu__clear(struct fpu *fpu)
> +static void fpu__clear(struct fpu *fpu, bool user_only)
>  {
> -       WARN_ON_FPU(fpu != &current->thread.fpu); /* Almost certainly an anomaly */
> +       WARN_ON_FPU(fpu != &current->thread.fpu);
>
> -       fpu__drop(fpu);
> +       if (!static_cpu_has(X86_FEATURE_FPU)) {
> +               fpu__drop(fpu);
> +               fpu__initialize(fpu);
> +               return;
> +       }
>
> -       /*
> -        * Make sure fpstate is cleared and initialized.
> -        */
> -       fpu__initialize(fpu);
> -       if (static_cpu_has(X86_FEATURE_FPU))
> -               copy_init_fpstate_to_fpregs();
> +       fpregs_lock();
> +
> +       if (user_only) {
> +               if (!fpregs_state_valid(fpu, smp_processor_id()) &&
> +                   xfeatures_mask_supervisor())
> +                       copy_kernel_to_xregs(&fpu->state.xsave,
> +                                            xfeatures_mask_supervisor());

This looks correct to me.

So I'm guessing that syzbot may have misattributed the problem.  But
we definitely need to clean up the XRSTOR #GP handling before CET
lands.
