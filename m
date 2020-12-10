Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAEC22D597D
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Dec 2020 12:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbgLJLlj (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 10 Dec 2020 06:41:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:43750 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbgLJLlc (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 10 Dec 2020 06:41:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C73AAAE2B;
        Thu, 10 Dec 2020 11:40:49 +0000 (UTC)
Date:   Thu, 10 Dec 2020 11:36:07 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org,
        tip-bot2 for Masami Hiramatsu <tip-bot2@linutronix.de>,
        linux-tip-commits@vger.kernel.org,
        syzbot+9b64b619f10f19d19a7c@syzkaller.appspotmail.com,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>, x86@kernel.org
Subject: Re: [tip: x86/urgent] x86/uprobes: Do not use prefixes.nbytes when
 looping over prefixes.bytes
Message-ID: <20201210103607.GA26633@zn.tnic>
References: <160697103739.3146288.7437620795200799020.stgit@devnote2>
 <160709424307.3364.5849503551045240938.tip-bot2@tip-bot2>
 <20201205091256.14161a2e1606c527131efc06@kernel.org>
 <20201205101704.GB26409@zn.tnic>
 <20201206125325.d676906774c2329742746005@kernel.org>
 <20201206090250.GA10741@zn.tnic>
 <20201209180147.GD185686@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201209180147.GD185686@kernel.org>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Wed, Dec 09, 2020 at 03:01:47PM -0300, Arnaldo Carvalho de Melo wrote:
> Trying to swap this back into my brain...

I know *exactly* what you mean. :)

> 
> Humm, if I'm building this on, say, aarch64 then asm/ will not be
> pointing to x86, right? Intel PT needs the x86 instruction decoder,
> right?

Yeah.

> I should've have wrote in the cset comment log if this was related to
> cross build failures I encountered, can't remember now :-\

I think that is it. There's inat.h in tools/arch/x86/include/asm/ too so
it needs to be exactly that one that gets included on other arches.

> And also it would be interesting to avoid updating both the kernel and
> the tools/ copy, otherwise one would have to test the tools build, which
> may break with such updates.
>
> The whole point of the copy is to avoid that, otherwise we could just
> use the kernel files directly.

Well, there's this diff -u thing which makes sure both copies are in sync.

Why did we ever copy the insn decoder to tools/?

There must've been some reason because otherwise we could probably use
the one in arch/x86/lib/, in tools/.

Yeah, this whole copying of headers back'n'forth is turning out to be
kinda hairy...

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
