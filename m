Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73CD028C265
	for <lists+linux-tip-commits@lfdr.de>; Mon, 12 Oct 2020 22:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730073AbgJLUar (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 12 Oct 2020 16:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbgJLUaq (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 12 Oct 2020 16:30:46 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B580BC0613D0
        for <linux-tip-commits@vger.kernel.org>; Mon, 12 Oct 2020 13:30:46 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 10so5173558pfp.5
        for <linux-tip-commits@vger.kernel.org>; Mon, 12 Oct 2020 13:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=92bEnA9H8SNJVNNEXdCaE7fELDRnT1hkxToMXMt8tLA=;
        b=HIzavVBrjsYEPQ7zy0x1ixfFocokAD1tqxPGdjDYhes2oevtUfqY5UIZh9P6HklKje
         HC8JHxJUWPG5dzOYZ1r16QkKifB8c9cwTeiy88Qc0ppBNaPwi4jb7ItH/p69MNInchXT
         B9YfxheLzcZn49W5OLfOCfQqf4Ddc9IGB26PY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=92bEnA9H8SNJVNNEXdCaE7fELDRnT1hkxToMXMt8tLA=;
        b=YbH2bo3xxmXx6TMNalfILB/LRqw7ihVV+OAH8A0hfBprdjNpDUnsAnRof5BnG4JZFz
         TiNCK0IFUI1iXDSpsCfjl7z4ngSWmSA2XZW8njl7shR7recVNxE5qui9/AH/+B3vJrv5
         6QvlEdjEUjNVzZgLmIRwII+hFJNrZGWypG0TNWJAFNl4Wdz5yGSSDuNqAAtdciJi53GQ
         FOUtIqtQBMvmNqxJJ3ZLaCE+d/R8Rce0dEI91JiiVrdBhue+WnM2YgYNM16U39uVzhQT
         BZMjXbfsmK7FC7BgqCEaTReaudDkOyEarpzNesJNmDDWabEZWplakFKr3Xjr4Ba5zWKH
         Lkkg==
X-Gm-Message-State: AOAM531FKZUemRfbj95c43/u25HsG/pP1dpoN0uOMPU4ghlpaUAPrf1N
        DPaRN/7MkVmExaUoPywShmuNEA==
X-Google-Smtp-Source: ABdhPJwJEP74UTtY0Q33+EQuKQPgJX/KiKy/9Mz86zmV36sv0w+P6X0F9bskoZGMEMk35HIF8oYiEw==
X-Received: by 2002:a17:90a:7d16:: with SMTP id g22mr21849656pjl.135.1602534646290;
        Mon, 12 Oct 2020 13:30:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k127sm5983990pgk.10.2020.10.12.13.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 13:30:45 -0700 (PDT)
Date:   Mon, 12 Oct 2020 13:30:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Marco Elver <elver@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        syzkaller <syzkaller@googlegroups.com>,
        linux-tip-commits <linux-tip-commits@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>
Subject: Re: [tip: x86/entry] x86/entry: Convert Divide Error to IDTENTRY
Message-ID: <202010121329.1DEA8CD@keescook>
References: <20200505134904.663914713@linutronix.de>
 <158991831479.17951.17390452716048622271.tip-bot2@tip-bot2>
 <CACT4Y+bTZFkuZd7+bPArowOv-7Die+WZpfOWnEO_Wgs3U59+oA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+bTZFkuZd7+bPArowOv-7Die+WZpfOWnEO_Wgs3U59+oA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Sun, Oct 11, 2020 at 05:25:22PM +0200, Dmitry Vyukov wrote:
> On Tue, May 19, 2020 at 9:59 PM tip-bot2 for Thomas Gleixner
> <tip-bot2@linutronix.de> wrote:
> >
> > The following commit has been merged into the x86/entry branch of tip:
> >
> > -DO_ERROR(X86_TRAP_DE,     SIGFPE,  FPE_INTDIV,   IP, "divide error",        divide_error)
> >
> > +DEFINE_IDTENTRY(exc_divide_error)
> > +{
> > +       do_error_trap(regs, 0, "divide_error", X86_TRAP_DE, SIGFPE,
> > +                     FPE_INTDIV, error_get_trap_addr(regs));
> > +}
> 
> I suppose this is a copy-paste typo and was supposed to be "divide
> error", right?
> Otherwise it changes how kernel oopses look like and breaks syzkaller
> crash parsing, and probably of every other kernel testing system that
> looks for kernel crashes.
> 
> syzkaller now says just the following for divide errors, without
> attribution to function/file/maintainers:
> 
> kernel panic: Fatal exception (3)
> FS:  0000000000000000(0000) GS:ffff8880ae500000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000004c9428 CR3: 0000000009e8d000 CR4: 00000000001506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Kernel panic - not syncing: Fatal exception in interrupt
> Kernel Offset: disabled
> Rebooting in 86400 seconds..
> 
> I will fix it up in syzkaller. It is now required anyway since this
> new crash mode is in git history, so needed for bisection and testing
> of older releases.
> 
> It is not the first time kernel crash output changes
> intentionally/unintentionally breaking kernel testing.
> But I wonder if LKDTM can be turned into actual executable tests that
> produce pass/fail and fix crash output for different oopses?
> Marco, you implemented some "output tests" for KCSAN. Can that be
> extended to other crash types? With some KUnit help? However, I am not
> sure about hard panics, they may not play well with unit-testing...

A lot of the behavioral tests in LKDTM end up triggering arch-specific
logging. I decided to avoid trying to consolidate it in favor of
actually getting the test coverage. :)

-- 
Kees Cook
