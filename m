Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D04A134110
	for <lists+linux-tip-commits@lfdr.de>; Wed,  8 Jan 2020 12:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbgAHLpu (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 8 Jan 2020 06:45:50 -0500
Received: from mail.skyhub.de ([5.9.137.197]:57334 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726323AbgAHLpu (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 8 Jan 2020 06:45:50 -0500
Received: from zn.tnic (p200300EC2F0BD40029EAD32D10B1B629.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:d400:29ea:d32d:10b1:b629])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 206671EC0CC9;
        Wed,  8 Jan 2020 12:45:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1578483948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=SJM3P7TJUHuFQReR8fpWR/Ki+TmMG3NXbYCvLcSh8ig=;
        b=eRAtCz8R6+9GheroYOqJ2ttJGmZC9/ghrm5BBZTSWZGFSLPI0jt1zP8pgu2PsRF++dFifr
        V5+Ost87lUSURC/rr6ojO3NiRxM96Jk4DjEHxt8PS1P+JvBJtnsQjUFiKcG+FPn/h64hlQ
        BCB1u+PDlaE/eokYWvM66hZKUtsKBhI=
Date:   Wed, 8 Jan 2020 12:45:39 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, x86-ml <x86@kernel.org>
Subject: Re: [tip: x86/fpu] x86/fpu: Deactivate FPU state after failure
 during state load
Message-ID: <20200108114539.GE27363@zn.tnic>
References: <157840155965.30329.313988118654552721.tip-bot2@tip-bot2>
 <FA0D2929-63D0-4473-A492-42227D7A5D98@amacapital.net>
 <20200107211134.tckhc5knkthmjsj6@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200107211134.tckhc5knkthmjsj6@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Tue, Jan 07, 2020 at 10:11:34PM +0100, Sebastian Andrzej Siewior wrote:
> The go people contirbuted a testcase. Maybe I should hack up it up so
> that we trigger each path and post since it obviously did not happen.

Yes, please do.

> Boris, do you remember why we did not include their testcase yet?

It is in my ever-growing TODO list so if you could find some time to add
it to selftests, I'd appreciate it a lot:

https://lkml.kernel.org/r/20191126221328.GH31379@zn.tnic

And Andy wants it in the slow category (see reply) and that's fine with
me - I'm happy with some tests than none at all.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
