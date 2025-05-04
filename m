Return-Path: <linux-tip-commits+bounces-5231-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03221AA89F1
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 May 2025 00:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 558131717A1
	for <lists+linux-tip-commits@lfdr.de>; Sun,  4 May 2025 22:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8F224BD0C;
	Sun,  4 May 2025 22:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DSnIbMof"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C998F1F236B;
	Sun,  4 May 2025 22:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746398591; cv=none; b=DA3SgoAbDtq9LnngRjWIdBkT3x9fTbCAhxhUpMJ0jQZOg77rCuF9AXcrjRZ4ozh4ar6kzhrOtyaa6h8rkTaj48Rb64Bog+qS7hR07FLrRH+lg5vrIp6PeUfyJxQiGnFvLY94jQiZzZycok6OsTYvFdXq5HBtPl4WB3MouLHsMQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746398591; c=relaxed/simple;
	bh=gIMpMCROprVXbhOlKMSDHs8Aax/Xg1zy+Ft4H9K6sG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GC0dsvn6KZduSnA3d13nSw7ukJehW+gVFm8opc/R7oIVzmm6woQ0Wy975dnMhtbC+yc1r6BNhGv29Fwx5tKG2L7Tg9gpEBWzv9uRZ6UoZ1RyqoSF/9lymVdUlHnhfv9f8qQiaAXU+uFcSWl/VGlieZS7TihasaDU66fj5nwmU7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DSnIbMof; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C68EC4CEE7;
	Sun,  4 May 2025 22:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746398591;
	bh=gIMpMCROprVXbhOlKMSDHs8Aax/Xg1zy+Ft4H9K6sG8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DSnIbMof8BalYdz/t37XrH15oBNFSDyQE3ks2f+lhpoA06205PW/UHNZXm9PXIeot
	 msxFvXJkFJ/EMcQ99Vvj507RMTufhoN0SeXxsVGeuIqXbhiyYmH0fHtV5DFYgUWB4F
	 rj0NeCrrLi1zzUFy9x0nM72l4Wjg5gPjOy2G/cSROfJoopp6p8o6Z/unvIZto9EZr9
	 rsysxV8fdOBegmaz3czkLCSfYJZoPC/KnxOZQHmKqHClkTCRLz/5f8w7RAoQGxmDX+
	 UH2R7ls5ChjebCUzmdBIO2D3QSIdWTE39/UBDq9fa2v8chd89NeiyjK8HuN2sNqVbr
	 ++pvHX4onhk1Q==
Date: Sun, 4 May 2025 15:43:07 -0700
From: Kees Cook <kees@kernel.org>
To: Borislav Petkov <bp@alien8.de>
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
Message-ID: <202505041541.C3D97BE@keescook>
References: <20250503120712.GJaBYG8A-D77MllFZ3@fat_crate.local>
 <202505041418.F47130C4C8@keescook>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202505041418.F47130C4C8@keescook>

On Sun, May 04, 2025 at 03:30:38PM -0700, Kees Cook wrote:
> However, I can't test this patch -- I'm not able to reproduce the problem
> either, even with your .config. What hardware are you using?

Oh, wait, yes, I reproduced it. I just didn't actually log in or wait for
complex daemons to start. Without my patch I quickly see the crashes. With
my patch, everything is fine. So, I can confirm that fixes it.

-- 
Kees Cook

