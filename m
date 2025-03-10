Return-Path: <linux-tip-commits+bounces-4112-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C5AA5A378
	for <lists+linux-tip-commits@lfdr.de>; Mon, 10 Mar 2025 19:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84FAE18862D5
	for <lists+linux-tip-commits@lfdr.de>; Mon, 10 Mar 2025 18:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B2E17A2E8;
	Mon, 10 Mar 2025 18:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GrmjSU9e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABC4374EA;
	Mon, 10 Mar 2025 18:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741633040; cv=none; b=b1lrx0YV6JIKR8dcdfKoFUI1Enswg7dMVIFUc6Loo2ARNV0wazj4CVdQkXE9slqzVMiGh/q5SxAva24ynPQjmX3YldKLImq8JkRZKj9bRQI3mG//EOsfiZ7MpSJID3rTPV1Fn1ug4SehAvitwuq3tvFh2JU1XXmdmG5te1roZbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741633040; c=relaxed/simple;
	bh=RtLqefbM2Ii3H47vdqL087266bc1TXcV2JZ2kn5jnKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rYyUEYwPwDoS+VgRW3Tl6P8FgUxNDvU9Y/8rFa3xpN9qbDdWxjxO/yIG76MN1AvlZzjYNCcHKR+MXdijmLByI4scAoKEGyF6IomKMhMk5qxx989FwvWflTPlQ+3AxvdGdDtAoAUcmxGuQSJh7O0yCF0hSIGJjnvwKMElIM4Ugh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GrmjSU9e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB5C0C4CEE5;
	Mon, 10 Mar 2025 18:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741633039;
	bh=RtLqefbM2Ii3H47vdqL087266bc1TXcV2JZ2kn5jnKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GrmjSU9ei+hu7AAkET5Jq0DO9Zn3ql+gAyCcqBR+8Yd5/pgAm9zt+QeCPf1Bph97T
	 Ii69qOlOLcoyprrRufBMQHWbBOi5Y/rUsZNGdQIir3YprBDcVhwJwYU/StUZ9XLo+B
	 1etp3gmkwogkALZLcEqVeQNPDrcwSY8KRLIqQlZnJcNsALCC+4gL21HXnvpPZZi8OG
	 JKzIuLAZn2aQvH70cA5izW8VayR64vRNYv9npc2bj+KllO2wU6OnfJ5BkZli3FCoi2
	 p7u83SsH5e6+4R2SxaaXf+RmaEGq11tymkbLueavNTECtmRyxANCnWiwDRyOBSMuf+
	 Iostw6h4p/YVA==
Date: Mon, 10 Mar 2025 19:57:14 +0100
From: Ingo Molnar <mingo@kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org,
	"tip-bot2 for H. Peter Anvin (Intel)" <tip-bot2@linutronix.de>,
	linux-tip-commits@vger.kernel.org, "Xin Li (Intel)" <xin@zytor.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org
Subject: Re: [tip: x86/cpu] x86/cpufeatures: Add {REQUIRED,DISABLED} feature
 configs
Message-ID: <Z882Cj2sO5wDWZIs@gmail.com>
References: <20250228082338.73859-3-xin@zytor.com>
 <174159470920.14745.5729743445717865267.tip-bot2@tip-bot2>
 <A0C784F1-EF4F-4CCC-98AE-954197CD7554@zytor.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A0C784F1-EF4F-4CCC-98AE-954197CD7554@zytor.com>


* H. Peter Anvin <hpa@zytor.com> wrote:

> >+config X86_DISABLED_FEATURE_FRED
> >+	def_bool y
> >+	depends on !X86_FRED
> >+
> >+config X86_DISABLED_FEATURE_SEV_SNP
> >+	def_bool y
> >+	depends on !KVM_AMD_SEV
> >+
> >+config X86_DISABLED_FEATURE_INVLPGB
> >+	def_bool y
> >+	depends on !BROADCAST_TLB_FLUSH
> 
> I think it is worth noting that the list here was intentionally 
> unchanged from the previous definitions, but that several of these 
> could and probably should be overhauled.

Yeah, note that this list was *not* unchanged since the -v1 submission, 
there's two new dependencies we added since -v1 which ended with the 
FRED entry:

 - X86_DISABLED_FEATURE_INVLPGB dependency we added today, which is due 
   to a new feature freshly merged into tip:x86/mm.

 - X86_DISABLED_FEATURE_SEV_SNP was added a bit back - that too is a 
   fresh sub-feature.

So we are aware, but we are also limited by what we notice. :-)

> For example, CPUID is actually required by any i586+ configuration.

Mind sending patches for anything you can think of? This series is now 
headed for v6.15 via tip:x86/cpu, modulo any unexpected catastrophes in 
-next testing.

Thanks,

	Ingo

