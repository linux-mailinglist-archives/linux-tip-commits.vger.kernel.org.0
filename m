Return-Path: <linux-tip-commits+bounces-7123-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE95C28330
	for <lists+linux-tip-commits@lfdr.de>; Sat, 01 Nov 2025 17:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B82864E0257
	for <lists+linux-tip-commits@lfdr.de>; Sat,  1 Nov 2025 16:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9512E26D4C7;
	Sat,  1 Nov 2025 16:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="anbufR7M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9E51FDE14;
	Sat,  1 Nov 2025 16:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762015415; cv=none; b=ZOpKlbymauVqXLV8+esf6pTmYvR9UeysDlQaA5OtLzwGfesT3THCmlle3y6yHkhlN5VW57rAnhHugMOoCeqArj9Yy9M76Y8KfA3QFnizQUsRGzBFr+suuIsFrZsTAqgohs/e19TLa2uB1Q/1eOC6et5VWt8ZJ4/IW6Kp64YrmXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762015415; c=relaxed/simple;
	bh=Y5Jcgi1hHxmPyWFLZ7tYrmAPkHHnXS1xs/OhfJGBS6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C6Tx9fC+AYTqJDT5jPQg7h3CXPboXfMK70JcGNAOJc84FnMR1koFa7Me4ANVyZT8B3I2oSjjcfdjBFpQR/ssp1Anzn2rU4MAsw3pKjcCyuGEvNB5TG03KvMMSr4MLHAeN7YISDBIwqrPI/+wjVXXFoL3p1Xpq6lrON+4rlPrWlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=anbufR7M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA3B5C4CEF1;
	Sat,  1 Nov 2025 16:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762015414;
	bh=Y5Jcgi1hHxmPyWFLZ7tYrmAPkHHnXS1xs/OhfJGBS6g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=anbufR7MdnE+oDZZJmm9a5HkUQXBvxA4p/omg739+B7WiD+eWyNgk1CGWbmrUHl8n
	 diaT2MB6uI1OLRk8c8ARJscGYFOQtdvC6YCkX+4RxD8gZ2JADi3Xbm6cs5nZgpyJXy
	 NKrdcRAyX+JVut8SzrqgjgO5rU0QxA0mkT54b23FdCvignoUmOlKoUBIydfEYD8g0H
	 xR31r42OwFWrKlnRmaXB4emfGwrSaU4DXqxPQs3ow8VCbj90Z84fy46G08OzoprXmV
	 S/g8x4qBxhc3YJt3nUTSMVQLwANT2d2PZuFgRdup+4rhKk3Suijg/VM4ydTs+BB09G
	 bKUDIr3rABkKQ==
Date: Sat, 1 Nov 2025 12:43:29 -0400
From: Nathan Chancellor <nathan@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, linux-kernel@vger.kernel.org,
	linux-tip-commits@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
	Joe Lawrence <joe.lawrence@redhat.com>, x86@kernel.org
Subject: Re: [PATCH] tools/objtool: Copy the __cleanup unused variable fix
 for older clang
Message-ID: <20251101164329.GA3250327@ax162>
References: <176060833509.709179.4619457534479145477.tip-bot2@tip-bot2>
 <20251031114919.GBaQSiPxZrziOs3RCW@fat_crate.local>
 <20251031140944.GA3022331@ax162>
 <20251031142100.GEaQTFzKD-nV3kQkhj@fat_crate.local>
 <wi54qqmdbzuajt7f5krknhcibs7pj45zhf42n3z5nyqujoabgz@hbduuwymyufh>
 <20251031202526.GB2486902@ax162>
 <20251101124432.GBaQYAsK3mcvrB9cqm@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251101124432.GBaQYAsK3mcvrB9cqm@fat_crate.local>

On Sat, Nov 01, 2025 at 01:44:32PM +0100, Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> Date: Sat, 1 Nov 2025 13:37:51 +0100
> 
> Copy from
> 
>   54da6a092431 ("locking: Introduce __cleanup() based infrastructure")
> 
> the bits which mark the variable with a cleanup attribute unused so that my
> clang 15 can dispose of it properly instead of warning that it is unused which
> then fails the build due to -Werror.
> 
> Suggested-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Link: https://lore.kernel.org/r/20251031114919.GBaQSiPxZrziOs3RCW@fat_crate.local

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  tools/objtool/include/objtool/warn.h | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/objtool/include/objtool/warn.h b/tools/objtool/include/objtool/warn.h
> index e88322d97573..a1e3927d8e7c 100644
> --- a/tools/objtool/include/objtool/warn.h
> +++ b/tools/objtool/include/objtool/warn.h
> @@ -107,6 +107,15 @@ extern int indent;
>  
>  static inline void unindent(int *unused) { indent--; }
>  
> +/*
> + * Clang prior to 17 is being silly and considers many __cleanup() variables
> + * as unused (because they are, their sole purpose is to go out of scope).
> + *
> + * https://github.com/llvm/llvm-project/commit/877210faa447f4cc7db87812f8ed80e398fedd61
> + */
> +#undef __cleanup
> +#define __cleanup(func) __maybe_unused __attribute__((__cleanup__(func)))
> +
>  #define __dbg(format, ...)						\
>  	fprintf(stderr,							\
>  		"DEBUG: %s%s" format "\n",				\
> @@ -127,7 +136,7 @@ static inline void unindent(int *unused) { indent--; }
>  })
>  
>  #define dbg_indent(args...)						\
> -	int __attribute__((cleanup(unindent))) __dummy_##__COUNTER__;	\
> +	int __cleanup(unindent) __dummy_##__COUNTER__;			\
>  	__dbg_indent(args);						\
>  	indent++
>  
> -- 
> 2.51.0
> 
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

