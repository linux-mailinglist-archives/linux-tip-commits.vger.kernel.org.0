Return-Path: <linux-tip-commits+bounces-3357-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A81CA321E3
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Feb 2025 10:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D9E3161C2A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Feb 2025 09:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594A8205ADD;
	Wed, 12 Feb 2025 09:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UvcHBjID"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF432046A1;
	Wed, 12 Feb 2025 09:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739351855; cv=none; b=sYCgAgaAPHd0CD9p9DoOBvsnYQpB357q30g32kbtZeAPqcMHZ2bOIJmIU93xyOCleJRxPqKkjtm0ZZMv0GMZ8pcuWdIuR2zm/FmGiykQPinjZG2ttFAQ2/CiseGou/g5ZtyzYRy/75g8E4fXFjFMZdFOkIpXhvr5Nd74UEdSwHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739351855; c=relaxed/simple;
	bh=VaWA69jLJEbx1tzGpVWQqW68uEMrEtMTNCIwHOwPWic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KlhsXAnhrYrCj6lgh9IV6mFRK1pz0gGb6mve9acuDTbsOnE7O95GOtNTS00xP3rFszJLyk1UBYw8zGQRSDCQOL0qq2IUlAmNM928QRTZ0f0lAecu+jayH4Jr8lBNY53xlsOmmTgqa6FDcFnfJKf2CYEfPs0s2e9lUWxo38yAXOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UvcHBjID; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gkKkfn9RZYpOXUy1js9dF0h3N+oOvgZyHXslAX7StVo=; b=UvcHBjIDImLXSx122KLXeXB+E7
	KoiVbl31dYtUDknrBK4nf6zhgFUWUwgwT/mfOM/gnDaFxOiUbNkgP9faSkIjm+Oext0WTZq7SRlrK
	sWUCc9t7y/xQJSU3/1SWptUTKdjIlVpiqV5LZ6UxqvFB99v3QIrnurJ8IyruxiPlfmW5TGK1kXuF8
	/5aamdyGGzsF0N7IgLRO5gHq/mTOSyYv/qYNqZvnGx3zXW4jFy0byilRTeYxhNOwY2qSCAByfsw10
	xwVU34JD6NiBG4a6X4h1tiwEYGeu856iOp+k165oP6S6JCwFj0epHoo8aUNGNEDNk+PVHlU/K4DgT
	ppAOs07A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1ti8rp-00000000mzV-1Tny;
	Wed, 12 Feb 2025 09:17:13 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 60EB8300318; Wed, 12 Feb 2025 10:17:11 +0100 (CET)
Date: Wed, 12 Feb 2025 10:17:11 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Cristian Prundeanu <cpru@amazon.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
	Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>,
	Ali Saidi <alisaidi@amazon.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Geoff Blake <blakgeof@amazon.com>, Csaba Csoma <csabac@amazon.com>,
	Bjoern Doebel <doebel@amazon.com>,
	Gautham Shenoy <gautham.shenoy@amd.com>,
	Joseph Salisbury <joseph.salisbury@oracle.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Borislav Petkov <bp@alien8.de>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-tip-commits@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v2] [tip: sched/core] sched: Move PLACE_LAG and
 RUN_TO_PARITY to sysctl
Message-ID: <20250212091711.GA19118@noisy.programming.kicks-ass.net>
References: <20250119110410.GAZ4zcKkx5sCjD5XvH@fat_crate.local>
 <20250212053644.14787-1-cpru@amazon.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212053644.14787-1-cpru@amazon.com>

On Tue, Feb 11, 2025 at 11:36:44PM -0600, Cristian Prundeanu wrote:
> Replacing CFS with the EEVDF scheduler in kernel 6.6 introduced
> significant performance degradation in multiple database-oriented
> workloads. This degradation manifests in all kernel versions using EEVDF,
> across multiple Linux distributions, hardware architectures (x86_64,
> aarm64, amd64), and CPU generations.
> 
> Testing combinations of available scheduler features showed that the
> largest improvement (short of disabling all EEVDF features) came from
> disabling both PLACE_LAG and RUN_TO_PARITY.
> 
> Moving PLACE_LAG and RUN_TO_PARITY to sysctl will allow users to override
> their default values and persist them with established mechanisms.

Nope -- you have knobs in debugfs, and that's where they'll stay. Esp.
PLACE_LAG is super dodgy and should not get elevated to anything
remotely official.

Also, FYI, by keeping these emails threaded in the old thread I nearly
missed them again. I'm not sure where this nonsense of keeping
everything in one thread came from, but it is bloody stupid.

