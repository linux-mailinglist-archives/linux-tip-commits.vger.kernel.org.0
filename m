Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAFD61666D9
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Feb 2020 20:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbgBTTJh (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 20 Feb 2020 14:09:37 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42626 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728315AbgBTTJh (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 20 Feb 2020 14:09:37 -0500
Received: by mail-pg1-f196.google.com with SMTP id w21so2388057pgl.9
        for <linux-tip-commits@vger.kernel.org>; Thu, 20 Feb 2020 11:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mrly7V6dbK4/Jt5t8XEVPETkT0pUle6CTcq6TpnuQrY=;
        b=IPshY4hqjse+pKEEI64mtIXT+GcH+gZXttEziLebKETysKzKNKeAPeRll/PfP0L1q5
         VHLc8LuPG2ziNY3dpzCbSu0Mvapau8iesqn57d/DmS7TZdJDpQ4aphyPPQRTVymRpX05
         RSSXHv+ebRQjR2RYJj3o31NgT/c3wHdWNSl9xIz6He6BJ1KqiTN3aRXoJIrPALBNVoHW
         gI0Fe9aQN/fYLqMfZCvZBQB2Yib9ibwofpnPgh6BoaZgRmydkzCP/12/riN0+rStJcRa
         Od75X1LGzRlKkntFeyqgwqM0SYY6d9vstDEpcDPM32/Ht1FMfBPRwJjQxrnKYBx3Wgjk
         Amtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mrly7V6dbK4/Jt5t8XEVPETkT0pUle6CTcq6TpnuQrY=;
        b=C7Uo/Hf/bHzyz4eX+lcG5s8jK5at2IAQBiQj+SzZ29jStjjgM8xaiwbD5afG0Bj4tt
         +TOJlIFfQOjO/kPKjl9r2L4ATnatj8lzpzIR31SCN2kchYIqlfNCh6tEq2DitvlyO2bW
         FyZ+S7/EmJmXFw/i+l2W4hN/u2E6I65XzcSnSCK10OIe68o6BrW7Ho02l3Cv/Ln8NY4L
         jikXEpLTCNmpBMyKm1IYz1JLY0mo0BNEiaD1s6ufqJv4rPrCLKM5/sy3bjPIyvZnl7Xn
         3Gkf5RgikoIh+K25Cu8A1hPXkECEDoIpeozLR7Wu8XWZu2af8rvTH8D5JNY2Mmy6lE9Y
         nQaA==
X-Gm-Message-State: APjAAAXaqbqcdNhyZvvZ0I0ReOYBKZRTatNUtTw9XxC/LLgPtmFBVc4w
        dm0rOOVkLM7nGGXs2b2ChXYGYBazsLe8NydovzK8gQ==
X-Google-Smtp-Source: APXvYqxr69KVVFfzWbJ6X/F9YdojS+JkN5x2SFv/dBtj5LK8LnsrmagKSNav+CveUBfMNfXfvg65ftXLcjL7r79HBDg=
X-Received: by 2002:a65:6412:: with SMTP id a18mr9118931pgv.10.1582225775613;
 Thu, 20 Feb 2020 11:09:35 -0800 (PST)
MIME-Version: 1.0
References: <f18c3743de0fef673d49dd35760f26bdef7f6fc3.1581359535.git.jpoimboe@redhat.com>
 <158142525822.411.5401976987070210798.tip-bot2@tip-bot2> <20200213221100.odwg5gan3dwcpk6g@treble>
 <87sgjeghal.fsf@nanos.tec.linutronix.de> <20200214175758.s34rdwmwgiq6qwq7@treble>
 <CAKwvOdmJvWpmbP3GyzaZxyiuwooFXA8D7ui05QE7+f8Oaz+rXg@mail.gmail.com> <20200220004434.GA5687@intel.com>
In-Reply-To: <20200220004434.GA5687@intel.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 20 Feb 2020 11:09:24 -0800
Message-ID: <CAKwvOd=p18z8yxfuOBgpOheZOUzmgAfzvVD-5Kuz=VqKCUpOKw@mail.gmail.com>
Subject: Re: [tip: core/objtool] objtool: Fail the kernel build on fatal errors
To:     Philip Li <philip.li@intel.com>
Cc:     Chen Rong <rong.a.chen@intel.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

(everyone else to bcc)

On Wed, Feb 19, 2020 at 4:44 PM Philip Li <philip.li@intel.com> wrote:
>
> On Wed, Feb 19, 2020 at 02:43:39PM -0800, Nick Desaulniers wrote:
> > On Fri, Feb 14, 2020 at 9:58 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > >
> > > On Fri, Feb 14, 2020 at 01:10:26AM +0100, Thomas Gleixner wrote:
> > > > Josh Poimboeuf <jpoimboe@redhat.com> writes:
> > > > > On Tue, Feb 11, 2020 at 12:47:38PM -0000, tip-bot2 for Josh Poimboeuf wrote:
> > > > >> The following commit has been merged into the core/objtool branch of tip:
> > > > >>
> > > > >> Commit-ID:     644592d328370af4b3e027b7b1ae9f81613782d8
> > > > >> Gitweb:        https://git.kernel.org/tip/644592d328370af4b3e027b7b1ae9f81613782d8
> > > > >> Author:        Josh Poimboeuf <jpoimboe@redhat.com>
> > > > >> AuthorDate:    Mon, 10 Feb 2020 12:32:38 -06:00
> > > > >> Committer:     Borislav Petkov <bp@suse.de>
> > > > >> CommitterDate: Tue, 11 Feb 2020 13:27:03 +01:00
> > > > >>
> > > > >> objtool: Fail the kernel build on fatal errors
> > > > >>
> > > > >> When objtool encounters a fatal error, it usually means the binary is
> > > > >> corrupt or otherwise broken in some way.  Up until now, such errors were
> > > > >> just treated as warnings which didn't fail the kernel build.
> > > > >>
> > > > >> However, objtool is now stable enough that if a fatal error is
> > > > >> discovered, it most likely means something is seriously wrong and it
> > > > >> should fail the kernel build.
> > > > >>
> > > > >> Note that this doesn't apply to "normal" objtool warnings; only fatal
> > > > >> ones.
> > > > >
> > > > > Clang still has some toolchain issues which need to be sorted out, so
> > > > > upgrading the fatal errors is causing their CI to fail.
> > > >
> > > > Good. Last time we made it fail they just fixed their stuff.
> > > >
> > > > > So I think we need to drop this one for now.
> > > >
> > > > Why? It's our decision to define which level of toolchain brokeness is
> > > > tolerable.
> > > >
> > > > > Boris, are you able to just drop it or should I send a revert?
> > > >
> > > > I really want to see a revert which has a proper justification why the
> > > > issues of clang are tolerable along with a clear statement when this
> > > > fatal error will come back. And 'when' means a date, not 'when clang is
> > > > fixed'.
> > >
> > > Fair enough.  The root cause was actually a bug in binutils which gets
> > > triggered by a new clang feature.  So instead of reverting the above
> > > patch, I think I've figured out a way to work around the binutils bug,
> > > while also improving objtool at the same time (win-win).
> > >
> > > The binutils bug will be fixed in binutils 2.35.
> > >
> > > BTW, to be fair, this was less "Clang has issues" and more "Josh is
> > > lazy".  I didn't test the patch with Clang -- I tend to rely on 0-day
> > > bot reports because I don't have the bandwidth to test the
> > > kernel/config/toolchain combinations.  Nick tells me Clang will soon be
> > > integrated with the 0-day bot, which should help prevent this type of
> > > thing in the future.
> >
> > Hi Rong, Philip,
> > Do you have any status updates on turning on the 0day bot emails to
> > the patch authors in production?  It's been quite handy in helping us
> > find issues, for the private mails we've been triaging daily.
> Hi Nick, this is on our schedule in a new 2-3 weeks, sorry not to update
> your in another mail loop earlier.

No worries.

>
> What I plan to do is to cc you for the clang reports when 0-day ci sends
> to kernel patch author. If you notice something may be related to clang (since
> we always integrate newer clang version), you can help filter it out. How
> do you think?

If you would kindly cc our mailing list "clang-built-linux
<clang-built-linux@googlegroups.com>" we'd be happy to continue to
triage and provide suggestions.  That level of indirection better
allows us to deal with subscriptions and change of email addresses
without having to disturb you.

-- 
Thanks,
~Nick Desaulniers
