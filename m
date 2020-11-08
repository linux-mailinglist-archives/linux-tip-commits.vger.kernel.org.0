Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A78D22AACA4
	for <lists+linux-tip-commits@lfdr.de>; Sun,  8 Nov 2020 18:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgKHRf6 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 8 Nov 2020 12:35:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbgKHRf6 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 8 Nov 2020 12:35:58 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F749C0613D2
        for <linux-tip-commits@vger.kernel.org>; Sun,  8 Nov 2020 09:35:58 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id v18so7184734ljc.3
        for <linux-tip-commits@vger.kernel.org>; Sun, 08 Nov 2020 09:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=goAf5APyC5tyGd02qLYin25Wsnv/7V4lb6bl4j7KYBA=;
        b=OIlrQdfnTL/fOrmqEZO2uA/eSIGlvwCBqDCtTzbVRQ05lK6JyUU44d7XKswyLxEQ3e
         Qc313nvQHeiviQ9mtGjKiSEsja6bspSPukvcqZs/wbbgyFHTmRFN4OjNzZLs5LnDk8LV
         +fyX3PNYZX9zfRDZG5KlIVCyb8yDPO5cXRBw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=goAf5APyC5tyGd02qLYin25Wsnv/7V4lb6bl4j7KYBA=;
        b=adAPacY238lBlVC4fhjiSCR8hjMx8IX7DEXMTMbolsSriuRyNiADZiBKs+t/PrW1si
         ulP5BFhrctnOJE4RlJ96FH8Nupx/KRCRrKvAeiYKH3VvyFCyzpvYoKgGRlunWuaAsdD7
         S2IYR7+ma8mrzgg5+3I6KRRdYDUOJKb4Ba9bjnd4VvfhWYBrzbgoRShUe14Gfm6zT8sg
         BVsVxCgqoQuuWXw29oAe/Xqj8MOfVACoKIQN53yzXe6je3OcdIltikjsphqGFuezdpIl
         m1gqurB9lJu6x0Azq6wPKbc4HVeFUAjS+RoboFcYYZJlU6dMYRXiH6KWDzDlosBs8wQg
         drRA==
X-Gm-Message-State: AOAM5300ovFvh9vrJvpgVY04kFyPQoFXsOkaV7vGpvgO+fKjGmsy2flu
        Mso2ZqV1LqGckMhsUAWYh0l5EJOVcfTRPg==
X-Google-Smtp-Source: ABdhPJxFa5GB7qgihp3oPi3IZDHF7L+mtrUDa3cTBUToOkMt4AtJtQ5Go0HwIpByicmYPbBEita10Q==
X-Received: by 2002:a2e:8e7b:: with SMTP id t27mr2823322ljk.129.1604856955786;
        Sun, 08 Nov 2020 09:35:55 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id o4sm1739082ljp.92.2020.11.08.09.35.54
        for <linux-tip-commits@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Nov 2020 09:35:54 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id 11so7183548ljf.2
        for <linux-tip-commits@vger.kernel.org>; Sun, 08 Nov 2020 09:35:54 -0800 (PST)
X-Received: by 2002:a2e:9212:: with SMTP id k18mr1536219ljg.371.1604856953961;
 Sun, 08 Nov 2020 09:35:53 -0800 (PST)
MIME-Version: 1.0
References: <160476203869.11244.7869849163897430965.tip-bot2@tip-bot2>
 <20201107160444.GB30275@zn.tnic> <20201108090521.GA108695@gmail.com> <20201108092333.GA13870@zn.tnic>
In-Reply-To: <20201108092333.GA13870@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 8 Nov 2020 09:35:38 -0800
X-Gmail-Original-Message-ID: <CAHk-=whVvcAawxiKnoYLRvpPqzgtiqvV+ogBC=q2F0CBqNidnA@mail.gmail.com>
Message-ID: <CAHk-=whVvcAawxiKnoYLRvpPqzgtiqvV+ogBC=q2F0CBqNidnA@mail.gmail.com>
Subject: Re: [tip: perf/kprobes] locking/atomics: Regenerate the atomics-check SHA1's
To:     Borislav Petkov <bp@alien8.de>
Cc:     Ingo Molnar <mingo@kernel.org>, x86-ml <x86@kernel.org>,
        linux-tip-commits@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Will Deacon <will.deacon@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Sun, Nov 8, 2020 at 1:23 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Sun, Nov 08, 2020 at 10:05:21AM +0100, Ingo Molnar wrote:
> > So that mode change to executable was intentional, as mentioned in the
> > changelog.
>
> Yeah, I thought we don't make them executable in the tree but I guess we
> do, at least most of them, from looking at git ls-files *.sh output.

We do try mark scripts executable, but you may have been misled by the
fact that we then try to avoid _depending_ on that during the build.

That's mostly because some people still use old workflows with
patches, and the executable bit will be lost if you apply a patch
without the proper git tools.

(I think we've also had cases where people were developing on no-exec
filesystems etc).

So while we try to mark scripts executable, we then actually generally
execute them using an explicit interpreter invocation anyway (ie using

  $(CONFIG_SHELL) "some-script-path"

or similar).

              Linus
