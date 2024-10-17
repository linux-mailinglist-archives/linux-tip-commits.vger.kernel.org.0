Return-Path: <linux-tip-commits+bounces-2495-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB089A1DDE
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Oct 2024 11:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2A831F2149C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Oct 2024 09:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFB01D88AD;
	Thu, 17 Oct 2024 09:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bsPsW6+W"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3344C1D88A4;
	Thu, 17 Oct 2024 09:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729156248; cv=none; b=SOUnIkwqXlogEwp4rQ36+gd/j0AfvMDd5iTIm1KclD2mJ8Quaeox9RfbCqxdtdnDkMX9TfWbUxf80ryVRts4yaBfLS6tZG1Xk+fL3yTfeKORdtOKhkhlBYQaGOlJmngfDKOlLpDY9Z1x+OJQ/hNdzl++7/NycjTI1Y+EZyZcnlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729156248; c=relaxed/simple;
	bh=vkUdPO+YIv6UsgWnupr1JbvuHq5pN/V19qg0DmTGilY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6iOna4IketU0lRqikydrHI198CAPtckhrKu7Lw4P3w6rG8bMTkYTyX3HY6axk6KGz0Bv/Ux6iHuyWxrw0QQj7q91Xt8r7iU8I98/3+ikGD0P009B+o2m9Q38xVLBk5LvYmtAvDg6/7ELum1W5sDnmZKkBCADEDw9JrDhWaRs+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bsPsW6+W; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=93T41rkeDd78b9KfSigfA60vyErE/d0x4myn52H8IsQ=; b=bsPsW6+WGCYP5M4+yngNqGJPSF
	nhKuJlJXlsw+v8fRY0BZfLQtlw8pDt7EFuP6b0w+YO9a9qc2TcZfG0T0pGXNwt/3/9ELb+rqBSvY4
	Wtv23BEw2JGsHV7DWJqSjl608roQ0kKjuyCCzO5z7mqr9PX/G2vVyqgUOgae82875EQ5na2fMee7c
	7QrbT1MtEF1GAWhaot5Ttb+UPK2lpaNwaFQ9b/9HC+LrlP+pTzvjaKAgW/O7O4rRIsQeZsVn02kZo
	R5Wsu3WN0ov0GK5+E/mkSFtWFJCzMrP2RNEHBG1uxVbF+OyuY4WI5uxOq3EFdMG2DKY8Y18M1P5xw
	9KQhWH6Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t1MWj-000000075cM-0S7F;
	Thu, 17 Oct 2024 09:10:37 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5BD613005AF; Thu, 17 Oct 2024 11:10:36 +0200 (CEST)
Date: Thu, 17 Oct 2024 11:10:36 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Cristian Prundeanu <cpru@amazon.com>
Cc: linux-tip-commits@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Bjoern Doebel <doebel@amazon.com>,
	Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>,
	Geoff Blake <blakgeof@amazon.com>, Ali Saidi <alisaidi@amazon.com>,
	Csaba Csoma <csabac@amazon.com>, gautham.shenoy@amd.com
Subject: Re: [PATCH 0/2] [tip: sched/core] sched: Disable PLACE_LAG and
 RUN_TO_PARITY and move them to sysctl
Message-ID: <20241017091036.GT16066@noisy.programming.kicks-ass.net>
References: <20241017052000.99200-1-cpru@amazon.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017052000.99200-1-cpru@amazon.com>

On Thu, Oct 17, 2024 at 12:19:58AM -0500, Cristian Prundeanu wrote:

> For example, running mysql+hammerdb results in a 12-17% throughput 

Gautham, is this a benchmark you're running?

> Testing combinations of available scheduler features showed that the 
> largest improvement (short of disabling all EEVDF features) came from 
> disabling both PLACE_LAG and RUN_TO_PARITY:

How does using SCHED_BATCH compare?

> While the long term approach is debugging and fixing the scheduler 
> behavior, algorithm changes to address performance issues of this nature 
> are specialized (and likely prolonged or open-ended) research. Until a 
> change is identified which fixes the performance degradation, in the 
> interest of a better out-of-the-box performance: (1) disable these 
> features by default, and (2) expose these values in sysctl instead of 
> debugfs, so they can be more easily persisted across reboots.

So disabling them by default will undoubtedly affect a ton of other
workloads. And sysctl is arguably more of an ABI than debugfs, which
doesn't really sound suitable for workaround.

And I don't see how adding a line to /etc/rc.local is harder than adding
a line to /etc/sysctl.conf

