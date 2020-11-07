Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C15F62AA68D
	for <lists+linux-tip-commits@lfdr.de>; Sat,  7 Nov 2020 17:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgKGQFB (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 7 Nov 2020 11:05:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgKGQFB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 7 Nov 2020 11:05:01 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5D2C0613CF;
        Sat,  7 Nov 2020 08:05:01 -0800 (PST)
Received: from zn.tnic (p200300ec2f1d1200a8d68c48616d8b01.dip0.t-ipconnect.de [IPv6:2003:ec:2f1d:1200:a8d6:8c48:616d:8b01])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5B6F01EC037C;
        Sat,  7 Nov 2020 17:04:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1604765098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=zLbfiPQNQiOyDmepaw5b3U2bW/GQvt26RzIOuic4GiY=;
        b=aP1qGClNGHCYfuaVb+dAi9EonLeN7s9gM2FBe7Jk7u/dCEih/uWbr8hGZchRaXYdmpwmEF
        lfSqrLNe1SXyMebPhrgmXH8DZT3dM6dLBHg2yJfihAw2QbvFdyv6dMCZRYa9kCebGxEeE4
        QIpqi6z+NrGkIAOOWiqJ5buwi0NWsko=
Date:   Sat, 7 Nov 2020 17:04:44 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     x86-ml <x86@kernel.org>
Cc:     linux-tip-commits@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Will Deacon <will.deacon@arm.com>, x86@kernel.org
Subject: Re: [tip: perf/kprobes] locking/atomics: Regenerate the
 atomics-check SHA1's
Message-ID: <20201107160444.GB30275@zn.tnic>
References: <160476203869.11244.7869849163897430965.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <160476203869.11244.7869849163897430965.tip-bot2@tip-bot2>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Sat, Nov 07, 2020 at 03:13:58PM -0000, tip-bot2 for Ingo Molnar wrote:
> The following commit has been merged into the perf/kprobes branch of tip:
> 
> Commit-ID:     a70a04b3844f59c29573a8581d5c263225060dd6
> Gitweb:        https://git.kernel.org/tip/a70a04b3844f59c29573a8581d5c263225060dd6
> Author:        Ingo Molnar <mingo@kernel.org>
> AuthorDate:    Sat, 07 Nov 2020 12:54:49 +01:00
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Sat, 07 Nov 2020 13:20:41 +01:00
> 
> locking/atomics: Regenerate the atomics-check SHA1's
> 
> The include/asm-generic/atomic-instrumented.h checksum got out
> of sync, so regenerate it. (No change to actual code.)
> 
> Also make scripts/atomic/gen-atomics.sh executable, to make
> it easier to use.
> 
> The auto-generated atomic header signatures are now fine:
> 
>   thule:~/tip> scripts/atomic/check-atomics.sh
>   thule:~/tip>
> 
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> ---
>  include/asm-generic/atomic-instrumented.h | 2 +-
>  scripts/atomic/gen-atomics.sh             | 0
>  2 files changed, 1 insertion(+), 1 deletion(-)
>  mode change 100644 => 100755 scripts/atomic/gen-atomics.sh
		^^^^^^^^^^^^^^^

That looks like it snuck in but it shouldn't have...

> diff --git a/scripts/atomic/gen-atomics.sh b/scripts/atomic/gen-atomics.sh
> old mode 100644
> new mode 100755

... here too.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
