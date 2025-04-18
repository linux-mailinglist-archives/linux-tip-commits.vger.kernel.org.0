Return-Path: <linux-tip-commits+bounces-5072-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B131FA93618
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Apr 2025 12:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FD521B64837
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Apr 2025 10:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC36E20A5CA;
	Fri, 18 Apr 2025 10:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="E+baY4h9"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C3DEEB3;
	Fri, 18 Apr 2025 10:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744972780; cv=none; b=A/pJk8BeJezhS8K1zip2b9OE8KE+sr40QDGM6BDBGflmB/v9Px1/Ud+P+DAhx77V4x0FiEb7BrQuXBlm5y/rJ/TXvssxCfWxwuTpY0fAKQYrKXiXZ/h8xA4EsMZ9BKOdmac6EXh7z7VxRPRonepy8bFUwInpBjikaudDBZO3W3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744972780; c=relaxed/simple;
	bh=ttVLovfr4SKmH6ICrzvUiDZ6r/EcmzRNBp6rmO90bhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hK/EuP2OmGkKYBFged67f5vyI+mWXBHRrnaLScasIDLVG1PHaw+TOS0rIhqjmeohLoZjkM+2mcOk5JzYjUO+X1K6d5o6TFb7kZ67P+cmR4ds9cxPLDSR5CVnI+7OymEdfg4kUJ6Xx6wRGN9op62PBTMamhrY0cgtHKoU7iHZkpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=E+baY4h9; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id AAA5E40E0246;
	Fri, 18 Apr 2025 10:39:28 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id RtsIpmjYvNdv; Fri, 18 Apr 2025 10:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1744972762; bh=B62Z83vt9Rb2CGpw59P5RzMmycfbByVvl9Una/LIoL0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E+baY4h9rYsKaHR+2Z40v12O0JbhEJmKT3Y7HB3NSRqAdIbV0Sl24nHRVHkj2SCJ3
	 DuitlTltmyJmoqUGM93CgqdaanCCdODjbncJD5b7RUSBBDiCSMs5GyDcoDL4l0aP5X
	 eHCufa8zLw0Wk/QnTT48R2ZNcWcRJVrcfmb+A1eZ38uwH7ARqz4dnm2/k7F+MB5hEU
	 DkdWqFpZ5DMgi6NnZTuaraUldox5c0+73Iv3Y4+YzHepwCflnwGXTNVBqq4Za/VNfP
	 jWX+43VrvtrgWJZxAOEOAOy3tszRF1Il3YyM0EMeEh3vsoTgK9qhFaaHX8gfCkEEcb
	 SyGcWDFDlEMG3Ykej1yEdMjCXUsemV7N2pg7GThER5eK9ktKBF3SI42o+Q1HyJ9ADN
	 oLyv9ZuMEf5mmbM5YUe+3lx5oPsGs9RX3jXwDDisxE5iQr7d1MckH0gkLSBJNXlzZM
	 vdUNekIO7trksWjoK04+3sx9Dv3v9Ptp6wh6nZ2GK/IONwzKTUfWEzUMGpuBeu8hU5
	 vYjsSpxIsmVju2bix0vXPI5tdvwexSmdYCToVSYkGHySaqVZFp7q/KYwAFBuc89lkG
	 M6JgcJeLifbKRSIOW8ws+xZNyrSCkR4wQxT6cT8q3V6Eh+RhSfNEjZqDc811UYiSMz
	 FT2NiCxbTVk7FsFjw8cZZYi8=
Received: from rn.tnic (p200300ea972aa8895b9802a589316de9.dip0.t-ipconnect.de [IPv6:2003:ea:972a:a889:5b98:2a5:8931:6de9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 43D6040E0214;
	Fri, 18 Apr 2025 10:39:17 +0000 (UTC)
Date: Fri, 18 Apr 2025 12:40:13 +0200
From: Borislav Petkov <bp@alien8.de>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, Sandipan Das <sandipan.das@amd.com>,
	Ingo Molnar <mingo@kernel.org>, x86@kernel.org
Subject: Re: [tip: x86/urgent] x86/cpu/amd: Fix workaround for erratum 1054
Message-ID: <20250418104013.GAaAIsDW2skB12L-nm@renoirsky.local>
References: <174495817953.31282.5641497960291856424.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <174495817953.31282.5641497960291856424.tip-bot2@tip-bot2>

On Fri, Apr 18, 2025 at 06:36:19AM -0000, tip-bot2 for Sandipan Das wrote:
> The following commit has been merged into the x86/urgent branch of tip:
> 
> Commit-ID:     f4efdb357680bef4584faedbd44b90cd53d3245f
> Gitweb:        https://git.kernel.org/tip/f4efdb357680bef4584faedbd44b90cd53d3245f
> Author:        Sandipan Das <sandipan.das@amd.com>
> AuthorDate:    Fri, 18 Apr 2025 11:49:40 +05:30
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Fri, 18 Apr 2025 08:31:07 +02:00
> 
> x86/cpu/amd: Fix workaround for erratum 1054
> 
> Erratum 1054 affects AMD Zen processors that are a part of Family 17h
> Models 00-2Fh and the workaround is to not set HWCR[IRPerfEn]. However,
> when X86_FEATURE_ZEN1 was introduced, the condition to detect unaffected
> processors was incorrectly changed in a way that the IRPerfEn bit gets
> set only for unaffected Zen 1 processors.

Whoops, sorry about that.

> Fixes: 232afb557835 ("x86/CPU/AMD: Add X86_FEATURE_ZEN1")
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Link: https://lore.kernel.org/r/caa057a9d6f8ad579e2f1abaa71efbd5bd4eaf6d.1744956467.git.sandipan.das@amd.com

This needs

Cc: <stable@kernel.org>

Thx.

