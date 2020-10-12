Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8BC28BC89
	for <lists+linux-tip-commits@lfdr.de>; Mon, 12 Oct 2020 17:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390815AbgJLPlg (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 12 Oct 2020 11:41:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24338 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390292AbgJLPj6 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 12 Oct 2020 11:39:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602517197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tVvce4e6eIFCyn6Tznu2Pb8PdDR0S4LAYFGAeOch+LY=;
        b=WzoT+iW5diRfnTYA3l6ArVphq0PS2E+0z1xEJ6Kd4iMPcTl8TqoDqP+jugCqPRaUTzoZFB
        sNMNosnGWu9XxWyxmMmS342MseQLqvFGCg2utOy23TzYp0gJDe8OT7U7Ou0Gjnr7wNQAcS
        H+//YlT9hnfz7r13+4ixms/WUfYsUUk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-AIxEAjSVNEyJJFti44RVyw-1; Mon, 12 Oct 2020 11:39:55 -0400
X-MC-Unique: AIxEAjSVNEyJJFti44RVyw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9EA936408B;
        Mon, 12 Oct 2020 15:39:53 +0000 (UTC)
Received: from treble (ovpn-118-167.rdu2.redhat.com [10.10.118.167])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F076973663;
        Mon, 12 Oct 2020 15:39:51 +0000 (UTC)
Date:   Mon, 12 Oct 2020 10:39:49 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, x86 <x86@kernel.org>
Subject: Re: [tip: objtool/core] x86/insn: Support big endian cross-compiles
Message-ID: <20201012153949.jfwa7rgpzu5b7ld4@treble>
References: <160208761921.7002.1321765913567405137.tip-bot2@tip-bot2>
 <20201009203822.GA2974@worktop.programming.kicks-ass.net>
 <20201009204921.GB21731@zn.tnic>
 <20201010174415.zwopoy6vpficoqlr@treble>
 <20201012091236.0f9a64bfedb8825732b65ea5@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201012091236.0f9a64bfedb8825732b65ea5@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Mon, Oct 12, 2020 at 09:12:36AM +0900, Masami Hiramatsu wrote:
> On Sat, 10 Oct 2020 12:44:15 -0500
> Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> 
> > On Fri, Oct 09, 2020 at 10:49:21PM +0200, Borislav Petkov wrote:
> > > On Fri, Oct 09, 2020 at 10:38:22PM +0200, Peter Zijlstra wrote:
> > > > On Wed, Oct 07, 2020 at 04:20:19PM -0000, tip-bot2 for Martin Schwidefsky wrote:
> > > > > The following commit has been merged into the objtool/core branch of tip:
> > > > > 
> > > > > Commit-ID:     2a522b53c47051d3bf98748418f4f8e5f20d2c04
> > > > > Gitweb:        https://git.kernel.org/tip/2a522b53c47051d3bf98748418f4f8e5f20d2c04
> > > > > Author:        Martin Schwidefsky <schwidefsky@de.ibm.com>
> > > > > AuthorDate:    Mon, 05 Oct 2020 17:50:31 +02:00
> > > > > Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
> > > > > CommitterDate: Tue, 06 Oct 2020 09:32:29 -05:00
> > > > > 
> > > > > x86/insn: Support big endian cross-compiles
> > > > > 
> > > > > x86 instruction decoder code is shared across the kernel source and the
> > > > > tools. Currently objtool seems to be the only tool from build tools needed
> > > > > which breaks x86 cross compilation on big endian systems. Make the x86
> > > > > instruction decoder build host endianness agnostic to support x86 cross
> > > > > compilation and enable objtool to implement endianness awareness for
> > > > > big endian architectures support.
> > > > > 
> > > > > Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> > > > > Co-developed-by: Vasily Gorbik <gor@linux.ibm.com>
> > > > > Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
> > > > > Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> > > > > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > > > 
> > > > This commit breaks the x86 build with CONFIG_X86_DECODER_SELFTEST=y.
> > > > 
> > > > I've asked Boris to truncate tip/objtool/core.
> > > 
> > > Yeah, top 4 are gone until this is resolved.
> > 
> > Masami, I wonder if we even need these selftests anymore?  Objtool
> > already decodes the entire kernel.
> 
> No, they have different roles. The selftest checks if the decoder
> works correctly by comparing with the output of objdump.
> 
> As far as I can see, the objtool relies on the sanity of the decoder
> (it trusts the output of the decoder).

Ok.  I wonder if we should move the decoder selftest to the 'tools'
subdirectory.

-- 
Josh

