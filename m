Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C29ED2D021F
	for <lists+linux-tip-commits@lfdr.de>; Sun,  6 Dec 2020 10:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725822AbgLFJDg (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 6 Dec 2020 04:03:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:33374 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbgLFJDg (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 6 Dec 2020 04:03:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 775AEAB63;
        Sun,  6 Dec 2020 09:02:54 +0000 (UTC)
Date:   Sun, 6 Dec 2020 10:02:50 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        tip-bot2 for Masami Hiramatsu <tip-bot2@linutronix.de>,
        linux-tip-commits@vger.kernel.org,
        syzbot+9b64b619f10f19d19a7c@syzkaller.appspotmail.com,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>, x86@kernel.org
Subject: Re: [tip: x86/urgent] x86/uprobes: Do not use prefixes.nbytes when
 looping over prefixes.bytes
Message-ID: <20201206090250.GA10741@zn.tnic>
References: <160697103739.3146288.7437620795200799020.stgit@devnote2>
 <160709424307.3364.5849503551045240938.tip-bot2@tip-bot2>
 <20201205091256.14161a2e1606c527131efc06@kernel.org>
 <20201205101704.GB26409@zn.tnic>
 <20201206125325.d676906774c2329742746005@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201206125325.d676906774c2329742746005@kernel.org>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

( drop stable@ )

On Sun, Dec 06, 2020 at 12:53:25PM +0900, Masami Hiramatsu wrote:
> On Sat, 5 Dec 2020 11:17:04 +0100
> Borislav Petkov <bp@alien8.de> wrote:
> 
> > On Sat, Dec 05, 2020 at 09:12:56AM +0900, Masami Hiramatsu wrote:
> > > This may break tools/objtool build. Please keep "inat.h".
> > 
> > How? Please elaborate.
> > 
> > Build tests are fine here.
> 
> Oops, sorry, it was for perf build.
> 
> Please refer commit 00a263902ac3 ("perf intel-pt: Use shared x86 insn decoder").

Oh wow:

"This way we continue to be able to process perf.data files with Intel PT
 traces in distros other than x86."

acme, why is that? Can you explain pls?

It probably would be better to fix this so that copying insn.h to keep
it in sync won't cause any future breakages. Or the diffing check should
verify whether header paths are wrong in the tools/ version and fail if
so, so that we don't break it.

Hmmm.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
