Return-Path: <linux-tip-commits+bounces-5142-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6FFAA47D1
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Apr 2025 12:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F18B4C41ED
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Apr 2025 10:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88ED1E8338;
	Wed, 30 Apr 2025 10:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iPP1cP0b"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2B227453;
	Wed, 30 Apr 2025 10:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746007391; cv=none; b=MMrfyhhpdKetNJ+K3lHvlb8m9YSIQmRpYhxiMfxVNIxq5GiolfcyDPw/Nt64fWVvMOD+xF2K5kOBz0plOABnOvhvlE955tDjDit4rJmVEYHZmffgIIguezVRgTpXBpRIvqeXJ3wgGY5ami3RXlUb2rgaoWiJiNcvRlDXV6hvO9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746007391; c=relaxed/simple;
	bh=KGrywym0ZOPJ7Xz6jT1rH9HD67hby50/YM/sqq5W7Ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B5J07/oTVnO5SVSpmXtCOkMu5XcI5X+Zi4VyX+nm2/WvUVQnw4GPlztzIYhCCOKjPr5DKOdXwqcES9I1Ld5dkv+X4kYhBIh0BMoh6LIE1YyGQqncPkWIKUJ/FD2KMoG+r//YatckdRVF8bp0ii1Xgg0eABQErEI3G0+nQF5nWpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iPP1cP0b; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wnpd3q5WOijzfJQLTLp3KY3bMqG+b+asGNrhRbSKFUs=; b=iPP1cP0bFtD3Rv3xLAGyffUDiZ
	KKZU3/5OI9Imh0rKeKe7yM+m7wFhp2kvOPllhKaxzyJTuWhpIdA6tb1oowm84bawgx8wd02qNu6cR
	4EVMvZn1Fl9QCCzoXuYLo5HmbJXplPthuBzppxOog5bkXxNqG2qm5JL0IR+YGf/ReBl+vKg4vFE8z
	txEh+QdtASPET3fCX8boA2V+WUmWH98O1aUY9MjhQiznUoXd7uN0/1jMZwL5U77RpDfQUlDvMCxPS
	aSXYdFnpcc9NRg4FrtWUS3zd7PmwgClqpdOZBHmZd8MbUJoWrv1ezKD8UMB+DLyw7Up7nvGUb/0Tw
	y0KgRDMw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1uA4HL-0000000DlSm-2vRX;
	Wed, 30 Apr 2025 10:03:00 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3A8AB300642; Wed, 30 Apr 2025 12:02:59 +0200 (CEST)
Date: Wed, 30 Apr 2025 12:02:59 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Cristian Prundeanu <cpru@amazon.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
	Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>,
	Ali Saidi <alisaidi@amazon.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Geoff Blake <blakgeof@amazon.com>, Csaba Csoma <csabac@amazon.com>,
	Bjoern Doebel <doebel@amazon.com>,
	Gautham Shenoy <gautham.shenoy@amd.com>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Joseph Salisbury <joseph.salisbury@oracle.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Borislav Petkov <bp@alien8.de>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-tip-commits@vger.kernel.org, x86@kernel.org
Subject: Re: EEVDF regression still exists
Message-ID: <20250430100259.GK4439@noisy.programming.kicks-ass.net>
References: <20250429213817.65651-1-cpru@amazon.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429213817.65651-1-cpru@amazon.com>

On Tue, Apr 29, 2025 at 04:38:17PM -0500, Cristian Prundeanu wrote:

> [1] https://github.com/aws/repro-collection/blob/main/repros/repro-mysql-EEVDF-regression/results/20250428/README.md

That 'perf sched stats diff' output is completely broken -- probably
trying to diff two different schedstat versions isn't working.

Anyway, looking at the two individual reports side by side:

 - schedule() left the processor idle             -- is up

vs.

 - pull_task() count on cpu newly idle            -- is down
 - load_balance() success count on cpu newly idle -- is down

Which seem related and would suggest we look at newidle balance. One of
the things we've seen before is that newidle was affected by the shorter
slice of EEVDF. But it is also quite possible something changed in the
load-balancer here.

Also of note is that .15 seems to have a lower number of 'ttwu() was
called to wake up on the local cpu' -- which I'm not quite sure how to
rhyme with the previous observation. The newidle thing seems to suggest
not enough migrations, while this would suggest too many migrations.



