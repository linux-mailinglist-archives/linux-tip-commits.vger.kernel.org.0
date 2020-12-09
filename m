Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D15B2D487E
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Dec 2020 19:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbgLISCT (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 9 Dec 2020 13:02:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:53924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728099AbgLISCT (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 9 Dec 2020 13:02:19 -0500
Date:   Wed, 9 Dec 2020 15:01:47 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607536899;
        bh=YkDIffOrd4YjHYDteG42fXPxp5LD271yGDalbafSdOw=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=RwMWg2vh4jdD1M3CmObhFWfTVC05SAP4FolhKw6f6a8iZ4+1Lwv9tER04yEyTiSDV
         hH2Ew2MiwfJizuUJfnNCvEcKd2ImNBMQcM11lczLGe6u2868x5AQdR9JtmefVMLc62
         V8lI0DIXZVyO8sEfRPbDcRk6BlvXirc8blss9G1Rc+OmutDKyOnoGWJQ4bA2nMlH4F
         miTswvTh1kqfxfcMf4yEnKC1Ykz3jKcdE8nOFsmxhvg3u5o3ZOjObkRYzNx7Nvys8x
         xezvT//oWg1Qqb+QuK2k4JgbMyewGtObOQbE38aGj2TnJuYvGG7OwFS1GDYuesoq8k
         TJThOwG/fsExQ==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Borislav Petkov <bp@suse.de>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        tip-bot2 for Masami Hiramatsu <tip-bot2@linutronix.de>,
        linux-tip-commits@vger.kernel.org,
        syzbot+9b64b619f10f19d19a7c@syzkaller.appspotmail.com,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>, x86@kernel.org
Subject: Re: [tip: x86/urgent] x86/uprobes: Do not use prefixes.nbytes when
 looping over prefixes.bytes
Message-ID: <20201209180147.GD185686@kernel.org>
References: <160697103739.3146288.7437620795200799020.stgit@devnote2>
 <160709424307.3364.5849503551045240938.tip-bot2@tip-bot2>
 <20201205091256.14161a2e1606c527131efc06@kernel.org>
 <20201205101704.GB26409@zn.tnic>
 <20201206125325.d676906774c2329742746005@kernel.org>
 <20201206090250.GA10741@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201206090250.GA10741@zn.tnic>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

Em Sun, Dec 06, 2020 at 10:02:50AM +0100, Borislav Petkov escreveu:
> ( drop stable@ )
> 
> On Sun, Dec 06, 2020 at 12:53:25PM +0900, Masami Hiramatsu wrote:
> > On Sat, 5 Dec 2020 11:17:04 +0100
> > Borislav Petkov <bp@alien8.de> wrote:
> > 
> > > On Sat, Dec 05, 2020 at 09:12:56AM +0900, Masami Hiramatsu wrote:
> > > > This may break tools/objtool build. Please keep "inat.h".
> > > 
> > > How? Please elaborate.
> > > 
> > > Build tests are fine here.
> > 
> > Oops, sorry, it was for perf build.
> > 
> > Please refer commit 00a263902ac3 ("perf intel-pt: Use shared x86 insn decoder").
> 
> Oh wow:
> 
> "This way we continue to be able to process perf.data files with Intel PT
>  traces in distros other than x86."
> 
> acme, why is that? Can you explain pls?
> 
> It probably would be better to fix this so that copying insn.h to keep
> it in sync won't cause any future breakages. Or the diffing check should
> verify whether header paths are wrong in the tools/ version and fail if
> so, so that we don't break it.

Trying to swap this back into my brain...

Humm, if I'm building this on, say, aarch64 then asm/ will not be
pointing to x86, right? Intel PT needs the x86 instruction decoder,
right?

I should've have wrote in the cset comment log if this was related to
cross build failures I encountered, can't remember now :-\

- Arnaldo
