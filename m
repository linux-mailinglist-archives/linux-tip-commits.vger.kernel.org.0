Return-Path: <linux-tip-commits+bounces-6807-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5A3BD9F61
	for <lists+linux-tip-commits@lfdr.de>; Tue, 14 Oct 2025 16:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C86DC4F9993
	for <lists+linux-tip-commits@lfdr.de>; Tue, 14 Oct 2025 14:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52A41EB9FA;
	Tue, 14 Oct 2025 14:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="L7k8n0gp"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E46A21FF49;
	Tue, 14 Oct 2025 14:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760451467; cv=none; b=nAV6mIvBx/zUi0jG0E6ss3jZroKBcsGzVhzKICijiAJy8UFmAoSej8P2lmHiqriPYgSKCdKL6Bntuxg1SPATgHTscKjOSdkCQukJ8TKe5TofPqrIF7osLGhIm4GIqvWCKnOWKvfNzKehv5G++vRNKgcnvjVc7gG96TzEhOpftDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760451467; c=relaxed/simple;
	bh=MlmkKFMo0oL1ETqy3u7J2qu7uYLV/EmgoIr2V9l0Cac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mw8T9jf1+aUiEQeCdbTnMACjPASFY4X2FFZOePU7d5iRS9Y+/wTckqJ62qpQZKFRAFou8McUPPmV75IAR4k1vqqfKW1da/2c7uGsX7xJtKIoJr+LXlmOaUkb+SDZbnPTzdOmfJ1lTntR61feZpje/2oVUWudYDruSk8t+VPXkqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=L7k8n0gp reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6198A40E019F;
	Tue, 14 Oct 2025 14:17:43 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id aAm_1dge9cZC; Tue, 14 Oct 2025 14:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1760451459; bh=/WY70hBaPxDwdbFmfP758kKEM5p4NGY+9WBjwbMDqmA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L7k8n0gpQS3w9wlgTnGOQR2SylqJK9yT1l+yCCjz/AHROdcK4RElH27Os4Kb55XQm
	 kt+2xoL6fBrCCIL+i6P8X5yk0ebA2pZjX7hI3pcx9SjgGwIzv9dnxsN6AWBIKKemD8
	 RRFmV9Gb5rbm08Uaun2stLWSxmib8ZC8ewSo36K7isFkAUkvbiAltnmOJD1oEY71yu
	 gRVdNTq7uaOnAdS13Unr6w3e1mb6mE8O+NxP7RqYX/SJe+Ia9BgoZWSoOgMAzawKnT
	 CW7yDDtRp4YQsh0xPWC9Vu32G2NSuU5gJi2a8O3JjgwIJF8FotcXN9xughkIN/40Q5
	 Ab6iPlxSkmvyxorV3WoO8G0s4FKV09ZZRA95+Pk9FvQi4QcvBcZeHO0aaFY+gZkIH+
	 QkopNrPGunjic16larEueaF6K/9nLGuPE7yvizvrcGqiG7ARXyc5sFqaEavpuq+BMn
	 1lfkSffVJq0yhaCDNi8+ElEM364kPhBECeAcHqNtQnDY3fhihPTODxGHjTa84ExbuX
	 jbpW1yRoX9Oo8JNiRzXFvrWi/cFl/y6HEl4E4y4Ww4SAJtzWY8z2q4NieGt6qSC7M1
	 ZCxeQvqSiTYtSSBrpzMBfTYoMlWS505hHUDZH8HUaOx4sSY6PmlgFIueWRR/X8ZElV
	 tsWCKZAKF6iZt+Gu0IuJ8eyw=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id DEF8F40E019B;
	Tue, 14 Oct 2025 14:17:33 +0000 (UTC)
Date: Tue, 14 Oct 2025 16:17:32 +0200
From: Borislav Petkov <bp@alien8.de>
To: =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org
Subject: Re: [tip: x86/core] x86/alternative: Patch a single alternative
 location only once
Message-ID: <20251014141732.GEaO5bfOR9YYlLBH3Q@fat_crate.local>
References: <20250929112947.27267-4-jgross@suse.com>
 <176043135449.709179.18067035380831847643.tip-bot2@tip-bot2>
 <20251014125909.GAaO5JHU_cgsPgstc_@fat_crate.local>
 <20251014132544.GBaO5PWEbKfbQFCXdB@fat_crate.local>
 <ddb38d36-0194-414c-8614-1f37b1f38283@suse.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ddb38d36-0194-414c-8614-1f37b1f38283@suse.com>
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 04:13:11PM +0200, J=C3=BCrgen Gro=C3=9F wrote:
> I can have a try with this approach.
>=20
> Could take some time, vacation is coming up...

Thanks.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

