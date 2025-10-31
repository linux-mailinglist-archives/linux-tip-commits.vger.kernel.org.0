Return-Path: <linux-tip-commits+bounces-7114-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A20C3C257C9
	for <lists+linux-tip-commits@lfdr.de>; Fri, 31 Oct 2025 15:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9B83581067
	for <lists+linux-tip-commits@lfdr.de>; Fri, 31 Oct 2025 14:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B840D25784B;
	Fri, 31 Oct 2025 14:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N01GKuW8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1D81F37D4;
	Fri, 31 Oct 2025 14:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761919789; cv=none; b=FplNVsT4ykBQjPdEjF+NPW2aqECDf7ZoWPIcf376qjJnlDMlvM7v4wg18xOvda/sBFoXbr8bdnKilSJNGhC8/30Eo2d9NW+XQ1V6rKJE4lr0SrGSYuj7SoA8kfVbvic6KaZDZAkMhMsoScdHv0g5LLyL+0GmkhidEZKYrbBhyCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761919789; c=relaxed/simple;
	bh=8wCSZybMl3Z4NnP/tU1aMkhTs/+6NLIANQ/z8Bp5xP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VpE7ORP7KqmVq1/hhxBTB0KgdnfDKrNsmlRsM3lQ7ugVz0IIcbAPbYYY5Vt5ae3DRZZnTFmBGMGY5WxDAHM841uDQhnCXGlYj5JY0o1A9tT3h9id+hfp2JuJL/aMbZ/RD3CGpBStCqUHa1kV+piIeruheYJq0WUFpOX8PsfVBtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N01GKuW8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A2B3C4CEE7;
	Fri, 31 Oct 2025 14:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761919789;
	bh=8wCSZybMl3Z4NnP/tU1aMkhTs/+6NLIANQ/z8Bp5xP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N01GKuW8ftbJt69UA7TPfzf3LH3hsMP6C7T11F31s03b6IplnFnX9lL3z7g33K9EL
	 560PBzMWkDvyThjJ8uo/LsEb5aUtITmtwjj5VCExvDTch9G8EuEo4w6PT7HDV6DCpi
	 V0OZ1+1p1c2RruO60VTf2rzspeBSf2ui0NksSRx2c8z62kOxI3vV+ywURyXA7mlZaU
	 mJdYQIvJLWHSJFLTi05y+Jz1jbN6kR3XANd4uBEwnlreIfV8SYJGGLcb9pM8xOYcT5
	 2N/yndx2C27XpLWSc3i+5i16VKrU7Iv0Y8cwlvIURXH9OXnAvvw6/53OYZrH5B7Bey
	 vfg7Bd0NXjR2g==
Date: Fri, 31 Oct 2025 10:09:44 -0400
From: Nathan Chancellor <nathan@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, linux-kernel@vger.kernel.org,
	linux-tip-commits@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
	Joe Lawrence <joe.lawrence@redhat.com>, x86@kernel.org
Subject: Re: [tip: objtool/core] objtool/klp: Add --debug option to show
 cloning decisions
Message-ID: <20251031140944.GA3022331@ax162>
References: <176060833509.709179.4619457534479145477.tip-bot2@tip-bot2>
 <20251031114919.GBaQSiPxZrziOs3RCW@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031114919.GBaQSiPxZrziOs3RCW@fat_crate.local>

Hey Boris,

On Fri, Oct 31, 2025 at 12:49:19PM +0100, Borislav Petkov wrote:
> On Thu, Oct 16, 2025 at 09:52:15AM -0000, tip-bot2 for Josh Poimboeuf wrote:
> > The following commit has been merged into the objtool/core branch of tip:
> > 
> > Commit-ID:     7c2575a6406fb85946b05d8dcc856686d3156354
> > Gitweb:        https://git.kernel.org/tip/7c2575a6406fb85946b05d8dcc856686d3156354
> > Author:        Josh Poimboeuf <jpoimboe@kernel.org>
> > AuthorDate:    Wed, 17 Sep 2025 09:04:00 -07:00
> > Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
> > CommitterDate: Tue, 14 Oct 2025 14:50:18 -07:00
> > 
> > objtool/klp: Add --debug option to show cloning decisions
> > 
> > Add a --debug option to klp diff which prints cloning decisions and an
> > indented dependency tree for all cloned symbols and relocations.  This
> > helps visualize which symbols and relocations were included and why.
> > 
> > Acked-by: Petr Mladek <pmladek@suse.com>
> > Tested-by: Joe Lawrence <joe.lawrence@redhat.com>
> > Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> > ---
> 
> ...
> 
> > +#define dbg_indent(args...)						\
> > +	int __attribute__((cleanup(unindent))) __dummy_##__COUNTER__;	\
> 
> so this compiler:
> 
> Ubuntu clang version 15.0.7
> 
> doesn't like this, see below. With some configs only, I've attached one.
> 
> Newer clang is fine so I guess this old one which we support can't do that
> unused var squashing or so.

Correct, I fixed this in clang-17 so clang-15 and clang-16 will show
this.

https://github.com/llvm/llvm-project/commit/877210faa447f4cc7db87812f8ed80e398fedd61

> How about this fix?

Yeah, that looks good to me and matches the workaround that Peter did in
include/linux/compiler-clang.h. If cleanup is going to be used more in
objtool, it might be worth taking that approach there too like:

  #ifdef __clang__
  #define __cleanup(func) __maybe_unused __attribute__((__cleanup__(func)))
  #else
  #define __cleanup(func) __attribute__((__cleanup__(func)))
  #endif

> Seems to work here.
> 
> ---
> 
> diff --git a/tools/objtool/include/objtool/warn.h b/tools/objtool/include/objtool/warn.h
> index e88322d97573..289fbce428c5 100644
> --- a/tools/objtool/include/objtool/warn.h
> +++ b/tools/objtool/include/objtool/warn.h
> @@ -127,7 +127,7 @@ static inline void unindent(int *unused) { indent--; }
>  })
>  
>  #define dbg_indent(args...)                                            \
> -       int __attribute__((cleanup(unindent))) __dummy_##__COUNTER__;   \
> +       int __attribute__((cleanup(unindent))) __used __dummy_##__COUNTER__; \
>         __dbg_indent(args);                                             \
>         indent++
>  
> ---
> 
> build error:
> 
> ---
> 
> klp-diff.c:601:2: error: unused variable '__dummy___COUNTER__' [-Werror,-Wunused-variable]
>         dbg_indent("%s%s", patched_sym->name, data_too ? " [+DATA]" : "");
>         ^
> /home/amd/kernel/linux/tools/objtool/include/objtool/warn.h:130:41: note: expanded from macro 'dbg_indent'
>         int __attribute__((cleanup(unindent))) __dummy_##__COUNTER__;   \
>                                                ^
> <scratch space>:132:1: note: expanded from here
> __dummy___COUNTER__
> ^
> klp-diff.c:1045:2: error: unused variable '__dummy___COUNTER__' [-Werror,-Wunused-variable]
>         dbg_clone_reloc(sec, offset, patched_sym, addend, export, klp);
>         ^
> klp-diff.c:1016:2: note: expanded from macro 'dbg_clone_reloc'
>         dbg_indent("%s+0x%lx: %s%s0x%lx [%s%s%s%s%s%s]",                                \
>         ^
> /home/amd/kernel/linux/tools/objtool/include/objtool/warn.h:130:41: note: expanded from macro 'dbg_indent'
>         int __attribute__((cleanup(unindent))) __dummy_##__COUNTER__;   \
>                                                ^
> <scratch space>:138:1: note: expanded from here
> __dummy___COUNTER__
> ^

Cheers,
Nathan

