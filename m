Return-Path: <linux-tip-commits+bounces-1473-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A04A90FF76
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Jun 2024 10:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BAED1C2137C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Jun 2024 08:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790E71AAE11;
	Thu, 20 Jun 2024 08:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="dv3k7Rea"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA992582;
	Thu, 20 Jun 2024 08:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718873360; cv=none; b=jtmYYQadIG55RIQO6EoVS/gwq7IsV9YHiQgN4lTHELik7dGZLD6tznCrIZzgV8hPD9ImZVUE3lBRzjdyGEvX2l4jWFQLGaajbHpvrJEYRuwRSt43egIAH+3iyZqWF85uaNOEfq6nLHTMpPW7Tcko4JX7pP1pUQ3g3ic7I4+U1WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718873360; c=relaxed/simple;
	bh=jNfkDMRcO2oeeYKSJDzxCHJCMTTV67C3zqxJqxPPYYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r/tpR4dn9cjltW2pGV06epKesf0YxmHNUaKJdM8ec+7uikIRDU8VN6JX7BNRtXNpvU4azLGiZMy2lM50meftA+9hY5PpaIjPZp21iEcYg7GXRxaH5H8cS5Ws4FwZ2Fzdo/VxJgJB+4nX3HvaJ68kgDJJpf5OCiyM5y5S6FG0jXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=dv3k7Rea; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 645CA40E021A;
	Thu, 20 Jun 2024 08:49:14 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Uv5zLkmrO5Np; Thu, 20 Jun 2024 08:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1718873350; bh=6EyIcoUfttVVNnxBX/AUr5QBtwGzWzGdL+5OK4EVuC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dv3k7ReanBgHyjpkkVskT8jnbh35c6C2llvNvCgDKnvCWxNqlEIEDzBCnQ/Ub2TLN
	 GKDDKWT6DRo1EtsdPgO7lzjTjr+ZwBP/BCi5BGfrYnTI4P7sfZkrQD0ksrdTWPfhEx
	 ArhQtF4JrfMhr6fkc2C0FaoXBT9BjxIgXX58RfiUqWn5Ie5Pmz8rTpcS3/YAPMKSfm
	 xxBT8SIIoSuSC/vF2crSp8+d8ARufM/0KFiWnT94OPkOAn+XiY7IlMCsPVTgseo4z/
	 Npsg9zKJ+LX6Ah6Djv7RApCNZKTuchEANiXkv2CVMnHqSTBSbr4IPtchC3kBxYDmuX
	 oCFtMmjjhgj5S0KdP3FiW1iriC2bzBAGssXhxu6lGU+Kx5PXl+wD2lCaQodtH4QNOt
	 WNEsDudjN7V7PO5YqNagT4qrQ8GuiqI9oYC6Bu7llRw8eTWTk/NcBOigDjTGYfzldm
	 RuYOrhFBrlyOac7rKMSbPqHLaHMStoHz7oKa83/fmu3qAqGUWF1vWaDjZm3LN9Oalx
	 Anu7G/KJXBv6q3x/3K947gmdEaVMMf5MAbH6qz1Hd12JkSjMx24Ax9iPMBxo5uSY67
	 VccROMPvyeOtCyCrWMXTIgfapeJSU/J3ghYBS6NCtHRZNVjTsSatnNmjpTCxL0dNpi
	 608HV6WbwiemcHMmWr984C9A=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 706FA40E01A5;
	Thu, 20 Jun 2024 08:49:05 +0000 (UTC)
Date: Thu, 20 Jun 2024 10:48:53 +0200
From: Borislav Petkov <bp@alien8.de>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, kernel test robot <lkp@intel.com>,
	Sean Christopherson <seanjc@google.com>, x86@kernel.org
Subject: Re: [tip: x86/alternatives] x86/alternatives, kvm: Fix a couple of
 CALLs without a frame pointer
Message-ID: <20240620084853.GAZnPs9Q94aakywkUn@fat_crate.local>
References: <171878639288.10875.12927337921927674667.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <171878639288.10875.12927337921927674667.tip-bot2@tip-bot2>

On Wed, Jun 19, 2024 at 08:39:52AM -0000, tip-bot2 for Borislav Petkov (AMD) wrote:
> The following commit has been merged into the x86/alternatives branch of tip:
> 
> Commit-ID:     93f78dadee5e56ae48aff567583d503868aa3bf2
> Gitweb:        https://git.kernel.org/tip/93f78dadee5e56ae48aff567583d503868aa3bf2
> Author:        Borislav Petkov (AMD) <bp@alien8.de>
> AuthorDate:    Tue, 18 Jun 2024 21:57:27 +02:00
> Committer:     Borislav Petkov (AMD) <bp@alien8.de>
> CommitterDate: Wed, 19 Jun 2024 10:33:25 +02:00
> 
> x86/alternatives, kvm: Fix a couple of CALLs without a frame pointer
> 
> objtool complains:
> 
>   arch/x86/kvm/kvm.o: warning: objtool: .altinstr_replacement+0xc5: call without frame pointer save/setup
>   vmlinux.o: warning: objtool: .altinstr_replacement+0x2eb: call without frame pointer save/setup
> 
> Make sure rSP is an output operand to the respective asm() statements.
> 
> The test_cc() hunk courtesy of peterz. Also from him add some helpful
> debugging info to the documentation.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202406141648.jO9qNGLa-lkp@intel.com/
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Acked-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/include/asm/alternative.h      |  2 +-
>  arch/x86/kernel/alternative.c           |  2 +-
>  arch/x86/kvm/emulate.c                  |  2 +-
>  tools/objtool/Documentation/objtool.txt | 19 +++++++++++++++++++
>  4 files changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
> index 89fa50d..8cff462 100644
> --- a/arch/x86/include/asm/alternative.h
> +++ b/arch/x86/include/asm/alternative.h
> @@ -248,7 +248,7 @@ static inline int alternatives_text_reserved(void *start, void *end)
>   */
>  #define alternative_call(oldfunc, newfunc, ft_flags, output, input...)	\
>  	asm_inline volatile(ALTERNATIVE("call %c[old]", "call %c[new]", ft_flags) \
> -		: output : [old] "i" (oldfunc), [new] "i" (newfunc), ## input)
> +		: output, ASM_CALL_CONSTRAINT : [old] "i" (oldfunc), [new] "i" (newfunc), ## input)

Yeah, this doesn't fly currently:

https://lore.kernel.org/r/202406200507.AXxJ6Bmw-lkp@intel.com

because those atomic64_32.h macros do

        alternative_atomic64(set, /* no output */,
                             "S" (v), "b" (low), "c" (high)

so without an output, it ends up becoming:

asm __inline volatile("# ALT: oldinstr\n" ... ".popsection\n" : , "+r" (current_stack_pointer) : [old] "i" ...

note the preceding ",".

And I can't do "output..." macro argument with ellipsis and paste with "##
output" because "input..." already does that. :-\

So I am not sure what to do here. Removing the ASM_CALL_CONSTRAINT works,
let's see whether it passes build tests.

Or add dummy output arguments to the three atomic macros which have no
output?

Hm.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

