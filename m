Return-Path: <linux-tip-commits+bounces-4424-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C93F8A6D9A5
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Mar 2025 13:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B14E167C1E
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Mar 2025 12:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E81425E46F;
	Mon, 24 Mar 2025 12:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eEGA+B2y"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAFE25E461;
	Mon, 24 Mar 2025 12:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742817603; cv=none; b=nD1WOCyE7SUCbrK8UW3SiwhFFx9EUeY36H3nd/86r+BuveqjrLYdttD7hJNxSBtZ9IWta562UiaJHs+pCibhJC6vCwDWnvmeu22EoJx0WgGGEZFvYwJ/4uQcKlI3pgdwDJxWpSZfJ9TLjOkGR4v7zcbPjB3MAekMRaMmLB7t4Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742817603; c=relaxed/simple;
	bh=1tO84DwuxXNsqpKrwI2DNSv+oUloblqpcZ/RmymvqO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QSVFsv/CyBaoc/ychVDXnulwfiWxHffrBc5579J2nhz3B0yRsS3Rj/QXij+Fb4B2CpS8uR2MG8DN0LQg4jYpvMYytxHqizM5bivEzCkeA2/9CBbbwCy25CIKFRc+8PcffRNQtgnBXjUVfxVFNJt1rCUOI5THRdnlY1vJ1K6GeDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eEGA+B2y; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HS4zdAOookLhStFwrpf/+8GcTVifRr9zTXzMZfWtDU0=; b=eEGA+B2yPtag/gbTh3vvn1jfz4
	3imbt7QNVeweo9QVw7ocvBusprVzihnr5gyvUyJFKArMY5zA3Txz28aypWECbUysc4caTPby8k9hY
	Ow6yvsNFeQS4RekX3Ea7uyCbIzLbAf82VPTxRUkEnV6V/J9+kD0IZ9BLVnkWmUPdMscdMXY34GUJB
	1e3SuxBY0FQvja7UPSr4UoIiewwva84TFA9+LJm0HsoIMVnvTiYhRBzZCZne4z/8mVLNlB3iyz9aQ
	cUIt/d5FY2gObhQOjuumQxF7JX3jReQ53kGrWVYa3DTouUJuF0+n8E8MAD656k+8MK7dZe1YvUFSh
	oo0CzVQg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1twgTD-00000000ae8-3Kzq;
	Mon, 24 Mar 2025 11:59:55 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 61A913004AF; Mon, 24 Mar 2025 12:59:55 +0100 (CET)
Date: Mon, 24 Mar 2025 12:59:55 +0100
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
Subject: Re: [tip: sched/core] sched/debug: Change SCHED_WARN_ON() to
 WARN_ON_ONCE()
Message-ID: <20250324115955.GF14944@noisy.programming.kicks-ass.net>
References: <20250317104257.3496611-2-mingo@kernel.org>
 <174246120542.14745.16936293992221722909.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174246120542.14745.16936293992221722909.tip-bot2@tip-bot2>

On Thu, Mar 20, 2025 at 09:00:05AM -0000, tip-bot2 for Ingo Molnar wrote:
> The following commit has been merged into the sched/core branch of tip:
> 
> Commit-ID:     f7d2728cc032a23fccb5ecde69793a38eb30ba5c
> Gitweb:        https://git.kernel.org/tip/f7d2728cc032a23fccb5ecde69793a38eb30ba5c
> Author:        Ingo Molnar <mingo@kernel.org>
> AuthorDate:    Mon, 17 Mar 2025 11:42:52 +01:00
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Wed, 19 Mar 2025 22:20:53 +01:00
> 
> sched/debug: Change SCHED_WARN_ON() to WARN_ON_ONCE()
> 
> The scheduler has this special SCHED_WARN() facility that
> depends on CONFIG_SCHED_DEBUG.
> 
> Since CONFIG_SCHED_DEBUG is getting removed, convert
> SCHED_WARN() to WARN_ON_ONCE().
> 
> Note that the warning output isn't 100% equivalent:
> 
>    #define SCHED_WARN_ON(x)      WARN_ONCE(x, #x)
> 
> Because SCHED_WARN_ON() would output the 'x' condition
> as well, while WARN_ONCE() will only show a backtrace.
> 
> Hopefully these are rare enough to not really matter.
> 
> If it does, we should probably introduce a new WARN_ON()
> variant that outputs the condition in stringified form,
> or improve WARN_ON() itself.

So those strings really were useful, trouble is WARN_ONCE() generates
utter crap code compared to WARN_ON_ONCE(), but since SCHED_DEBUG that
doesn't really matter.

Also, last time I measured, there was a measurable performance
difference between SCHED_DEBUG=n and SCHED_DEBUG=y.

