Return-Path: <linux-tip-commits+bounces-3587-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B447A3FF41
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 20:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AB3F4252A6
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 19:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA5C253330;
	Fri, 21 Feb 2025 19:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UpmaA3MD"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AC61FE478;
	Fri, 21 Feb 2025 19:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740164561; cv=none; b=c1XhK+MwXiBjATAd/5vwe9kHIapl1wsqQt9C8xOhZPOmONOskw4+qYlOGAOQiSronGpjK0MeJSDiELq0/OQciS8uaKOh7uiKKtd6LxmaBaE+ODhtDl7TInIGmQEDtdrA4aOddIgU2lqnM8X0f0hFN8Vj5TOISi1DdR9AcRaPh9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740164561; c=relaxed/simple;
	bh=ckrF6AUDfvq7FWGQfleb7mSuyOHJa8ww6kbR2Qu/3ZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RmU945/o6w2URsD1BBfTVLdA6NCD6/Pg4R1Q7uEMmoWwC9oITexuRaQH4boZdRgrTQ6tiz/FLmyEY5Kyaf/Bspi7PZfOGsQtOeZjKBuD8cSCYbxd7LQGy/ZxcyzqykTJls3zF2rnbQShstmekcjqBpDHDa8+bohhxNyVrd9/ya4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UpmaA3MD; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DqbC3vH33yfexMVl+lCvyvg9tBCu02Oen0YWhCqFLxo=; b=UpmaA3MDmdjvgVBWFyw+x66hA8
	MXKj6mOZZzj/2pi4U5hEoIN16OPt00NVNUKzTAmbio8iXvthJC2JK+rJr1qV8nqHWrg0IDbjCRqkB
	2kmJwl/QKn87zZOTniUwRGj0lcp49dygjAsrLKgIxmeNK/iyUhBQT8cYv6cjk3mUgNHq0zcG6has6
	yvnfl0etQOBqNxenW181P7i4Y7Sq3gm4DsMB4ux2ZWjq/va70aJcu77/kZsQlP7qVEfPah+OlDt1L
	g+opGVVtXjd6jCSdcrPJJmhFilAB/TBw9kyPnLHxE2IflXN5Pxo7tOSRx+83X2YHdgHvnE6ExQXKk
	gSPOb/rw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tlYIH-00000002iMb-1UZP;
	Fri, 21 Feb 2025 19:02:37 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id F2B55300783; Fri, 21 Feb 2025 20:02:36 +0100 (CET)
Date: Fri, 21 Feb 2025 20:02:36 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, Kees Cook <kees@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: [tip: x86/cpu] x86/kcfi: Require FRED for FineIBT
Message-ID: <20250221190236.GD7373@noisy.programming.kicks-ass.net>
References: <20250214192210.work.253-kees@kernel.org>
 <174015048551.10177.4353365227122906077.tip-bot2@tip-bot2>
 <20250221190024.GC7373@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221190024.GC7373@noisy.programming.kicks-ass.net>

On Fri, Feb 21, 2025 at 08:00:24PM +0100, Peter Zijlstra wrote:
> On Fri, Feb 21, 2025 at 03:08:05PM -0000, tip-bot2 for Kees Cook wrote:
> > The following commit has been merged into the x86/cpu branch of tip:
> > 
> > Commit-ID:     f12315780faf1cbfe00991077a1e8c8e4c201f3b
> > Gitweb:        https://git.kernel.org/tip/f12315780faf1cbfe00991077a1e8c8e4c201f3b
> > Author:        Kees Cook <kees@kernel.org>
> > AuthorDate:    Fri, 14 Feb 2025 11:22:21 -08:00
> > Committer:     Ingo Molnar <mingo@kernel.org>
> > CommitterDate: Fri, 21 Feb 2025 15:38:11 +01:00
> 
> Ingo, seriously NO!

I've zapped the commit.

