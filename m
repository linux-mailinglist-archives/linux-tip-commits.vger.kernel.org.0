Return-Path: <linux-tip-commits+bounces-1312-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DAD8D4D6E
	for <lists+linux-tip-commits@lfdr.de>; Thu, 30 May 2024 16:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D88F81C231D2
	for <lists+linux-tip-commits@lfdr.de>; Thu, 30 May 2024 14:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95021474C3;
	Thu, 30 May 2024 14:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="HWamFT3x"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED749186E32;
	Thu, 30 May 2024 14:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717077901; cv=none; b=JKzvPYIA1UySOmKe+6SSQ4FFklbjYyaZCBTzG/X7g8kcX9iVjElSn/lA9eR5nBurLAub06eYxu5BFel2hEVbVEBaHEu4cmOmi+bvFMpLp9V1OWQ1R3UpsvZTgfXGNFxf+7ZBZTo+RGCyHeYm1SQ/WZWgL+zAfgCtEtqxRSZ7tKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717077901; c=relaxed/simple;
	bh=ABBWcpkh87HumHDzf2KDobuTBk2N1d8JJ4fjNpzoS1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sHV+3AYye6yIjEIc3FWeAPzlhCLFzPWd0ggAjBSbmQFPudXxD1nT2puL27aDjlaNSnygz15/UdhcsBXm/3MTn19x07SngXm0507BtsjWFnVU0dvHC4O9ZfQjUEgeskhCVtmgCsG2a4B9VCYMF8zkISEfMVthdViAjWf9V7P400c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=HWamFT3x; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9B66840E0192;
	Thu, 30 May 2024 14:04:49 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id YZgOyo_Wrz23; Thu, 30 May 2024 14:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717077886; bh=W8SfD8cqXYbhTm+gZa2gaKivt8VGV0aD4jBoQKBjeQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HWamFT3xq6BM3221ZEQ5AeSuK9RmAYRXxAiMHDnH8F8QEux7ofTHAQ0CleIMBVGPH
	 uT0hmU9mT73sC7RTh62KfWMMn5/VUujUfykifGmXZU0+FdTOEb8AmwCPTlwjJmvyr8
	 cty/2NijG9RvutLHRNtAM6l+AqJSAQRAau+DVkuk4S0CwlMCuDSDXaN6mqdAdrq70a
	 PJJxN4BQoUd7B+2TAb1ftbxm8vq4kCsi8NmzDxkhotsFPOMqNPVhOTl5vhCZQHRt+C
	 jiASZ8MLq4DsvveYmicZS4knEchxmvCrlYBmQvklRqZ5Srx5qa3B4bHbuQvw7sjIgL
	 gPoGMnYl0dnPZ7VSMb4nVA3xWt34QlQEB5SJeFoKQa1qd4KoyVl78stg5Xe3UetYSc
	 XsWxyyLnX4y3pB6yuv0bMm/IfAR3zZiyOA3Bf+7C7Jc62HyXIeQNxTccbKUYOaGNFj
	 hWGlqoLDErmZk82oWuoZXnTyqCacLVtiAFTJmgkO40dyVtITuMzMSOotH4qUB/IriL
	 vfxYiEPwVSmCTN60GBc3oRTtZW+h5ZWUuAiu3d9YamvFU6uYRC/AQs97EwzRqaSzZC
	 eXwYAN4RkThJUdvJDIZZD+e5dNXD9fNpnVu2cqvEMngc6Amih3mW3gKBpYKmTEI5cQ
	 bGoWI+oSLdMVaNmL0a0DuZ0U=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5F9E940E0177;
	Thu, 30 May 2024 14:04:42 +0000 (UTC)
Date: Thu, 30 May 2024 16:04:36 +0200
From: Borislav Petkov <bp@alien8.de>
To: Christian Heusel <christian@heusel.eu>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [tip: x86/urgent] x86/topology/amd: Evaluate SMT in CPUID leaf
 0x8000001e only on family 0x17 and greater
Message-ID: <20240530140436.GCZliHdFXy1VkMdgAP@fat_crate.local>
References: <7skhx6mwe4hxiul64v6azhlxnokheorksqsdbp7qw6g2jduf6c@7b5pvomauugk>
 <171697474837.10875.6335609575452053884.tip-bot2@tip-bot2>
 <2gj2lkahha4wzyf2ol6xk2ermrmsxaklznrisixdg4m3ogzten@gbrtiyjebeup>
 <20240530085914.GAZlg_4lcZIaa83jVb@fat_crate.local>
 <xoof7q7s6gak5iyvp3x6lgksqlpmw6sfiqvyjqc53m7egrvuya@vb7w6uoq25w7>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xoof7q7s6gak5iyvp3x6lgksqlpmw6sfiqvyjqc53m7egrvuya@vb7w6uoq25w7>

On Thu, May 30, 2024 at 02:21:28PM +0200, Christian Heusel wrote:
> Sounds good! I thought it was a thing because I saw it used in a few
> places, i.e. here:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=e37617c8e53a1f7fcba6d5e1041f4fd8a2425c27

Yeah, I'm polling internally whether we should add this new tag. But
Reported-by pretty much does it...

> I'll keep it in mind for future bug reports! :)
> 
> Have a nice week,

Thanks and ditto. :-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

