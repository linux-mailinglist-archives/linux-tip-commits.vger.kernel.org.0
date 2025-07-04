Return-Path: <linux-tip-commits+bounces-6000-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D03AF90BA
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Jul 2025 12:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CEC61899ED6
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Jul 2025 10:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0975A2F235E;
	Fri,  4 Jul 2025 10:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DN5WXByJ"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FA62F234E;
	Fri,  4 Jul 2025 10:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751625172; cv=none; b=PQyGlIANMWRTj0GRLghj655/feK+2Zqf/o+LS1vc71S+fp/5hIJIc6EQsRRtMaeC/YR5C5sPc0moJZAeKPvc5grxj4GWIg3qNga5wZw2ChMbaGCY4HwyfnhvrRXS2ic0NyDADrH7ypGnY1473b96TQsp6Em66zSfvqvnT3Dzaug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751625172; c=relaxed/simple;
	bh=X/yNWlWB/y2ACN5oLtHF/++ScOovYYJezLzNbWoUL8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lWVGrPQGJDVPSp27uO81Kq/nBN2oYTwin+HeniYYlA5KIcBH4dfrUcmsLSapx4axcfjPYFRbYbnK77maaNCoOFNYspITOdyDwW/N+tJ+T/wq1MTrxmev18ueVwr2WSxhZnEI6+BCxdkKTEeJ7zaLn81mmlCwwaswS828XpSBjNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DN5WXByJ; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=e6rhXVAqDgkrV1yyz4a83LxOWl/gSNLKryLQbSZ9wsA=; b=DN5WXByJ6Fib4xlyf4PAVST/6B
	AtGqIjuBo+P9FgNiMdm6t5xgZKvCJLV9rDB/fOmxeC8g+OWI+3GtA75ycViI7c6zMHivIMsf7Gfjb
	xtLDxnHOyRknjPNH6H+GZ0McZjB1nDqn9+YqtAukDYmBRJYo+YyT9/sD6KS5KfLHTlMAxfwjR4Huz
	BPGDwuou3i/vcSUVI5Qxdwpspk4sz9mN61LZY5N70rDnxKdLGWTsAPwAeX4pgNMlhp4EhqtchnVd4
	GWWsi5dQZReYa5DSp22v4QFoBJssHvqmJpokOaCHJZ0oYvKEf8EpBHOhTXuPyh1kLpEKHAdqVvEeJ
	Uuzqavgw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXdio-00000007weM-1Z1V;
	Fri, 04 Jul 2025 10:32:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2C394300233; Fri, 04 Jul 2025 12:32:45 +0200 (CEST)
Date: Fri, 4 Jul 2025 12:32:44 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Borislav Petkov <bp@alien8.de>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>, linux-kernel@vger.kernel.org,
	linux-tip-commits@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Steve Wahl <steve.wahl@hpe.com>, x86@kernel.org
Subject: Re: [tip: sched/urgent] sched/fair: Use sched_domain_span() for
 topology_span_sane()
Message-ID: <20250704103244.GA2307777@noisy.programming.kicks-ass.net>
References: <20250630061059.1547-1-kprateek.nayak@amd.com>
 <175162039637.406.8610358723761872462.tip-bot2@tip-bot2>
 <20250704102103.GAaGerDxWX7VhePA3j@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704102103.GAaGerDxWX7VhePA3j@fat_crate.local>

On Fri, Jul 04, 2025 at 12:21:03PM +0200, Borislav Petkov wrote:
> On Fri, Jul 04, 2025 at 09:13:16AM -0000, tip-bot2 for K Prateek Nayak wrote:
> > The following commit has been merged into the sched/urgent branch of tip:
> > 
> > Commit-ID:     02bb4259ca525efa39a2531cb630329fb87fc968
> > Gitweb:        https://git.kernel.org/tip/02bb4259ca525efa39a2531cb630329fb87fc968
> > Author:        K Prateek Nayak <kprateek.nayak@amd.com>
> > AuthorDate:    Mon, 30 Jun 2025 06:10:59 
> > Committer:     Peter Zijlstra <peterz@infradead.org>
> > CommitterDate: Fri, 04 Jul 2025 10:35:56 +02:00
> > 
> > sched/fair: Use sched_domain_span() for topology_span_sane()
> 
> My guest doesn't like this one and reverting it ontop of the whole tip lineup
> fixes it.

OK, let me pull this patch real quick for now. Clearly it needs moar
work.

