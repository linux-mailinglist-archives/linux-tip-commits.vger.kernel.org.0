Return-Path: <linux-tip-commits+bounces-4895-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 662DFA867E1
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 23:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 162403A4839
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 21:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5A228F927;
	Fri, 11 Apr 2025 21:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="QCEU4cSz"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C43A28137D;
	Fri, 11 Apr 2025 21:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744405659; cv=none; b=OpbQq1CoPcKHfhQaozPO/Izu6cyjjoJm1XiCoNHv0n8xKP7s3k432oVs34GiraE12QXsR0nIrQSSgqcZZlv0Ofnf/0sf02E8euBQXluxxI0g/4sY2s6ejYgsTdsnDmmg//FIFwmL3bCtZS5ipA1BLerWs+DmBnM1kPKi6M4bL6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744405659; c=relaxed/simple;
	bh=ENH/Y+nOVEI1BAoOTQhbzPgHZ2GpcUa6TDxgr5qklKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SpyawKoDSD1yS3GaAhg9J0HJEMpjChckxL2qrWiLsJWEkHQpKcJ0oChaANcDj1pQeCeoTElyc0/Xs6GFKwnesm6CX/26SZSevpAAwrXlTWWo7cuY2w/A/R1hpQudpWPnUzx2dqgS/IQXDrWlozDeC29IH1g4XLKLPJ7ar1zYgjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=QCEU4cSz; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 05A0F40E0243;
	Fri, 11 Apr 2025 21:07:34 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id kWzkNTy35xC4; Fri, 11 Apr 2025 21:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1744405649; bh=4ZuE/4ByeKFbJvDK+PvfqJLDi/M7fMiJ6ZnlFyetjkk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QCEU4cSzOWd4B28eyn3CKptoyv4jNTdd60RdmsHA+78rHdan7IhCKJYvIeeh512/V
	 /dLCkVJ/F8Tr2TSfOtHxFn4QpFbJTnwmBHBB+S7bkX8GD7RhteM3xgFyRsknavq7Qg
	 WIlIPuvxI7phId0hBe/NTQyP6Pjj5JgvGpJ4c65/S35mJQf+vThaNKvW6t5EUDiAB8
	 dso6YOSZpCgLzuuvQO8axhRBOrk8huK8rYcAD/2m+hT9Cykidx/U0zQ77c7iIcu1Fz
	 UbODYE57Iqin0D6idkWXobGXE5vHZb8afzxTSbAuAcbyErJOCw5pRBWoHgjWtwKg5n
	 90mhAEVcWEwQNFR2zhqcAHYvRtRmJoZJI98CmbEciTCX678Y4PJDlrIqrdlDq/GgLm
	 Lvy2C8BZ/PcO0aMs+NBdly8XTdZ3LVfj7Nwinef17mJ5e1V/IPJa4IMcVqCAh8CByO
	 4QTx27A8D9ZMY5FIXdY15/Q/ZyeWgC5Ca5JvsIL+8nv2b+3pClbV/+Jcq9UHVnIl5a
	 ke6D3+ghkHOD2CISdcNYfWmaXWlJb4mDo8wRqzWFUWnbicXveSWy+iAfQbIStE4uiI
	 FdNXerDJAgzFIWUZXe1WUHF4Un5GGNCHqiyoI6cxyj6TOyMbLbwtej5kMTdJTgjmP8
	 2mQg7JhTd3YFkXfGSKIZPKD8=
Received: from rn.tnic (ip-185-104-138-50.ptr.icomera.net [185.104.138.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id B481240E01FF;
	Fri, 11 Apr 2025 21:07:22 +0000 (UTC)
Date: Fri, 11 Apr 2025 23:08:15 +0200
From: Borislav Petkov <bp@alien8.de>
To: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
Cc: linux-tip-commits@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>,
	Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org
Subject: Re: [tip: core/urgent] compiler.h: Avoid the usage of
 __typeof_unqual__() when __GENKSYMS__ is defined
Message-ID: <20250411210815.GAZ_mEv8riLWzvERYY@renoirsky.local>
References: <20250404102535.705090-1-ubizjak@gmail.com>
 <174428272631.31282.1484467383146370221.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <174428272631.31282.1484467383146370221.tip-bot2@tip-bot2>

On Thu, Apr 10, 2025 at 10:58:46AM -0000, tip-bot2 for Uros Bizjak wrote:
> The following commit has been merged into the core/urgent branch of tip:
> 
> Commit-ID:     e696e5a114b59035f5a889d5484fedec4f40c1f3
> Gitweb:        https://git.kernel.org/tip/e696e5a114b59035f5a889d5484fedec4f40c1f3
> Author:        Uros Bizjak <ubizjak@gmail.com>
> AuthorDate:    Fri, 04 Apr 2025 12:24:37 +02:00
> Committer:     Borislav Petkov (AMD) <bp@alien8.de>
> CommitterDate: Thu, 10 Apr 2025 12:44:27 +02:00
> 
> compiler.h: Avoid the usage of __typeof_unqual__() when __GENKSYMS__ is defined
> 
> Current version of genksyms doesn't know anything about __typeof_unqual__()
> operator.  Avoid the usage of __typeof_unqual__() with genksyms to prevent
> errors when symbols are versioned.
> 
> There were no problems with gendwarfksyms.
> 
> Fixes: ac053946f5c40 ("compiler.h: introduce TYPEOF_UNQUAL() macro")
> Closes: https://lore.kernel.org/lkml/81a25a60-de78-43fb-b56a-131151e1c035@molgen.mpg.de/
> Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Tested-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Link: https://lore.kernel.org/r/20250404102535.705090-1-ubizjak@gmail.com
> ---
>  include/linux/compiler.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index 27725f1..98057f9 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -229,10 +229,10 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
>  /*
>   * Use __typeof_unqual__() when available.
>   *
> - * XXX: Remove test for __CHECKER__ once
> - * sparse learns about __typeof_unqual__().
> + * XXX: Remove test for __GENKSYMS__ once "genksyms" handles
> + * __typeof_unqual__(), and test for __CHECKER__ once "sparse" handles it.
>   */
> -#if CC_HAS_TYPEOF_UNQUAL && !defined(__CHECKER__)
> +#if CC_HAS_TYPEOF_UNQUAL && !defined(__GENKSYMS__) && !defined(__CHECKER__)
>  # define USE_TYPEOF_UNQUAL 1
>  #endif

So mingo is right - this is not really a fix but a brown-paper bag of
sorts.

The right thing to do here is to unpatch the __typeof_unqual__ stuff
until all the fallout from it - genksyms and whatever else - has been
fixed properly.

So to avoid too much churn I's suggest something like this (totally untested
ofc) until all has been fixed.

---

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 27725f1ab5ab..916a97999ddb 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -232,11 +232,9 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
  * XXX: Remove test for __CHECKER__ once
  * sparse learns about __typeof_unqual__().
  */
-#if CC_HAS_TYPEOF_UNQUAL && !defined(__CHECKER__)
-# define USE_TYPEOF_UNQUAL 1
-#endif
+#undef USE_TYPEOF_UNQUAL
 
-/*
+	/*
  * Define TYPEOF_UNQUAL() to use __typeof_unqual__() as typeof
  * operator when available, to return an unqualified type of the exp.
  */

