Return-Path: <linux-tip-commits+bounces-4423-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3804A6D99D
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Mar 2025 12:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2436D3A7CA5
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Mar 2025 11:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3280D25E45F;
	Mon, 24 Mar 2025 11:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gMds7k1+"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA531F4295;
	Mon, 24 Mar 2025 11:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742817433; cv=none; b=PF7E4Ha2MQRsYfvDeMDs9MCrolPjqMYp3rYlHFbiJ/lqJOy8nZ/bA2MJ+6RbJYrtbJCaOt077dmIKQxZqb/Cih4FvpYP+fsKKGGi62lvMZNLc7IlPEc6IlL7Ft5Ow5u1Q9fPq8FBMv6PBzW4mmP24SdCCwsaKEdWSvOzynlWaxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742817433; c=relaxed/simple;
	bh=e2maosv2GjAQ57jBOZoZ0/22d68+uo81/cNV9RNyUTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QIkXP2x/wyPbTYuY/57cx+fJ5a3CSAtm5ZXWKUHCRc+F5TGR2Q8l66xC6u/rblHriVgGJH/3hQtsaFv0kq3EDsEvXggOY+eJjzdpJVXfMmsPxf6gWOoAhnV2Kt89ZVSEWJzRc2mZ1gSqTZ2p7KGb29cPXWCsECRQUFM6RJoX4Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gMds7k1+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jljL51RtqiDXstFkd+RT3SvtTJ5nKEizZBdJowEbtgY=; b=gMds7k1+ia7XrPuAKKh0Z6Qc1S
	hBM1nQwXhYXajHCyVaoycwHpOXR998zsrqrURogunv9X//haumbncDe25wrTqj9DzOAAtL7pIUKEA
	ZWo4WiHd/k9Ngy98vJdkpOo0aU94T9L3waJHJaFF1j48YK61iQ8V8zcof9XiLwYnv//iFRZUdapld
	mMR7fY6UjgPSXkw1E9wBW9lJmJm7IaBWV8Oo6sxklnJpoYt+po4d+OmMIqnPtvDJQiPDfmbvanIEN
	CNfkYraHGsy4Kp5fMnZAWYaX4dlgzPwYupeLHoq0ObsjdGsqoKmLxR65slWwxCehgWMYkV9tOm+1m
	TeEJBcdA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1twgQR-00000000aFz-1ZcN;
	Mon, 24 Mar 2025 11:57:03 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id EF9F73004AF; Mon, 24 Mar 2025 12:57:02 +0100 (CET)
Date: Mon, 24 Mar 2025 12:57:02 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org
Subject: Re: [tip: sched/core] sched/debug: Remove CONFIG_SCHED_DEBUG
Message-ID: <20250324115702.GE14944@noisy.programming.kicks-ass.net>
References: <20250317104257.3496611-6-mingo@kernel.org>
 <174246119640.14745.12154097959900766458.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174246119640.14745.12154097959900766458.tip-bot2@tip-bot2>

On Thu, Mar 20, 2025 at 08:59:56AM -0000, tip-bot2 for Ingo Molnar wrote:
> The following commit has been merged into the sched/core branch of tip:
> 
> Commit-ID:     b52173065e0aad82a31863bb5f63ebe46f7eb657
> Gitweb:        https://git.kernel.org/tip/b52173065e0aad82a31863bb5f63ebe46f7eb657
> Author:        Ingo Molnar <mingo@kernel.org>
> AuthorDate:    Mon, 17 Mar 2025 11:42:56 +01:00
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Wed, 19 Mar 2025 22:23:24 +01:00
> 
> sched/debug: Remove CONFIG_SCHED_DEBUG
> 
> For more than a decade, CONFIG_SCHED_DEBUG=y has been enabled
> in all the major Linux distributions:
> 
>    /boot/config-6.11.0-19-generic:CONFIG_SCHED_DEBUG=y
> 
> The reason is that while originally CONFIG_SCHED_DEBUG started
> out as a debugging feature, over the years (decades ...) it has
> grown various bits of statistics, instrumentation and
> control knobs that are useful for sysadmin and general software
> development purposes as well.
> 
> But within the kernel we still pretend that there's a choice,
> and sometimes code that is seemingly 'debug only' creates overhead
> that should be optimized in reality.
> 
> So make it all official and make CONFIG_SCHED_DEBUG unconditional.
> 
> Now that all uses of CONFIG_SCHED_DEBUG are removed from
> the code by previous patches, remove the Kconfig option as well.


I really don't much like this :-(

