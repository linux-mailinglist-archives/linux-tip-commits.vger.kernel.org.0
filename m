Return-Path: <linux-tip-commits+bounces-3593-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BD0A401E7
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 22:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 671B0189FA42
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 21:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA6C1EF0B4;
	Fri, 21 Feb 2025 21:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="usiTLATP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226851CB501;
	Fri, 21 Feb 2025 21:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740172537; cv=none; b=L8vmGByINhL+XHhEcloLW57lezRmOJtXnML+olHgch0HCtya1jwayff/stKbzZ9QLi88DzU5F/A4ITErkw1GIXPRRy3302/IgAREu01iMmIZ9llPevzk2xR+2zDA0PgqZ7w3iD6Tknxig6DXSMw6WwCLJkpnj9oxhrfFTn9Vdp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740172537; c=relaxed/simple;
	bh=fWo2H7ApwGYIDfbBi+A8D7zvz0guh1DOl6kTWm14hKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PDTogPSphzuYehy90LKCNaYwlf+seE29DyEcONo+zTX3EDQAhSao0qVIKss4yQBlQeic9tianUdXgj+IbwrtC7yKXRhkpgqYb9+F4L8srfMHVkdt8/2x6Z3WBo/BrwQYTZnOs9XyWZRfiU85X7gIxrW7W4yIoEnQ82ki3nfx20I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=usiTLATP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9128C4CED6;
	Fri, 21 Feb 2025 21:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740172536;
	bh=fWo2H7ApwGYIDfbBi+A8D7zvz0guh1DOl6kTWm14hKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=usiTLATPheqd6kimJTx4Wl1bOR4c8d1mkje4/bZ7k0tEL2MjCM9QCuc+o2jGuE+XQ
	 UkOyWzcAfBtcrxIzll/fcEkqzsN7GI/LZS5/59pNhqPlbiWCpTtk5JgGOd2jwv6WHt
	 7Pulw4uAKx1Y8HEpGFIFEZtybq3nGQyWDGJaw8yx8SzrHMNIZEDl8qCjojWWaYxb2/
	 TunytUu8bm5lLhwIIMmkoGrWFagXZ1YM8XY/woILfCkHsmbT2dmvGgwiI3OSK1Bgdk
	 A1ECcPNu+WBkQeONHzODaKOui55/edzhQ7IU1H+Vk1H5YYKQWghhNTd4RghowbRIGH
	 T/CCAvWQh55Lw==
Date: Fri, 21 Feb 2025 22:15:27 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: [tip: x86/cpu] x86/kcfi: Require FRED for FineIBT
Message-ID: <Z7js71Q8Fl2E8mt7@gmail.com>
References: <20250214192210.work.253-kees@kernel.org>
 <174015048551.10177.4353365227122906077.tip-bot2@tip-bot2>
 <20250221190024.GC7373@noisy.programming.kicks-ass.net>
 <20250221190236.GD7373@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221190236.GD7373@noisy.programming.kicks-ass.net>


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, Feb 21, 2025 at 08:00:24PM +0100, Peter Zijlstra wrote:
> > On Fri, Feb 21, 2025 at 03:08:05PM -0000, tip-bot2 for Kees Cook wrote:
> > > The following commit has been merged into the x86/cpu branch of tip:
> > > 
> > > Commit-ID:     f12315780faf1cbfe00991077a1e8c8e4c201f3b
> > > Gitweb:        https://git.kernel.org/tip/f12315780faf1cbfe00991077a1e8c8e4c201f3b
> > > Author:        Kees Cook <kees@kernel.org>
> > > AuthorDate:    Fri, 14 Feb 2025 11:22:21 -08:00
> > > Committer:     Ingo Molnar <mingo@kernel.org>
> > > CommitterDate: Fri, 21 Feb 2025 15:38:11 +01:00
> > 
> > Ingo, seriously NO!
> 
> I've zapped the commit.

I've also re-integrated tip:master to make sure it doesn't go out to -next.
Sorry about that ...

Thanks,

	Ingo

