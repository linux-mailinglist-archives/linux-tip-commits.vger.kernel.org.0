Return-Path: <linux-tip-commits+bounces-4976-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 789ABA88502
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Apr 2025 16:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71864189F821
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Apr 2025 14:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B8529A3D9;
	Mon, 14 Apr 2025 13:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="TuR5g0hQ"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8870F29A3D8;
	Mon, 14 Apr 2025 13:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744639007; cv=none; b=VFoo+sAxon/+BQBzcCDBvFT4RLZw80TxqQuAiIQYrZVNjdULc3K2/LPYVXXIiRsCgCwTEWq4rR67HwwlJOVfozY3ao4qOpdkvp7qE7pOMIT/rTt2OElpEA+r9h79fKbN4dclb2ssZ/glosVPUT9ESw3m0waqwvLT+3KTwhjxWsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744639007; c=relaxed/simple;
	bh=ICCERbdN+d9XFG8QIphAhllv31qITvWteyiyQQaPFN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BV8X8KzKyquHMEpISuhduJ/IuDSFEXD0jffc10J66LXrKQSp/eLE0a7mPY5NnUwn+M4GjfBpNlz9A+xb/Hz5BIGehO8dAsihnfPQE0yJXs6/6YoJ+HHd1giUmn41+RedXVhK7nnBcNIEpCizZ8ks/1edMNFFNVdBmjAQBziv7pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=TuR5g0hQ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6C1E140E0248;
	Mon, 14 Apr 2025 13:56:43 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id fCWBT3j8Izt0; Mon, 14 Apr 2025 13:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1744639000; bh=HLCX4EFuYm2pv8p7i93n8Dt29qH3zK/d7q3+Qm86V8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TuR5g0hQlKQUWDCd92qQWz56T8nQYK9LQ4W+8pxG/h3rU8NoUGlJTjTGPajgLW/JU
	 2L7+kSN08GiLCFscrjgRthUzbRHu37dwe/aQtkTFOveE2PCPaQ1LQuToc/IYdkCzCE
	 Nos9nb2KmYyGof6OjrsAvh6SMgR3vdWT8lLNQMWqMykdD+QSBbHh2apC2zQ4Md/x9/
	 TehcClhhgnPByKfpPiSB3FCsGTaxORTd0eGOi+t4rs23lur+Jh+sU657g29ZQpWdss
	 Kv4Y86sM6VBDQfGA9gDQCX9c1Zk55zlea4oBHLrZsksXSHO/qeuXGkqhePkfHXdEAw
	 L8GBCQTUNntZiVDfVDLgJRJ3PVQuEJnUIpfJCkJecnIE4lB7TTwQ61wEUe4TPR1vmW
	 VCfmyuOsL+PbPzkYgqBCJZlWwhQo0sgBWpligNfS2No5j5qlI5Dbluhvt/dbu8ys8f
	 gPTeKFbD2DpNOgvDZ9B1WocDNClJJBO7OfSA8ctOOzE5C+6CXZ0l36wa1yoLg0xT83
	 fKjT7TMoXciJFG92krA1Vggp/iNYyNjwm9NY7IxVWFfVFPMweVtLxcnGcITC6lGaWH
	 3Mqz3Lly9banijveGg+eMwEBCzX2M1chCAAAHd2URSoLLU/Wnec4qHqHfTItnrNclH
	 ZfO1/06JSg0Al3m6qofV5imE=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E26A340E023A;
	Mon, 14 Apr 2025 13:56:31 +0000 (UTC)
Date: Mon, 14 Apr 2025 15:56:25 +0200
From: Borislav Petkov <bp@alien8.de>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Ian Campbell <ijc@hellion.org.uk>,
	Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org
Subject: Re: [tip: x86/build] x86/boot: Add back some padding for the CRC-32
 checksum
Message-ID: <20250414135625.GDZ_0UCcIQ-fg8DKZL@fat_crate.local>
References: <20250312081204.521411-2-ardb+git@google.com>
 <174178137443.14745.10057090473999621829.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <174178137443.14745.10057090473999621829.tip-bot2@tip-bot2>

On Wed, Mar 12, 2025 at 12:09:34PM -0000, tip-bot2 for Ard Biesheuvel wrote:
> The following commit has been merged into the x86/build branch of tip:
> 
> Commit-ID:     e471a86a8c523eccdfd1c4745ed7ac7cbdcc1f3f
> Gitweb:        https://git.kernel.org/tip/e471a86a8c523eccdfd1c4745ed7ac7cbdcc1f3f
> Author:        Ard Biesheuvel <ardb@kernel.org>
> AuthorDate:    Wed, 12 Mar 2025 09:12:05 +01:00
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Wed, 12 Mar 2025 13:04:52 +01:00
> 
> x86/boot: Add back some padding for the CRC-32 checksum
> 
> Even though no uses of the bzImage CRC-32 checksum are known, ensure
> that the last 4 bytes of the image are unused zero bytes, so that the
> checksum can be generated post-build if needed.

Sounds like it is not needed and sounds like we should whack this thing no?

Or are we doing a grace period and then whack it when that grace period
expires?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

