Return-Path: <linux-tip-commits+bounces-5512-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC75AB0575
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 23:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 835A51BC71E4
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 21:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE57221FDB;
	Thu,  8 May 2025 21:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aUDJQ7TM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670EC1CAA6E;
	Thu,  8 May 2025 21:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746740640; cv=none; b=h5wEi2Z6QbVWL1XNSdXBO1GWe+enme67MKMDsUcXWK/bG9+Aubu/wLgXb6zlFWkkMsRZsKje3cvfeYfI+J5Tmm39s6yd5GhV/YgjxSKO1OiQh6QkeZXr0CslCHKm5wOZKc9VaBLi91uJVLXX7TdpwWWsh29aGEzhnuuUuJGEEc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746740640; c=relaxed/simple;
	bh=2XM0ycqF9U6sa+FgoRGJnyBhv3k0LGN8UkGCg3UhoMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nn1pq8FvM/TVSflWNsVaZXyDeedCLmY8AS3iEL11y5zIQoCP83R3BU4DFdPiL1BEtlT9w5VDpIfLMUwv3y4Mgl2RJwJA5pbhiORzS5bxkk9kAOMEYq7TMIOJ2n5+ZYwK3WKRSevS86LfYkT3h/POawsOsSAbn5WSGQ4upipW1f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aUDJQ7TM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED364C4CEE7;
	Thu,  8 May 2025 21:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746740640;
	bh=2XM0ycqF9U6sa+FgoRGJnyBhv3k0LGN8UkGCg3UhoMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aUDJQ7TMLaRB9cnLeSgzoWJEtdQBcpXGxXX3iQdgb/fgkky2ebvtCYpZLmdhci48l
	 TmnoOj3mUAygZZYoVHtWPbVtJwha3ocNCa/+16PP4BWZOZW1jFnjzAOEKwhKUi5L2y
	 5zWHAGai3TXN2tDplVbRSkVB5waYHoWYunAg1hrBW2YRVARQ0IcwrL/oEiIppnRDXV
	 0Ukl+4He2OzrLJSIcN6FXMY4Qsf7zMhkPe1AD/fH/BtyfpPebsNz2SleZtTATnaFL+
	 fxXp1GUBTm/t/5K6/IogD15G9TC1NKOE+7iJWNckXd3MPJc5pXgm41L9zNDVRo1RWm
	 lGJFmu4+Ycc7Q==
Date: Thu, 8 May 2025 23:43:57 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	x86@kernel.org
Subject: Re: [tip: perf/core] perf: Fix irq work dereferencing garbage
Message-ID: <aB0lnW68rLDtuCkZ@pavilion.home>
References: <174670046919.406.15885032121099672652.tip-bot2@tip-bot2>
 <aB0B2xaHWkzCjC_s@pavilion.home>
 <20250508194605.GA8552@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250508194605.GA8552@noisy.programming.kicks-ass.net>

Le Thu, May 08, 2025 at 09:46:05PM +0200, Peter Zijlstra a écrit :
> On Thu, May 08, 2025 at 09:11:23PM +0200, Frederic Weisbecker wrote:
> > Le Thu, May 08, 2025 at 10:34:29AM -0000, tip-bot2 for Frederic Weisbecker a écrit :
> > > The following commit has been merged into the perf/core branch of tip:
> > > 
> > > Commit-ID:     88d51e795539acd08bce028eff3aa78748b847a8
> > > Gitweb:        https://git.kernel.org/tip/88d51e795539acd08bce028eff3aa78748b847a8
> > > Author:        Frederic Weisbecker <frederic@kernel.org>
> > > AuthorDate:    Mon, 28 Apr 2025 13:11:47 +02:00
> > > Committer:     Peter Zijlstra <peterz@infradead.org>
> > > CommitterDate: Fri, 02 May 2025 12:40:40 +02:00
> > > 
> > > perf: Fix irq work dereferencing garbage
> > > 
> > > The following commit:
> > > 
> > > 	da916e96e2de ("perf: Make perf_pmu_unregister() useable")
> > > 
> > > has introduced two significant event's parent lifecycle changes:
> > > 
> > > 1) An event that has exited now has EVENT_TOMBSTONE as a parent.
> > >    This can result in a situation where the delayed wakeup irq_work can
> > >    accidentally dereference EVENT_TOMBSTONE on:
> > > 
> > > CPU 0                                          CPU 1
> > 
> > This is missing the most important (and boring) part of the changelog :-)
> > 
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > 
> > And I suspect some automatic check will also yell at some point at missing Sob.
> 
> Doh, script fail :/
> 
> Let me go fix.

Looks good, thanks!

-- 
Frederic Weisbecker
SUSE Labs

