Return-Path: <linux-tip-commits+bounces-4557-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C2EA71193
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Mar 2025 08:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 321933A5456
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Mar 2025 07:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E7919D892;
	Wed, 26 Mar 2025 07:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DdrZpt62"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D81519D898;
	Wed, 26 Mar 2025 07:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742974953; cv=none; b=IWkz0CGSyk5EJNSLbytqcyQvjReBPpYBMxXBnaXGFG3B4+MC7VZsVeZDqofF2HLlK2vrAdbSECxNdrrO8pkKlMcfa5SEQ6TYYak8piZos3MtZmi9dPi03DGoxPFcHhnL2Bi1xF9ZyOgJ1SIKrdPlZHgb/kknSY5M3hz6vhey37c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742974953; c=relaxed/simple;
	bh=a39+hOyOBrLWeBos3bRjt0r0Ck9szc7SKc42ebq5PoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lmaNVkDnI2GO7YklIFqBMo4y1PBBXm1ovRVv5iJvk9v/Is8E39irvG9AKMRlVhnPN6ZJYGZqAR5pZowBV92FMvkgBMKLMwPtS6mNwemJ0UhxWAegbnYaQanQEjZVMySRBKGxL7rZBihLFZlHUYvG7s4LBpcGo78t3x/RuOSuiYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DdrZpt62; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA28C4CEEE;
	Wed, 26 Mar 2025 07:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742974953;
	bh=a39+hOyOBrLWeBos3bRjt0r0Ck9szc7SKc42ebq5PoM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DdrZpt62vmxatBvcF50WRZeLjwuQK1aCe+C+9urExeiH7vWpYuv3xjFQhRVwqCJZ9
	 2tB9Tzh6sAT32Ci3dDhsNnw712zwSeNykTqNKk1Oe3h/8g93cDKodhXJNGqsxUqVab
	 2ZqsXrtQZS2q0dXn8bv97v+YxDr2omeekzpP5ae4qIlxOeEHBF8D1xVyDbqNyVt5RI
	 qsTN95w3I8ikx95q04nmkARoHRdhsCQdVl/IMcKPUUD9SWpmaT7ZoToKmQz3RB0FpB
	 envgh04m+n3QXDp3LrIQEkPOg9JL8F5z8486HhayWmu1Ywj2Ptv8tWX9llX7kKFjnk
	 oO1uaXSHQCDAw==
Date: Wed, 26 Mar 2025 08:42:27 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	linux-tip-commits@vger.kernel.org,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, x86@kernel.org
Subject: Re: [PATCH] bug: Add the condition string to the
 CONFIG_DEBUG_BUGVERBOSE=y output
Message-ID: <Z-Ov478wdBKpqtmA@gmail.com>
References: <20250317104257.3496611-2-mingo@kernel.org>
 <174246120542.14745.16936293992221722909.tip-bot2@tip-bot2>
 <20250324115955.GF14944@noisy.programming.kicks-ass.net>
 <Z-J5UEFwM3gh6VXR@gmail.com>
 <Z-KRD3ODxT9f8Yjw@gmail.com>
 <20250325123625.GM36322@noisy.programming.kicks-ass.net>
 <CAHk-=wg_BRnCs8o5vEjK_zDuc0KJ-z9bvq5845jKv+7UduS4hQ@mail.gmail.com>
 <Z-MxULQtc--KoKMW@gmail.com>
 <CAHk-=wjMu5iGZ2ifBqjzV4a993D13OnDvfbtYe6jgPP8cZnAGQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjMu5iGZ2ifBqjzV4a993D13OnDvfbtYe6jgPP8cZnAGQ@mail.gmail.com>


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Tue, 25 Mar 2025 at 15:42, Ingo Molnar <mingo@kernel.org> wrote:
> >
> > So something like the patch below?
> > [...]
> > After:
> >
> >   WARNING: CPU: 0 PID: 0 at [ptr == 0 && 1] kernel/sched/core.c:8511 sched_init+0x20/0x410
> >                             ^^^^^^^^^^^^^^^
> 
> Hmm. Is that the prettiest output ever? No. But it does seem workable,
> and the patch is simple.
> 
> And I think the added condition string is useful, in that I often end
> up looking up warnings that other people report and where the line
> numbers have changed enough that it's not immediately obvious exactly
> which warning it is. Not only does it disambiguate which warning it
> is, it would probably often would obviate having to look it up
> entirely because the warning message is now more useful.

Yeah, that exactly was the original motivation for SCHED_WARN_ON(): 
core kernel code often gets backported on and changed by distributions, 
so line numbers are fuzzy and with large functions it's sometimes 
unclear exactly where the warning originated from.

> So I think I like it. Let's see how it works in practice.
> 
> (I actually think the "CPU: 0 PID: 0" is likely the least useful part 
> of that warning string, and maybe *that* should be moved away and 
> make things a bit more legible, but I think that discussion might as 
> well be part of that "Let's see how it works")

Okay!

The CPU and PID part is particularly useless, given that it's repeated 
in the splat a few lines later:

  ------------[ cut here ]------------^M
  WARNING: CPU: 0 PID: 0 at [ptr == 0 && 1] kernel/sched/core.c:8511 sched_init+0x20/0x410
  Modules linked in:
  CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.14.0-01616-g94d7af2844aa #4 PREEMPT(undef)
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
  RIP: 0010:sched_init+0x20/0x410

So I'll just remove it, which will turn this into:

  WARNING: [ptr == 0 && 1] kernel/sched/core.c:8511 sched_init+0x20/0x410

Which is actually pretty nicely formatted IMHO and orders the 
information by expected entropy: most constant, most valuable 
information comes first.

BTW., there's also another option we still have open: by using a unique 
character separator that isn't 0 we could split up the single string 
into cond_str and FILE_str parts, and leave formatting to 
architectures. But I don't think it's needed if we get rid of the "CPU: 
PID:" noise though.

	Ingo

