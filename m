Return-Path: <linux-tip-commits+bounces-6805-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE06BD9ECA
	for <lists+linux-tip-commits@lfdr.de>; Tue, 14 Oct 2025 16:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 255E8189D43D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 14 Oct 2025 14:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4DF314D19;
	Tue, 14 Oct 2025 14:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="THiW0nWs"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C0230F94E;
	Tue, 14 Oct 2025 14:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760451182; cv=none; b=TOpHY7V3r1pzpa8j7ob26PFltvzNwfK6b0LLw22eqd0bTIsoAvhvTn3P5dmNscbRtbgI77fKu+kDiUfQ2ljTWo30Oqp3RGKwYJgQU9NHEtSqo6t6/XuJCamgwFWs1T9mlvmpL7j6u0PQbWSaGh2pvUw80s3+kNCoVsQ7GRX5CiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760451182; c=relaxed/simple;
	bh=MR6deseauhFpCGVC99NfJmCaN8hyODSqB++nF10j+Wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ln4sB22xqMUxj8LPDijS9S9394lpuUA1CnqKTntTg66XtikgZcfsVyzieJevemGzeF5J7L33JVnnvT7BofN46E7mELkCccGeloB6gHbYT5W0YwPqGBhs68oEESw5IJk1feaAkULudnpJcplqsO8ONfhx1YntXKCPLH9jezcHUvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=THiW0nWs reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B68D540E016D;
	Tue, 14 Oct 2025 14:12:55 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id eDBaVgJkICf8; Tue, 14 Oct 2025 14:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1760451171; bh=DNPat8NYRM3i8Q8XnXuxYyZl/gjjTgeznrkgXqSJIW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=THiW0nWsMhEQZc66LnNYPwe0PpBONT9fS6XExzPcwlNZUeSZ3TrXI03fddCsv1LUD
	 O62jUthsWtex8zrBnMH9lIbAXLwohuCdHIxCMvACIu4WqHGEtX58qN8xSxcXRvcpbo
	 p/2V/pXutlTiGCQEh5q8pIuiPigO6Y8TCCTfy/DmVASomM1pGgFD3vXAs1SKWV/2EK
	 slSRrQ344YNqSNIzN/r/5J59Jz2kbPl3aGD3ImKYpI1t5uv9k8uJ6zlDrvABUzFqOX
	 B97i4qmnU+L2WCTfLTDwYN4oizRo8uIUe/ZdqB2t2sxgZdoPZ+m6vHwr8r5webL/8J
	 lRZ8SwstghTNaGRAzFH7OuVKj6dDO2XjPyHLjf2DbWqy4dyVLzQyVN0IRE+KhkF6iY
	 VcAP60sNdxqEpg/JorUOTVFihfSGp8iRQn3Ay3dgulvcRcCU854jkIRWt4bd/O5mpk
	 0AerklihKVG7dTgv9sAvrJidgf6VXOyK1oeawTaqfkjFnd0NbVFJaQiDfqVHpbTsGm
	 2fQQjrHMqTRzsiTeNfUXXSdyNhGSKLoAhVqYFwgaAmIQSu8mnq+TvUGv8KAMoFCbS3
	 hLUHPvCLPvfP9hmYmwyJINHHzxMD0swXV/mRrU7p6hgcZcklPYrE76qMZRs/fBUjKH
	 PfxC8b8sZYQrfFVGdxZsnfIA=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 188CD40E016A;
	Tue, 14 Oct 2025 14:12:46 +0000 (UTC)
Date: Tue, 14 Oct 2025 16:12:45 +0200
From: Borislav Petkov <bp@alien8.de>
To: =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org
Subject: Re: [tip: x86/core] x86/alternative: Patch a single alternative
 location only once
Message-ID: <20251014141245.GCaO5aXSQqglFrT9Iy@fat_crate.local>
References: <20250929112947.27267-4-jgross@suse.com>
 <176043135449.709179.18067035380831847643.tip-bot2@tip-bot2>
 <20251014125909.GAaO5JHU_cgsPgstc_@fat_crate.local>
 <4fd058ac-3af5-4778-842c-9a185d828c9d@suse.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4fd058ac-3af5-4778-842c-9a185d828c9d@suse.com>
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 04:08:47PM +0200, J=C3=BCrgen Gro=C3=9F wrote:
> And just for the record: NMI handling is using ALTERNATIVE_2, so you
> can't just "disable interrupts" and be sure it will work.

Are you fixing anything you're actually hitting while patching alternativ=
es or
are you talking hypothetically here?

Because I can't think of an easy way to trigger NMIs that early during bo=
ot,
when not even SMP is up.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

