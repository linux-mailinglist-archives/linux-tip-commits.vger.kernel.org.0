Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E74228AB28
	for <lists+linux-tip-commits@lfdr.de>; Mon, 12 Oct 2020 02:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgJLACe (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Oct 2020 20:02:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:53672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbgJLACd (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Oct 2020 20:02:33 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08D4B2074D;
        Mon, 12 Oct 2020 00:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602460952;
        bh=GMaaSRJhJ9tBEJeg7JGfEam3FoW0td08m4out50B96g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nbfBteZcGCAWtJo7sCXioLCQA2gf8JgMSxZ3jwYb+ElPI1+XxkirlqxHn9QzD5kXZ
         iMuIYZNoPQMmacI+8AiKfMi21OWlKD5Qsg/o5h3YHf96uc9/L12YOoH0pEX7i6rOx+
         zIj399Y9OUf8DzT1m6IiZ7LbOqAdHVMkP5w8KtEc=
Date:   Mon, 12 Oct 2020 09:02:28 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        x86 <x86@kernel.org>
Subject: Re: [tip: objtool/core] x86/insn: Support big endian cross-compiles
Message-Id: <20201012090228.2af0bf7e2f85c3a251e573fc@kernel.org>
In-Reply-To: <your-ad-here.call-01602338530-ext-4703@work.hours>
References: <160208761921.7002.1321765913567405137.tip-bot2@tip-bot2>
        <20201009203822.GA2974@worktop.programming.kicks-ass.net>
        <20201009204921.GB21731@zn.tnic>
        <your-ad-here.call-01602338530-ext-4703@work.hours>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Sat, 10 Oct 2020 16:02:10 +0200
Vasily Gorbik <gor@linux.ibm.com> wrote:

> On Fri, Oct 09, 2020 at 10:49:21PM +0200, Borislav Petkov wrote:
> > On Fri, Oct 09, 2020 at 10:38:22PM +0200, Peter Zijlstra wrote:
> > > On Wed, Oct 07, 2020 at 04:20:19PM -0000, tip-bot2 for Martin Schwidefsky wrote:
> > > > The following commit has been merged into the objtool/core branch of tip:
> > > > 
> > > > Commit-ID:     2a522b53c47051d3bf98748418f4f8e5f20d2c04
> > > > Gitweb:        https://git.kernel.org/tip/2a522b53c47051d3bf98748418f4f8e5f20d2c04
> > > > 
> > > > x86/insn: Support big endian cross-compiles
> > > 
> > > This commit breaks the x86 build with CONFIG_X86_DECODER_SELFTEST=y.
> > > 
> > > I've asked Boris to truncate tip/objtool/core.
> > 
> > Yeah, top 4 are gone until this is resolved.
> > 
> > What I would suggest is to have a look at how tools/ headers are kept
> > separate from kernel proper ones, see tools/include/ and how those
> > headers there are full of dummy definitions just so it builds.
> > 
> > And then including a global one like linux/kernel.h is just looking for
> > trouble:
> > 
> > In file included from ./include/uapi/linux/byteorder/little_endian.h:12,
> >                  from ./include/linux/byteorder/little_endian.h:5,
> >                  from /usr/include/x86_64-linux-gnu/asm/byteorder.h:5,
> >                  from ./arch/x86/include/asm/insn.h:10,
> >                  from arch/x86/tools/insn_sanity.c:21:
> > ./tools/include/linux/types.h:30:18: error: conflicting types for ‘u64’
> >    30 | typedef uint64_t u64;
> 
> Sigh... I have not realized there are more usages of insn.c which are
> conditionally compiled. It's not like you grep *.c files to find who
> includes them regularity.

Yes, x86 insn library code is used for the sanity check tool too.

> 
> Looks like there is no way to find common byte swapping helpers for
> the kernel and tools then. Even though tools provide quite a bunch of
> them in tools/include/. So, completely avoiding mixing "kernel" and
> "userspace" headers would look like the following (delta to commit
> mentioned above):
> ---
> 
> diff --git a/arch/x86/include/asm/insn.h b/arch/x86/include/asm/insn.h
> index 004e27bdf121..68197fe18a11 100644
> --- a/arch/x86/include/asm/insn.h
> +++ b/arch/x86/include/asm/insn.h
> @@ -7,7 +7,13 @@
>   * Copyright (C) IBM Corporation, 2009
>   */
>  
> +#ifdef __KERNEL__
>  #include <asm/byteorder.h>
> +#define insn_cpu_to_le32 cpu_to_le32
> +#else
> +#include <endian.h>
> +#define insn_cpu_to_le32 htole32
> +#endif
>  /* insn_attr_t is defined in inat.h */
>  #include <asm/inat.h>
>  
> @@ -47,7 +53,7 @@ static inline void insn_field_set(struct insn_field *p, insn_value_t v,
>  				  unsigned char n)
>  {
>  	p->value = v;
> -	p->little = __cpu_to_le32(v);
> +	p->little = insn_cpu_to_le32(v);
>  	p->nbytes = n;
>  }
>  
> diff --git a/arch/x86/lib/insn.c b/arch/x86/lib/insn.c
> index 520b31fc1f1a..003f32ff7798 100644
> --- a/arch/x86/lib/insn.c
> +++ b/arch/x86/lib/insn.c
> @@ -5,7 +5,6 @@
>   * Copyright (C) IBM Corporation, 2002, 2004, 2009
>   */
>  
> -#include <linux/kernel.h>
>  #ifdef __KERNEL__
>  #include <linux/string.h>
>  #else
> @@ -16,15 +15,23 @@
>  
>  #include <asm/emulate_prefix.h>
>  
> +#ifdef __KERNEL__
> +#define insn_le32_to_cpu le32_to_cpu
> +#define insn_le16_to_cpu le16_to_cpu
> +#else
> +#define insn_le32_to_cpu le32toh
> +#define insn_le16_to_cpu le16toh
> +#endif
> +
>  #define leXX_to_cpu(t, r)						\
>  ({									\
>  	__typeof__(t) v;						\
>  	switch (sizeof(t)) {						\
> -	case 4: v = le32_to_cpu(r); break;				\
> -	case 2: v = le16_to_cpu(r); break;				\
> +	case 4: v = insn_le32_to_cpu(r); break;				\
> +	case 2: v = insn_le16_to_cpu(r); break;				\
>  	case 1:	v = r; break;						\
> -	default:							\
> -		BUILD_BUG(); break;					\
> +	default: /* relying on -Wuninitialized to report this */	\
> +		break;							\
>  	}								\
>  	v;								\
>  })
> --
> And the same for the tools/*
> No linux/kernel.h means no BUILD_BUG(), but -Wuninitialized actually
> does a decent job in this case:
> arch/x86/../../../arch/x86/lib/insn.c:605:37: error: variable 'v' is
> 		uninitialized when used here [-Werror,-Wuninitialized]
>                 insn_field_set(&insn->immediate2, get_next(long, insn), 1);
>                                                   ^~~~~~~~~~~~~~~~~~~~

Can you initialize v with 0 ? Anyway it will be optimized out while
compiling the code.

> 
> Masami, Josh,
> would that be acceptable?

Yes.

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
