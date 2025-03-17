Return-Path: <linux-tip-commits+bounces-4243-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A25A64942
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 11:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 547D21896E59
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 10:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3EA22FF2E;
	Mon, 17 Mar 2025 10:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="SfbCsiPD"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA4722257F;
	Mon, 17 Mar 2025 10:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742206477; cv=none; b=jB02IShho2Z/fqSOTxiH13hlTzflbo+uMKVTqWqOMDhrFD8dlN69xgCD4ZgP1hNXZIZxzrJuWwyytEz4t0JKMq/V5Y+jol/BYkXI8kP6kr6GF0/7/FOCmQGfFKBR2bOU2XxMcQGfjwb3E/oHTq9M1RFax9T2KIZm2MxNhyMKrR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742206477; c=relaxed/simple;
	bh=EeUctE2/P3yKvJnbRUh15fbcP0Z9xVX9onyE9XYknRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MoEMhOG1tdF7ZmB5PnJb/yJEQLeQFYQnxG+KA6FfC9ETcbKm70nCoOkxDKiD5A5GaseFVvP+rlEs/n9sWVBO48bnfMTPNGWZfbbULI23xPEjcF5ai0O4MWPD9k5zQDCQt0DdAf6ZiHt6j6flWcJnHJvSF8mCYB1YLLXYgzAoEHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=SfbCsiPD; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7B51C40E0196;
	Mon, 17 Mar 2025 10:14:31 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id IaeYT4_IfyoQ; Mon, 17 Mar 2025 10:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1742206466; bh=2n6hcLCVWzPn78xpoYAPBUM/0TX6AgClpAc8Szp8ycg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SfbCsiPDj04tOmiulVjsl7pkxZUc8rES8TmPzhyJqBDBhLb5m+U+2JJRSRz5IUJuO
	 /KsZyxYq908/OAm0L0SavKnUe4M/lSnotDgdfBpYPvO2bJXnI1R4qSNqKYEZoMrt28
	 70XIE08J6NbJVBWLsCkBz5xaqIXOlCmOENMQnWDJgAEOACCIHPzholsR+i/A7H1aDQ
	 ImpZ/ZPNJ3ft7yMHhyB1Q55jFZuPaZYGJuEptOBffBSdWPuubycCjSYeh5l+KOfSrr
	 mddlr467kdD9ZbpqBNor1YCmE55tv2XMPgK1qCzr4LkiE2pBe+aC2nmBt8wi5TsETA
	 KeG/+krQeZeGah58Q30hLiXo/keartsUGqFDaOINpzjKxGAjVHOFbSR4wDejRp0t2V
	 walzhq5AX+Z/zRTohogVxZ5Ac9Ce4GgIudP6Crr9ddWzwAMsz09WfOMhHFJV0GguMZ
	 EPVZ2ByJ0qSelAZnFKXzHUIUub+3IFIPV22xYvlEndJ4/6TOvtBnaRVpC76UGv/HbP
	 P4Pw+FmOsnaBqbsfmDeGMyPIaCAaW4TjlD5ulLGM/0ZNA3x9ADYLmVJXyL7O9j+j1p
	 +B/HSpiscGgxwjPnlXYZofZ/jhS1Zbmx2VPvSbaNW8dDCy3UvhJdVENhNLRAIjtRsp
	 p0nMySBKCMH2IRTtPPEuLMpg=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A7C0B40E020E;
	Mon, 17 Mar 2025 10:14:16 +0000 (UTC)
Date: Mon, 17 Mar 2025 11:14:15 +0100
From: Borislav Petkov <bp@alien8.de>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, Uros Bizjak <ubizjak@gmail.com>,
	Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@kernel.org>,
	Brian Gerst <brgerst@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org
Subject: Re: [tip: x86/fpu] x86/fpu: Use XSAVE{,OPT,C,S} and XRSTOR{,S}
 mnemonics in xstate.h
Message-ID: <20250317101415.GBZ9f198PAh90nMWDf@fat_crate.local>
References: <20250313130251.383204-1-ubizjak@gmail.com>
 <174188823430.14745.17591986001259957573.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <174188823430.14745.17591986001259957573.tip-bot2@tip-bot2>

On Thu, Mar 13, 2025 at 05:50:34PM -0000, tip-bot2 for Uros Bizjak wrote:
> The following commit has been merged into the x86/fpu branch of tip:
> 
> Commit-ID:     2883b4c2169a435488f7845e1b6fdc6f3438c7c6
> Gitweb:        https://git.kernel.org/tip/2883b4c2169a435488f7845e1b6fdc6f3438c7c6
> Author:        Uros Bizjak <ubizjak@gmail.com>
> AuthorDate:    Thu, 13 Mar 2025 14:02:27 +01:00
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Thu, 13 Mar 2025 18:36:52 +01:00
> 
> x86/fpu: Use XSAVE{,OPT,C,S} and XRSTOR{,S} mnemonics in xstate.h
> 
> Current minimum required version of binutils is 2.25, which
> supports XSAVE{,OPT,C,S} and XRSTOR{,S} instruction mnemonics.
> 
> Replace the byte-wise specification of XSAVE{,OPT,C,S}
> and XRSTOR{,S} with these proper mnemonics.
> 
> No functional change intended.
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Brian Gerst <brgerst@gmail.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Link: https://lore.kernel.org/r/20250313130251.383204-1-ubizjak@gmail.com
> ---
>  arch/x86/kernel/fpu/xstate.h | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
> index aa16f1a..1418423 100644
> --- a/arch/x86/kernel/fpu/xstate.h
> +++ b/arch/x86/kernel/fpu/xstate.h
> @@ -94,18 +94,17 @@ static inline int update_pkru_in_sigframe(struct xregs_state __user *buf, u64 ma
>  /* XSAVE/XRSTOR wrapper functions */
>  
>  #ifdef CONFIG_X86_64
> -#define REX_PREFIX	"0x48, "
> +#define REX_SUFFIX	"64"
>  #else
> -#define REX_PREFIX
> +#define REX_SUFFIX
>  #endif
>  
> -/* These macros all use (%edi)/(%rdi) as the single memory argument. */
> -#define XSAVE		".byte " REX_PREFIX "0x0f,0xae,0x27"
> -#define XSAVEOPT	".byte " REX_PREFIX "0x0f,0xae,0x37"
> -#define XSAVEC		".byte " REX_PREFIX "0x0f,0xc7,0x27"
> -#define XSAVES		".byte " REX_PREFIX "0x0f,0xc7,0x2f"
> -#define XRSTOR		".byte " REX_PREFIX "0x0f,0xae,0x2f"
> -#define XRSTORS		".byte " REX_PREFIX "0x0f,0xc7,0x1f"
> +#define XSAVE		"xsave" REX_SUFFIX " %[xa]"
> +#define XSAVEOPT	"xsaveopt" REX_SUFFIX " %[xa]"
> +#define XSAVEC		"xsavec" REX_SUFFIX " %[xa]"
> +#define XSAVES		"xsaves" REX_SUFFIX " %[xa]"
> +#define XRSTOR		"xrstor" REX_SUFFIX " %[xa]"
> +#define XRSTORS		"xrstors" REX_SUFFIX " %[xa]"
>  
>  /*
>   * After this @err contains 0 on success or the trap number when the
> @@ -114,10 +113,10 @@ static inline int update_pkru_in_sigframe(struct xregs_state __user *buf, u64 ma
>  #define XSTATE_OP(op, st, lmask, hmask, err)				\
>  	asm volatile("1:" op "\n\t"					\
>  		     "xor %[err], %[err]\n"				\
> -		     "2:\n\t"						\
> +		     "2:\n"						\
>  		     _ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_FAULT_MCE_SAFE)	\
>  		     : [err] "=a" (err)					\
> -		     : "D" (st), "m" (*st), "a" (lmask), "d" (hmask)	\
> +		     : [xa] "m" (*(st)), "a" (lmask), "d" (hmask)	\

This [xa] needs documenting in the comment above this.

What does "xa" even mean?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

