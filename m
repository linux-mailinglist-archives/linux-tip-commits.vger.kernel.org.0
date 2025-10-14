Return-Path: <linux-tip-commits+bounces-6803-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 622F5BD9B33
	for <lists+linux-tip-commits@lfdr.de>; Tue, 14 Oct 2025 15:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0F01635500D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 14 Oct 2025 13:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A682E8B73;
	Tue, 14 Oct 2025 13:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="TQs4iuy+"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C251C6FE5;
	Tue, 14 Oct 2025 13:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760448368; cv=none; b=RlhwTDVnUMW+w6mUZ7cvm6bwbyula+WLPqkj46rHxF35cFw50g/zhDBAldN/ZhEXARDwK0WPmhEiuTu6MHqxbRhZMilNG272o/TEpVpx4LKX7xjioQZVQelWTFxMfxufvGvWUOGxPcSuh7nLI1qvw6aIdM82WWGNiLGGg+DkhUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760448368; c=relaxed/simple;
	bh=HdoCn4GOazTS+zRp5uQLC2XnPHX0Mm2v2xht0ldSgvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kvdDsb/r2bIxJSmbxOVYokvcJj0NGwcMYduWpEfcO6U7Zrsc3vqNsmGgP0dFFf3u6WyacUfvU1KdMuELwebcoh0Db3OcF+3Mpw8plBVZSqu8Clhl/hw2bx/Y4hDz+VSKd1gS8pYSYeEidJaJupJD7CihnO54+WmumWkQx0XOCjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=TQs4iuy+; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B228F40E019B;
	Tue, 14 Oct 2025 13:25:58 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Um6Qob17WE9I; Tue, 14 Oct 2025 13:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1760448354; bh=p9mlxWCEY3N8VBccjtQKF4D4mfvLrnFkADy7v4KgqSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TQs4iuy+YypQargymdG4Hirwx6p90B/ZgXmeUyTZk+5iv2F4Cthy9HtH7tJYgmwit
	 YSdz9vx+brmQQnFjkR9MhwWH/IjRnhk9aBoRuq2MHINMGHTK8GP3y42I3S713pHixZ
	 Cf5Ii3XOO6/g2KoAxeNfMCetu27xXEO25HS8qmdl1OJTBUkphenmx/QKwhuWtYvQ8F
	 bUCJ7+C1n9+llIo/UPkvPtU9Zn2W7UqMQPqBgA5CawD/+I279Ocx0LN2m1VKv260QY
	 Dw96/ATdN2XAzLTHlyC0+ClEN0NrEEjLbVnQBVNZnk73CH3l3jjxbQwqTdCUgFiSCE
	 /eHa7iS3QAP0yIhSppZKH5pz1hNiOHu2Vcdf5tIaACaMMysTioTz7qu6OCJ+bF22zU
	 +QuO1jktUi46wmnukaWOmUKPbFDnH031eVFhIrWXs2ICowuKvbIhEGtjpKsH0BTfRc
	 9DE3oinKmHcZ6qn9nNEmylBzSmhoqRn7mgb7EBCtw+09FpYKcj8ANgLRPg+1k1DZ7O
	 XCQs2gMFdXc+fuSISe25wI1FlrtCykR8/wmwMeR5ngNiAU8d3ReFFAk7YTqIEdfrkv
	 biJfUS/GQO85qH8+KuLMXT9o/HcozEWlLR3xBIrZoF/oACpqKrsJC37BkAouqrnTNb
	 rTNTKAR+s5/4EYCbQDLXi920=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id C645440E016D;
	Tue, 14 Oct 2025 13:25:49 +0000 (UTC)
Date: Tue, 14 Oct 2025 15:25:44 +0200
From: Borislav Petkov <bp@alien8.de>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, Juergen Gross <jgross@suse.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org
Subject: Re: [tip: x86/core] x86/alternative: Patch a single alternative
 location only once
Message-ID: <20251014132544.GBaO5PWEbKfbQFCXdB@fat_crate.local>
References: <20250929112947.27267-4-jgross@suse.com>
 <176043135449.709179.18067035380831847643.tip-bot2@tip-bot2>
 <20251014125909.GAaO5JHU_cgsPgstc_@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251014125909.GAaO5JHU_cgsPgstc_@fat_crate.local>

On Tue, Oct 14, 2025 at 02:59:09PM +0200, Borislav Petkov wrote:
> And frankly, the justification for this patch is also meh: an interrupt might
> use the location?!? If this is a real issue then we better disable IRQs around
> it. But not make the code yucky.

And this patch is not doing what it is claiming is doing:

Here's an incarnation of XSTATE_XSAVE which is a 3-way alternative:

At location ffffffff81283cd3, it replaces the default XSAVE with XSAVEOPT.

[    2.456696] SMP alternatives: feat: 10*32+0, old: (save_fpregs_to_fpstate+0x43/0xa0 (ffffffff81283cd3) len: 6), repl: (ffffffff89c1e6d9, len: 6) flags: 0x0
[    2.459317] SMP alternatives: ffffffff81283cd3:   old_insn: 49 0f ae 64 24 40	xsave64 0x40(%r12)
[    2.460806] SMP alternatives: ffffffff89c1e6d9:   rpl_insn: 49 0f ae 74 24 40	xsaveopt64 0x40(%r12)
[    2.463316] SMP alternatives: ffffffff81283cd3: final_insn: 49 0f ae 74 24 40

and then that exact same location:

[    2.464757] SMP alternatives: feat: 10*32+1, old: (save_fpregs_to_fpstate+0x43/0xa0 (ffffffff81283cd3) len: 6), repl: (ffffffff89c1e6df, len: 6) flags: 0x0
[    2.467317] SMP alternatives: ffffffff81283cd3:   old_insn: 49 0f ae 64 24 40
[    2.468746] SMP alternatives: ffffffff89c1e6df:   rpl_insn: 49 0f c7 64 24 40	xsaves64 0x40(%r12)
[    2.470167] SMP alternatives: ffffffff81283cd3: final_insn: 49 0f c7 64 24 40

gets XSAVES.

So, long story short, this needs more thought:

1. check whether patching is needed

2. a helper function evaluates all instances and figures out the final insn
   bytes which need to be patched along with the proper padding

3. the proper bytes are copied into the target location and all good

But not like this - the idea is somewhat ok but it needs to be executed in
a cleaner manner.

I'd say.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

