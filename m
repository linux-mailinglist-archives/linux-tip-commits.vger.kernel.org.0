Return-Path: <linux-tip-commits+bounces-6811-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F95FBD9FD6
	for <lists+linux-tip-commits@lfdr.de>; Tue, 14 Oct 2025 16:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D56B542A70
	for <lists+linux-tip-commits@lfdr.de>; Tue, 14 Oct 2025 14:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F51213237;
	Tue, 14 Oct 2025 14:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ePda4F7t"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7643B347C7;
	Tue, 14 Oct 2025 14:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760452030; cv=none; b=jzr5ALKp1wLsdAXEQFhcy3UOkIbyvxOENwqJ/hNNWq4C4h1CFpDNGiymLxWgeqd96He5T3ax0qYjdEKgHkJjHZ+RempVF9eV+nSTaCUtyQsbgtqspi2XJjrr4zAfzxCJt/+JUrbyynay1xq5C5QM3q/nhFt/IsV0aX4WT1Igl74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760452030; c=relaxed/simple;
	bh=seupb5DrLHsju2xeaNcxxC7Uuxgzr4BGHmZKTsn/MsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uj9mGCIyXPJmEsGzalL6E9DUeqQBcIP+Qgi9ktAxFQ36v+OP2S+1VHBC5g32MmBztAarug3XpUpfq1p0VTYgC7FN9iZNz+aOZVWXTWeKEprM30FDbWi7gNFB67SAfDYe7xbPWuWqmj8v3hd1TJZYhbndZ6hdHeSt4u5+m99Ssj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ePda4F7t reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0028C40E019F;
	Tue, 14 Oct 2025 14:27:06 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id L-aqnWkEPUHu; Tue, 14 Oct 2025 14:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1760452022; bh=NlHapNuYf4frbBMVk1vzqhFQvkUKHEiFf2+FjM++m0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ePda4F7t3YL8xhN55SbiCIwagNFxlnqBOX5theakP7v7c0m/QuK0hpmm++NUDLW2Q
	 rZ0YAkNlu/GdwdcsD0S2MUisl4l/dCv8yyic8iJMtgjxmUBYsnFAksp4MJTvf/smIi
	 70TlEYfEvK62LrDiZciUYIAUeEu8FsDuHVODkW3jvvHxajbCRabaJ9W2UZ5Dh2dvdN
	 nOY62IFK7C4FiT7C1oFJ3ondp7ObnfJm71NLiMkEnmch8lVExhkwIo2iY+LtWRjS4w
	 rYjIDXFgsgKKViGj9nMRF++5zliijyEQ5pmWiYGQAb/XASTpdRIKr8IYWlhz8Bhpp2
	 wJ/DRV3id/FSBj+h1G+wZR6kZYlTwxzsteiacZ202K8eWzJkWj9r0639x4xWD8kgS8
	 aNqdxXK930ZSvM46q7AoP5mKkWVwharOnO0NNj6IOHzt+/BIJZuKkTlQv1Zd/2OURd
	 mhK4I8GhY0mFN7POAoFnFrCyVUbm0e87ZK6gEKzQsOVvzXjrD8vccpPLyQ2fIO8hVh
	 u2EI/1Uobg5RUOPWZj3ruNJrSyg1Tk27H5rWHvJTgyaqHKn/WeYl32OCDxoJRPtQYH
	 TaHT9ujmfBhXUGHD1jVmv4mrloRLRdAa/9yRVisC95mdeMg2erBP7Xv4SF4vNplF3/
	 86sUdzw2Vw47YMAqHyjfoB08=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 259DB40E016A;
	Tue, 14 Oct 2025 14:26:57 +0000 (UTC)
Date: Tue, 14 Oct 2025 16:26:56 +0200
From: Borislav Petkov <bp@alien8.de>
To: =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org
Subject: Re: [tip: x86/core] x86/alternative: Patch a single alternative
 location only once
Message-ID: <20251014142656.GFaO5dsDlJ6d_WY_fk@fat_crate.local>
References: <20250929112947.27267-4-jgross@suse.com>
 <176043135449.709179.18067035380831847643.tip-bot2@tip-bot2>
 <20251014125909.GAaO5JHU_cgsPgstc_@fat_crate.local>
 <4fd058ac-3af5-4778-842c-9a185d828c9d@suse.com>
 <20251014141245.GCaO5aXSQqglFrT9Iy@fat_crate.local>
 <c0fb45d5-c4a0-498d-8378-dd96ec261c8c@suse.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c0fb45d5-c4a0-498d-8378-dd96ec261c8c@suse.com>
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 04:22:09PM +0200, J=C3=BCrgen Gro=C3=9F wrote:
> I really ran into issues while writing my paravirt MSR series, as I had
> an ALTERNATIVE3() invocation modifying the original instruction (the
> indirect paravirt call) with an WRMSR and then trying to turn the no
> longer existing indirect call into a direct one.

So put *that* in the commit message. Along with a detailed example of wha=
t
you were seeing. This is bazillion miles more useful than some hypothetic=
ally,
potentially ... case.

Thx.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

