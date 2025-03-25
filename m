Return-Path: <linux-tip-commits+bounces-4539-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7097A70990
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 19:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 381C13BF45E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 18:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986E31C7008;
	Tue, 25 Mar 2025 18:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZQ3ndTwK"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2897E1AD41F;
	Tue, 25 Mar 2025 18:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742928408; cv=none; b=HqhbHQkRtDiVJeVHNHWy1xik7pIFFzOaWVRkAKDqSOkHgmXI7WDFYXVMvDkvphVJBigwRQ+kM2f7y88AWpBomH6gaS8I1AGseia7VBuFHE6AKdp69KHr06/fvbvLS7Hth4dH5jl7/gA4t0DndRMZBGm96lhDMqgro7lqbAtURx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742928408; c=relaxed/simple;
	bh=D8CU9OAiGVwJRbD8cmg5/i0vIksIQsFwuHBA/PigBi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dDbd8yYLD9+onXWFSDF/bW0cMdxdN5na1L0cHWXisK8oUr7XNwqEd0RUjYtunALFg8JSJtCC9oWs122xETH4oqk2MnBkJS54Q3oG/+ue1fyUMoZtasd6LBX/twCpCDlbYwsYzdLEKwJWfAQ95OSULPqP6U4R+DawmLkQQCVSous=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZQ3ndTwK; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=D8CU9OAiGVwJRbD8cmg5/i0vIksIQsFwuHBA/PigBi4=; b=ZQ3ndTwKIoMRBKbS5K7pSIeYQw
	YeDhGtY1ASdYzjxHfAvRfJv4SNFQleiqK6qBMTL03Cys9UYxizIbSXldA1oysSXrGWeA31p18r737
	Sd1fKRdZkYzh4KwfNy2Wx4YHwy42SyQBl9KMBAxl7EQqfcCIHj0Z3uDwaMoBAgUHR4JgiPWOXCMxM
	y/rDVL2VLgnaH2Yec/vel59XNY0CbTb0odJ4aeG5S82TfQsxlmoaIVMpfeh0jH2Ggb4c/6ZWk2AHS
	zUQ6r2+yp1GrMF/przOVEX3TKQer9OsYrE72OX/G16alQ+qjSKA7x0beyezspEZ48oxdbw8A2ECx3
	COeWcqYQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tx9IL-00000005gDK-0s17;
	Tue, 25 Mar 2025 18:46:37 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A5BEB30017D; Tue, 25 Mar 2025 19:46:36 +0100 (CET)
Date: Tue, 25 Mar 2025 19:46:36 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
	linux-tip-commits@vger.kernel.org,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, x86@kernel.org
Subject: Re: [PATCH] bug: Introduce CONFIG_DEBUG_BUGVERBOSE_EXTRA=y to also
 log warning conditions
Message-ID: <20250325184636.GB31413@noisy.programming.kicks-ass.net>
References: <20250317104257.3496611-2-mingo@kernel.org>
 <174246120542.14745.16936293992221722909.tip-bot2@tip-bot2>
 <20250324115955.GF14944@noisy.programming.kicks-ass.net>
 <Z-J5UEFwM3gh6VXR@gmail.com>
 <Z-KRD3ODxT9f8Yjw@gmail.com>
 <20250325123625.GM36322@noisy.programming.kicks-ass.net>
 <CAHk-=wg_BRnCs8o5vEjK_zDuc0KJ-z9bvq5845jKv+7UduS4hQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg_BRnCs8o5vEjK_zDuc0KJ-z9bvq5845jKv+7UduS4hQ@mail.gmail.com>

On Tue, Mar 25, 2025 at 10:48:49AM -0700, Linus Torvalds wrote:
> Hmm?

That is indeed what I was thinking of; far better articulated :-)

