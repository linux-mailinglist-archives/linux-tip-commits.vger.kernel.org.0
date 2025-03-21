Return-Path: <linux-tip-commits+bounces-4416-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F76A6BB1B
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Mar 2025 13:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E80B448623B
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Mar 2025 12:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92556225387;
	Fri, 21 Mar 2025 12:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="UfbRcMAg"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7B41EA7D3;
	Fri, 21 Mar 2025 12:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742561320; cv=none; b=I9IjSh7ddInbeOerV4Cc2DE+v6yPrdCE7u6fJY7bz1nh8iLhWgYOw8RhvFo85B4yzEav2/CpicIZjdmuUJMuGYjI+B7X2cMlougU0kYrvI8npwydJB6Uq+VQh2yArrwPJkLIJj6L5zCvDsSZKLHKz/+RThOzwS8FK9J5VtSXO/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742561320; c=relaxed/simple;
	bh=XudOo+cZglIsbGiwel11rAkhMQCWQUZfsVX9Ut2ZFNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lrjVP0YE37sroTWunWgrrjt0lQrMEwK77JtFZAt+nsXzc/Ro7YeeXo5Ipgo3sBUPr9rxCJelKixvSMaetKgwc3nooaWz7ROHvT8g9K1OnByP05C6R9ulI/xedazeHLDVfnj5RYRsMgShH8bV2PJnMJLnMVuwQ6Sp8I5yfgJSAmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=UfbRcMAg; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 465F640E0169;
	Fri, 21 Mar 2025 12:48:32 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id IV7xfQy2WVID; Fri, 21 Mar 2025 12:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1742561307; bh=3Pcumfa1RDZU2MCjeaWCfJYT0KdTPCzbavojRaOhIUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UfbRcMAgn26XjpY8zTKh9lHb692YZY7rFbVABdwM8Y02/siRvhBQgluR1pQXqxWy+
	 iMDSZMIFhT2AXZY6MoOFO1LXUSt+FEk5ftaux6r8PMKedUTS6KFfGNLrN/TjFCNfUa
	 hE6jaRHfLpnoePYo8CB1l5V719hh/B7U1iL2atM70v8/o79NkwtZsuIfUPPQS/wwEA
	 nptydv0wQmlFTKRHOigBd01/ia53opLayFeEVv5HoQRn+HlnJy648ve4wYEPf3INB5
	 OeffG2b/Euu5ZKvf6cjGT2Ick/EhdHyqBSkV4zE+RVQ3fABQ0VL4AroUdEBHnr66uk
	 o/rAJbwnVq1TAQ3APj1nGZAAFgjqpPO+rmBvY+X09w2Pa9yzM2KKvC1jNZjvgyX5Y1
	 kd8Akq8LflW1xBDbFHOjrxwhEJrYkZvvaFtVocoARjn0eapbwBfsPRjDfjMPAnYSHT
	 Bkhs6wt5u/pgtDo86ByQzi1UfppJvMWoICRkbt8fexht3RKPVbvl9RwxPrSelOC9fG
	 aRi66PaRiSzmxh3HgOy2E023pnisjpsRHwxf8F38Y7F3hV8+kCcQur+Uh/41V7izFz
	 iyH31bQkH6CoV+tzSeKYwj+nB2CYISI2l8KLY0GU3vuhhpoqdOfyR5DPaIEWgesN19
	 pWtQLgNbNxmQV8cdrBOaXcSU=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D362240E021F;
	Fri, 21 Mar 2025 12:48:19 +0000 (UTC)
Date: Fri, 21 Mar 2025 13:48:13 +0100
From: Borislav Petkov <bp@alien8.de>
To: linux-kernel@vger.kernel.org, Nick Terrell <terrelln@fb.com>
Cc: linux-tip-commits@vger.kernel.org,
	Michael Kelley <mhklinux@outlook.com>,
	Ingo Molnar <mingo@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org
Subject: Re: [tip: x86/core] zstd: Increase DYNAMIC_BMI2 GCC version cutoff
 from 4.8 to 11.0 to work around compiler segfault
Message-ID: <20250321124813.GAZ91gDUYB6TDsMJNv@fat_crate.local>
References: <174254398939.14745.1644465295513159567.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <174254398939.14745.1644465295513159567.tip-bot2@tip-bot2>

(cleanup the botched CC: line :))

+ Nick.

Interesting - we were looking at a similar issue recently:

https://lore.kernel.org/r/20250317135539.GDZ9gp24DhTKBGmkd8@fat_crate.local

and upgrading my toolchain fixed it.

Weird.

On Fri, Mar 21, 2025 at 07:59:49AM -0000, tip-bot2 for Ingo Molnar wrote:
> The following commit has been merged into the x86/core branch of tip:
> 
> Commit-ID:     1400c87e6cac47eb243f260352c854474d9a9073
> Gitweb:        https://git.kernel.org/tip/1400c87e6cac47eb243f260352c854474d9a9073
> Author:        Ingo Molnar <mingo@kernel.org>
> AuthorDate:    Fri, 21 Mar 2025 08:38:43 +01:00
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Fri, 21 Mar 2025 08:38:43 +01:00
> 
> zstd: Increase DYNAMIC_BMI2 GCC version cutoff from 4.8 to 11.0 to work around compiler segfault
> 
> Due to pending percpu improvements in -next, GCC9 and GCC10 are
> crashing during the build with:
> 
>     lib/zstd/compress/huf_compress.c:1033:1: internal compiler error: Segmentation fault
>      1033 | {
>           | ^
>     Please submit a full bug report,
>     with preprocessed source if appropriate.
>     See <file:///usr/share/doc/gcc-9/README.Bugs> for instructions.
> 
> The DYNAMIC_BMI2 feature is a known-challenging feature of
> the ZSTD library, with an existing GCC quirk turning it off
> for GCC versions below 4.8.
> 
> Increase the DYNAMIC_BMI2 version cutoff to GCC 11.0 - GCC 10.5
> is the last version known to crash.
> 
> Reported-by: Michael Kelley <mhklinux@outlook.com>
> Debugged-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Cc: https://lore.kernel.org/r/SN6PR02MB415723FBCD79365E8D72CA5FD4D82@SN6PR02MB4157.namprd02.prod.outlook.com
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> ---
>  lib/zstd/common/portability_macros.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/zstd/common/portability_macros.h b/lib/zstd/common/portability_macros.h
> index 0e3b2c0..0dde8bf 100644
> --- a/lib/zstd/common/portability_macros.h
> +++ b/lib/zstd/common/portability_macros.h
> @@ -55,7 +55,7 @@
>  #ifndef DYNAMIC_BMI2
>    #if ((defined(__clang__) && __has_attribute(__target__)) \
>        || (defined(__GNUC__) \
> -          && (__GNUC__ >= 5 || (__GNUC__ == 4 && __GNUC_MINOR__ >= 8)))) \
> +          && (__GNUC__ >= 11))) \
>        && (defined(__x86_64__) || defined(_M_X64)) \
>        && !defined(__BMI2__)
>    #  define DYNAMIC_BMI2 1

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

