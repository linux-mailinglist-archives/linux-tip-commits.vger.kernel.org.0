Return-Path: <linux-tip-commits+bounces-3359-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE28EA322A6
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Feb 2025 10:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4D1A3A1C9D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Feb 2025 09:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAA92066D9;
	Wed, 12 Feb 2025 09:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZKUNfn9Y"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140F42063F4;
	Wed, 12 Feb 2025 09:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739353399; cv=none; b=GvXwYBsAo2a8dNuzO++wtM7TuuESqZwf+py67TdhM/8GNxCe/754TCypzg5eCbFbD9EuaXY+jF2lehyp9WUvOJiRpeXLb43F71J/SrGQXrevT3U71TLz/1KDaG5qSpzdU41hyopkXunVnpvG08jtn4fT9lI3lNDeCmymPWv9mE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739353399; c=relaxed/simple;
	bh=riQIaA9jfwloeLuUC0rqMjOvmr9G0HwhV6cOCq/AckM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZdyyBcQot6MWrZ+3VeY0NrFoPg5E1/KGmd8hIJFPji9Hl/iApB7nfprPY3jyw21r2pMgPQ1ku1VLEhTadJottZrOH/v9+4kFPzoc3aHkBaYRSt0tiayhGZrls9NGxsXAngq/8BGiaTYAKAue6Ik/3Ihq9Y++wVwCKr5n0zo0sSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZKUNfn9Y; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dTFlbsmC0WjAMz9CQYs4K20vlagORcevhwzqv7FeHjg=; b=ZKUNfn9YKrc+sODKhuuCqPIHU/
	EUk+PNBuuNAGWpkntmcAJcn9aEay6YbmY3I3dW/oNrdv7DjEpodbkwIvrEXh5r7y9pqgb5AO6RNmp
	60UY/sNaibBFCkJUkwnZJQmUTee0nsaoWuiWucVdQq7oXBml+IrBw+JdPo7HKwBT/4qrjyju8wUIz
	A+nZ3rsg7cfauDLma5ZrHC04J5p53wP86aZyxzy2rHyy4/f4Umoc/0iY6Sqz77Uj+xjwtUG7UeZxx
	bwtUJxO+uE8P+G+WUjuzSt4bR8Z+MzVJKr4mJL90r9FYWDgWZrVEFWs9fSny+N2u9rrJIVeV/sFZC
	XAbFSFdg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1ti9Gu-00000004Al6-1Win;
	Wed, 12 Feb 2025 09:43:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id F2CDF300318; Wed, 12 Feb 2025 10:43:07 +0100 (CET)
Date: Wed, 12 Feb 2025 10:43:07 +0100
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
Subject: Re: [PATCH 0/2] [tip: sched/core] sched: Disable PLACE_LAG and
 RUN_TO_PARITY and move them to sysctl
Message-ID: <20250212094307.GB19118@noisy.programming.kicks-ass.net>
References: <20250119110410.GAZ4zcKkx5sCjD5XvH@fat_crate.local>
 <20250212054113.19938-1-cpru@amazon.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212054113.19938-1-cpru@amazon.com>

On Tue, Feb 11, 2025 at 11:41:13PM -0600, Cristian Prundeanu wrote:

> Your find also helps to point out that even when it works, SCHED_BATCH is 
> a more complex and error prone mitigation than just disabling PL and RTP. 
> The same reproducer setup that uses systemd to set SCHED_BATCH does show 
> improvement in 6.12, but not in 6.13+. There may not even be a single 
> approach that works well on both.
> 
> Conversely, setting NO_PLACE_LAG + NO_RUN_TO_PARITY is simply done at boot 
> time, and does not require further user effort. 

For your workload. It will wreck other workloads.

Yes, SCHED_BATCH might be more fiddly, but it allows for composition.
You can run multiple workloads together and they all behave.

Maybe the right thing here is to get mysql patched; so that it will
request BATCH itself for the threads that need it.

