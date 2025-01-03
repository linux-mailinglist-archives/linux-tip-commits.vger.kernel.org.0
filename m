Return-Path: <linux-tip-commits+bounces-3169-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A458CA00D6E
	for <lists+linux-tip-commits@lfdr.de>; Fri,  3 Jan 2025 19:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2445188475D
	for <lists+linux-tip-commits@lfdr.de>; Fri,  3 Jan 2025 18:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBA81B0429;
	Fri,  3 Jan 2025 18:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="cigJ5iEa"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E01F19DF99;
	Fri,  3 Jan 2025 18:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735927882; cv=none; b=DnzwVwtpuJ/b03Fz0jGoHiwyUay4YfOJXn2v+p4uVnOMLWQnerxQlV+HYibe03w4MTrBKMgmaUQQs+5ZK8EwYa7Qix0d4i715SZ1ii8h/Ldn+2qPPAfYdgKupV8l4UGZhvjVmXBhF2niZxFT4u9INEYr03EvzmpGszVevK9MpM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735927882; c=relaxed/simple;
	bh=CjGP/95OBWquaY6YeFk2ExB9FPgTomNV1MKqxRtIAFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IaErRw8UX21gPGqtuwb8GjB3RZP+8Yb80acZb0Dck9btmUaYtlt5FIZCZcSiM2eHXwm2b0nK1MLh9TuXbLfnGzwjTWJjF5zfY6AIPV+w+kAf6VJU/WbLtqy4DBUIDOSE0mummVRPWFFlkGYXmPeu98mt47y6fLPRP/qFbTW53Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=cigJ5iEa; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0B0B040E021D;
	Fri,  3 Jan 2025 18:11:17 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id AtYMzvC-atLH; Fri,  3 Jan 2025 18:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1735927872; bh=NBkoaa50Vlw44UoH2wYugeWhj3cXIJkmMuVqOn9UByg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cigJ5iEalZSqppWbQdyHYFXNKg7tmdFbJV/XT2tHghClsd7cW+Y3DMC1FVoXSVpWy
	 k7MzXHRwLb1mLeeuyYIABjCrg+a2T+UaTopxFRs+/AQZAn41P76oElAh29Ip85RvJ0
	 OGm+yjzPbouKy12FpMJ6bYN+2hjTaybSRt6x+mDy5YTkDqf1G7r6XmukLc1uSMNV9F
	 qbATybhaIxEN8YN/kRCO9zwARTq/SQs+dfKi18EZ+pPr9S3Mh9Ox892MAaCEmMgJ53
	 ETsC9BQpBnwrkFKCa4Z/W2esEZdfAqA9kZUv6+AiwG7h9BVqYI9HuAOP7Qjp0ejQ7j
	 +TF45r1ZN6BUgTknULhoLKR9dFM6YTVrZV/CV5NlqDhFWitz/TwQRwdjENxmUR9GtU
	 T9KyIlcjcqviFXhY3x+JtQXmPZ/i4q/IB/WH14qp1W4QfWfeAfGMC8JSZcRCs/F6Qt
	 R+VpS6okPoctKJkZ7jO1HmqIS6iuzXthNMW2YTOSPNFifWGuuCns/sqwp6qABmqSAS
	 rveSAY2giN9486njDlEPpeJamDvoJ4HWdjNcAc0ENsL4uasLeSKgh+n+Tm8T17dMOk
	 wWVZU8hiOPBdwejn+Zs9+NdbH0VXNtIVE0euZlW3S6e5rBhliAjEbi/XhAQfBEf6N3
	 0JlwOO2ftpqnwB1tJ1npQQBE=
Received: from zn.tnic (p200300Ea971f93BA329C23ffFeA6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971f:93ba:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0029940E01F9;
	Fri,  3 Jan 2025 18:11:04 +0000 (UTC)
Date: Fri, 3 Jan 2025 19:10:58 +0100
From: Borislav Petkov <bp@alien8.de>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org
Subject: Re: [tip: ras/core] x86/mce/amd: Remove unnecessary NULL pointer
 initializations
Message-ID: <20250103181058.GAZ3goMltpcpHkHGtY@fat_crate.local>
References: <20241212140103.66964-8-qiuxu.zhuo@intel.com>
 <173573184404.399.677738006176037845.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <173573184404.399.677738006176037845.tip-bot2@tip-bot2>

On Wed, Jan 01, 2025 at 11:44:03AM -0000, tip-bot2 for Qiuxu Zhuo wrote:
> The following commit has been merged into the ras/core branch of tip:
> 
> Commit-ID:     0a6c5391f8812323300057f4dbb89b8bf886ee8e
> Gitweb:        https://git.kernel.org/tip/0a6c5391f8812323300057f4dbb89b8bf886ee8e
> Author:        Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> AuthorDate:    Thu, 12 Dec 2024 22:01:03 +08:00
> Committer:     Borislav Petkov (AMD) <bp@alien8.de>
> CommitterDate: Tue, 31 Dec 2024 11:14:36 +01:00
> 
> x86/mce/amd: Remove unnecessary NULL pointer initializations
> 
> Remove unnecessary NULL pointer initializations from variables that
> are already initialized before use.
> 
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
> Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
> Link: https://lore.kernel.org/r/20241212140103.66964-8-qiuxu.zhuo@intel.com

Zapping this one in favor of:

https://lore.kernel.org/r/20241206161210.163701-2-yazen.ghannam@amd.com

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

