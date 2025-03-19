Return-Path: <linux-tip-commits+bounces-4325-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 763E7A6897E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 11:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AC57177375
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 10:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E781C20DD4B;
	Wed, 19 Mar 2025 10:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="YFZvIgAx"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CBA17A311;
	Wed, 19 Mar 2025 10:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742379914; cv=none; b=t48pdyCnsoIbRug+ISsz7vIq024J9WZ6ykZqaT/9SFul+BYvevDVp8f+g1WjXMAOtw2QVkcDvcOZN3ubO4UNfaVQxaghlVYWNt42MMELXkKX+YxmE8KcCHE0NC+xMdPGT1LI+IIIk2M51CIWI23xDhU5ekx+VzIwpXgWVBwyrE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742379914; c=relaxed/simple;
	bh=uWhWV+2sGjNB46T7vhlk302VRDpeYOGWW4nVDSdV0E0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TDdEmb1ixCTbN3HmnOux8CRAkFbtYT4ze7z/Wno4N5ZYXVVoIUL+xSaXZqwVGPYSnnj7kHZonGBW8Q+BJNPTSAxS91WSBI0RP/m8kFTDLvQljKF5Df+BF/ZYVGHLF71NLcM9WoPQf2yz79uJUEu3tzeH6DSVaFjxIFApbRGY36s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=YFZvIgAx; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8012940E0215;
	Wed, 19 Mar 2025 10:25:09 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id UlMD9vCVG-ig; Wed, 19 Mar 2025 10:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1742379904; bh=H0t09G1l0f7Bm4jN7rJd64VrhNK7iUywLdYD6/5STJ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YFZvIgAxsPzm5sIs2eQgE3m2OzpaxVmRn1ZZjAUBCo2Gkouot2gem/2ZysvGWLfQd
	 FFBkKZNGLKJsJelsR4wF2mjWqfmDDa+qmRYZPHICqyPmDPqPrt1s0dKr/ErlhTk8SO
	 gtHJxKB/HZcs2vitkyftD2qrFJ8aPGzeniCa2Yc4SYqAKksj/H/OS9lnFU3NDUB/DS
	 tS7VbI3a2ijEHx2iEyF5Cfz1vG4XbaeUVpzBTVW76fMaeNsKacr9r5jPLmM7aOf1DJ
	 B0P5/CaA7K6Nutte40S/SvABXBWLuNwYGZf33N934wfD8C2XR0GHkkYFWNxysPc4rC
	 SVrEcQUXoo/KNTomHVzQ89fGRLbfIISJLFSNj6QLnLcM5T7t0eIRC0sd1M2yFcLS/A
	 qQsGROPcwFAamcgSthjOgeSVLpDY7GWrIBVu8N4TyNL9RbyPeCejH1cyIlio7rmVJ1
	 V+/ZbVi7IVw5SdCZqacaMhnS7fYkFa7f0oXRn8vzh6zrZEQ/jS+mX2XWBbxxhd7j8e
	 cY3z7marzV/XrVZ+1HgNmz0IRrZAMmohLMatG+k+ylTo9v46vftfJYcQ7ANYqufVUN
	 sBVK5wBh7BsymqNpKMSWIswUxDdMJvWQb1CMOxrIy9fj2foENS9qeIgvRwVNNc2Fbf
	 qUBrq0kKxcipwkK6kDXZu190=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A185740E0196;
	Wed, 19 Mar 2025 10:24:47 +0000 (UTC)
Date: Wed, 19 Mar 2025 11:24:41 +0100
From: Borislav Petkov <bp@alien8.de>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	xingwei lee <xrivendell7@gmail.com>,
	yuxin wang <wang1315768607@163.com>,
	Marius Fleischer <fleischermarius@gmail.com>,
	Ingo Molnar <mingo@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Rik van Riel <riel@surriel.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Peter Xu <peterx@redhat.com>, x86@kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [tip: x86/mm] x86/mm/pat: Fix VM_PAT handling when fork() fails
 in copy_page_range()
Message-ID: <20250319102441.GBZ9qbaZfRWdYFIknU@fat_crate.local>
References: <20241029210331.1339581-1-david@redhat.com>
 <174100624258.10177.4534865061014070904.tip-bot2@tip-bot2>
 <fe0a67dc-d7cb-42ff-9b20-9527af7f6a94@redhat.com>
 <20250319095357.GAZ9qUNaWSORZMXdRK@fat_crate.local>
 <50f03347-0586-4284-b02d-b16abf89e656@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <50f03347-0586-4284-b02d-b16abf89e656@redhat.com>

On Wed, Mar 19, 2025 at 11:16:36AM +0100, David Hildenbrand wrote:
> Ahh, the commit id is already supposed to be stable, got it.

Yap, we try to avoid rebasing when it becomes really hairy and the commits
have been stable and out there for a while...

> I'm currently testing the following as fix, that avoids the second lookup
> completely.

Cool, please holler asap what happens so that we can act accordingly.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

