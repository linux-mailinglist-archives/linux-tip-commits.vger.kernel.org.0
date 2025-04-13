Return-Path: <linux-tip-commits+bounces-4949-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5F0A87381
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Apr 2025 21:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84E1916B5D3
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Apr 2025 19:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB271E51E7;
	Sun, 13 Apr 2025 19:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nz5CfqDG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9030D86344;
	Sun, 13 Apr 2025 19:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744572006; cv=none; b=VXLpB83jE6PJon380ReJEXwTWsNkH1kk/ocNT3/6KrWUVBVHKr/lpYBjPAKGD4CgmbyS00CXInaoUrtBnS/rfoban2ffwDiF0Y8tuSfqtYsLjCpF4xhI6UuGjr6JezAgRP8ZZ8UFJlK+SItEYeVc0IGYV3M0hbyq0FifPJGQZIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744572006; c=relaxed/simple;
	bh=jwJAf2mhzNRJa3GFdl49MLmGH40uEoMN3VP91CyQDk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qVhHKqxNVe2Wtpd50fsLugxuzg2ylGHaqsmyYi6N/0avZ+xYW8jM9NuQUhkaa/bhae0Nyp67FQxjOEz5qcENbwdKKs8VrdtLAG8jyXziJz+/oK7IaxCzJz+LLYlHOvrxz31BHViFdqlQn51bmHwe2JgL/B7qEZwbaiEGNToQJqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nz5CfqDG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B150AC4CEDD;
	Sun, 13 Apr 2025 19:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744572005;
	bh=jwJAf2mhzNRJa3GFdl49MLmGH40uEoMN3VP91CyQDk8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nz5CfqDGIuVkHMUr2U0MKaFc/kgKzAHDcrM/iqsMkfwk4J4PwQHXJqTSgHizG2rxa
	 xyUeB8hQFhGhX3aJb0xaj+hLM0ll9Ph845ZTsmT6Y9tyJv/s0pQKK9dosjZsOWYWAm
	 kkYDLZcutJ4zo+21sv3WVe7QZOPHMimwDDdLFD7fFDkCFGnvqew+9r+rIqK3Rlwrpw
	 P8tPu8K+ky14LvhZbA7hnclOj4FXVeidhr3Nefg0lQkt4msaIp7Fzmew9e0R5cMtMH
	 epkli/AsOscspr65I7xmoCX4AKxWaEW26gqxpi0nKwE3VY5LktDzY7Y8TZM3Q6I3Yq
	 1WNVBuHv2Rhyw==
Date: Sun, 13 Apr 2025 21:20:00 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Borislav Petkov <bp@alien8.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Paul Menzel <pmenzel@molgen.mpg.de>, x86@kernel.org
Subject: Re: [tip: core/urgent] compiler.h: Avoid the usage of
 __typeof_unqual__() when __GENKSYMS__ is defined
Message-ID: <Z_wOYOrVJJkUUUF9@gmail.com>
References: <20250404102535.705090-1-ubizjak@gmail.com>
 <174428272631.31282.1484467383146370221.tip-bot2@tip-bot2>
 <20250411210815.GAZ_mEv8riLWzvERYY@renoirsky.local>
 <Z_oqalk92C4G6Rqt@gmail.com>
 <CAFULd4bTd6GMftLBX7Nu0xftini00o4v7=1XfuoDC8ydUr9Ueg@mail.gmail.com>
 <Z_t7_brzSoboOsen@gmail.com>
 <CAFULd4ZBbAG4ndn+rzjjqF+pmtGa3UbyDOWfEXww0XhExJByVA@mail.gmail.com>
 <Z_wI0uNoG2G2TQMC@gmail.com>
 <CAFULd4b2afcu5PnxhqwwepwWMSA7mvYNyPnMtkCjjT84VG8VXA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFULd4b2afcu5PnxhqwwepwWMSA7mvYNyPnMtkCjjT84VG8VXA@mail.gmail.com>


* Uros Bizjak <ubizjak@gmail.com> wrote:

> > > If this commit is removed, [...]
> >
> > I did not remove commit ac053946f5c4, it's already upstream. Nor 
> > did I advocate for it to be reverted - I'd like it to be fixed. So 
> > you are barking up the wrong tree.
> 
> If the intention is to pass my proposed workaround via Andrew's tree, 
> then I'm happy to bark up the wrong tree, but from the referred 
> message trail, I didn't get the clear decision about the patch, and 
> neither am sure which patch "brown paper bag bug" refers to.

It's up to akpm (he merged your original patch that regressed), but I 
think scripts/genksyms/ should be fixed instead of worked around - 
which is why I zapped the workaround.

Thanks,

	Ingo

