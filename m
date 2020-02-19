Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17B6F1652A3
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Feb 2020 23:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbgBSWnv (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 19 Feb 2020 17:43:51 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41558 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727429AbgBSWnv (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 19 Feb 2020 17:43:51 -0500
Received: by mail-pg1-f196.google.com with SMTP id 70so842972pgf.8
        for <linux-tip-commits@vger.kernel.org>; Wed, 19 Feb 2020 14:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DarAl82PcxJAMUan8osRqiWJP5zrzBNFn2my/A9LRV0=;
        b=SI2uasgQc9FMfi5L8cj/jMw5i/igTpq5jC76d8Ym788Dg4qfgnAUOue0gF1t/Q//25
         CuR3r/WGfAOahQVIpbSGoeK53gfYTf6gBU6A+NGdEbBkR6qgO3pEjsY/wulM9RBIXpkb
         lfZ3o+uAQLoYpJKeEHu+KySxpiicUAPB7ek0vQX+MF2S2SqgG03zrU6fc7s6lWDC6Vjc
         F7tdFfJ5Rq1FOUk2FKQqFq+okBgPsCEEB9chHVPLm9iDwZ1hz+VnIxib6yUAW6BtmKwR
         u6vFhBzCyzsLm5snKXcTsbkh/i9rk8FFZVVUAbtsHXJf85L5lkyWQSY3nSTuF7zXr8R8
         sU3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DarAl82PcxJAMUan8osRqiWJP5zrzBNFn2my/A9LRV0=;
        b=L1CLpTRNAgCZIYgBMi7l6yeX7Fkm9ljEkZYvWg06Dleu/yHfuthudDtIsf/Z3/rNT7
         p5WYNHW2gyxlwy89gFqiiASzQYoHwnokpeF54MiCR/wYa2YFeVHxwn/aKApYJYQl2/aN
         1X9qMBBSiEMCSdYIr0j2e05Gg033wDS+whpTyAw93LKnGBfMBsjZusTsG6PdWBGnP2o1
         YqKOXgJfXTYMLUdb6ArLFmo8YCip1wssf0imdgtH9Thq7dDl/zgLub/Fc3q3v0XcgyDi
         Wmhr39Ys/X9Gj7+IQB6QZZvRhGoAD1iYUlDy9gDjMi6+IJ3P/2/ulyO1ecVaViWSgH04
         7tVg==
X-Gm-Message-State: APjAAAXZcyKh0sbQ4lFDWJG2PRVccVwaHTRG/E5MJXOolrQJtc4zDonx
        5Ktl63d9DcXpRfzcv3h8rA9XLWqQP8zHejkIh8sDnA==
X-Google-Smtp-Source: APXvYqxEZxyzj2o3h2/4b2lxiDR3ZyXP5vS3IdPCQrTBEhnxDQlQi2PAtKFWTpf2l/rL2e36VXoG7CgtC1N0WJrPr48=
X-Received: by 2002:a63:f24b:: with SMTP id d11mr29148152pgk.381.1582152230079;
 Wed, 19 Feb 2020 14:43:50 -0800 (PST)
MIME-Version: 1.0
References: <f18c3743de0fef673d49dd35760f26bdef7f6fc3.1581359535.git.jpoimboe@redhat.com>
 <158142525822.411.5401976987070210798.tip-bot2@tip-bot2> <20200213221100.odwg5gan3dwcpk6g@treble>
 <87sgjeghal.fsf@nanos.tec.linutronix.de> <20200214175758.s34rdwmwgiq6qwq7@treble>
In-Reply-To: <20200214175758.s34rdwmwgiq6qwq7@treble>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 19 Feb 2020 14:43:39 -0800
Message-ID: <CAKwvOdmJvWpmbP3GyzaZxyiuwooFXA8D7ui05QE7+f8Oaz+rXg@mail.gmail.com>
Subject: Re: [tip: core/objtool] objtool: Fail the kernel build on fatal errors
To:     Chen Rong <rong.a.chen@intel.com>, Philip Li <philip.li@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        tip-bot2 for Josh Poimboeuf <tip-bot2@linutronix.de>,
        linux-tip-commits@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Julien Thierry <jthierry@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Fri, Feb 14, 2020 at 9:58 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Fri, Feb 14, 2020 at 01:10:26AM +0100, Thomas Gleixner wrote:
> > Josh Poimboeuf <jpoimboe@redhat.com> writes:
> > > On Tue, Feb 11, 2020 at 12:47:38PM -0000, tip-bot2 for Josh Poimboeuf wrote:
> > >> The following commit has been merged into the core/objtool branch of tip:
> > >>
> > >> Commit-ID:     644592d328370af4b3e027b7b1ae9f81613782d8
> > >> Gitweb:        https://git.kernel.org/tip/644592d328370af4b3e027b7b1ae9f81613782d8
> > >> Author:        Josh Poimboeuf <jpoimboe@redhat.com>
> > >> AuthorDate:    Mon, 10 Feb 2020 12:32:38 -06:00
> > >> Committer:     Borislav Petkov <bp@suse.de>
> > >> CommitterDate: Tue, 11 Feb 2020 13:27:03 +01:00
> > >>
> > >> objtool: Fail the kernel build on fatal errors
> > >>
> > >> When objtool encounters a fatal error, it usually means the binary is
> > >> corrupt or otherwise broken in some way.  Up until now, such errors were
> > >> just treated as warnings which didn't fail the kernel build.
> > >>
> > >> However, objtool is now stable enough that if a fatal error is
> > >> discovered, it most likely means something is seriously wrong and it
> > >> should fail the kernel build.
> > >>
> > >> Note that this doesn't apply to "normal" objtool warnings; only fatal
> > >> ones.
> > >
> > > Clang still has some toolchain issues which need to be sorted out, so
> > > upgrading the fatal errors is causing their CI to fail.
> >
> > Good. Last time we made it fail they just fixed their stuff.
> >
> > > So I think we need to drop this one for now.
> >
> > Why? It's our decision to define which level of toolchain brokeness is
> > tolerable.
> >
> > > Boris, are you able to just drop it or should I send a revert?
> >
> > I really want to see a revert which has a proper justification why the
> > issues of clang are tolerable along with a clear statement when this
> > fatal error will come back. And 'when' means a date, not 'when clang is
> > fixed'.
>
> Fair enough.  The root cause was actually a bug in binutils which gets
> triggered by a new clang feature.  So instead of reverting the above
> patch, I think I've figured out a way to work around the binutils bug,
> while also improving objtool at the same time (win-win).
>
> The binutils bug will be fixed in binutils 2.35.
>
> BTW, to be fair, this was less "Clang has issues" and more "Josh is
> lazy".  I didn't test the patch with Clang -- I tend to rely on 0-day
> bot reports because I don't have the bandwidth to test the
> kernel/config/toolchain combinations.  Nick tells me Clang will soon be
> integrated with the 0-day bot, which should help prevent this type of
> thing in the future.

Hi Rong, Philip,
Do you have any status updates on turning on the 0day bot emails to
the patch authors in production?  It's been quite handy in helping us
find issues, for the private mails we've been triaging daily.
-- 
Thanks,
~Nick Desaulniers
