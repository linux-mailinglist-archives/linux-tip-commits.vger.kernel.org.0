Return-Path: <linux-tip-commits+bounces-5238-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9AC5AA8F2C
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 May 2025 11:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D2F93A662A
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 May 2025 09:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F67C19F462;
	Mon,  5 May 2025 09:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="hvMKDAzX"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3EF34CF5;
	Mon,  5 May 2025 09:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746436537; cv=none; b=tjLVCdVQfH+0J/zb0IttumbsOMlm0d3QtbeVKWxtVWj3hgcf79EeO/ZiWbr85+ooSisov8HQBwdlCcTbst6SO8wexnujKswXzgb8vzB1BIfkwJ3LCztSvRoNc8GAAuRA1saqEaO+2KgnsZ1B2pktEfRUdD4su/WjOv5scArcKzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746436537; c=relaxed/simple;
	bh=s4VxeVBfwf/lRLGakeQu23tOiUQkM//ukgN3I6WbC4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eOD94N/9DYbpoYhFNO5ZV17QjpbYo5rrXu1w4tYgmBUzJZPpZs1gXkFmdJBNwQGhReH4J8ygx9enWcm+rCKudAG02kzKtmJ3yAK8+V3FbYioBTYCv0Rq1kV0CPSRXxlfp723wm/Iqc39JLL1BqHlyF7ldrqLft3hv5r1D8V3M44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=hvMKDAzX; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B2DBE40E0196;
	Mon,  5 May 2025 09:15:32 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id u9a81fp4maJu; Mon,  5 May 2025 09:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1746436528; bh=ur1FAHlE7mVM+br0+9PR3Ei9FD4ZGrriHb4DVevVmw8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hvMKDAzXnbBX1Og5eM0r1OUQHVx6GOJzl/BYTFggLjJhLA+NugURwT5F7vbeZ1GCX
	 M/DnSmo7UMf0CFUdZrmqpcOc4lI99KD9DdXuQkPqLLRXQ3CAy7Wvk48Q9/9/BFeE7S
	 DeVcPjXhu5yukIN2dxU8IbNvzv4UoPNEwseYR24QDFnds9VN5vQrdkmGz9puViUID5
	 ojG9uKkPXphkHX/jlERvfVfYA4TCY1siCA3xtY1mGc98FyvEoSINIJvg4k20s239io
	 FY94tUrQUQk2DPfuIvi/ApLoeuyNz0fhlJIwEpLfJMhgSaSBgBfxKE7wGBmWLThgXx
	 ypM72gF/6y3jSBmyvG0CGFUg+wYs4J5q+vxfTrtNlpXH0fXfIUYXadxYWayagd5GnG
	 wXgo9FDtQs0GWBN5uWRwLW/DOz5AZyagmtRQsFpWsHuwP1yp0bYECxqSc7Mk+pd+QV
	 flSSqpDrwQe68e/TSJ2wxR/lZq63kvyrWJquZBSLV+8dPyus0qijdvWuFrKSfYA2b7
	 LowU0lD7U+tjSFKqYHvyIJke7YZHs5ElVHvz+ygMwE04zqUnhzaKD2dvKunupNfd8+
	 VSphlwt91tHCRVwIN0csW01QJTiGoNJRwIlPkDnYdqaLgaJEkyj9WvfoJA9Ru3GoJq
	 zmZHGl2wnNM+guynzrwlQhUo=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2202940E01FA;
	Mon,  5 May 2025 09:15:16 +0000 (UTC)
Date: Mon, 5 May 2025 11:15:15 +0200
From: Borislav Petkov <bp@alien8.de>
To: Kees Cook <kees@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-tip-commits@vger.kernel.org,
	Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
	"Chang S. Bae" <chang.seok.bae@intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org
Subject: Re: hardened_usercopy 32-bit (was: Re: [tip: x86/merge] x86/fpu:
 Make task_struct::thread constant size)
Message-ID: <20250505091515.GDaBiBo_1ywZciEMt1@fat_crate.local>
References: <20250503120712.GJaBYG8A-D77MllFZ3@fat_crate.local>
 <202505041418.F47130C4C8@keescook>
 <202505041541.C3D97BE@keescook>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202505041541.C3D97BE@keescook>

On Sun, May 04, 2025 at 03:43:07PM -0700, Kees Cook wrote:
> On Sun, May 04, 2025 at 03:30:38PM -0700, Kees Cook wrote:
> > However, I can't test this patch -- I'm not able to reproduce the problem
> > either, even with your .config. What hardware are you using?
> 
> Oh, wait, yes, I reproduced it. I just didn't actually log in or wait for
> complex daemons to start. Without my patch I quickly see the crashes. With
> my patch, everything is fine. So, I can confirm that fixes it.

I can confirm your patch fixes the boot here too - thanks for the
debugging and fixing!

Reported-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Borislav Petkov (AMD) <bp@alien8.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

