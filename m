Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67CDC3F8E47
	for <lists+linux-tip-commits@lfdr.de>; Thu, 26 Aug 2021 20:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243338AbhHZS4i (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 26 Aug 2021 14:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243330AbhHZS4h (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 26 Aug 2021 14:56:37 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318F6C0613C1
        for <linux-tip-commits@vger.kernel.org>; Thu, 26 Aug 2021 11:55:49 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id l18so6878948lji.12
        for <linux-tip-commits@vger.kernel.org>; Thu, 26 Aug 2021 11:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M1HBwNfaXlqSuyb+RTXcwjG+gWJfeC76x9b0o5Py3vI=;
        b=HPqVRwc+fE0VOjGGm+xpW8Dfb1yshAiJwUoyukU+h9bbRnuLWaOh+pD0Az+4H7N4ap
         XschrMcyE7C+AXvSGccwZ4OY7wb+fstTB1lFF3BDdTmPMUd0LaORbdgtJW4bSgKC1gux
         M5rA6fkHnXSnxsgpiV6nHz2s7uA0mM9Umab/vmKSDpv3/WIRLjtaktsDcNQ3tXqpyhvW
         qz/VYQD63KwKuLVB4Zs72taH2qU92JA/+/e6yNLIMIay6Y2njLM75PmOxNUz8JLJ11me
         KZUhnGGvyuV4DZ6PQfkeBy0aEc69X8u96ZD/rfXdmg2QeacB+RCwIWmvW9osT0ND41qU
         ZG4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M1HBwNfaXlqSuyb+RTXcwjG+gWJfeC76x9b0o5Py3vI=;
        b=DuDOpdsmTZ5UV9XB4MXFoAjKby7HvOtsX4KUPEmwX6x5crvtNx112xVrYqk4rgTPXw
         q0ftsEYUdyi0Ia/C5wtnIn3k36mOytyh6RayvLD7nCvSO1K50JEltSEjXbPgVN1FeNxe
         BhtCyYiih3ilE6joSKKt6SAXhDuO2iAZD419kGeUIKQFXGrSS2fMm4JAcTK4w2EG8zHV
         BqLHDy5h7YuKqJiamMDtGubp52UmTPRtF+wugg6ek0xVLuWaRAPFeuhnSB90G52J3hvI
         +M5B1UXWRgLPllYx649kFq7z5BZE1kDWv2JYvuJdswb/h5DSZ+7nQML4FmG9eCHSARQv
         uh2A==
X-Gm-Message-State: AOAM533pqXUNwWyV+s45czTkzIP3/7wnlOnpE+u3ctBxOsqTN0hqS3re
        uO+SeX+FZKVbidzKzzbTWRfgE6f1G5omCVW/hlyPTw==
X-Google-Smtp-Source: ABdhPJwEztVV71UxtR+hwM2EjHPvUY6Hw/IgG3ZkguTIRJejfb82Aw2E1EI72YnPDX5IfdPAoQSUEEWmURipFzs4WTI=
X-Received: by 2002:a2e:8008:: with SMTP id j8mr4167242ljg.233.1630004147252;
 Thu, 26 Aug 2021 11:55:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210812183848.1519994-1-ndesaulniers@google.com>
 <162902143957.395.7404280890417854945.tip-bot2@tip-bot2> <YSILd/Dc0dYKK2qk@gmail.com>
In-Reply-To: <YSILd/Dc0dYKK2qk@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 26 Aug 2021 11:55:35 -0700
Message-ID: <CAKwvOd=ML1ytp8Q10oiz8q1ERAHcGnjjCSMOHj=tq6E2vHAkQw@mail.gmail.com>
Subject: Re: [tip: x86/build] x86/build: Remove stale cc-option checks
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Borislav Petkov <bp@suse.de>,
        Nathan Chancellor <nathan@kernel.org>, x86@kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Sun, Aug 22, 2021 at 1:31 AM Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * tip-bot2 for Nick Desaulniers <tip-bot2@linutronix.de> wrote:
>
> > The following commit has been merged into the x86/build branch of tip:
> >
> > Commit-ID:     1463c2a27d59c69358ad1cbd869d3a8649695d8c
> > Gitweb:        https://git.kernel.org/tip/1463c2a27d59c69358ad1cbd869d3a8649695d8c
> > Author:        Nick Desaulniers <ndesaulniers@google.com>
> > AuthorDate:    Thu, 12 Aug 2021 11:38:48 -07:00
> > Committer:     Borislav Petkov <bp@suse.de>
> > CommitterDate: Sun, 15 Aug 2021 10:32:52 +02:00
> >
> > x86/build: Remove stale cc-option checks
> >
> > -mpreferred-stack-boundary= is specific to GCC, while -mstack-alignment=
> > is specific to Clang. Rather than test for this three times via
> > cc-option and __cc-option, rely on CONFIG_CC_IS_* from Kconfig.
> >
> > GCC did not support values less than 4 for -mpreferred-stack-boundary=
> > until GCC 7+. Change the cc-option test to check for a value of 2,
> > rather than 4.
>
> > --- a/arch/x86/Makefile
> > +++ b/arch/x86/Makefile
> > @@ -14,10 +14,13 @@ endif
> >
> >  # For gcc stack alignment is specified with -mpreferred-stack-boundary,
> >  # clang has the option -mstack-alignment for that purpose.
> > -ifneq ($(call cc-option, -mpreferred-stack-boundary=4),)
> > +ifdef CONFIG_CC_IS_GCC
> > +ifneq ($(call cc-option, -mpreferred-stack-boundary=2),)
> >        cc_stack_align4 := -mpreferred-stack-boundary=2
> >        cc_stack_align8 := -mpreferred-stack-boundary=3
> > -else ifneq ($(call cc-option, -mstack-alignment=16),)
> > +endif
> > +endif
> > +ifdef CONFIG_CC_IS_CLANG
> >        cc_stack_align4 := -mstack-alignment=4
> >        cc_stack_align8 := -mstack-alignment=8
>
> So I spent most of yesterday bisecting a hard to diagnose bug that looked
> like a GPU driver bug - but the bisect somewhat surprisingly ended up at
> this commit.

I'm genuinely sorry about that.  Let me guess, GPF on SSE instruction
with stack based operand from AMDGPU? (I've seen that twice so far
related to these options.)

I see now what went wrong....
GCC only supports a 4B stack alignment for ***32b*** (or 16b) x86;
`-mpreferred-stack-boundary=2` will produce an error unless -m32 or
-m16 is set; but `-mpreferred-stack-boundary=2 -m32` has been long
supported.  It's -mpreferred-stack-boundary=3 for -m64 that wasn't
supported until the gcc-7 release.  So the cc-option test should
instead test -mpreferred-stack-boundary=3.

>
> Doing the partial revert below solves the regression - as the above hunk is
> not obviously an identity transformation. I have a pretty usual GCC 10.3.0
> build environment with nothing exotic.
>
> I amdended the commit with the partial revert in tip:x86/build.

No worries. I'll send a follow up.

-- 
Thanks,
~Nick Desaulniers
