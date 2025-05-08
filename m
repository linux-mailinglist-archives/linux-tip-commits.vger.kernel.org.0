Return-Path: <linux-tip-commits+bounces-5507-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B73CAB03EF
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 21:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93204526413
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 19:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980E228AB0C;
	Thu,  8 May 2025 19:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oQ0kbt66"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B80628AB07;
	Thu,  8 May 2025 19:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746733576; cv=none; b=uH6pnNx03Civ/PJi01TwT0cp3ehRehXtAr28I0j8UQRFpAiZUCMfCS7fnskaGQiIxA8HPL7G8PSbECTgqla6EFpkPZVaIGFWYhTf5xEF8zV+6zA6EOlWKiSX83y0cLJU17FVuy+wkZpcNGTM4b3muZyqaZpuNqv4PHDK1GF4E4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746733576; c=relaxed/simple;
	bh=yyvI7DAXm3rfJ/sbUu5kfKFg14e8FmbkKV8nRA5xZF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QBxeJnfIWxhKW3z6sEw8xRArrkt9UhREMKgXeXT66FrZt+46BeMZP8DvmOQEuWcw2EWb9KRL4yXVUEF11tczMntSo7IjjXZtWKvsC1qVnew3sHJelG3CDP7EkeXq2D+2IwdFIR+v7blc0Knz6eUPuIclWCM+LRBbIKA4rURK6aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oQ0kbt66; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=OHiKRzCBkFciXiXYaG9F67Fcg4ghNHssFOoXfh5Nyc8=; b=oQ0kbt66eLjKZjqvg8p1lYvnvG
	RjUVIgTkUC6VFWI6qheNEBc7wP1pRnpHKpxUMbZsaB9EkHngCeZ0QSMVrJkUubPF55OWXWT1BoFOq
	15gAS8pDzNWq4uASqW3vIjLf6NDSDGRUUYDFTRqo1IMGFOveGHJR2xw6cb4pc5jZwIJIwjAVWwwAN
	VbqDEn1Q/2DiM3POX2BDwYiysfUvtU96xaBTqxMSGzGYEs7Pv3QqHxudRfBSaqLg0PNw5BYfF/H0f
	c34fzJZz2zpJlGDeW8HiMjJYeAcV/PywtkZw0UCQEWJD5T5Wh08Yx9mYH+a0fr0gpQsGq09c9TouT
	g39YXy2w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uD7C3-00000002pgX-0uXY;
	Thu, 08 May 2025 19:46:06 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BF12930005A; Thu,  8 May 2025 21:46:05 +0200 (CEST)
Date: Thu, 8 May 2025 21:46:05 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	x86@kernel.org
Subject: Re: [tip: perf/core] perf: Fix irq work dereferencing garbage
Message-ID: <20250508194605.GA8552@noisy.programming.kicks-ass.net>
References: <174670046919.406.15885032121099672652.tip-bot2@tip-bot2>
 <aB0B2xaHWkzCjC_s@pavilion.home>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aB0B2xaHWkzCjC_s@pavilion.home>

On Thu, May 08, 2025 at 09:11:23PM +0200, Frederic Weisbecker wrote:
> Le Thu, May 08, 2025 at 10:34:29AM -0000, tip-bot2 for Frederic Weisbecker a écrit :
> > The following commit has been merged into the perf/core branch of tip:
> > 
> > Commit-ID:     88d51e795539acd08bce028eff3aa78748b847a8
> > Gitweb:        https://git.kernel.org/tip/88d51e795539acd08bce028eff3aa78748b847a8
> > Author:        Frederic Weisbecker <frederic@kernel.org>
> > AuthorDate:    Mon, 28 Apr 2025 13:11:47 +02:00
> > Committer:     Peter Zijlstra <peterz@infradead.org>
> > CommitterDate: Fri, 02 May 2025 12:40:40 +02:00
> > 
> > perf: Fix irq work dereferencing garbage
> > 
> > The following commit:
> > 
> > 	da916e96e2de ("perf: Make perf_pmu_unregister() useable")
> > 
> > has introduced two significant event's parent lifecycle changes:
> > 
> > 1) An event that has exited now has EVENT_TOMBSTONE as a parent.
> >    This can result in a situation where the delayed wakeup irq_work can
> >    accidentally dereference EVENT_TOMBSTONE on:
> > 
> > CPU 0                                          CPU 1
> 
> This is missing the most important (and boring) part of the changelog :-)
> 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> And I suspect some automatic check will also yell at some point at missing Sob.

Doh, script fail :/

Let me go fix.

