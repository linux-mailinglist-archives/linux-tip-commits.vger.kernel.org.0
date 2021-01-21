Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 815E72FE757
	for <lists+linux-tip-commits@lfdr.de>; Thu, 21 Jan 2021 11:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbhAUKRQ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 21 Jan 2021 05:17:16 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:48729 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729016AbhAUKQn (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 21 Jan 2021 05:16:43 -0500
Received: from mail-ej1-f69.google.com ([209.85.218.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <andrea.righi@canonical.com>)
        id 1l2X0F-00005C-0i
        for linux-tip-commits@vger.kernel.org; Thu, 21 Jan 2021 10:15:47 +0000
Received: by mail-ej1-f69.google.com with SMTP id le12so554779ejb.13
        for <linux-tip-commits@vger.kernel.org>; Thu, 21 Jan 2021 02:15:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nUFfyvUlJANPl5QUFEVLx1yTXROv8TYtpca6Xw1vx/o=;
        b=U9efKUtX1YPZB4jaQUaydjShpaDV66wx3N9U8Vu9m7pg8hejBj4iYai+JuoPlVpUim
         aRo3n2ctfeJKbGPrqwvNEA0EyM5bFkNlnw4/2H0Its1NaBPDW7pLECX5tHqrzAflx6z9
         knd1+HjU9aww693oCZ6a3wKLat2pKXn2HQg85EjACvFVlbOTdmdXedtk/XIU86Sp5+rb
         ByhB9juBKYnGflf81WAdMpi+fPDhB9gBaXMBDs3ZEj4lDpYjml9Abpxwk4mVlrqHTDy3
         CzMTYQRqrJLq3NRHrzqvq+4Tbx6mXQBIZQ151L89Sy3P1rHVVPd9dIXLXEKZ0+CjO/St
         PFag==
X-Gm-Message-State: AOAM533jyNnIlV9W8MFZ7hEyHPjq0ZJ7tU9TsFYAUruJBtvKRfUKLNa6
        t/VYZlpbnmiOQbThlaigZllMyyDkpvzeHasR61EX5wS5fZ+1Yc1edjBYz9aOKj6cZ2TlakMejve
        p68Ma0KDibD6oC+eF2LN9BzydNZefPx2ls6tGD2O2InjI5Ple
X-Received: by 2002:a05:6402:22ba:: with SMTP id cx26mr10620066edb.350.1611224146481;
        Thu, 21 Jan 2021 02:15:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz6n3kKv/0vJWfWS+YdCglfI3p85TXbTNS8r/5TQCFcL3E7z1I3d31X/VJhF590p/Y3CYG4Kw==
X-Received: by 2002:a05:6402:22ba:: with SMTP id cx26mr10620055edb.350.1611224146269;
        Thu, 21 Jan 2021 02:15:46 -0800 (PST)
Received: from localhost (host-79-52-126-228.retail.telecomitalia.it. [79.52.126.228])
        by smtp.gmail.com with ESMTPSA id bl13sm2053785ejb.64.2021.01.21.02.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 02:15:45 -0800 (PST)
Date:   Thu, 21 Jan 2021 11:15:44 +0100
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org
Subject: Re: [tip: x86/entry] x86/entry: Build thunk_$(BITS) only if
 CONFIG_PREEMPTION=y
Message-ID: <YAlUUBs2qPIqLgCt@xps-13-7390>
References: <YAAvk0UQelq0Ae7+@xps-13-7390>
 <161121327995.414.14890124942899525500.tip-bot2@tip-bot2>
 <20210121074928.GA1346795@gmail.com>
 <YAlAr1Gs+Jm4r5o7@xps-13-7390>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YAlAr1Gs+Jm4r5o7@xps-13-7390>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Thu, Jan 21, 2021 at 09:52:01AM +0100, Andrea Righi wrote:
> On Thu, Jan 21, 2021 at 08:49:28AM +0100, Ingo Molnar wrote:
> > 
> > * tip-bot2 for Andrea Righi <tip-bot2@linutronix.de> wrote:
> > 
> > > The following commit has been merged into the x86/entry branch of tip:
> > > 
> > > Commit-ID:     e6d92b6680371ae1aeeb6c5eb2387fdc5d9a2c89
> > > Gitweb:        https://git.kernel.org/tip/e6d92b6680371ae1aeeb6c5eb2387fdc5d9a2c89
> > > Author:        Andrea Righi <andrea.righi@canonical.com>
> > > AuthorDate:    Thu, 14 Jan 2021 12:48:35 +01:00
> > > Committer:     Ingo Molnar <mingo@kernel.org>
> > > CommitterDate: Thu, 21 Jan 2021 08:11:52 +01:00
> > > 
> > > x86/entry: Build thunk_$(BITS) only if CONFIG_PREEMPTION=y
> > > 
> > > With CONFIG_PREEMPTION disabled, arch/x86/entry/thunk_64.o is just an
> > > empty object file.
> > > 
> > > With the newer binutils (tested with 2.35.90.20210113-1ubuntu1) the GNU
> > > assembler doesn't generate a symbol table for empty object files and
> > > objtool fails with the following error when a valid symbol table cannot
> > > be found:
> > > 
> > >   arch/x86/entry/thunk_64.o: warning: objtool: missing symbol table
> > > 
> > > To prevent this from happening, build thunk_$(BITS).o only if
> > > CONFIG_PREEMPTION is enabled.
> > > 
> > >   BugLink: https://bugs.launchpad.net/bugs/1911359
> > > 
> > > Fixes: 320100a5ffe5 ("x86/entry: Remove the TRACE_IRQS cruft")
> > > Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
> > > Signed-off-by: Ingo Molnar <mingo@kernel.org>
> > > Cc: Borislav Petkov <bp@alien8.de>
> > > Link: https://lore.kernel.org/r/YAAvk0UQelq0Ae7+@xps-13-7390
> > 
> > Hm, this fails to build on UML defconfig:
> > 
> >  /home/mingo/gcc/cross/lib/gcc/x86_64-linux/9.3.1/../../../../x86_64-linux/bin/ld: arch/x86/um/../entry/thunk_64.o: in function `preempt_schedule_thunk':
> >  /home/mingo/tip.cross/arch/x86/um/../entry/thunk_64.S:34: undefined reference to `preempt_schedule'
> >  /home/mingo/gcc/cross/lib/gcc/x86_64-linux/9.3.1/../../../../x86_64-linux/bin/ld: arch/x86/um/../entry/thunk_64.o: in function `preempt_schedule_notrace_thunk':
> >  /home/mingo/tip.cross/arch/x86/um/../entry/thunk_64.S:35: undefined reference to `preempt_schedule_notrace'
> > 
> > Thanks,
> > 
> > 	Ingo
> 
> I've been able to reproduce it, I'm looking at this right now. Thanks!

I see, basically UML selects ARCH_NO_PREEMPT, but in
arch/x86/um/Makefile it explicitly includes thunk_$(BITS).o regardless.

Considering that thunk_$(BITS) only contains preemption code now, we can
probably drop it from the Makefile, or, to be more consistent with the
x86 change, we could include it only if CONFIG_PREEMPTION is enabled
(even if it would never be, because UML has ARCH_NO_PREEMPT).

If it's unlikely that preemption will be enabled in UML one day I'd
probably go with the former, otherwise I'd go with the latter, because
it looks more consistent.

Opinions?

Thanks,
-Andrea
