Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C127D28A7CD
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Oct 2020 16:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388029AbgJKOkf (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Oct 2020 10:40:35 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35110 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388019AbgJKOke (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Oct 2020 10:40:34 -0400
Received: from zn.tnic (p200300ec2f235400a60ec6c3f2395fa8.dip0.t-ipconnect.de [IPv6:2003:ec:2f23:5400:a60e:c6c3:f239:5fa8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 58A381EC025D;
        Sun, 11 Oct 2020 16:40:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1602427233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=5K1jNLcmilq+80YqccgA1fZmXUtYyF0INP+KH5ptoNk=;
        b=F62sBSpxuNywkgN6j8CtcaS6WDRQXrMs45b244Od/tLXmh6lsETTr5qmp1yl8rxbw0e0Tq
        D7a8FObKkQcDyRqHRSBT7t7s5ZHl3UUyts5i0uOQiLFdsiAHT/cC5vyTb4HQyjTpniuMXD
        ALirmLxUsVwRVc8AVFcwMfbcxhtr0mw=
Date:   Sun, 11 Oct 2020 16:40:25 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        x86 <x86@kernel.org>
Subject: Re: [tip: objtool/core] x86/insn: Support big endian cross-compiles
Message-ID: <20201011144025.GB15925@zn.tnic>
References: <160208761921.7002.1321765913567405137.tip-bot2@tip-bot2>
 <20201009203822.GA2974@worktop.programming.kicks-ass.net>
 <20201009204921.GB21731@zn.tnic>
 <your-ad-here.call-01602338530-ext-4703@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <your-ad-here.call-01602338530-ext-4703@work.hours>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Sat, Oct 10, 2020 at 04:02:10PM +0200, Vasily Gorbik wrote:
> Should I resent the entire patch series again with these changes
> squashed? Or just as a separate commit which would go on top?

You can wait at least a week (merge window starts tomorrow) and then
resend the entire series once the final approach is agreed upon.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
