Return-Path: <linux-tip-commits+bounces-4421-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7ADA6C820
	for <lists+linux-tip-commits@lfdr.de>; Sat, 22 Mar 2025 08:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E30A18969FB
	for <lists+linux-tip-commits@lfdr.de>; Sat, 22 Mar 2025 07:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913111C84D5;
	Sat, 22 Mar 2025 07:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQl2/jdS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675351ADC86;
	Sat, 22 Mar 2025 07:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742629503; cv=none; b=Kym+oDIhyN8/B5tjwM2lryozLfFJFXEQZhgfzPW+WrEOJSynUJo0kURl3CoEQEkmN5CiHbK5NUJabtrNviRFxBziZure96WvVHtn4eZj7DnRcCVRAWD3baPHg45En1/10Dj2JC5sGAb3wazoJRv7y9yW4r7NskXw/K7pulXcJp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742629503; c=relaxed/simple;
	bh=odXZ5mRDkwtb+tGO1DSgKv0lQ0sPOkRNdFNhNns5z88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P+C57hvT8YcxCmH2k3KnwNBEILGKNNOpxQY5SUNNcWqKnojdPEY7wUQwaxYbGRCgxpGYTy4W+phhMoq2afbuw/4ZrJhK1WKHtGz32/QuDAMM9lqhSkUlG1o177b5psksj8eW951+xUwAi/DLVR80nGZ/FF6OWIqouvQKf4cxyNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQl2/jdS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20946C4CEDD;
	Sat, 22 Mar 2025 07:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742629502;
	bh=odXZ5mRDkwtb+tGO1DSgKv0lQ0sPOkRNdFNhNns5z88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BQl2/jdST6jTdJG992Sjtyrj3L6df5PErZn1EOm3YHfY5iyC451trLik3QH8boSEH
	 gTjqH7L7jx9/nEXLZPO8md9ZXXajeWJxpbXVLwAeAy8ga7s12JO00xd/LyPG+Cujam
	 dUz7zJFUON3egrHlHcRM4KTDSgT38Z0E7wMgvTKmWMQB3SNga+2T+yFqUE59zUzqXn
	 JiT9R+FUk3qsWOOJHgOml42CqtlI4oxxrnmfK9LHts+e17Fp4n/u+ERiPaYq2Xc3dR
	 UlVEEuwF358oQ5+f/4sYguKjeGvXbcov2wpm3/vvNzAPGhPDKCVde/X0TliPxt3Bpu
	 W/icdB94sZU/A==
Date: Sat, 22 Mar 2025 08:44:58 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, Nick Terrell <terrelln@fb.com>,
	linux-tip-commits@vger.kernel.org,
	Michael Kelley <mhklinux@outlook.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org
Subject: Re: [tip: x86/core] zstd: Increase DYNAMIC_BMI2 GCC version cutoff
 from 4.8 to 11.0 to work around compiler segfault
Message-ID: <Z95qekGt2GHnph01@gmail.com>
References: <174254398939.14745.1644465295513159567.tip-bot2@tip-bot2>
 <20250321124813.GAZ91gDUYB6TDsMJNv@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321124813.GAZ91gDUYB6TDsMJNv@fat_crate.local>


* Borislav Petkov <bp@alien8.de> wrote:

> (cleanup the botched CC: line :))
> 
> + Nick.
> 
> Interesting - we were looking at a similar issue recently:
> 
> https://lore.kernel.org/r/20250317135539.GDZ9gp24DhTKBGmkd8@fat_crate.local
> 
> and upgrading my toolchain fixed it.

Applying the ZSTD version quirk would likely also fix it under the 
original compiler version (GCC 10.3.0).

Thanks,

	Ingo

