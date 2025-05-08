Return-Path: <linux-tip-commits+bounces-5506-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 602CCAB0366
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 21:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D82444A61CD
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 19:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1901621D3F9;
	Thu,  8 May 2025 19:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JyIBZAn4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49C94B1E7A;
	Thu,  8 May 2025 19:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746731488; cv=none; b=a6FzWUf2sdW/cRqEaQ0nudlxIATBCQW0H3ynczvpOlQBkRG1PiXecJRqQM7bhSsL/g5sriz9BpFAX+O8gfqnTt8HGQPIeoNwdYvCoIv7HrczAmH5OgfhNOXLqOnGLOwi7lj4LtsnZLDKhvPMAjihBLi7qZzpWZUp16wdiWSikMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746731488; c=relaxed/simple;
	bh=pbKt+m9WCXAlpSz+5QVcZsMjM4/XTs7xPY3ZeTGF0bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YoIq2XI5zTDsuGDihnMThit6SeEJ+poEWWSG/LpGrUrbmG5Qf6P2faizzAZ0lLgh6ku5L8ERMFe/5mz9curdS3JbBekm5ki5tuNOvUQYM18xz21m7SaGMfeGhwpv6m7rn3Dlv2w/Qzsjw0bG6KKdD6e360WlumSWyU0PlpnqTIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JyIBZAn4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF5C3C4CEE7;
	Thu,  8 May 2025 19:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746731487;
	bh=pbKt+m9WCXAlpSz+5QVcZsMjM4/XTs7xPY3ZeTGF0bs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JyIBZAn4XqLJ8kqOO2AR/LZGoIIFid1N/xFLbEdr+/Lmiq0t1J+moVKazIjIMI4vO
	 +cNqKduT2RCrKjOQ20Y5Zvxos4uEEuqxB650XbrdXUkB3x31TvwXhBNyaMlMHMaWgq
	 pozHg5RVH90DQNVKIlE3W81fbYXiNt9fXoLhNAcBadaTgOQ2qzgsnFny3mVC51iigZ
	 cYlEpGgKuOBYpFlZN+O20/FQnedIAxt+XRs0jfjX+FaT0ITdAtsG7fbPMvICjcgDeZ
	 0YfvuICWWiBYFIoN7jCyDnoEDuzAdNZjJGCHY9Fh5n2FcZCAsxXCMBH4fulytXXA4s
	 s6VWn7AYtcs2w==
Date: Thu, 8 May 2025 21:11:23 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org
Subject: Re: [tip: perf/core] perf: Fix irq work dereferencing garbage
Message-ID: <aB0B2xaHWkzCjC_s@pavilion.home>
References: <174670046919.406.15885032121099672652.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <174670046919.406.15885032121099672652.tip-bot2@tip-bot2>

Le Thu, May 08, 2025 at 10:34:29AM -0000, tip-bot2 for Frederic Weisbecker a écrit :
> The following commit has been merged into the perf/core branch of tip:
> 
> Commit-ID:     88d51e795539acd08bce028eff3aa78748b847a8
> Gitweb:        https://git.kernel.org/tip/88d51e795539acd08bce028eff3aa78748b847a8
> Author:        Frederic Weisbecker <frederic@kernel.org>
> AuthorDate:    Mon, 28 Apr 2025 13:11:47 +02:00
> Committer:     Peter Zijlstra <peterz@infradead.org>
> CommitterDate: Fri, 02 May 2025 12:40:40 +02:00
> 
> perf: Fix irq work dereferencing garbage
> 
> The following commit:
> 
> 	da916e96e2de ("perf: Make perf_pmu_unregister() useable")
> 
> has introduced two significant event's parent lifecycle changes:
> 
> 1) An event that has exited now has EVENT_TOMBSTONE as a parent.
>    This can result in a situation where the delayed wakeup irq_work can
>    accidentally dereference EVENT_TOMBSTONE on:
> 
> CPU 0                                          CPU 1

This is missing the most important (and boring) part of the changelog :-)

> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

And I suspect some automatic check will also yell at some point at missing Sob.

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

