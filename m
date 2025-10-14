Return-Path: <linux-tip-commits+bounces-6802-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21219BD97CF
	for <lists+linux-tip-commits@lfdr.de>; Tue, 14 Oct 2025 14:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AED21893EAD
	for <lists+linux-tip-commits@lfdr.de>; Tue, 14 Oct 2025 12:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B011DDA24;
	Tue, 14 Oct 2025 12:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="QEWCF3cO"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD9E31354B;
	Tue, 14 Oct 2025 12:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760446772; cv=none; b=EmGadCu/st3AZxVKf/8x31P3L1meXI39YZTCufU7f5m729HTZ8jOUHNXzI6s3kYcLTDiz8BX10u+27wZMzKsdL94GuVJV3HEyn49Ab3U2BZY4YUPd0+k08qdbsmOVJpCZwz+DwdDwLk+wtaYm8jNEFiIKLDActf9f+1ZLpFLPfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760446772; c=relaxed/simple;
	bh=dA8ZO6ChYJ9c/RyoUIv5bvOV40QV/ycga8CfhphPEKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VNy7gEImJkIf3Oeu3XmUqVWIrsQ/eJINDZnqWU/K/LQ/xp78JXnKnJFb1uRrXE35irxAUexIgvwwfLsj0jLA+RDF5Fs+4ixXL+S8UeU7RXrZwaogSSFq8xWx6waKUCls4VUb14//ywlJ01EmnAXcBePoqEfItuLrQdSDQrvxb7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=QEWCF3cO; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6B0DE40E01AB;
	Tue, 14 Oct 2025 12:59:24 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 44Ym9plS8O5S; Tue, 14 Oct 2025 12:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1760446760; bh=CRAm/96OhU1MWiQAAgFQeaQhfDFuGGKHReG3tVOvRds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QEWCF3cOYhCsRumnVfUo0HdEP1854RnsFaKcAGAWUMOYOWCbZ6jhN7dNI0U79H6kA
	 4rAti4K3TH9gI6vohOC+fj8fyenNbh7kcRth/oVOENuwsHDAhrQqRNqZY6KSj/M0Zi
	 JEwqEROpLkHbI27UyFSA/CcE0d4DZn+JorHGTID1VXrfUY2BANjUpmvT4YDFy4B2xB
	 4OZkC4qUUq2KgF/xfdhGWvtg5NSPkhIMGAWBqxftjjm5f1jBcl5DtHYZexStckF0tH
	 uIcRktBDsfQMooTtqvrWI8/gGjK7FoTFIHX7/9ZOXvxOp5Rehpx7ZiWDraSzyRchzk
	 FzzKwtLPwiGwmbsjFPLMKoDfmeQo1Q9VGSDVZ0ViSdeEqbvUvRh+cJ2FhMohAorkE5
	 quQbP6oH/B0OGg4jTrVETO0YQNU3Zv9pFJnbbcdjljeYLmrtvVs3SPm4pTVRxZzF1g
	 asy60+II+mmRNFgm/7zxDcMaE/KcLmIZaUislSsEGvyD1ZH+bwHHEE9muton/sUjIF
	 yBPCOVuDdEUbrvB1eFae/+2oMBZQlSKBb+9j1LduuBTPIbSyE9/2KDEWw93/gz2CrY
	 RCzjrZJwetKTNrn9kZSb3OSJmJ9D7nUGjamAfGidv0l4hx/OO6QiVaMF0t+Wfyd08J
	 mbKOJqhJfrJwPpr8yXlgZL08=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id B9B5740E019F;
	Tue, 14 Oct 2025 12:59:15 +0000 (UTC)
Date: Tue, 14 Oct 2025 14:59:09 +0200
From: Borislav Petkov <bp@alien8.de>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, Juergen Gross <jgross@suse.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org
Subject: Re: [tip: x86/core] x86/alternative: Patch a single alternative
 location only once
Message-ID: <20251014125909.GAaO5JHU_cgsPgstc_@fat_crate.local>
References: <20250929112947.27267-4-jgross@suse.com>
 <176043135449.709179.18067035380831847643.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <176043135449.709179.18067035380831847643.tip-bot2@tip-bot2>

On Tue, Oct 14, 2025 at 08:42:34AM -0000, tip-bot2 for Juergen Gross wrote:
> @@ -648,6 +648,8 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
>  	u8 insn_buff[MAX_PATCH_LEN];
>  	u8 *instr;
>  	struct alt_instr *a, *b;
> +	unsigned int instances = 0;
> +	bool patched = false;

Except that we have the reverse fir tree rule in tip for function-local vars.

The tip-tree preferred ordering of variable declarations at the
beginning of a function is reverse fir tree order::

	struct long_struct_name *descriptive_name;
	unsigned long foo, bar;
	unsigned int tmp;
	int ret;

The above is faster to parse than the reverse ordering::

	int ret;
	unsigned int tmp;
	unsigned long foo, bar;
	struct long_struct_name *descriptive_name;

And even more so than random ordering::

	unsigned long foo, bar;
	int ret;
	struct long_struct_name *descriptive_name;
	unsigned int tmp;

> @@ -692,14 +698,19 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
>  		 * - feature not present but ALT_FLAG_NOT is set to mean,
>  		 *   patch if feature is *NOT* present.
>  		 */
> -		if (!boot_cpu_has(a->cpuid) == !(a->flags & ALT_FLAG_NOT)) {
> -			memcpy(insn_buff, instr, a->instrlen);
> -			optimize_nops(instr, insn_buff, a->instrlen);
> -		} else {
> +		if (!boot_cpu_has(a->cpuid) != !(a->flags & ALT_FLAG_NOT)) {
>  			apply_one_alternative(instr, insn_buff, a);
> +			patched = true;
>  		}
>  
> -		text_poke_early(instr, insn_buff, a->instrlen);
> +		instances--;
> +		if (!instances) {
> +			if (!patched) {

I don't see how this is making this code better - this is slowly turning into
an unreadable mess with those magic "instances" and "patched".

And frankly, the justification for this patch is also meh: an interrupt might
use the location?!? If this is a real issue then we better disable IRQs around
it. But not make the code yucky.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

